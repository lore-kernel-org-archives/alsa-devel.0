From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 5/5] ASoC: S3C64XX: Fix to support BCLK,
	LRCLK rates 	setting
Date: Fri, 6 Aug 2010 15:02:49 +0900
Message-ID: <AANLkTikQ2Mb=7mKghxJep-h4m2Myi3kF1ugKQHrjf1_y@mail.gmail.com>
References: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
	<1281054999-18243-1-git-send-email-sw.youn@samsung.com>
	<AANLkTim2g4=j0TdYZb7QCbyZVJvhxMsCFa4yFokJCu1W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C98B24133
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 08:02:49 +0200 (CEST)
Received: by wwb17 with SMTP id 17so4453385wwb.20
	for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2010 23:02:49 -0700 (PDT)
In-Reply-To: <AANLkTim2g4=j0TdYZb7QCbyZVJvhxMsCFa4yFokJCu1W@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBBdWcgNiwgMjAxMCBhdCAxOjI1IFBNLCBKYXNzaSBCcmFyIDxqYXNzaXNpbmdoYnJh
ckBnbWFpbC5jb20+IHdyb3RlOgo+IE9uIEZyaSwgQXVnIDYsIDIwMTAgYXQgOTozNiBBTSwgU2V1
bmd3aGFuIFlvdW4gPHN3LnlvdW5Ac2Ftc3VuZy5jb20+IHdyb3RlOgo+PiBUaGlzIHBhdGNoIGZp
eCB0byBzdXBwb3J0IEJDTEsgYW5kIExSQ0xLIHJhdGVzIHNldHRpbmcgYXMKPj4gd204NTgwIE1h
c3RlciBtb2RlLiBBZnRlciBhcHBseSB0aGlzIHBhdGNoLCBMUkNMSyBhbmQgQkNMSwo+PiBzaWdu
YWwgYXBwZWFycyBjb3JyZWN0bHkgZnJvbSB3bTg1ODAgaW4gc29tZSBmcmVxLiwgOGtIego+PiBh
bmQgMTEuMDI1a0h6LCBvbiBTTURLIGJvYXJkLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTZXVuZ3do
YW4gWW91biA8c3cueW91bkBzYW1zdW5nLmNvbT4KPj4gLS0tCj4+IMKgc291bmQvc29jL3MzYzI0
eHgvc21kazY0eHhfd204NTgwLmMgfCDCoCDCoDQgKystLQo+PiDCoDEgZmlsZXMgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvc291bmQv
c29jL3MzYzI0eHgvc21kazY0eHhfd204NTgwLmMgYi9zb3VuZC9zb2MvczNjMjR4eC9zbWRrNjR4
eF93bTg1ODAuYwo+PiBpbmRleCAzOWJiNzAxLi5mM2RiZGZiIDEwMDY0NAo+PiAtLS0gYS9zb3Vu
ZC9zb2MvczNjMjR4eC9zbWRrNjR4eF93bTg1ODAuYwo+PiArKysgYi9zb3VuZC9zb2MvczNjMjR4
eC9zbWRrNjR4eF93bTg1ODAuYwo+PiBAQCAtMTI0LDExICsxMjQsMTEgQEAgc3RhdGljIGludCBz
bWRrNjR4eF9od19wYXJhbXMoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCj4+
IMKgIMKgIMKgIMKgaWYgKHJldCA8IDApCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
IHJldDsKPj4KPj4gLSDCoCDCoCDCoCByZXQgPSBzbmRfc29jX2RhaV9zZXRfY2xrZGl2KGNwdV9k
YWksIFMzQ19JMlNWMl9ESVZfQkNMSywgYmZzKTsKPj4gKyDCoCDCoCDCoCByZXQgPSBzbmRfc29j
X2RhaV9zZXRfY2xrZGl2KGNvZGVjX2RhaSwgV004NTgwX0JDTEtfUkFURSwgYmZzKTsKPj4gwqAg
wqAgwqAgwqBpZiAocmV0IDwgMCkKPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0
Owo+Pgo+PiAtIMKgIMKgIMKgIHJldCA9IHNuZF9zb2NfZGFpX3NldF9jbGtkaXYoY3B1X2RhaSwg
UzNDX0kyU1YyX0RJVl9SQ0xLLCByZnMpOwo+PiArIMKgIMKgIMKgIHJldCA9IHNuZF9zb2NfZGFp
X3NldF9jbGtkaXYoY29kZWNfZGFpLCBXTTg1ODBfTFJDTEtfUkFURSwgcmZzKTsKPj4gwqAgwqAg
wqAgwqBpZiAocmV0IDwgMCkKPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Owo+
Cj4gaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9waXBlcm1haWwvYWxzYS1kZXZlbC8y
MDA5LVNlcHRlbWJlci8wMjEwMDUuaHRtbAo+IGlzIHdoYXQgSSBtZWFudCBhIGZldyBkYXlzIGFn
byB3aGVuIEkgc2FpZCBpdCBzaG91bGQgYmUgZG9uZSBwcm9wZXJseS4KCkkgc2VlLCBpZiBNYXJr
J3Mgb3BpbmlvbiBpcyBzYW1lIGFzIGJlZm9yZSwgSSB0aGluayBJIGNhbiB0cnkgdG8gbWFrZQph
bm90aGVyIHBhdGNoIGZvciBpdC4gOikKCj4KPiBBbHNvLCBJIGFtIG5vdCBzdXJlIGlmIHdlIGNh
biBkbyB3aXRob3V0IHNldHRpbmcgUkZTLEJGUyBvbiBDUFUgc2lkZQo+IGV2ZW4gaW4gc2xhdmUg
bW9kZS4gV2UgbmVlZCB0byBjb25maXJtLgo+CgpPa2F5LCBJIGFncmVlIHRvIGNvbmZpcm0gdGhp
cyBhdCB0aGUgSC9XIGRlc2lnbiBwb2ludCBvZiB2aWV3LgoKVGhhbmtzLAoKQ2xhdWRlCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
