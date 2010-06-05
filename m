From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] ASoC/kirkwood: patch for the useless
	'break' removal.
Date: Sat, 5 Jun 2010 15:04:40 +0800
Message-ID: <AANLkTimHsGoR4aonANTBFaTgZmXA2jZlYJ5q5WA_3gab@mail.gmail.com>
References: <4C06105B.2060702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F148B103B43
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Jun 2010 09:04:46 +0200 (CEST)
Received: by vws8 with SMTP id 8so2325762vws.38
	for <alsa-devel@alsa-project.org>; Sat, 05 Jun 2010 00:04:44 -0700 (PDT)
In-Reply-To: <4C06105B.2060702@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, zswan@marvell.com
List-Id: alsa-devel@alsa-project.org

SGkgTWFyaywKCkhvdyBhYm91dCB0aGlzIHBhdGNoPwpNeSBvdGhlciBwYXRjaCBzZWVtIHRvIGJl
IGFwcGxpZWQsIGJ1dCB0aGlzIG9uZSBzdGlsbCBiZSBodW5nLgoK5ZyoIDIwMTDlubQ25pyIMuaX
pSDkuIvljYg0OjAz77yMV2FuIFpvbmdTaHVuIDxtY3Vvcy5jb21AZ21haWwuY29tPiDlhpnpgZPv
vJoKPiBUaGlzIHBhdGNoIHRvIHJlbW92ZSB0aGUgJ2JyZWFrOycsIHdoZW4gdGhlICdzd2l0Y2gn
IGp1bXBzIHRvCj4gdGhlICdkZWZhdWx0JyBicmFuY2gsIHRoZSAncmV0dXJuIC1FSU5WQUwnIHdp
bGwgYmUgcmV0dXJuIHdpdGgKPiBhIGVycm9yIG51bWJlciwgc28gdGhlICdicmVhazsnIGNvZGUg
bmV2ZXIgYmUgcnVuLCBpdCBpcyB1bnVzZWZ1bAo+IGFuZCBzaG91bGQgYmUgcmVtb3ZlZCBoZXJl
Lgo+Cj4KPiBTaWduZWQtb2ZmLWJ5OiBXYW4gWm9uZ1NodW48bWN1b3MuY29tQGdtYWlsLmNvbT4K
PiAtLS0KPiDCoHNvdW5kL3NvYy9raXJrd29vZC9raXJrd29vZC1pMnMuYyB8IMKgIMKgMSAtCj4g
wqAxIGZpbGVzIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9zb3VuZC9zb2Mva2lya3dvb2Qva2lya3dvb2QtaTJzLmMgYi9zb3VuZC9zb2Mv
a2lya3dvb2Qva2lya3dvb2QtaTJzLmMKPiBpbmRleCAwYWRjNTk3Li4wZmRjN2RiIDEwMDY0NAo+
IC0tLSBhL3NvdW5kL3NvYy9raXJrd29vZC9raXJrd29vZC1pMnMuYwo+ICsrKyBiL3NvdW5kL3Nv
Yy9raXJrd29vZC9raXJrd29vZC1pMnMuYwo+IEBAIC0yOTYsNyArMjk2LDYgQEAgc3RhdGljIGlu
dCBraXJrd29vZF9pMnNfcmVjX3RyaWdnZXIoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJz
dHJlYW0sCj4KPiDCoCDCoCDCoCDCoGRlZmF1bHQ6Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gLUVJTlZBTDsKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOwo+IMKgIMKgIMKg
IMKgfQo+Cj4gwqAgwqAgwqAgwqByZXR1cm4gMDsKPiAtLQo+IDEuNi4zLjMKPgoKCgotLSAKKmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cm1haWwgYWRkcjpsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKeW91IGNhbiBzdWJzY3JpYmUgYnk6Cmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAoKKiBsaW51eC1hcm0t
TlVDOTAwIG1haWxpbmcgbGlzdAptYWlsIGFkZHI6TlVDOTAwQGdvb2dsZWdyb3Vwcy5jb20KbWFp
biB3ZWI6IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZ3JvdXAvTlVDOTAwCnlvdSBjYW4gc3Vi
c2NyaWJlIGl0IGJ5IHNlbmRpbmcgbWUgbWFpbDoKbWN1b3MuY29tQGdtYWlsLmNvbQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
