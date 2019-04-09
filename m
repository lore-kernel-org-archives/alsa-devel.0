From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH v2 3/3] ASoC: imx-audmix: fix object reference leaks in probe
Date: Tue, 9 Apr 2019 11:27:42 +0000
Message-ID: <1554809242-27475-4-git-send-email-viorel.suman@nxp.com>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Viorel Suman <viorel.suman@nxp.com>, Viorel Suman <viorel.suman@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

UmVsZWFzZSB0aGUgcmVmZXJlbmNlIHRvIHRoZSB1bmRlcmx5aW5nIGRldmljZSB0YWtlbg0KYnkg
b2ZfZmluZF9kZXZpY2VfYnlfbm9kZSgpIGNhbGwuDQoNClNpZ25lZC1vZmYtYnk6IFZpb3JlbCBT
dW1hbiA8dmlvcmVsLnN1bWFuQG54cC5jb20+DQpSZXBvcnRlZC1ieTogSnVsaWEgTGF3YWxsIDxK
dWxpYS5MYXdhbGxAbGlwNi5mcj4NCi0tLQ0KIHNvdW5kL3NvYy9mc2wvaW14LWF1ZG1peC5jIHwg
NCArKysrDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMgYi9zb3VuZC9zb2MvZnNsL2lteC1hdWRtaXguYw0K
aW5kZXggNzk4M2JkMy4uOWFhZjNlNSAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9mc2wvaW14LWF1
ZG1peC5jDQorKysgYi9zb3VuZC9zb2MvZnNsL2lteC1hdWRtaXguYw0KQEAgLTE3MSw2ICsxNzEs
NyBAQCBzdGF0aWMgaW50IGlteF9hdWRtaXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCiAJCQlucC0+ZnVsbF9uYW1lKTsNCiAJCXJldHVybiAtRUlOVkFMOw0KIAl9DQorCXB1
dF9kZXZpY2UoJmF1ZG1peF9wZGV2LT5kZXYpOw0KIA0KIAludW1fZGFpID0gb2ZfY291bnRfcGhh
bmRsZV93aXRoX2FyZ3MoYXVkbWl4X25wLCAiZGFpcyIsIE5VTEwpOw0KIAlpZiAobnVtX2RhaSAh
PSBGU0xfQVVETUlYX01BWF9EQUlTKSB7DQpAQCAtMjE2LDYgKzIxNyw3IEBAIHN0YXRpYyBpbnQg
aW14X2F1ZG1peF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJCWRldl9l
cnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBmaW5kIFNBSSBwbGF0Zm9ybSBkZXZpY2VcbiIpOw0K
IAkJCXJldHVybiAtRUlOVkFMOw0KIAkJfQ0KKwkJcHV0X2RldmljZSgmY3B1X3BkZXYtPmRldik7
DQogDQogCQlkYWlfbmFtZSA9IGRldm1fa2FzcHJpbnRmKCZwZGV2LT5kZXYsIEdGUF9LRVJORUws
ICIlcyVzIiwNCiAJCQkJCSAgZmVfbmFtZV9wcmVmLCBhcmdzLm5wLT5mdWxsX25hbWUgKyAxKTsN
CkBAIC0yODAsNiArMjgyLDggQEAgc3RhdGljIGludCBpbXhfYXVkbWl4X3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8g
ZmluZCBTQUkgcGxhdGZvcm0gZGV2aWNlXG4iKTsNCiAJCXJldHVybiAtRUlOVkFMOw0KIAl9DQor
CXB1dF9kZXZpY2UoJmNwdV9wZGV2LT5kZXYpOw0KKw0KIAlwcml2LT5jcHVfbWNsayA9IGRldm1f
Y2xrX2dldCgmY3B1X3BkZXYtPmRldiwgIm1jbGsxIik7DQogCWlmIChJU19FUlIocHJpdi0+Y3B1
X21jbGspKSB7DQogCQlyZXQgPSBQVFJfRVJSKHByaXYtPmNwdV9tY2xrKTsNCi0tIA0KMi43LjQN
Cg0K
