From: =?ISO-8859-1?Q?J=F6rg?= Krause <joerg.krause@embedded.rocks>
Subject: Re: [PATCH] pcm: softvol: fix signedness of tlv data
 type
Date: Sun, 08 May 2016 20:18:19 +0200
Message-ID: <1462731499.2641.3.camel@embedded.rocks>
References: <1462568920-19891-1-git-send-email-joerg.krause@embedded.rocks>
 <38c794bd-5eda-2bb2-7022-a13e2869dc3a@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C59AC260601
 for <alsa-devel@alsa-project.org>; Sun,  8 May 2016 20:18:25 +0200 (CEST)
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
 by mout01.posteo.de (Postfix) with ESMTPS id A2807208C3
 for <alsa-devel@alsa-project.org>; Sun,  8 May 2016 20:18:24 +0200 (CEST)
In-Reply-To: <38c794bd-5eda-2bb2-7022-a13e2869dc3a@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGVsbG8sCgpPbiBTYSwgMjAxNi0wNS0wNyBhdCAwOTowNiArMDIwMCwgQ2xlbWVucyBMYWRpc2No
IHdyb3RlOgo+IErDtnJnIEtyYXVzZSB3cm90ZToKPiA+IEZvciB0aGUgc29mdHZvbCBwbHVnaW4g
dGhlIFRMViBkYXRhIGFyZSB3cml0dGVuIHdyb25nLCBlLmcuIGZvciB0aGUKPiA+IGRlZmF1bHQg
dmFsdWVzCj4gPiBvZiBtaW5fZEIgPSAtNTEgZEIgYW5kIG1heF9kQiA9IDAgZEIsIGFsc2FjdGwg
Z2VuZXJhdGVzIHRoZQo+ID4gZm9sbG93aW5nIHN0YXRlOgo+ID4gCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0bHYgJzAwMDAwMDAxMDAwMDAwMDgw
MDAwMDAwMDAwMDAwMDE0Jwo+ID4gCj4gPiBBcyBib3RoIG1pbl9kQiBhbmQgbWF4X2RCIGNhbiBi
ZSBuZWdhdGl2ZSBudW1iZXJzLCB0aGUgdGx2IHR5cGUKPiA+IG11c3Qgbm90IGJlCj4gPiB1bnNp
Z25lZC4KPiAKPiBUTFZzIGFsd2F5cyBhcmUgdW5zaWduZWQuwqDCoEJ1dCB0aGV5IGNhbiBjb250
YWluIGJpdCBwYXR0ZXJucyB0aGF0IGFyZQo+IHRvCj4gYmUgaW50ZXJwcmV0ZWQgYXMgc2lnbmVk
LgoKSSBzZWUhCgo+ID4gLQl1bnNpZ25lZCBpbnQgdGx2WzRdOwo+ID4gKwlpbnQgdGx2WzRdOwo+
ID4gwqAJdGx2WzBdID0gU05EX0NUTF9UTFZUX0RCX1NDQUxFOwo+ID4gwqAJdGx2WzFdID0gMiAq
IHNpemVvZihpbnQpOwo+ID4gwqAJdGx2WzJdID0gc3ZvbC0+bWluX2RCICogMTAwOwo+IAo+IFRo
ZSBwcm9ibGVtIGlzIHRoYXQgY29udmVyc2lvbiBvZiBhIG5lZ2F0aXZlIGZsb2F0aW5nLXBvaW50
IG51bWJlcgo+IGludG8KPiBhbiB1bnNpZ25lZCBpbnRlZ2VyIHJlc3VsdHMgaW4gdW5kZWZpbmVk
IGJlaGF2aW91ciwgYW5kIG9uIHlvdXIKPiBhcmNoaXRlY3R1cmUgKHdoYXRldmVyIGl0IGlzKSwg
dGhpcyByZXN1bHRzIGluIHplcm8uCj4gCj4gVGhlIGNvcnJlY3Qgd2F5IHRvIGhhbmRsZSB0aGlz
IHdvdWxkIGJlIHNvbWV0aGluZyBsaWtlIHRoaXM6Cj4gCj4gwqAgdGx2W2ldID0gKGludCkoLi4u
KTsKClRoaXMgZml4ZXMgdGhlIGlzc3VlIGZvciBteSBBUk0gdGFyZ2V0LCBtYW55IHRoYW5rcyEg
SSdsbCBzZW5kIGFuCnVwZGF0ZWQgdmVyc2lvbi4KCk1hbnkgdGhhbmtzIGZvciB0aGUgcmV2aWV3
IQoKQmVzdCByZWdhcmRzLApKw7ZyZyBLcmF1c2UKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
