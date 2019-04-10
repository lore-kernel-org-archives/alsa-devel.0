From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH v3 0/4] ASoC: fsl: audmix: remove "model" attribute and fix
 ref leaks
Date: Wed, 10 Apr 2019 10:37:27 +0000
Message-ID: <1554892629-17646-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Viorel Suman <viorel.suman@nxp.com>, Viorel Suman <viorel.suman@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

VGhlIGxhdGVzdCBhdWRtaXggcGF0Y2gtc2V0ICh2NSkgaGFkIHRoZSAibW9kZWwiIGF0dHJpYnV0
ZSByZW1vdmVkIGFzDQpyZXF1ZXN0ZWQgYnkgTmljb2xpbiBDaGVuLCBidXQgbG9va3MgbGlrZSAo
djQpIHZlcnNpb24gb2YgREFJIGRyaXZlcg0KcmVhY2hlZCAiZm9yLW5leHQiIGJyYW5jaCAtIGZp
eCB0aGlzIGJ5IHJlbW92aW5nICJtb2RlbCIgYXR0cmlidXRlLg0KQXNzaWRlIG9mIHRoaXMgZml4
IG9iamVjdCByZWZlcmVuY2UgbGVha3MgaW4gbWFjaGluZSBwcm9iZSByZXBvcnRlZCBieQ0KSnVs
aWEgTGF3YWxsLg0KDQpWaW9yZWwgU3VtYW4gKDQpOg0KICBBU29DOiBmc2xfYXVkbWl4OiByZW1v
dmUgIm1vZGVsIiBhdHRyaWJ1dGUNCiAgZHQtYmluZGluZ3M6IGZzbCxhdWRtaXg6IHJlbW92ZSAi
bW9kZWwiIGF0dHJpYnV0ZQ0KICBBU29DOiBpbXgtYXVkbWl4OiBmaXggb2JqZWN0IHJlZmVyZW5j
ZSBsZWFrcyBpbiBwcm9iZQ0KICBBU29DOiBmc2xfYXVkbWl4OiBjYWNoZSBwZGV2LT5kZXYgcG9p
bnRlcg0KDQpDaGFuZ2VzIHNpbmNlIFYxOg0KICBhKSBSZW1vdmVkICJtb2RlbCIgYXR0cmlidXRl
IGZyb20gZHQtYmluZGluZ3MgZG9jdW1lbnRhdGlvbg0KICBiKSBBZHJlc3NlZCBEYW5pZWwncyBj
b21tZW50cw0KDQpDaGFuZ2VzIHNpbmNlIFYyOg0KICBhKSBDYWNoZSBwZGV2LT5kZXYgcG9pbnRl
ciBpbiBmc2xfYXVkbWl4IHByb2JlIGFzIHN1Z2dlc3RlZCBieSBOaWNvbGluDQoNCiAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9mc2wsYXVkbWl4LnR4dCAgICAgICB8ICA0IC0tDQogc291
bmQvc29jL2ZzbC9mc2xfYXVkbWl4LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCA2MSArKysr
KysrKysrKystLS0tLS0tLS0tDQogc291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgNCArKw0KIDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygr
KSwgMzMgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi43LjQNCg0K
