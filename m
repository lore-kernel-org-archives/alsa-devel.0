From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 2/3] mfd: wm5110: Add register patch for
 rev E and above
Date: Tue, 7 Jul 2015 16:08:21 +0100
Message-ID: <20150707150821.GK3182@x1>
References: <1436279294-13672-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1436279294-13672-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 9936C2654CD
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 17:08:24 +0200 (CEST)
Received: by wifm2 with SMTP id m2so62608976wif.1
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2015 08:08:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436279294-13672-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAwNyBKdWwgMjAxNSwgQ2hhcmxlcyBLZWVwYXggd3JvdGU6Cgo+IEFkZCBhIHJlZ2lz
dGVyIHBhdGNoIGZvciByZXYgRSBhbmQgYWJvdmUgdGhhdCBjb25maWd1cmVzIHRoZSBsb2NhdGlv
biBvZgo+IHNvbWUgd3JpdGUgc2VxdWVuY2VzIHRvIGFzc2lzdCB3aXRoIHRoZSBoZWFkcGhvbmUg
ZW5hYmxlcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaGFybGVzIEtlZXBheCA8Y2tlZXBheEBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+Cj4gLS0tCj4gCj4gQ2hhbmdlcyBzaW5jZSB2MjoKPiAg
LSBNb3ZlZCBjb21tZW50IHRvIGNvdmVyIHdob2xlIHJlZ2lzdGVyIHBhdGNoCj4gCj4gVGhhbmtz
LAo+IENoYXJsZXMKPiAKPiAgZHJpdmVycy9tZmQvd201MTEwLXRhYmxlcy5jIHwgICAxNCArKysr
KysrKysrKysrLQo+ICAxIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b25zKC0pCgpBY2tlZC1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbWZkL3dtNTExMC10YWJsZXMuYyBiL2RyaXZlcnMvbWZkL3dtNTEx
MC10YWJsZXMuYwo+IGluZGV4IDYyYTRhYTEuLmUwODkyNDIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9tZmQvd201MTEwLXRhYmxlcy5jCj4gKysrIGIvZHJpdmVycy9tZmQvd201MTEwLXRhYmxlcy5j
Cj4gQEAgLTI0OSw2ICsyNDksMTYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByZWdfZGVmYXVsdCB3
bTUxMTBfcmV2ZF9wYXRjaFtdID0gewo+ICAJeyAweDgwLCAweDAgfSwKPiAgfTsKPiAgCj4gKy8q
IEFkZCBleHRyYSBoZWFkcGhvbmUgd3JpdGUgc2VxdWVuY2UgbG9jYXRpb25zICovCj4gK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgcmVnX2RlZmF1bHQgd201MTEwX3JldmVfcGF0Y2hbXSA9IHsKPiArCXsg
MHg4MCwgMHgzIH0sCj4gKwl7IDB4ODAsIDB4MyB9LAo+ICsJeyAweDRiLCAweDEzOCB9LAo+ICsJ
eyAweDRjLCAweDEzZCB9LAo+ICsJeyAweDgwLCAweDAgfSwKPiArCXsgMHg4MCwgMHgwIH0sCj4g
K307Cj4gKwo+ICAvKiBXZSB1c2UgYSBmdW5jdGlvbiBzbyB3ZSBjYW4gdXNlIEFSUkFZX1NJWkUo
KSAqLwo+ICBpbnQgd201MTEwX3BhdGNoKHN0cnVjdCBhcml6b25hICphcml6b25hKQo+ICB7Cj4g
QEAgLTI2Niw3ICsyNzYsOSBAQCBpbnQgd201MTEwX3BhdGNoKHN0cnVjdCBhcml6b25hICphcml6
b25hKQo+ICAJCQkJCSAgICAgd201MTEwX3JldmRfcGF0Y2gsCj4gIAkJCQkJICAgICBBUlJBWV9T
SVpFKHdtNTExMF9yZXZkX3BhdGNoKSk7Cj4gIAlkZWZhdWx0Ogo+IC0JCXJldHVybiAwOwo+ICsJ
CXJldHVybiByZWdtYXBfcmVnaXN0ZXJfcGF0Y2goYXJpem9uYS0+cmVnbWFwLAo+ICsJCQkJCSAg
ICAgd201MTEwX3JldmVfcGF0Y2gsCj4gKwkJCQkJICAgICBBUlJBWV9TSVpFKHdtNTExMF9yZXZl
X3BhdGNoKSk7Cj4gIAl9Cj4gIH0KPiAgRVhQT1JUX1NZTUJPTF9HUEwod201MTEwX3BhdGNoKTsK
Ci0tIApMZWUgSm9uZXMKTGluYXJvIFNUTWljcm9lbGVjdHJvbmljcyBMYW5kaW5nIFRlYW0gTGVh
ZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93
IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
