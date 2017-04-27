From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 1/2] ASoC: codec: wm9860: avoid
 maybe-uninitialized warning
Date: Thu, 27 Apr 2017 11:02:52 +0000
Message-ID: <1493290972.18400.40.camel@nxp.com>
References: <1493212192-7930-1-git-send-email-daniel.baluta@nxp.com>
 <1493212192-7930-2-git-send-email-daniel.baluta@nxp.com>
 <CAK8P3a1ZGTyjhAzy4h2D10+-dFNi6o_qe0pY9Wx5wYXZK6ObDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0081.outbound.protection.outlook.com [104.47.0.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E5C0266483
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 13:02:57 +0200 (CEST)
In-Reply-To: <CAK8P3a1ZGTyjhAzy4h2D10+-dFNi6o_qe0pY9Wx5wYXZK6ObDw@mail.gmail.com>
Content-Language: en-US
Content-ID: <E07B3C5EF9F09D46BFE5512A93220712@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "arnd@arndb.de" <arnd@arndb.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

T24gSm8sIDIwMTctMDQtMjcgYXQgMTI6MDcgKzAyMDAsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+
IE9uIFdlZCwgQXByIDI2LCAyMDE3IGF0IDM6MDkgUE0sIERhbmllbCBCYWx1dGEgPGRhbmllbC5i
YWx1dGFAbnhwLmNvbQ0KPiA+IHdyb3RlOg0KPiA+IA0KPiA+IFRoZSBuZXcgUExMIGNvbmZpZ3Vy
YXRpb24gY29kZSB0cmlnZ2VycyBhIGhhcm1sZXNzIHdhcm5pbmc6DQo+ID4gDQo+ID4gc291bmQv
c29jL2NvZGVjcy93bTg5NjAuYzogSW4gZnVuY3Rpb24gJ3dtODk2MF9jb25maWd1cmVfY2xvY2tp
bmcnOg0KPiA+IHNvdW5kL3NvYy9jb2RlY3Mvd204OTYwLmM6NzM1OjM6IGVycm9yOiAnYmVzdF9m
cmVxX291dCcgbWF5IGJlIHVzZWQNCj4gPiB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24g
Wy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0NCj4gPiDCoMKgwqB3bTg5NjBfc2V0X3BsbChj
b2RlYywgZnJlcV9pbiwgYmVzdF9mcmVxX291dCk7DQo+ID4gwqDCoMKgXn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4gc291bmQvc29jL2NvZGVjcy93bTg5
NjAuYzo2OTk6MTI6IG5vdGU6ICdiZXN0X2ZyZXFfb3V0JyB3YXMNCj4gPiBkZWNsYXJlZA0KPiA+
IGhlcmUNCj4gPiANCj4gPiBGaXggdGhpcyBieSByZXdvcmtpbmcgdGhlIGNvZGUgc3VjaCB0aGF0
Og0KPiA+IA0KPiA+IDEpIFdoZW4gdGhlcmUgaXMgbm8gUExMIGZyZXEgYXZhaWxhYmxlIHJldHVy
biAtRUlOVkFMIGFuZCBtYWtlDQo+ID4gc3VyZSAqYmNsa19pZHgsICpkYWNfaWR4LCAqc3lzY2xr
X2lkeCBhcmUgaW5pdGlhbGl6ZWQgd2l0aA0KPiA+IGludmFsaWQgdmFsdWVzLg0KPiA+IA0KPiA+
IDIpIFdoZW4gdGhlcmUgaXMgYSBQTEwgZnJlcSBhdmFpbGFibGUgaW5pdGlhbGl6ZSAqYmNsa19p
ZHgsDQo+ID4gKmRhY19pZHggYW5kICpzeXNjbGtfaWR4IHdpdGggY29ycmVjdCB2YWx1ZXMgYW5k
IGltbWVkaWF0ZWx5DQo+ID4gcmV0dXJuIHRoZSBmcmVxIGF2YWlsYWJsZS4NCj4gPiANCj4gPiBG
aXhlczogODRmZGMwMGQ1MTlmICgiQVNvQzogY29kZWM6IHdtOTg2MDogUmVmYWN0b3IgUExMIG91
dCBmcmVxDQo+ID4gc2VhcmNoIikNCj4gPiBGaXhlczogMzAzZTg5NTRhZjhkICgiQVNvQzogY29k
ZWM6IHdtODk2MDogU3RvcCB3aGVuIGEgbWF0Y2hpbmcgUExMDQo+ID4gZnJlcSBpcyBmb3VuZCIp
DQo+ID4gU3VnZ2VzdGVkLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCj4gTG9v
a3MgZ29vZCB0byBtZS4gTGV0IG1lIGtub3cgaWYgeW91IG5lZWQgbWUgdG8gdGVzdCB0aGlzIG1v
cmUNCj4gdGhvcm91Z2hseQ0KPiB3aXRoIHJhbmRjb25maWcgYnVpbGRzLCBvdGhlcndpc2UgSSds
bCBhc3N1bWUgaXQncyBmaW5lIGFuZCBpdCB3aWxsDQo+IGdldCB0ZXN0ZWQgb25jZQ0KPiBpdCBz
aG93cyB1cCBpbiBsaW51eC1uZXh0Lg0KPiANCj4gQWNrZWQtYnk6IEFybmQgQmVyZ21hbm4gPGFy
bmRAYXJuZGIuZGU+DQo+IA0KDQpIaSBBcm5kLMKgDQoNClRoYW5rcyBmb3IgZG9pbmcgdGhpcy4g
SSB3b3VsZG4ndCBleHBlY3QgcmFuZGNvbmZpZ3MgYnVpbGRzIHRvIHNob3cNCm90aGVyIGlzc3Vl
cy4NCg0KQW55aG93LCB3b3VsZCBsaWtlIHRvIHNlZSBpZiB3aXRoIHlvdXIgY29tcGlsZXIgdGhl
cmUgYXJlIG5vIHdhcm5pbmdzDQpmb3IgdGhlIHNlY29uZCBwYXRjaCBvZiB0aGUgc2VyaWVzOg0K
DQpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL3BpcGVybWFpbC9hbHNhLWRldmVsLzIw
MTctQXByaWwvMTIwMTc3Lmh0bWwNCg0KdGhhbmtzLA0KRGFuaWVsLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
