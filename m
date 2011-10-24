From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH 2/3] ASoC: wm8940: Fix a typo for the mask
	of setting WM8940_BCLKDIV
Date: Mon, 24 Oct 2011 13:06:34 +0100
Message-ID: <CABS+qY0a-w5igUod7eMeYqt9GZsj-aFS3Oa-VUPUHE-LTSVG8g@mail.gmail.com>
References: <1319427161.5773.3.camel@phoenix> <1319427235.5773.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 81D6D10382A
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 14:06:35 +0200 (CEST)
Received: by mail-yx0-f172.google.com with SMTP id 11so1784137yxi.17
	for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2011 05:06:34 -0700 (PDT)
In-Reply-To: <1319427235.5773.4.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gMjQgT2N0b2JlciAyMDExIDA0OjMzLCBBeGVsIExpbiA8YXhlbC5saW5AZ21haWwuY29tPiB3
cm90ZToKPiBUaGUgcmVnaXN0ZXJzIGFyZSAxNiBiaXRzLCB0aHVzIHJlbW92ZSBhbiBleHRyYSBG
IGZvciB0aGUgbWFzay4KPgo+IFNpZ25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxpbkBnbWFp
bC5jb20+Cj4gLS0tCj4gwqBzb3VuZC9zb2MvY29kZWNzL3dtODk0MC5jIHwgwqAgwqAyICstCj4g
wqAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3dtODk0MC5jIGIvc291bmQvc29jL2NvZGVjcy93
bTg5NDAuYwo+IGluZGV4IDNjYzNiY2UuLmZlYzM4OTIgMTAwNjQ0Cj4gLS0tIGEvc291bmQvc29j
L2NvZGVjcy93bTg5NDAuYwo+ICsrKyBiL3NvdW5kL3NvYy9jb2RlY3Mvd204OTQwLmMKPiBAQCAt
NjE5LDcgKzYxOSw3IEBAIHN0YXRpYyBpbnQgd204OTQwX3NldF9kYWlfY2xrZGl2KHN0cnVjdCBz
bmRfc29jX2RhaSAqY29kZWNfZGFpLAo+Cj4gwqAgwqAgwqAgwqBzd2l0Y2ggKGRpdl9pZCkgewo+
IMKgIMKgIMKgIMKgY2FzZSBXTTg5NDBfQkNMS0RJVjoKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHJlZyA9IHNuZF9zb2NfcmVhZChjb2RlYywgV004OTQwX0NMT0NLKSAmIDB4RkZFRjM7Cj4gKyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCByZWcgPSBzbmRfc29jX3JlYWQoY29kZWMsIFdNODk0MF9DTE9D
SykgJiAweEZFRjM7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBzbmRfc29jX3dyaXRl
KGNvZGVjLCBXTTg5NDBfQ0xPQ0ssIHJlZyB8IChkaXYgPDwgMikpOwo+IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgYnJlYWs7Cj4gwqAgwqAgwqAgwqBjYXNlIFdNODk0MF9NQ0xLRElWOgo+IC0tCgpB
Y2tlZC1ieTogTGlhbSBHaXJkd29vZCA8bHJnQHRpLmNvbT4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
