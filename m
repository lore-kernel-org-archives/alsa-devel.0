From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [patch 5/6] orion/kirkwood: Add i2s support
Date: Mon, 17 May 2010 08:23:31 +0300
Message-ID: <AANLkTim31zMgvsSdcidDvmD-Q3124w48PVxMnT3nL5O6@mail.gmail.com>
References: <20100515152958.899927802@mandriva.com>
	<20100515153130.937921459@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 33804244F8
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 07:23:33 +0200 (CEST)
Received: by wya21 with SMTP id 21so1415370wya.38
	for <alsa-devel@alsa-project.org>; Sun, 16 May 2010 22:23:32 -0700 (PDT)
In-Reply-To: <20100515153130.937921459@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

PiArIMKgIMKgIMKgIC8qIEZpcnN0IGRpc2FibGUgYW5kIGNsZWFyIHdpbmRvd3MgKi8KPiArIMKg
IMKgIMKgIGZvciAod2luX251bSA9IDA7IHdpbl9udW0gPCBPUklPTl9NQVhfQVVESU9fV0lOOyB3
aW5fbnVtKyspIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHdyaXRlbCgwLCBiYXNlICsgT1JJ
T05fQVVESU9fV0lOX0NUUkxfUkVHKHdpbl9udW0pKTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHdyaXRlbCgwLCBiYXNlICsgT1JJT05fQVVESU9fV0lOX0JBU0VfUkVHKHdpbl9udW0pKTsKPiAr
IMKgIMKgIMKgIH0KPiArCj4gKyDCoCDCoCDCoCAvKiBTZXR1cCB3aW5kb3dzIGZvciBERFIgKi8K
PiArIMKgIMKgIMKgIGZvciAod2luX251bSA9IDA7IHdpbl9udW0gPCBPUklPTl9NQVhfQVVESU9f
V0lOOyB3aW5fbnVtKyspIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIFdlIHdpbGwgc2V0
IHRoZSBXaW5kb3cgdG8gRFJBTV9DUzEgaW4gZGVmYXVsdCAqLwo+ICsgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgc3RydWN0IG1idXNfZHJhbV93aW5kb3cgKmNzID0gJmRyYW0tPmNzWzFdOwo+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgd3JpdGVsKGNzLT5iYXNlICYgMHhmZmZmMDAwMCwKPiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYmFzZSArIE9SSU9OX0FVRElPX1dJTl9CQVNFX1JF
Ryh3aW5fbnVtKSk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCB3cml0ZWwoKChjcy0+c2l6ZSAt
IDEpICYgMHhmZmZmMDAwMCkgfAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAo
Y3MtPm1idXNfYXR0ciA8PCA4KSB8Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oChkcmFtLT5tYnVzX2RyYW1fdGFyZ2V0X2lkIDw8IDQpIHwgMSwKPiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGJhc2UgKyBPUklPTl9BVURJT19XSU5fQ1RSTF9SRUcod2luX251
bSkpOwo+ICsgwqAgwqAgwqAgfQo+ICt9ClRoZSBpMnMgY29udHJvbGxlciBoYXMgb25lIHdpbmRv
dyBmb3IgcGxheWJhY2ssIHNvIHRoYXQgd2luZG93IG11c3QgYmUKc2V0IGFjY29yZGluZyB0byB0
aGUgY3VycmVudCBkbWEgYWRkcmVzcywgaS5lLCBpZiB0aGUgZG1hIGFkZHJlc3MKZmFsbHMgaW50
byBjc1ggdGhlbiB0aGUgd2luZG93IHNob3VsZCBiZSBjb25maWd1cmVkIHRvIGNzWC4gc2FtZSBm
b3IKcmVjb3JkLgpzb3JyeSBmb3IgdGhlIGxhdGUgY29tbWVudC4Kc2FlZWQKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
