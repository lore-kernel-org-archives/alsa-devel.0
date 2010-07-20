From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/12] ad1836: fix a memory leak if another
	ad1836 is registered
Date: Tue, 20 Jul 2010 18:31:43 +0800
Message-ID: <AANLkTim21rRtOWi6MEnh_wAMFimiPMV4YGnDbwo2XqGx@mail.gmail.com>
References: <1279162147.29294.2.camel@mola> <1279162237.29294.4.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 200C41037FC
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 12:32:06 +0200 (CEST)
Received: by ywa6 with SMTP id 6so524668ywa.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2010 03:32:04 -0700 (PDT)
In-Reply-To: <1279162237.29294.4.camel@mola>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Barry Song <Barry.Song@analog.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBKdWwgMTUsIDIwMTAgYXQgMTA6NTAgQU0sIEF4ZWwgTGluIDxheGVsLmxpbkBnbWFp
bC5jb20+IHdyb3RlOgo+IGFkMTgzNiBpcyBhbGxvY2F0ZWQgaW4gYWQxODM2X3NwaV9wcm9iZSgp
IGJ1dCBpcyBub3QgZnJlZWQgaWYgYWQxODM2X3JlZ2lzdGVyKCkKPiByZXR1cm4gLUVJTlZBTCAo
aWYgYW5vdGhlciBhZDE4MzYgaXMgcmVnaXN0ZXJlZCkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBeGVs
IExpbiA8YXhlbC5saW5AZ21haWwuY29tPgoKQWNrZWQtYnk6IEJhcnJ5IFNvbmcgPDIxY25iYW9A
Z21haWwuY29tPgoKPiAtLS0KPiDCoHNvdW5kL3NvYy9jb2RlY3MvYWQxODM2LmMgfCDCoCDCoDEg
Kwo+IMKgMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9hZDE4MzYuYyBiL3NvdW5kL3NvYy9jb2Rl
Y3MvYWQxODM2LmMKPiBpbmRleCAyMTc1Mzg0Li5hMDEwMDZjIDEwMDY0NAo+IC0tLSBhL3NvdW5k
L3NvYy9jb2RlY3MvYWQxODM2LmMKPiArKysgYi9zb3VuZC9zb2MvY29kZWNzL2FkMTgzNi5jCj4g
QEAgLTI3Miw2ICsyNzIsNyBAQCBzdGF0aWMgaW50IGFkMTgzNl9yZWdpc3RlcihzdHJ1Y3QgYWQx
ODM2X3ByaXYgKmFkMTgzNikKPgo+IMKgIMKgIMKgIMKgaWYgKGFkMTgzNl9jb2RlYykgewo+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZGV2X2Vycihjb2RlYy0+ZGV2LCAiQW5vdGhlciBhZDE4MzYg
aXMgcmVnaXN0ZXJlZFxuIik7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBrZnJlZShhZDE4MzYp
Owo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FSU5WQUw7Cj4gwqAgwqAgwqAgwqB9
Cj4KPiAtLQo+IDEuNS40LjMKPgo+Cj4KPiAtLQo+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBs
aXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmliZSBsaW51eC1rZXJuZWwiIGluCj4gdGhlIGJv
ZHkgb2YgYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcKPiBNb3JlIG1ham9y
ZG9tbyBpbmZvIGF0IMKgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1s
Cj4gUGxlYXNlIHJlYWQgdGhlIEZBUSBhdCDCoGh0dHA6Ly93d3cudHV4Lm9yZy9sa21sLwo+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
