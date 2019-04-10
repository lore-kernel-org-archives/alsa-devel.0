From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH v4 2/4] ASoC: fsl_audmix: remove "model" attribute from DT
 document
Date: Wed, 10 Apr 2019 11:06:37 +0000
Message-ID: <1554894380-25153-3-git-send-email-viorel.suman@nxp.com>
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Viorel Suman <viorel.suman@nxp.com>, Viorel Suman <viorel.suman@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

UmVtb3ZlICJtb2RlbCIgYXR0cmlidXRlIGZyb20gZnNsX2F1ZG1peCBEVCBkb2N1bWVudC4NCg0K
U2lnbmVkLW9mZi1ieTogVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT4NCkFja2Vk
LWJ5OiBOaWNvbGluIENoZW4gPG5pY29sZW90c3VrYUBnbWFpbC5jb20+DQotLS0NCiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvZnNsLGF1ZG1peC50eHQgfCA0IC0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9mc2wsYXVkbWl4LnR4dCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9mc2wsYXVkbWl4LnR4dA0KaW5kZXggNDVm
ODA3ZS4uODQwYjdlMCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zb3VuZC9mc2wsYXVkbWl4LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NvdW5kL2ZzbCxhdWRtaXgudHh0DQpAQCAtMzgsOSArMzgsNiBAQCBEZXZpY2Ug
ZHJpdmVyIHJlcXVpcmVkIHByb3BlcnRpZXM6DQogCQkJICB0byBTQUkgaW50ZXJmYWNlcyB0byBi
ZSBwcm92aWRlZCwgdGhlIGZpcnN0IFNBSSBpbiB0aGUNCiAJCQkgIGxpc3QgYmVpbmcgdXNlZCB0
byByb3V0ZSB0aGUgQVVETUlYIG91dHB1dC4NCiANCi0gIC0gbW9kZWwJCTogTXVzdCBjb250YWlu
IG1hY2hpbmUgZHJpdmVyIG5hbWUgd2hpY2ggd2lsbCBjb25maWd1cmUNCi0JCQkgIGFuZCBpbnN0
YW50aWF0ZSB0aGUgYXBwcm9wcmlhdGUgYXVkaW8gY2FyZC4NCi0NCiBEZXZpY2UgZHJpdmVyIGNv
bmZpZ3VyYXRpb24gZXhhbXBsZToNCiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KICAgYXVkbWl4OiBhdWRtaXhANTk4NDAwMDAgew0KQEAgLTUwLDUgKzQ3LDQgQEAgRGV2
aWNlIGRyaXZlciBjb25maWd1cmF0aW9uIGV4YW1wbGU6DQogICAgIGNsb2NrLW5hbWVzID0gImlw
ZyI7DQogICAgIHBvd2VyLWRvbWFpbnMgPSA8JnBkX2F1ZG1peD47DQogICAgIGRhaXMgPSA8JnNh
aTQ+LCA8JnNhaTU+Ow0KLSAgICBtb2RlbCA9ICJpbXgtYXVkbWl4IjsNCiAgIH07DQotLSANCjIu
Ny40DQoNCg==
