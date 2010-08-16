From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 4/7] ASoC: Automatically calculate clock
 ratio for WM8580
Date: Mon, 16 Aug 2010 13:16:15 +0900
Message-ID: <AANLkTin2DtMjwgdiTnxuu+W8B2Jgfoo0VWT9EO_Tjikc@mail.gmail.com>
References: <20100813193305.GB3778@sirena.org.uk>
	<1281728107-25386-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6649D1037F5
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 06:16:16 +0200 (CEST)
Received: by wyb42 with SMTP id 42so5237611wyb.38
	for <alsa-devel@alsa-project.org>; Sun, 15 Aug 2010 21:16:15 -0700 (PDT)
In-Reply-To: <1281728107-25386-4-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Seungwhan Youn <sw.youn@samsung.com>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBBdWcgMTQsIDIwMTAgYXQgNDozNSBBTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgoKLi4uLi4KCj4gK3N0YXRpYyBpbnQgd204
NTgwX3NldF9zeXNjbGsoc3RydWN0IHNuZF9zb2NfZGFpICpkYWksIGludCBjbGtfaWQsCj4gKyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVuc2lnbmVkIGludCBmcmVx
LCBpbnQgZGlyKQo+ICt7Cj4gKyDCoCDCoCDCoCBzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMg
PSBkYWktPmNvZGVjOwo+ICsgwqAgwqAgwqAgc3RydWN0IHdtODU4MF9wcml2ICp3bTg1ODAgPSBz
bmRfc29jX2NvZGVjX2dldF9kcnZkYXRhKGNvZGVjKTsKPiArIMKgIMKgIMKgIGludCBzZWwsIHNl
bF9tYXNrLCBzZWxfc2hpZnQ7Cj4gKwo+ICsgwqAgwqAgwqAgc3dpdGNoIChkYWktPmRyaXZlci0+
aWQpIHsKPiArIMKgIMKgIMKgIGNhc2UgV004NTgwX0RBSV9QQUlGVFg6CgogICAgc2hvdWxkIGJl
ICBXTTg1ODBfREFJX1BBSUZSWDoKCkJlY2F1c2UsIFdNODU4MF9EQUlfUEFJRlRYIC0tPiBDYXB0
dXJlIC0tPiBBREMuCgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2VsX21hc2sgPSAweDM7Cj4g
KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzZWxfc2hpZnQgPSAwOwo+ICsgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgYnJlYWs7Cj4gKwo+ICsgwqAgwqAgwqAgY2FzZSBXTTg1ODBfREFJX1BBSUZSWDogIC0t
PiBUWAoKICAgIHNob3VsZCBiZSAgV004NTgwX0RBSV9QQUlGVFg6CgpCZWNhdXNlLCBXTTg1ODBf
REFJX1BBSUZSWCAtLT4gUGxheWJhY2sgLS0+IERBQy4KCgoKPiArIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHNlbF9tYXNrID0gMHhjOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2VsX3NoaWZ0ID0g
MzsKClNob3VsZG4ndCB0aGUgc2hpZnQgYmUgMiA/CgouLi4uCgo+ICsgwqAgwqAgwqAgLyogV2Ug
cmVhbGx5IHNob3VsZCB2YWxpZGF0ZSBQTEwgc2V0dGluZ3MgYnV0IG5vdCB5ZXQgKi8KPiArIMKg
IMKgIMKgIHdtODU4MC0+c3lzY2xrW2RhaS0+aWRdID0gZnJlcTsKPiArCj4gKyDCoCDCoCDCoCBy
ZXR1cm4gc25kX3NvY191cGRhdGVfYml0cyhjb2RlYywgV004NTgwX0NMS1NFTCwgc2VsLCBzZWxf
bWFzayk7CgpTZWVtcyB0aGUgdmFsdWUgYW5kIG1hc2sgYXJndW1lbnRzIGFyZSBzd2FwcGVkID8K
ClRoYW5rcywKQ2xhdWRlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
