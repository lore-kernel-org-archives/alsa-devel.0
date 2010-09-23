From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: Add debug logging for s3c-ac97
	resets
Date: Fri, 24 Sep 2010 08:00:40 +0900
Message-ID: <AANLkTinrRt+tXdL=iXW8JT4bB91xAA9EtQHSxYQ=zoi3@mail.gmail.com>
References: <1285267270-22426-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1285267270-22426-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8638610396D
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Sep 2010 01:00:40 +0200 (CEST)
Received: by bwz13 with SMTP id 13so1086212bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2010 16:00:40 -0700 (PDT)
In-Reply-To: <1285267270-22426-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBTZXAgMjQsIDIwMTAgYXQgMzo0MSBBTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IEhlbHBzIHRyYWNpbmcgZXJyb3JzIGZ1
cnRoZXIgdXAgdGhlIHN0YWNrLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWFyayBCcm93biA8YnJvb25p
ZUBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20+Cj4gLS0tCj4gwqBzb3VuZC9zb2MvczNjMjR4
eC9zM2MtYWM5Ny5jIHwgwqAgwqAzICsrKwo+IMKgMSBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3MzYzI0eHgv
czNjLWFjOTcuYyBiL3NvdW5kL3NvYy9zM2MyNHh4L3MzYy1hYzk3LmMKPiBpbmRleCAzMWUyYjNk
Li5mODkxZWI3IDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9zM2MyNHh4L3MzYy1hYzk3LmMKPiAr
KysgYi9zb3VuZC9zb2MvczNjMjR4eC9zM2MtYWM5Ny5jCj4gQEAgLTE2Myw2ICsxNjMsNyBAQCBz
dGF0aWMgdm9pZCBzM2NfYWM5N193cml0ZShzdHJ1Y3Qgc25kX2FjOTcgKmFjOTcsIHVuc2lnbmVk
IHNob3J0IHJlZywKPgo+IMKgc3RhdGljIHZvaWQgczNjX2FjOTdfY29sZF9yZXNldChzdHJ1Y3Qg
c25kX2FjOTcgKmFjOTcpCj4gwqB7Cj4gKyDCoCDCoCDCoCBwcl9kZWJ1ZygiQUM5NzogQ29sZCBy
ZXNldFxuIik7Cj4gwqAgwqAgwqAgwqB3cml0ZWwoUzNDX0FDOTdfR0xCQ1RSTF9DT0xEUkVTRVQs
Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzM2NfYWM5Ny5yZWdzICsgUzND
X0FDOTdfR0xCQ1RSTCk7Cj4gwqAgwqAgwqAgwqBtc2xlZXAoMSk7Cj4gQEAgLTE3OSw2ICsxODAs
OCBAQCBzdGF0aWMgdm9pZCBzM2NfYWM5N193YXJtX3Jlc2V0KHN0cnVjdCBzbmRfYWM5NyAqYWM5
NykKPiDCoCDCoCDCoCDCoGlmIChzdGF0ID09IFMzQ19BQzk3X0dMQlNUQVRfTUFJTlNUQVRFX0FD
VElWRSkKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybjsgLyogUmV0dXJuIGlmIGFscmVh
ZHkgYWN0aXZlICovCj4KPiArIMKgIMKgIMKgIHByX2RlYnVnKCJBQzk3OiBXYXJtIHJlc2V0XG4i
KTsKPiArCj4gwqAgwqAgwqAgwqB3cml0ZWwoUzNDX0FDOTdfR0xCQ1RSTF9XQVJNUkVTRVQsIHMz
Y19hYzk3LnJlZ3MgKyBTM0NfQUM5N19HTEJDVFJMKTsKPiDCoCDCoCDCoCDCoG1zbGVlcCgxKTsK
CkFja2VkLWJ5OiBKYXNzaSBCcmFyIDxqYXNzaS5icmFyQHNhbXN1bmcuY29tPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
