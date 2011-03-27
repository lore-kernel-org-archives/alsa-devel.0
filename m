From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Device-drivers-devel] [PATCH 2/2 v2] ASoC:
	SSM2602: convert to soc-cache
Date: Sun, 27 Mar 2011 11:07:10 -0400
Message-ID: <AANLkTik63pnEueSr4QgH+Cf+1pqydSGt1bz_7R5ePmiX@mail.gmail.com>
References: <1301124539-527-2-git-send-email-vapier@gentoo.org>
	<1301124975-2963-1-git-send-email-vapier@gentoo.org>
	<20110326124812.GG28537@opensource.wolfsonmicro.com>
	<AANLkTim8HH5PPA-d6cCqCfB2QqoP4O6825qSqyevTUr1@mail.gmail.com>
	<20110327103609.GA11148@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BE38F103809
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Mar 2011 17:07:33 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1592285fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Mar 2011 08:07:30 -0700 (PDT)
In-Reply-To: <20110327103609.GA11148@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCBNYXIgMjcsIDIwMTEgYXQgMDY6MzYsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gU3Vu
LCBNYXIgMjcsIDIwMTEgYXQgMTI6MDk6MTZBTSAtMDQwMCwgTWlrZSBGcnlzaW5nZXIgd3JvdGU6
Cj4+IGlzIHRoZXJlIGFuIGV4aXN0aW5nIGNvZGVjIGRyaXZlciB5b3UgY2FuIGhpZ2hsaWdodCB0
aGF0IGRvZXMgd2hhdAo+PiB5b3UncmUgc2F5aW5nIGhlcmUgPwo+Cj4gJCBncmVwIHNuZF9zb2Nf
Y2FjaGVfc3luYyBzb3VuZC9zb2MvY29kZWNzLyouYwo+IHNvdW5kL3NvYy9jb2RlY3MvY3M0Mjcx
LmM6IMKgIMKgIMKgcmV0ID0gc25kX3NvY19jYWNoZV9zeW5jKGNvZGVjKTsKPiBzb3VuZC9zb2Mv
Y29kZWNzL21heDk4NTAuYzogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0ID0gc25k
X3NvY19jYWNoZV9zeW5jKGNvZGVjKTsKPiBzb3VuZC9zb2MvY29kZWNzL3dtODczNy5jOiDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNuZF9zb2NfY2FjaGVfc3luYyhjb2RlYyk7Cj4g
c291bmQvc29jL2NvZGVjcy93bTg5OTEuYzogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzbmRfc29jX2NhY2hlX3N5bmMoY29kZWMpOwo+IHNvdW5kL3NvYy9jb2RlY3Mvd204OTk0LmM6
IMKgIMKgIMKgcmV0ID0gc25kX3NvY19jYWNoZV9zeW5jKGNvZGVjKTsKPiBzb3VuZC9zb2MvY29k
ZWNzL3dtODk5NS5jOiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IHNuZF9z
b2NfY2FjaGVfc3luYyhjb2RlYyk7CgpzbyBpIGNvdWxkIGRyb3AgdGhlIHdob2xlIGZvciBsb29w
IGluIGZhdm9yIG9mIHRoaXMgb25lIGNhbGwgPwotbWlrZQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
