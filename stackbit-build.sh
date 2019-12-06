#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://bf5ba9d8.ngrok.io/project/5dea2730b183cb4d2201724d/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://bf5ba9d8.ngrok.io/pull/5dea2730b183cb4d2201724d 
fi
curl -s -X POST https://bf5ba9d8.ngrok.io/project/5dea2730b183cb4d2201724d/webhook/build/ssgbuild > /dev/null
hugo
curl -s -X POST https://bf5ba9d8.ngrok.io/project/5dea2730b183cb4d2201724d/webhook/build/publish > /dev/null
