From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] aplay: Fix error message when writing
	captured data
Date: Fri, 7 Apr 2017 13:13:40 +0000
Message-ID: <1491570819.6595.12.camel@nxp.com>
References: <1491567280-20273-1-git-send-email-daniel.baluta@nxp.com>
 <e7879bd4-2a31-2869-068f-43b828fe2b43@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30068.outbound.protection.outlook.com [40.107.3.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C4522664EB
 for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2017 15:13:44 +0200 (CEST)
In-Reply-To: <e7879bd4-2a31-2869-068f-43b828fe2b43@sakamocchi.jp>
Content-Language: en-US
Content-ID: <0C6AE6116756D84889CBFB04E61475AC@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "o-takashi@sakamocchi.jp" <o-takashi@sakamocchi.jp>, "tiwai@suse.de" <tiwai@suse.de>
Cc: Mihai Serban <mihai.serban@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "S.J. Wang" <shengjiu.wang@nxp.com>, Viorel Suman <viorel.suman@nxp.com>
List-Id: alsa-devel@alsa-project.org

T24gVmksIDIwMTctMDQtMDcgYXQgMjE6NTYgKzA5MDAsIFRha2FzaGkgU2FrYW1vdG8gd3JvdGU6
DQo+IEhpLA0KPiANCj4gT24gQXByIDcgMjAxNyAyMToxNCwgRGFuaWVsIEJhbHV0YSB3cm90ZToN
Cj4gPiANCj4gPiBXcml0ZSBjYW4gcmV0dXJuIGxlc3MgdGhlbiByZXF1ZXN0ZWQgYnl0ZXMsIGJ1
dCB3ZSB0cmVhdA0KPiA+IHRoaXMgYXMgYW4gZXJyb3IuDQo+ID4gDQo+ID4gQW55aG93LCBlcnJu
byBpcyBub3QgdXBkYXRlZCBpbiB0aGlzIGNhc2UgYW5kIHdlIGNhbiBlbmQNCj4gPiB1cCB3aXRo
IGEgY29uZnVzaW5nIGVycm9yIG1lc3NhZ2UuDQo+ID4gDQo+ID4gRm9yIGV4YW1wbGUsIHdoZW4g
dGhlcmUgaXMgbm8gcm9vbSB0byB3cml0ZSBkYXRhIGludG8gdGhlDQo+ID4gb3V0cHV0IGZpbGUg
d2UgcmVjZWl2ZToNCj4gPiANCj4gPiAkIGFyZWNvcmQgLWQgMjAwMCAtYyAyIC1yIDE5MjAwMCAt
ZiBTMTZfTEUgLURwbHVnaHc6MCwwIGF1ZGlvLndhdg0KPiA+IFJlY29yZGluZyBXQVZFICcvbW50
L21zYy9hdWRpby53YXYnIDogU2lnbmVkIDE2IGJpdCBMaXR0bGUgRW5kaWFuLA0KPiA+IFJhdGUN
Cj4gPiAxOTIwMDAgSHosIFN0ZXJlbw0KPiA+IGF1ZGlvLndhdjogTm8gc3VjaCBmaWxlIG9yIGRp
cmVjdG9yeQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5i
YWx1dGFAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGFwbGF5L2FwbGF5LmMgfCAyICstDQo+ID4g
wqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvYXBsYXkvYXBsYXkuYyBiL2FwbGF5L2FwbGF5LmMNCj4gPiBpbmRleCBl
ZTQ4MGYyLi45NTQ3ZDFiIDEwMDY0NA0KPiA+IC0tLSBhL2FwbGF5L2FwbGF5LmMNCj4gPiArKysg
Yi9hcGxheS9hcGxheS5jDQo+ID4gQEAgLTMwNzksNyArMzA3OSw3IEBAIHN0YXRpYyB2b2lkIGNh
cHR1cmUoY2hhciAqb3JpZ19uYW1lKQ0KPiA+IMKgCQkJCWJyZWFrOw0KPiA+IMKgCQkJfQ0KPiA+
IMKgCQkJaWYgKHdyaXRlKGZkLCBhdWRpb2J1ZiwgYykgIT0gYykgew0KPiA+IC0JCQkJcGVycm9y
KG5hbWUpOw0KPiA+ICsJCQkJZnByaW50ZihzdGRlcnIsICJDb3VsZG4ndCB3cml0ZQ0KPiA+IGFs
bCBkYXRhIHRvICVzXG4iLCBuYW1lKTsNCj4gPiDCoAkJCQlpbl9hYm9ydGluZyA9IDE7DQo+ID4g
wqAJCQkJYnJlYWs7DQo+ID4gwqAJCQl9DQo+IEkgYWdyZWUgd2l0aCB0aGlzIGNoYW5nZS4NCj4g
DQo+IEEgc21hbGwgbml0cGlja2luZy4gVGhpcyB1dGlsaXR5IHN1cHBvcnRzIGkxOG4gd2l0aCBn
ZXR0ZXh0LiBMZXQgdXMNCj4gdXNlwqANCj4gZ2V0dGV4dCBhbGlhcyB0byB0aGUgbWVzc2FnZT8N
Cj4gDQo+ICQgY2QgYWxzYS11dGlscy9hcGxheQ0KPiAkIGdpdCBncmVwIGZwcmludGZcKCB8IHdj
DQo+IMKgwqDCoMKgwqDCoDU3wqDCoMKgwqDCoDM4N8KgwqDCoMKgMzkzOQ0KPiAkIGdpdCBncmVw
IGZwcmludGZcKCB8IGdyZXAgX1woIHwgd2MNCj4gwqDCoMKgwqDCoMKgMzfCoMKgwqDCoMKgMjYw
wqDCoMKgwqAyNTcwDQo+IA0KPiANCg0KU3VyZSwgd2lsbCBzZW5kIHYyLiBJIGRpZG4ndCBrbm93
IGFib3V0IHRoZSBnZXR0ZXh0IGFsaWFzLiA6KQ0KDQpEYW5pZWwuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
