From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3 v3] mfd: arizona: Export function to
 control subsystem DVFS
Date: Fri, 27 Jun 2014 09:31:55 +0100
Message-ID: <20140627083155.GF19645@lee--X1>
References: <1403540909-22013-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1403540909-22013-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 688DA26514C
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 10:32:03 +0200 (CEST)
Received: by mail-ie0-f179.google.com with SMTP id tr6so4170577ieb.10
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 01:32:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403540909-22013-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

T24gTW9uLCAyMyBKdW4gMjAxNCwgQ2hhcmxlcyBLZWVwYXggd3JvdGU6Cgo+IEZyb206IFJpY2hh
cmQgRml0emdlcmFsZCA8cmZAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPgo+IAo+IE1vdmlu
ZyB0aGlzIGNvbnRyb2wgZnJvbSBiZWluZyBhIHNpZGUtZWZmZWN0IG9mIHRoZSBMRE8xCj4gcmVn
dWxhdG9yIGRyaXZlciB0byBhIHNwZWNpZmljIGV4cG9ydGVkIGZ1bmN0aW9uLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IFJpY2hhcmQgRml0emdlcmFsZCA8cmZAb3BlbnNvdXJjZS53b2xmc29ubWljcm8u
Y29tPgo+IFNpZ25lZC1vZmYtYnk6IENoYXJsZXMgS2VlcGF4IDxja2VlcGF4QG9wZW5zb3VyY2Uu
d29sZnNvbm1pY3JvLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9tZmQvYXJpem9uYS1jb3JlLmMgICAg
ICAgfCAgIDg3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gIGluY2x1
ZGUvbGludXgvbWZkL2FyaXpvbmEvY29yZS5oIHwgICAxMiArKysrKwo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDk5IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbWZkL2FyaXpvbmEtY29yZS5jIGIvZHJpdmVycy9tZmQvYXJpem9uYS1jb3JlLmMKPiBp
bmRleCBjZmMxOTFhLi44MGY3OWVjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbWZkL2FyaXpvbmEt
Y29yZS5jCj4gKysrIGIvZHJpdmVycy9tZmQvYXJpem9uYS1jb3JlLmMKPiBAQCAtOTQsNiArOTQs
OTIgQEAgaW50IGFyaXpvbmFfY2xrMzJrX2Rpc2FibGUoc3RydWN0IGFyaXpvbmEgKmFyaXpvbmEp
Cj4gIH0KPiAgRVhQT1JUX1NZTUJPTF9HUEwoYXJpem9uYV9jbGszMmtfZGlzYWJsZSk7Cj4gIAo+
ICtpbnQgYXJpem9uYV9kdmZzX3VwKHN0cnVjdCBhcml6b25hICphcml6b25hLCB1bnNpZ25lZCBp
bnQgZmxhZ3MpCj4gK3sKPiArCXVuc2lnbmVkIGludCBuZXdfZmxhZ3M7Cj4gKwlpbnQgcmV0ID0g
MDsKPiArCj4gKwltdXRleF9sb2NrKCZhcml6b25hLT5zdWJzeXNfbWF4X2xvY2spOwo+ICsKPiAr
CW5ld19mbGFncyA9IGFyaXpvbmEtPnN1YnN5c19tYXhfcnEgfCBmbGFnczsKPiArCj4gKwlpZiAo
YXJpem9uYS0+c3Vic3lzX21heF9ycSAhPSBuZXdfZmxhZ3MpIHsKPiArCQlzd2l0Y2ggKGFyaXpv
bmEtPnR5cGUpIHsKPiArCQljYXNlIFdNNTEwMjoKPiArCQljYXNlIFdNODk5NzoKPiArCQkJcmV0
ID0gcmVndWxhdG9yX3NldF92b2x0YWdlKGFyaXpvbmEtPmRjdmRkLAo+ICsJCQkJCQkgICAgMTgw
MDAwMCwgMTgwMDAwMCk7Cj4gKwkJCWlmIChyZXQgIT0gMCkgewo+ICsJCQkJZGV2X2Vycihhcml6
b25hLT5kZXYsCj4gKwkJCQkJIkZhaWxlZCB0byByYWlzZSBkY3ZkZCAoJWQpXG4iLCByZXQpOwoK
QXJlIHlvdSBzdXJlIHRoaXMgbWVzc2FnZSBpcyBhY2N1cmF0ZS4gIFdoYXQgaWYgdGhlIHZvbHRh
Z2Ugd2VyZQphbHJlYWR5IHYxLjg/ICBUaGVuIHlvdSB3b3VsZG4ndCB0ZWNobmljYWxseSBiZSB0
cnlpbmcgdG8gcmFpc2UgaXQuCgpbLi4uXQoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1RNaWNyb2Vs
ZWN0cm9uaWNzIExhbmRpbmcgVGVhbSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNv
ZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBC
bG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
