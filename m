From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH tinycompress] cplay: Stop playback stream
 at the end
Date: Wed, 27 Jun 2018 11:15:15 +0000
Message-ID: <1530098114.2102.36.camel@nxp.com>
References: <1530085691-27736-1-git-send-email-daniel.baluta@nxp.com>
 <20180627102424.GH22377@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0056.outbound.protection.outlook.com [104.47.1.56])
 by alsa0.perex.cz (Postfix) with ESMTP id 833A4267610
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 13:15:17 +0200 (CEST)
In-Reply-To: <20180627102424.GH22377@vkoul-mobl>
Content-Language: en-US
Content-ID: <12F11A273045E4429F470A47A3FD446C@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "vkoul@kernel.org" <vkoul@kernel.org>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

T24gTWksIDIwMTgtMDYtMjcgYXQgMTU6NTQgKzA1MzAsIFZpbm9kIHdyb3RlOg0KPiBPbiAyNy0w
Ni0xOCwgMTA6NDgsIERhbmllbCBCYWx1dGEgd3JvdGU6DQo+ID4gDQo+ID4gRWFjaCBjb21wcmVz
c19zdGFydCBzaG91bGQgaGF2ZSBhIGNvcnJlc3BvbmRpbmcgY29tcHJlc3Nfc3RvcA0KPiA+IGF0
IHRoZSBlbmQuDQo+ID4gDQo+ID4gQWxzbywgdGhpcyBnaXZlcyB1c2VyIGEgY2hhbmdlIHRvIGNs
ZWFudXAgcmVzb3VyY2VzIHRoYXQgbWlnaHQNCj4gPiBoYXZlIGJlZW4gYWxsb2NhdGVkIGluIGNv
bXByZXNzX3N0YXJ0Lg0KPiBJIHRoaW5rIHRoZSBhc3N1bXB0aW9ucyBhcmUgbm90IHF1aXRlIGNv
cnJlY3QgaGVyZSwgcmVzb3VyY2VzIHNob3VsZA0KPiBiZQ0KPiBhbGxvY2F0ZWQgaW4gLm9wZW4g
YW5kIGNsZWFudXAgaW4gLmZyZWUgZm9yIGRyaXZlciBjYWxsYmFjay4NCj4gDQo+ID4gDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29t
Pg0KPiA+IC0tLQ0KPiA+IEknbSBpbXBsZW1lbnRpbmcgY29kZWMgbGlicmFyeSBkeW5hbWljIGxv
YWRpbmcgYXQgcnVudGltZSBhbmQgSSdtDQo+ID4gZXhwbG9yaW5nDQo+ID4gdXNpbmc6DQo+ID4g
CSogU05EUlZfQ09NUFJFU1NfU1RBUlQgLT4gdG8gbG9hZCB0aGUgbGlicmFyeQ0KPiA+IAkqIFNO
RFJWX0NPTVBSRVNTX1NUT1DCoMKgLT4gdG8gdW5sb2FkIHRoZSBsaWJyYXJ5DQo+ID4gDQo+ID4g
VGhpcyBtaWdodCBub3QgYmUgdGhlIGJlc3QgaWRlYSBiZWNhc3VlIGZvciBleGFtcGxlIGxvYWRp
bmcNCj4gPiB0aGUgbGlicmFyeSBtaWdodCBpbnRyb2R1Y2Ugc29tZSBkZWxheXMsIGFueWhvdyBp
IHN0aWxsIHRoaW5rDQo+ID4gdGhpcyB0aGF0IGNvbXByZXNzX3N0b3AgaXMgY29ycmVjdCB0aGlu
ZyB0byBhZGQgYXQgdGhlIGVuZCBvZg0KPiA+IHBsYXliYWNrLg0KPiBJIHRoaW5rIHlvdSBzaG91
bGQgdGllIHRoZSBsaWJyYXJ5IGxvYWQgdG8gbXVjaCBlYXJsaWVyIGluIHBhdGguIE5vdA0KPiBp
bg0KPiBzdGFydC4NCj4gDQo+IEFsc28sIHdlIGludm9rZSBkcmFpbiBhbmQgaGVuY2UgdGhlcmUg
aXMgbm8gbmVlZCBvZiBzdG9wDQoNCkdvdCB5b3VyIHBvaW50IGhlcmUuwqANCg0KUGVyaGFwcywN
Cg0KwqAtIHVzZSAuaHdfcGFyYW1zIHRvIGxvYWQgdGhlIGNvZGVjIGxpYnJhcnkuDQrCoC0gYWRk
IC5od19mcmVlIChhcyBMaWFtIHN1Z2dlc3RlZCBpbiBhIHNlcGFyYXRlIGVtYWlsKSB0byB1bmxv
YWQgdGhlIMKgIMKgIMKgY29kZWMgbGlicmFyeS4NCg0KVGhhbmtzIHdlIGNhbiBkcm9wIHRoaXMg
cGF0Y2ggdGhlbi4NCg0KRGFuaWVsLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
