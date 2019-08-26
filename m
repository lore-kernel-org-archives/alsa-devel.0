From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH -next] ASoC: SOF: imx8: Fix return value check in
 imx8_probe()
Date: Mon, 26 Aug 2019 12:01:07 +0000
Message-ID: <01883a69834142f14cd3ac6c9cb97343ee432d67.camel@nxp.com>
References: <20190826120003.183279-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826120003.183279-1-weiyongjun1@huawei.com>
Content-Language: en-US
Content-ID: <D2F4893BB6C8E845AC840622770CE331@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAyMDE5LTA4LTI2IGF0IDEyOjAwICswMDAwLCBXZWkgWW9uZ2p1biB3cm90ZToNCj4g
SW4gY2FzZSBvZiBlcnJvciwgdGhlIGZ1bmN0aW9uIGRldm1faW9yZW1hcF93YygpIHJldHVybnMg
TlVMTCBwb2ludGVyDQo+IG5vdCBFUlJfUFRSKCkuIFRoZSBJU19FUlIoKSB0ZXN0IGluIHRoZSBy
ZXR1cm4gdmFsdWUgY2hlY2sgc2hvdWxkIGJlDQo+IHJlcGxhY2VkIHdpdGggTlVMTCB0ZXN0Lg0K
PiANCj4gRml4ZXM6IDIwMmFjYzU2NWExZiAoIkFTb0M6IFNPRjogaW14OiBBZGQgaS5NWDggSFcg
c3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IFdlaSBZb25nanVuIDx3ZWl5b25nanVuMUBodWF3
ZWkuY29tPg0KDQpHb29kIGNhdGNoLiBUaGFua3MhDQoNClJldmlld2VkLWJ5OiBEYW5pZWwgQmFs
dXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQoNCj4gLS0tDQo+ICBzb3VuZC9zb2Mvc29mL2lt
eC9pbXg4LmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3NvZi9pbXgvaW14OC5j
IGIvc291bmQvc29jL3NvZi9pbXgvaW14OC5jDQo+IGluZGV4IGU1MDJmNTg0MjA3Zi4uMjYzZDRk
ZjM1ZmU4IDEwMDY0NA0KPiAtLS0gYS9zb3VuZC9zb2Mvc29mL2lteC9pbXg4LmMNCj4gKysrIGIv
c291bmQvc29jL3NvZi9pbXgvaW14OC5jDQo+IEBAIC0yOTYsMTAgKzI5NiwxMCBAQCBzdGF0aWMg
aW50IGlteDhfcHJvYmUoc3RydWN0IHNuZF9zb2ZfZGV2ICpzZGV2KQ0KPiAgCXNkZXYtPmJhcltT
T0ZfRldfQkxLX1RZUEVfU1JBTV0gPSBkZXZtX2lvcmVtYXBfd2Moc2Rldi0+ZGV2LA0KPiByZXMu
c3RhcnQsDQo+ICAJCQkJCQkJICByZXMuZW5kIC0NCj4gcmVzLnN0YXJ0ICsNCj4gIAkJCQkJCQkg
IDEpOw0KPiAtCWlmIChJU19FUlIoc2Rldi0+YmFyW1NPRl9GV19CTEtfVFlQRV9TUkFNXSkpIHsN
Cj4gKwlpZiAoIXNkZXYtPmJhcltTT0ZfRldfQkxLX1RZUEVfU1JBTV0pIHsNCj4gIAkJZGV2X2Vy
cihzZGV2LT5kZXYsICJmYWlsZWQgdG8gaW9yZW1hcCBtZW0gMHgleCBzaXplDQo+IDB4JXhcbiIs
DQo+ICAJCQliYXNlLCBzaXplKTsNCj4gLQkJcmV0ID0gUFRSX0VSUihzZGV2LT5iYXJbU09GX0ZX
X0JMS19UWVBFX1NSQU1dKTsNCj4gKwkJcmV0ID0gLUVOT01FTTsNCj4gIAkJZ290byBleGl0X3Bk
ZXZfdW5yZWdpc3RlcjsNCj4gIAl9DQo+ICAJc2Rldi0+bWFpbGJveF9iYXIgPSBTT0ZfRldfQkxL
X1RZUEVfU1JBTTsNCj4gDQo+IA0KPiANCg==
