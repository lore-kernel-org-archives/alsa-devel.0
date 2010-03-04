From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: Add delay information for Samsung
	IISv2 DAIs
Date: Thu, 4 Mar 2010 22:18:59 +0900
Message-ID: <1b68c6791003040518k21b0894ap150bcad6a1195da3@mail.gmail.com>
References: <1267704358-31501-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id D6CF724382
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 14:19:01 +0100 (CET)
Received: by vws15 with SMTP id 15so1108288vws.38
	for <alsa-devel@alsa-project.org>; Thu, 04 Mar 2010 05:19:00 -0800 (PST)
In-Reply-To: <1267704358-31501-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Jassi <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBNYXIgNCwgMjAxMCBhdCA5OjA1IFBNLCBNYXJrIEJyb3duCjxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gQEAgLTU1MCw2ICs1NTAsMjEgQEAgc3Rh
dGljIGludCBzM2MyNDEyX2kyc19zZXRfY2xrZGl2KHN0cnVjdCBzbmRfc29jX2RhaSAqY3B1X2Rh
aSwKPiDCoCDCoCDCoCDCoHJldHVybiAwOwo+IMKgfQo+Cj4gK3N0YXRpYyBsb25nIHMzYzI0MTJf
aTJzX2RlbGF5KHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAo+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3Qgc25kX3NvY19kYWkgKmRh
aSkKcmV0dXJuIHR5cGUgc25kX3BjbV9zZnJhbWVzX3QgPwoKPiArewo+ICsgwqAgwqAgwqAgc3Ry
dWN0IHMzY19pMnN2Ml9pbmZvICppMnMgPSB0b19pbmZvKGRhaSk7Cj4gKyDCoCDCoCDCoCB1MzIg
cmVnID0gcmVhZGwoaTJzLT5yZWdzICsgUzNDMjQxMl9JSVNGSUMpOwo+ICsgwqAgwqAgwqAgaW50
IGRlbGF5OwonZGVsYXknIHR5cGUgc25kX3BjbV9zZnJhbWVzX3QgPwoKPiArCj4gKyDCoCDCoCDC
oCBpZiAoc3Vic3RyZWFtLT5zdHJlYW0gPT0gU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDSykKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRlbGF5ID0gUzNDMjQxMl9JSVNGSUNfVFhDT1VOVChyZWcp
Owo+ICsgwqAgwqAgwqAgZWxzZQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGVsYXkgPSBTM0My
NDEyX0lJU0ZJQ19SWENPVU5UKHJlZyk7Cj4gKwo+ICsgwqAgwqAgwqAgcmV0dXJuIGRlbGF5Owo+
ICt9Cj4gKwo+ICsgwqAgwqAgwqAgLyogQWxsb3cgb3ZlcnJpZGluZyBieSAoZm9yIGV4YW1wbGUp
IElJU3Y0ICovCj4gKyDCoCDCoCDCoCBpZiAoIW9wcy0+ZGVsYXkpCj4gKyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBvcHMtPmRlbGF5ID0gczNjMjQxMl9pMnNfZGVsYXksCk9rIGZvciBub3cuCkkgYW0g
dHJ5aW5nIHRvIG1ha2UgZnVuY3Rpb25zIGluIHMzYy1pMnMtdjIuYyByZS1lbnRyYW50IGFzIG11
Y2ggYXMgcG9zc2libGUsCidkZWxheScgdG9vIHNlZW1zIHRvIGJlIGEgZ29vZCBjYW5kaWRhdGUu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
