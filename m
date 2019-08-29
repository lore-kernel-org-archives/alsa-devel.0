From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: cs42xx8: Force suspend/resume during
 system suspend/resume
Date: Thu, 29 Aug 2019 10:03:34 +0000
Message-ID: <0b6116bb10c1d94246383b715b89abd9d458a661.camel@nxp.com>
References: <1566944026-18113-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566944026-18113-1-git-send-email-shengjiu.wang@nxp.com>
Content-Language: en-US
Content-ID: <41D1E37C5A1C8C4A8C580A13345026FA@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "perex@perex.cz" <perex@perex.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDE4OjEzIC0wNDAwLCBTaGVuZ2ppdSBXYW5nIHdyb3RlOg0K
PiBVc2UgZm9yY2Vfc3VzcGVuZC9yZXN1bWUgdG8gbWFrZSBzdXJlIGNsb2NrcyBhcmUgZGlzYWJs
ZWQvZW5hYmxlZA0KPiBhY2NvcmRpbmdseSBkdXJpbmcgc3lzdGVtIHN1c3BlbmQvcmVzdW1lLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPg0K
DQpSZXZpZXdlZC1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0KDQo+
IC0tLQ0KPiAgc291bmQvc29jL2NvZGVjcy9jczQyeHg4LmMgfCAyICsrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVj
cy9jczQyeHg4LmMgYi9zb3VuZC9zb2MvY29kZWNzL2NzNDJ4eDguYw0KPiBpbmRleCA1YjA0OWZj
ZGJhMjAuLjk0YjFhZGIwODhmZCAxMDA2NDQNCj4gLS0tIGEvc291bmQvc29jL2NvZGVjcy9jczQy
eHg4LmMNCj4gKysrIGIvc291bmQvc29jL2NvZGVjcy9jczQyeHg4LmMNCj4gQEAgLTY4NCw2ICs2
ODQsOCBAQCBzdGF0aWMgaW50IGNzNDJ4eDhfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UN
Cj4gKmRldikNCj4gICNlbmRpZg0KPiAgDQo+ICBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBjczQy
eHg4X3BtID0gew0KPiArCVNFVF9TWVNURU1fU0xFRVBfUE1fT1BTKHBtX3J1bnRpbWVfZm9yY2Vf
c3VzcGVuZCwNCj4gKwkJCQlwbV9ydW50aW1lX2ZvcmNlX3Jlc3VtZSkNCj4gIAlTRVRfUlVOVElN
RV9QTV9PUFMoY3M0Mnh4OF9ydW50aW1lX3N1c3BlbmQsDQo+IGNzNDJ4eDhfcnVudGltZV9yZXN1
bWUsIE5VTEwpDQo+ICB9Ow0KPiAgRVhQT1JUX1NZTUJPTF9HUEwoY3M0Mnh4OF9wbSk7DQo=
