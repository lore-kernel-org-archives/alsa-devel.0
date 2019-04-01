From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 02/10] extcon: axp288: Convert to use
 acpi_dev_get_first_match_dev()
Date: Mon, 1 Apr 2019 10:25:37 +0900
Message-ID: <bbc87e57-520e-57cd-3b9e-6ceb91078ef2@samsung.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
 <20190328171729.44002-3-andriy.shevchenko@linux.intel.com>
 <c5090422-e707-a774-f3ab-b5bf49cd6851@samsung.com>
 <CGME20190329230056epcas2p2251a02365b30280e369883ad7df50d5a@epcas2p2.samsung.com>
 <3488798.d5z7iexCG2@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C96DEF80717
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2019 03:25:14 +0200 (CEST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20190401012508epoutp03bad1acfac6cf5d8cd18221dd501fb8bf~RNUMKtZ-A0393003930epoutp03g
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2019 01:25:08 +0000 (GMT)
In-Reply-To: <3488798.d5z7iexCG2@aspire.rjw.lan>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

SGkgUmFmYWVsLAoKT24gMTkuIDMuIDMwLiDsmKTsoIQgNzo1OCwgUmFmYWVsIEouIFd5c29ja2kg
d3JvdGU6Cj4gT24gRnJpZGF5LCBNYXJjaCAyOSwgMjAxOSAxOjUzOjA5IEFNIENFVCBDaGFud29v
IENob2kgd3JvdGU6Cj4+IEhpIEFuZHksCj4+Cj4+IE9uIDE5LiAzLiAyOS4g7Jik7KCEIDI6MTcs
IEFuZHkgU2hldmNoZW5rbyB3cm90ZToKPj4+IGFjcGlfZGV2X2dldF9maXJzdF9tYXRjaF9uYW1l
KCkgaXMgZGVwcmVjYXRlZCBhbmQgZ29pbmcgdG8gYmUgcmVtb3ZlZAo+Pj4gYmVjYXVzZSBpdCBs
ZWFrcyBhIHJlZmVyZW5jZS4KPj4+Cj4+PiBDb252ZXJ0IHRoZSBkcml2ZXIgdG8gdXNlIGFjcGlf
ZGV2X2dldF9maXJzdF9tYXRjaF9kZXYoKSBpbnN0ZWFkLgo+Pj4KPj4+IENjOiBDaGFud29vIENo
b2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KPj4+IENjOiBNeXVuZ0pvbyBIYW0gPG15dW5nam9v
LmhhbUBzYW1zdW5nLmNvbT4KPj4+IENjOiBDaGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+Cj4+
PiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4
LmludGVsLmNvbT4KPj4+IC0tLQo+Pj4gIGRyaXZlcnMvZXh0Y29uL2V4dGNvbi1heHAyODguYyB8
IDkgKysrKystLS0tCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9leHRjb24vZXh0Y29uLWF4cDI4
OC5jIGIvZHJpdmVycy9leHRjb24vZXh0Y29uLWF4cDI4OC5jCj4+PiBpbmRleCBhOTgzNzA4Yjc3
YTYuLjUwZjk0MDJmYjMyNSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZXh0Y29uL2V4dGNvbi1h
eHAyODguYwo+Pj4gKysrIGIvZHJpdmVycy9leHRjb24vZXh0Y29uLWF4cDI4OC5jCj4+PiBAQCAt
MzMzLDcgKzMzMyw3IEBAIHN0YXRpYyBpbnQgYXhwMjg4X2V4dGNvbl9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQo+Pj4gIAlzdHJ1Y3QgYXhwMjg4X2V4dGNvbl9pbmZvICppbmZv
Owo+Pj4gIAlzdHJ1Y3QgYXhwMjB4X2RldiAqYXhwMjB4ID0gZGV2X2dldF9kcnZkYXRhKHBkZXYt
PmRldi5wYXJlbnQpOwo+Pj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Owo+Pj4g
LQljb25zdCBjaGFyICpuYW1lOwo+Pj4gKwlzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXY7Cj4+PiAg
CWludCByZXQsIGksIHBpcnE7Cj4+PiAgCj4+PiAgCWluZm8gPSBkZXZtX2t6YWxsb2MoJnBkZXYt
PmRldiwgc2l6ZW9mKCppbmZvKSwgR0ZQX0tFUk5FTCk7Cj4+PiBAQCAtMzU3LDkgKzM1NywxMCBA
QCBzdGF0aWMgaW50IGF4cDI4OF9leHRjb25fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikKPj4+ICAJCWlmIChyZXQpCj4+PiAgCQkJcmV0dXJuIHJldDsKPj4+ICAKPj4+IC0JCW5h
bWUgPSBhY3BpX2Rldl9nZXRfZmlyc3RfbWF0Y2hfbmFtZSgiSU5UMzQ5NiIsIE5VTEwsIC0xKTsK
Pj4+IC0JCWlmIChuYW1lKSB7Cj4+PiAtCQkJaW5mby0+aWRfZXh0Y29uID0gZXh0Y29uX2dldF9l
eHRjb25fZGV2KG5hbWUpOwo+Pj4gKwkJYWRldiA9IGFjcGlfZGV2X2dldF9maXJzdF9tYXRjaF9k
ZXYoIklOVDM0OTYiLCBOVUxMLCAtMSk7Cj4+PiArCQlpZiAoYWRldikgewo+Pj4gKwkJCWluZm8t
PmlkX2V4dGNvbiA9IGV4dGNvbl9nZXRfZXh0Y29uX2RldihhY3BpX2Rldl9uYW1lKGFkZXYpKTsK
Pj4+ICsJCQlwdXRfZGV2aWNlKCZhZGV2LT5kZXYpOwo+Pj4gIAkJCWlmICghaW5mby0+aWRfZXh0
Y29uKQo+Pj4gIAkJCQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsKPj4+ICAKPj4+Cj4+Cj4+IEFwcGxp
ZWQgaXQuIFRoYW5rcy4KPj4KPj4KPiAKPiBCdXQgaXQgd29uJ3QgYnVpbGQgd2l0aG91dCB0aGUg
Zmlyc3QgcGF0Y2ggSSBzdXBwb3NlPwo+IAo+IEFDSywgcGxlYXNlPwoKSXQgaXMgbXkgZmF1bHQu
IEknbGwgZHJvcCBpdCBmcm9tIGV4dGNvbi5naXQuCgpBY2tlZC1ieTogQ2hhbndvbyBDaG9pIDxj
dzAwLmNob2lAc2Ftc3VuZy5jb20+Cgo+IAo+IAo+IAo+IAoKCi0tIApCZXN0IFJlZ2FyZHMsCkNo
YW53b28gQ2hvaQpTYW1zdW5nIEVsZWN0cm9uaWNzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
