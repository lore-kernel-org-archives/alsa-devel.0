From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH v4 0/4] ASoC: fsl: audmix: remove "model" attribute and fix
 ref leaks
Date: Wed, 10 Apr 2019 11:06:35 +0000
Message-ID: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
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
dmUgIm1vZGVsIiBhdHRyaWJ1dGUNCiAgQVNvQzogZnNsX2F1ZG1peDogcmVtb3ZlICJtb2RlbCIg
YXR0cmlidXRlIGZyb20gRFQgZG9jdW1lbnQNCiAgQVNvQzogaW14LWF1ZG1peDogZml4IG9iamVj
dCByZWZlcmVuY2UgbGVha3MgaW4gcHJvYmUNCiAgQVNvQzogZnNsX2F1ZG1peDogY2FjaGUgcGRl
di0+ZGV2IHBvaW50ZXINCg0KQ2hhbmdlcyBzaW5jZSBWMToNCiAgYSkgUmVtb3ZlZCAibW9kZWwi
IGF0dHJpYnV0ZSBmcm9tIGR0LWJpbmRpbmdzIGRvY3VtZW50YXRpb24NCiAgYikgQWRyZXNzZWQg
RGFuaWVsJ3MgY29tbWVudHMNCg0KQ2hhbmdlcyBzaW5jZSBWMjoNCiAgYSkgQ2FjaGUgcGRldi0+
ZGV2IHBvaW50ZXIgaW4gZnNsX2F1ZG1peCBwcm9iZSBhcyBzdWdnZXN0ZWQgYnkgTmljb2xpbg0K
DQpDaGFuZ2VzIHNpbmNlIFYzOg0KICBhKSBVc2Ugc3ViamVjdCBsaW5lcyBtYXRjaGluZyB0aGUg
c3R5bGUgZm9yIHRoZSBzdWJzeXN0ZW0uDQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3Vu
ZC9mc2wsYXVkbWl4LnR4dCAgICAgICB8ICA0IC0tDQogc291bmQvc29jL2ZzbC9mc2xfYXVkbWl4
LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCA2MCArKysrKysrKysrKy0tLS0tLS0tLS0tDQog
c291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCAr
Kw0KIDMgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQoN
Ci0tIA0KMi43LjQNCg0K
