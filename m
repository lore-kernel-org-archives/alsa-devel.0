From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] ASoC: ab8500: Remove pointless cast
Date: Thu, 26 Jul 2012 16:07:04 +0100
Message-ID: <50115D18.3040703@linaro.org>
References: <1343314151-26442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E288C265EE8
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 17:07:24 +0200 (CEST)
Received: by eeke50 with SMTP id e50so366768eek.38
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 08:07:27 -0700 (PDT)
In-Reply-To: <1343314151-26442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

T24gMjYvMDcvMTIgMTU6NDksIE1hcmsgQnJvd24gd3JvdGU6Cj4gVGhlcmUncyBuZXZlciBhbnkg
bmVlZCB0byBjYXN0IGF3YXkgZnJvbSB2b2lkLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWFyayBCcm93
biA8YnJvb25pZUBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20+Cj4gLS0tCj4gICBzb3VuZC9z
b2MvY29kZWNzL2FiODUwMC1jb2RlYy5jIHwgICAgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2Nv
ZGVjcy9hYjg1MDAtY29kZWMuYyBiL3NvdW5kL3NvYy9jb2RlY3MvYWI4NTAwLWNvZGVjLmMKPiBp
bmRleCAzYzc5NTkyLi4wNWQ3MDkzNCAxMDA2NDQKPiAtLS0gYS9zb3VuZC9zb2MvY29kZWNzL2Fi
ODUwMC1jb2RlYy5jCj4gKysrIGIvc291bmQvc29jL2NvZGVjcy9hYjg1MDAtY29kZWMuYwo+IEBA
IC0yNDA1LDcgKzI0MDUsNyBAQCBzdGF0aWMgaW50IGFiODUwMF9jb2RlY19wcm9iZShzdHJ1Y3Qg
c25kX3NvY19jb2RlYyAqY29kZWMpCj4gICAJZGV2X2RiZyhkZXYsICIlczogRW50ZXIuXG4iLCBf
X2Z1bmNfXyk7Cj4KPiAgIAkvKiBTZXR1cCBBQjg1MDAgYWNjb3JkaW5nIHRvIGJvYXJkLXNldHRp
bmdzICovCj4gLQlwZGF0YSA9IChzdHJ1Y3QgYWI4NTAwX3BsYXRmb3JtX2RhdGEgKilkZXZfZ2V0
X3BsYXRkYXRhKGRldi0+cGFyZW50KTsKPiArCXBkYXRhID0gZGV2X2dldF9wbGF0ZGF0YShkZXYt
PnBhcmVudCk7Cj4gICAJc3RhdHVzID0gYWI4NTAwX2F1ZGlvX3NldHVwX21pY3MoY29kZWMsICZw
ZGF0YS0+Y29kZWMtPmFtaWNzKTsKPiAgIAlpZiAoc3RhdHVzIDwgMCkgewo+ICAgCQlwcl9lcnIo
IiVzOiBGYWlsZWQgdG8gc2V0dXAgbWljcyAoJWQpIVxuIiwgX19mdW5jX18sIHN0YXR1cyk7Cj4K
CkkgdGhpbmsgT2xhIG5lZWRzIHRvIEFDSyB0aGlzLCBidXQgZndpdzoKCkFja2VkLWJ5OiBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1QtRXJp
Y3Nzb24gTGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdh
cmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
