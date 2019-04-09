From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH v2 0/3] ASoC: fsl: audmix: remove "model" attribute and fix
 ref leaks
Date: Tue, 9 Apr 2019 11:27:38 +0000
Message-ID: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
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
aWEgTGF3YWxsLg0KDQpWaW9yZWwgU3VtYW4gKDMpOg0KICBBU29DOiBmc2xfYXVkbWl4OiByZW1v
dmUgIm1vZGVsIiBhdHRyaWJ1dGUNCiAgZHQtYmluZGluZ3M6IGZzbCxhdWRtaXg6IHJlbW92ZSAi
bW9kZWwiIGF0dHJpYnV0ZQ0KICBBU29DOiBpbXgtYXVkbWl4OiBmaXggb2JqZWN0IHJlZmVyZW5j
ZSBsZWFrcyBpbiBwcm9iZQ0KDQpDaGFuZ2VzIHNpbmNlIFYxOg0KICBhKSBSZW1vdmVkICJtb2Rl
bCIgYXR0cmlidXRlIGZyb20gZHQtYmluZGluZ3MgZG9jdW1lbnRhdGlvbg0KICBiKSBBZHJlc3Nl
ZCBEYW5pZWwncyBjb21tZW50cw0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvZnNs
LGF1ZG1peC50eHQgICAgICAgfCAgNCAtLQ0KIHNvdW5kL3NvYy9mc2wvZnNsX2F1ZG1peC5jICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgNDMgKysrKysrKysrKysrLS0tLS0tLS0tLQ0KIHNvdW5k
L3NvYy9mc2wvaW14LWF1ZG1peC5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKysNCiAz
IGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KDQotLSAN
CjIuNy40DQoNCg==
