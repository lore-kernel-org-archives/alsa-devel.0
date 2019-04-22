From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH V5 1/3] ASoC: fsl_asrc: Fix the issue about unsupported rate
Date: Mon, 22 Apr 2019 02:32:32 +0000
Message-ID: <a74fe1798ef8f473e11f5e39452664b5e80515df.1555900078.git.shengjiu.wang@nxp.com>
References: <cover.1555900078.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1555900078.git.shengjiu.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

V2hlbiB0aGUgb3V0cHV0IHNhbXBsZSByYXRlIGlzIFs4a0h6LCAzMGtIel0sIHRoZSBsaW1pdGF0
aW9uDQpvZiB0aGUgc3VwcG9ydGVkIHJhdGlvIHJhbmdlIGlzICgxLzI0LCA4KS4gSW4gdGhlIGRy
aXZlcg0Kd2UgdXNlICg4a0h6LCAzMGtIeikgaW5zdGVhZCBvZiBbOGtIeiwgMzBrSHpdLg0KU28g
dGhpcyBwYXRjaCBpcyB0byBmaXggdGhpcyBpc3N1ZSBhbmQgdGhlIHBvdGVudGlhbCByb3VuZGlu
Zw0KaXNzdWUgd2l0aCBkaXZpZGVyLg0KDQpGaXhlczogZmZmNmUwM2M3YjY1ICgiQVNvQzogZnNs
X2FzcmM6IGFkZCBzdXBwb3J0IGZvciA4LTMwa0h6DQpvdXRwdXQgc2FtcGxlIHJhdGUiKQ0KQ2M6
IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8
c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KLS0tDQogc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jIHwg
NCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9mc2wvZnNsX2FzcmMuYyBiL3NvdW5kL3NvYy9mc2wv
ZnNsX2FzcmMuYw0KaW5kZXggMGI5Mzc5MjRkMmU0Li5lYTAzNWMxMmEzMjUgMTAwNjQ0DQotLS0g
YS9zb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMNCisrKyBiL3NvdW5kL3NvYy9mc2wvZnNsX2FzcmMu
Yw0KQEAgLTI4Miw4ICsyODIsOCBAQCBzdGF0aWMgaW50IGZzbF9hc3JjX2NvbmZpZ19wYWlyKHN0
cnVjdCBmc2xfYXNyY19wYWlyICpwYWlyKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0NCiANCi0J
aWYgKChvdXRyYXRlID4gODAwMCAmJiBvdXRyYXRlIDwgMzAwMDApICYmDQotCSAgICAob3V0cmF0
ZS9pbnJhdGUgPiAyNCB8fCBpbnJhdGUvb3V0cmF0ZSA+IDgpKSB7DQorCWlmICgob3V0cmF0ZSA+
PSA4MDAwICYmIG91dHJhdGUgPD0gMzAwMDApICYmDQorCSAgICAob3V0cmF0ZSA+IDI0ICogaW5y
YXRlIHx8IGlucmF0ZSA+IDggKiBvdXRyYXRlKSkgew0KIAkJcGFpcl9lcnIoImV4Y2VlZCBzdXBw
b3J0ZWQgcmF0aW8gcmFuZ2UgWzEvMjQsIDhdIGZvciBcDQogCQkJCWlucmF0ZS9vdXRyYXRlOiAl
ZC8lZFxuIiwgaW5yYXRlLCBvdXRyYXRlKTsNCiAJCXJldHVybiAtRUlOVkFMOw0KLS0gDQoxLjku
MQ0KDQo=
