#!/bin/bash -e

if [ -z ${CERTIFICATE} ]; then echo "Please set CERTIFICATE when running script"; exit 1; fi
if [ ! -f ${CERTIFICATE}-template.yaml ];  then echo "Please make sure ${CERTIFICATE}-template.yaml file exists"; exit 1; fi

INGRESS_DOMAIN=$(oc get --namespace=openshift-ingress-operator ingresscontroller/default --template="{{.status.domain}}")

oc process \
  -o yaml \
  -f ${CERTIFICATE}-template.yaml \
  -p INGRESS_WILDCARD="*.${INGRESS_DOMAIN}" \
  > ${CERTIFICATE}.yaml
