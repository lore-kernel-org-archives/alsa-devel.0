From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Subject: Re:
 =?utf-8?q?=5BPATCH_1/2=5D_ASoC=3A_Add_driver_for_CLP?=
 =?utf-8?q?S711X_DAI_interface?=
Date: Thu, 27 Feb 2014 11:17:27 +0400
Message-ID: <1393485447.431844445@f286.i.mail.ru>
References: <1393430741-16272-1-git-send-email-shc_work@mail.ru>
 <1393430741-16272-2-git-send-email-shc_work@mail.ru>
 <20140227034430.GB9383@sirena.org.uk>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f286.i.mail.ru (f286.i.mail.ru [217.69.128.253])
 by alsa0.perex.cz (Postfix) with ESMTP id C163A261AC7
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 08:17:30 +0100 (CET)
In-Reply-To: <20140227034430.GB9383@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?TWFyayBCcm93bg==?= <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, =?UTF-8?B?QXJuZCBCZXJnbWFubg==?= <arnd@arndb.de>, =?UTF-8?B?VGFrYXNoaSBJd2Fp?= <tiwai@suse.de>, =?UTF-8?B?TGlhbSBHaXJkd29vZA==?= <lgirdwood@gmail.com>, =?UTF-8?B?T2xvZiBKb2hhbnNzb24=?= <olof@lixom.net>
List-Id: alsa-devel@alsa-project.org

0KfQtdGC0LLQtdGA0LMsIDI3INGE0LXQstGA0LDQu9GPIDIwMTQsIDEyOjQ0ICswOTowMCDQvtGC
IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz46Cj4gT24gV2VkLCBGZWIgMjYsIDIwMTQg
YXQgMDg6MDU6NDFQTSArMDQwMCwgQWxleGFuZGVyIFNoaXlhbiB3cm90ZToKPiAKPiA+ICtzdGF0
aWMgaW50IGNscHM3MTF4X2RhaV9zZXRfY2xrZGl2KHN0cnVjdCBzbmRfc29jX2RhaSAqZGFpLCBp
bnQgZGl2X2lkLCBpbnQgZGl2KQo+ID4gK3sKPiA+ICsJc3RydWN0IGNscHM3MTF4X2RhaSAqcyA9
IGRldl9nZXRfZHJ2ZGF0YShkYWktPmRldik7Cj4gPiArCj4gPiArCXMtPmRpdjIgPSBkaXY7Cj4g
PiArCj4gPiArCXJldHVybiAwOwo+ID4gK30KPiAKPiBXaGF0IGlzIHRoaXMgZGl2aWRlciBhbmQg
d2h5IGRvZXMgdGhlIG1hY2hpbmUgZHJpdmVyIG5lZWQgdG8gbWFudWFsbHkKPiBjb25maWd1cmUg
aXQ/CgpJJ2xsIHRoaW5rIGFib3V0IGl0IC4uLgoKPiA+ICtzdGF0aWMgaW50IGNscHM3MTF4X3Bj
bV90cmlnZ2VyKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLCBpbnQgY21kKQo+
ID4gK3sKPiA+ICsJc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCA9IHN1YnN0cmVhbS0+
cHJpdmF0ZV9kYXRhOwo+ID4gKwlzdHJ1Y3QgY2xwczcxMXhfZGFpICpkYWkgPSBzbmRfc29jX3Bs
YXRmb3JtX2dldF9kcnZkYXRhKHJ0ZC0+cGxhdGZvcm0pOwo+ID4gKwo+ID4gKwlzd2l0Y2ggKGNt
ZCkgewo+ID4gKwljYXNlIFNORFJWX1BDTV9UUklHR0VSX1NUQVJUOgo+ID4gKwkJYXRvbWljX3Nl
dCgmZGFpLT5ydW5uaW5nLCAxKTsKPiA+ICsJCWhydGltZXJfc3RhcnQoJmRhaS0+aHJ0LCBuc190
b19rdGltZShkYWktPnJlbG9hZCksCj4gPiArCQkJICAgICAgSFJUSU1FUl9NT0RFX1JFTCk7Cj4g
PiArCQlicmVhazsKPiAKPiBJJ20gd29uZGVyaW5nIGlmIHRoZSBGSVEgY29kZSBjYW4gYmUgc2hh
cmVkIHdpdGggdGhlIGkuTVggRklRIGNvZGU/ICBOb3QKPiBzb21ldGhpbmcgdGhhdCBzaG91bGQg
YmxvY2sgbWVyZ2luZyBidXQgaXQgc2VlbXMgbGlrZSBpdCBtaWdodCBiZQo+IGhlbHBmdWwgZm9y
IG90aGVyIHBsYXRmb3JtcyB0aGF0IG5lZWQgdG8gdXNlIEZJUSBzdXBwb3J0LgoKVGhpcyBGSVEg
aW1wbGVtZW50YXRpb24gYW5kIGkuTVggRklRIGlzIHRvdGFsbHkgZGlmZmVyZW50LgpJIGFtIGZ1
bGx5IGNvbmZpZGVudCB0aGF0IHdlIGNhbiBub3QgdXNlIGFueSBjb21tb24gZmVhdHVyZXMvY2Fs
bHMuCgo+ID4gK3N0YXRpYyBpbnQgY2xwczcxMXhfcGNtX3NpbGVuY2Uoc3RydWN0IHNuZF9wY21f
c3Vic3RyZWFtICpzdWJzdHJlYW0sCj4gPiArCQkJCWludCBjaGFubmVsLCBzbmRfcGNtX3VmcmFt
ZXNfdCBwb3MsCj4gPiArCQkJCXNuZF9wY21fdWZyYW1lc190IGNvdW50KQo+ID4gK3sKPiA+ICsJ
cmV0dXJuIDA7Cj4gPiArfQo+IAo+IE9taXQgZW1wdHkgZnVuY3Rpb25zLgoKU28gZGVzaWduZWQu
IEknbGwgYWRkIGEgY29tbWVudCBpbiB0aGUgbmV4dCB2ZXJzaW9uLgoKPiA+ICsjaWYgZGVmaW5l
ZChDT05GSUdfU05EX0NMUFM3MTFYX1NPQ19NT0RVTEUpCj4gPiAraXJxcmV0dXJuX3Qgbm9fYWN0
aW9uKGludCBpcnEsIHZvaWQgKmRldl9pZCkKPiA+ICt7Cj4gPiArCXJldHVybiBJUlFfTk9ORTsK
PiA+ICt9Cj4gPiArI2VuZGlmCj4gCj4gRWg/ICBXYWh0J3MgdGhpcyBhYm91dD8KCkluIGNhc2Ug
dXNpbmcgdGhpcyBkcml2ZXIgYXMgbm9uLW1vZHVsZSwgIm5vX2FjdGlvbiIgaGFuZGxlciBpcyB1
c2VkCmZyb20ga2VybmVsL2lycS9oYW5kbGUuYywgYnV0IHNpbmNlIGl0IGlzIG5vdCBleHBvcnRl
ZCBpdCBjYW5ub3QgYmUgdXNlZAppbiBtb2R1bGUgY2FzZS4KSSdsbCByZW1hZGUgdGhpcyB0byB1
c2Ugb3duIGVtcHR5IGhhbmRsZXIgYWx3YXlzLgoKLS0tCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
