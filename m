From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH v4 3/4] ASoC: imx-audmix: fix object reference leaks in probe
Date: Wed, 10 Apr 2019 11:06:38 +0000
Message-ID: <1554894380-25153-4-git-send-email-viorel.suman@nxp.com>
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

UmVsZWFzZSB0aGUgcmVmZXJlbmNlIHRvIHRoZSB1bmRlcmx5aW5nIGRldmljZSB0YWtlbg0KYnkg
b2ZfZmluZF9kZXZpY2VfYnlfbm9kZSgpIGNhbGwuDQoNClNpZ25lZC1vZmYtYnk6IFZpb3JlbCBT
dW1hbiA8dmlvcmVsLnN1bWFuQG54cC5jb20+DQpSZXBvcnRlZC1ieTogSnVsaWEgTGF3YWxsIDxK
dWxpYS5MYXdhbGxAbGlwNi5mcj4NCkFja2VkLWJ5OiBOaWNvbGluIENoZW4gPG5pY29sZW90c3Vr
YUBnbWFpbC5jb20+DQotLS0NCiBzb3VuZC9zb2MvZnNsL2lteC1hdWRtaXguYyB8IDQgKysrKw0K
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3Nv
Yy9mc2wvaW14LWF1ZG1peC5jIGIvc291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMNCmluZGV4IDc5
ODNiZDMuLjlhYWYzZTUgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvZnNsL2lteC1hdWRtaXguYw0K
KysrIGIvc291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMNCkBAIC0xNzEsNiArMTcxLDcgQEAgc3Rh
dGljIGludCBpbXhfYXVkbWl4X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQog
CQkJbnAtPmZ1bGxfbmFtZSk7DQogCQlyZXR1cm4gLUVJTlZBTDsNCiAJfQ0KKwlwdXRfZGV2aWNl
KCZhdWRtaXhfcGRldi0+ZGV2KTsNCiANCiAJbnVtX2RhaSA9IG9mX2NvdW50X3BoYW5kbGVfd2l0
aF9hcmdzKGF1ZG1peF9ucCwgImRhaXMiLCBOVUxMKTsNCiAJaWYgKG51bV9kYWkgIT0gRlNMX0FV
RE1JWF9NQVhfREFJUykgew0KQEAgLTIxNiw2ICsyMTcsNyBAQCBzdGF0aWMgaW50IGlteF9hdWRt
aXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCQlkZXZfZXJyKCZwZGV2
LT5kZXYsICJmYWlsZWQgdG8gZmluZCBTQUkgcGxhdGZvcm0gZGV2aWNlXG4iKTsNCiAJCQlyZXR1
cm4gLUVJTlZBTDsNCiAJCX0NCisJCXB1dF9kZXZpY2UoJmNwdV9wZGV2LT5kZXYpOw0KIA0KIAkJ
ZGFpX25hbWUgPSBkZXZtX2thc3ByaW50ZigmcGRldi0+ZGV2LCBHRlBfS0VSTkVMLCAiJXMlcyIs
DQogCQkJCQkgIGZlX25hbWVfcHJlZiwgYXJncy5ucC0+ZnVsbF9uYW1lICsgMSk7DQpAQCAtMjgw
LDYgKzI4Miw4IEBAIHN0YXRpYyBpbnQgaW14X2F1ZG1peF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIGZpbmQgU0FJ
IHBsYXRmb3JtIGRldmljZVxuIik7DQogCQlyZXR1cm4gLUVJTlZBTDsNCiAJfQ0KKwlwdXRfZGV2
aWNlKCZjcHVfcGRldi0+ZGV2KTsNCisNCiAJcHJpdi0+Y3B1X21jbGsgPSBkZXZtX2Nsa19nZXQo
JmNwdV9wZGV2LT5kZXYsICJtY2xrMSIpOw0KIAlpZiAoSVNfRVJSKHByaXYtPmNwdV9tY2xrKSkg
ew0KIAkJcmV0ID0gUFRSX0VSUihwcml2LT5jcHVfbWNsayk7DQotLSANCjIuNy40DQoNCg==
