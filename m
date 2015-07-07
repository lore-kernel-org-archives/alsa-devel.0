From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/3] mfd: wm5110: Add register patch for
 rev E and above
Date: Tue, 7 Jul 2015 11:52:55 +0100
Message-ID: <20150707105255.GT3182@x1>
References: <1436260993-8814-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1436260993-8814-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 0671B26058A
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 12:52:59 +0200 (CEST)
Received: by wiclp1 with SMTP id lp1so46715415wic.0
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2015 03:52:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436260993-8814-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
c291cmNlLndvbGZzb25taWNyby5jb20+Cj4gLS0tCj4gCj4gQ2hhbmdlcyBzaW5jZSB2MToKPiAg
LSBBZGRlZCBhIGNvbW1lbnQgd2l0aCB0aGUgd3JpdGUgc2VxdWVuY2UKPiAKPiBUaGFua3MsCj4g
Q2hhcmxlcwo+IAo+ICBkcml2ZXJzL21mZC93bTUxMTAtdGFibGVzLmMgfCAgIDEzICsrKysrKysr
KysrKy0KPiAgMSBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygt
KQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC93bTUxMTAtdGFibGVzLmMgYi9kcml2ZXJz
L21mZC93bTUxMTAtdGFibGVzLmMKPiBpbmRleCA2MmE0YWExLi5iNzBmNzZiIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvbWZkL3dtNTExMC10YWJsZXMuYwo+ICsrKyBiL2RyaXZlcnMvbWZkL3dtNTEx
MC10YWJsZXMuYwo+IEBAIC0yNDksNiArMjQ5LDE1IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVn
X2RlZmF1bHQgd201MTEwX3JldmRfcGF0Y2hbXSA9IHsKPiAgCXsgMHg4MCwgMHgwIH0sCj4gIH07
Cj4gIAo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ19kZWZhdWx0IHdtNTExMF9yZXZlX3BhdGNo
W10gPSB7Cj4gKwl7IDB4ODAsIDB4MyB9LAo+ICsJeyAweDgwLCAweDMgfSwKPiArCXsgMHg0Yiwg
MHgxMzggfSwgLyogQWRkIGV4dHJhIGhlYWRwaG9uZSB3cml0ZSBzZXF1ZW5jZSBsb2NhdGlvbnMg
Ki8KPiArCXsgMHg0YywgMHgxM2QgfSwKPiArCXsgMHg4MCwgMHgwIH0sCj4gKwl7IDB4ODAsIDB4
MCB9LAo+ICt9OwoKTm93IHRoZSBvdGhlciBsaW5lcyBsb29rIHVuZG9jdW1lbnRlZC4gIENhbiB5
b3UgcGxlYXNlIHByb3ZpZGUgYW4Kb3Zlci1hcmNoaW5nIGNvbW1lbnQgd2hpY2ggZGVzY3JpYmVz
IHdoYXQgdGhlIGVudGlyZSBzZXF1ZW5jZSBkb2VzCnBsZWFzZS4KCj4gIC8qIFdlIHVzZSBhIGZ1
bmN0aW9uIHNvIHdlIGNhbiB1c2UgQVJSQVlfU0laRSgpICovCj4gIGludCB3bTUxMTBfcGF0Y2go
c3RydWN0IGFyaXpvbmEgKmFyaXpvbmEpCj4gIHsKPiBAQCAtMjY2LDcgKzI3NSw5IEBAIGludCB3
bTUxMTBfcGF0Y2goc3RydWN0IGFyaXpvbmEgKmFyaXpvbmEpCj4gIAkJCQkJICAgICB3bTUxMTBf
cmV2ZF9wYXRjaCwKPiAgCQkJCQkgICAgIEFSUkFZX1NJWkUod201MTEwX3JldmRfcGF0Y2gpKTsK
PiAgCWRlZmF1bHQ6Cj4gLQkJcmV0dXJuIDA7Cj4gKwkJcmV0dXJuIHJlZ21hcF9yZWdpc3Rlcl9w
YXRjaChhcml6b25hLT5yZWdtYXAsCj4gKwkJCQkJICAgICB3bTUxMTBfcmV2ZV9wYXRjaCwKPiAr
CQkJCQkgICAgIEFSUkFZX1NJWkUod201MTEwX3JldmVfcGF0Y2gpKTsKPiAgCX0KPiAgfQo+ICBF
WFBPUlRfU1lNQk9MX0dQTCh3bTUxMTBfcGF0Y2gpOwoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1RN
aWNyb2VsZWN0cm9uaWNzIExhbmRpbmcgVGVhbSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291
cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0
ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
