From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] ASoC: imx-audmix: register the card on a proper dev
Date: Tue, 27 Aug 2019 07:44:20 +0000
Message-ID: <65ef17869dbc0a785e2abe9c27df24fdfb273c16.camel@nxp.com>
References: <1566921315-23402-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566921315-23402-1-git-send-email-shengjiu.wang@nxp.com>
Content-Language: en-US
Content-ID: <72DF92E13A17A0468403E9BD125780DB@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, "perex@perex.cz" <perex@perex.cz>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDExOjU1IC0wNDAwLCBTaGVuZ2ppdSBXYW5nIHdyb3RlOg0K
PiBUaGlzIHBsYXRmb3JtIGRldmljZSBpcyByZWdpc3RlcmVkIGZyb20gImZzbF9hdWRtaXgiLCB3
aGljaCBpcw0KPiBpdHMgcGFyZW50IGRldmljZS4gSWYgdXNlIHBkZXYtPmRldi5wYXJlbnQgZm9y
IHRoZSBwcml2LT5jYXJkLmRldiwNCj4gdGhlIHZhbHVlIHNldCBieSBkZXZfc2V0X2RydmRhdGEg
aW4gcGFyZW50IGRldmljZSB3aWxsIGJlIGNvdmVyZWQNCj4gYnkgdGhlIHZhbHVlIGluIGNoaWxk
IGRldmljZS4NCj4gDQo+IEZpeGVzOiBiODZlZjUzNjc3NjEgKCJBU29DOiBmc2w6IEFkZCBBdWRp
byBNaXhlciBtYWNoaW5lIGRyaXZlciIpDQo+IFNpZ25lZC1vZmYtYnk6IFZpb3JlbCBTdW1hbiA8
dmlvcmVsLnN1bWFuQG54cC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNoZW5naml1IFdhbmcgPHNo
ZW5naml1LndhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERhbmllbCBCYWx1dGEgPGRhbmll
bC5iYWx1dGFAbnhwLmNvbT4NCg0KVGhhbmtzIFNoZW5naml1IGZvciB0aGUgZml4IQ0KDQo+IC0t
LQ0KPiAgc291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMgYi9zb3VuZC9zb2MvZnNsL2lteC1hdWRtaXguYw0K
PiBpbmRleCA5ZTFjYjE4ODU5Y2UuLjcxNTkwY2E2Mzk0YiAxMDA2NDQNCj4gLS0tIGEvc291bmQv
c29jL2ZzbC9pbXgtYXVkbWl4LmMNCj4gKysrIGIvc291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMN
Cj4gQEAgLTMyNSwxNCArMzI1LDE0IEBAIHN0YXRpYyBpbnQgaW14X2F1ZG1peF9wcm9iZShzdHJ1
Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXByaXYtPmNhcmQubnVtX2NvbmZpZ3Mg
PSBwcml2LT5udW1fZGFpX2NvbmY7DQo+ICAJcHJpdi0+Y2FyZC5kYXBtX3JvdXRlcyA9IHByaXYt
PmRhcG1fcm91dGVzOw0KPiAgCXByaXYtPmNhcmQubnVtX2RhcG1fcm91dGVzID0gcHJpdi0+bnVt
X2RhcG1fcm91dGVzOw0KPiAtCXByaXYtPmNhcmQuZGV2ID0gcGRldi0+ZGV2LnBhcmVudDsNCj4g
Kwlwcml2LT5jYXJkLmRldiA9ICZwZGV2LT5kZXY7DQo+ICAJcHJpdi0+Y2FyZC5vd25lciA9IFRI
SVNfTU9EVUxFOw0KPiAgCXByaXYtPmNhcmQubmFtZSA9ICJpbXgtYXVkbWl4IjsNCj4gIA0KPiAg
CXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsICZwcml2LT5jYXJkKTsNCj4gIAlzbmRfc29jX2Nh
cmRfc2V0X2RydmRhdGEoJnByaXYtPmNhcmQsIHByaXYpOw0KPiAgDQo+IC0JcmV0ID0gZGV2bV9z
bmRfc29jX3JlZ2lzdGVyX2NhcmQocGRldi0+ZGV2LnBhcmVudCwgJnByaXYtDQo+ID5jYXJkKTsN
Cj4gKwlyZXQgPSBkZXZtX3NuZF9zb2NfcmVnaXN0ZXJfY2FyZCgmcGRldi0+ZGV2LCAmcHJpdi0+
Y2FyZCk7DQo+ICAJaWYgKHJldCkgew0KPiAgCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJzbmRfc29j
X3JlZ2lzdGVyX2NhcmQgZmFpbGVkXG4iKTsNCj4gIAkJcmV0dXJuIHJldDsNCg==
