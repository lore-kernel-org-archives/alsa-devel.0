From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: Clean up the CODEC device as
 well as the board for SMDK WM9713
Date: Sat, 25 Sep 2010 00:18:30 +0900
Message-ID: <AANLkTi=c=nhULMbFGoSx4g68Sduo1FNg30NQEfWnsNsp@mail.gmail.com>
References: <1285252845-24171-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1285252845-24171-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=8G9jt7KWafeUhinWCQMqRtxfXY1ZxwSNZBby1@mail.gmail.com>
	<20100923145614.GJ25663@rakim.wolfsonmicro.main>
	<AANLkTiksrurq_GQOp7gmZ=NeWX8NQFq2W2cA7hvwPveP@mail.gmail.com>
	<20100924092223.GH32112@rakim.wolfsonmicro.main>
	<AANLkTi=e0LK+1cD8x6iQv+GE3awrnO1yX585e6yxhrSF@mail.gmail.com>
	<20100924120140.GL32112@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id A99122451A
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Sep 2010 17:18:30 +0200 (CEST)
Received: by bwz13 with SMTP id 13so1551117bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2010 08:18:30 -0700 (PDT)
In-Reply-To: <20100924120140.GL32112@rakim.wolfsonmicro.main>
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

T24gRnJpLCBTZXAgMjQsIDIwMTAgYXQgOTowMSBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIEZyaSwgU2VwIDI0LCAyMDEwIGF0
IDA4OjEwOjUwUE0gKzA5MDAsIEphc3NpIEJyYXIgd3JvdGU6Cj4+IE9uIEZyaSwgU2VwIDI0LCAy
MDEwIGF0IDY6MjIgUE0sIE1hcmsgQnJvd24KPgo+PiA+IENvdWxkIHlvdSBiZSBtb3JlIHNwZWNp
ZmljIGFib3V0IHdoYXQgb3RoZXIgY2hhbmdlcyB5b3UgYmVsaWV2ZSBhcmUKPj4gPiBuZWVkZWQ/
Cj4KPj4gSUlVSUMsIHRoZSBhaW0gb2YgdGhpcyBwYXRjaCBpcyB0byBiZSBhYmxlIHRvIHJlbG9h
ZCB0aGUgbW9kdWxlLCB3aGljaCBpc24ndAo+PiBnb2luZyB0byB3b3JrIHNpbXBseSB3aXRoIHRo
aXMgY2hhZ2UgLSB3ZSBuZWVkIHRvIGRvIGFzIHdlbGwgc29tZXRoaW5nCj4+IGFib3V0IHRoZSAn
c29jLWF1ZGlvJyBwbGF0Zm9ybSBkZXZpY2UgYWRkZWQgdGhlIGZpcnN0IHRpbWUgPwo+PiBTbyBJ
TUhPLCB0aGlzIGNoYW5nZSBpcyBhIHJpZ2h0IHN0ZXAgYnV0IG5vdCBlbm91Z2guCj4KPiBBcyBJ
IHNhaWQgaW4gcmVwbHkgdG8geW91ciBlYXJsaWVyIG1haWwgdGhlIHByZS1leGlzdGluZyBjb2Rl
IGluIHRoZQo+IGRyaXZlciBhbHJlYWR5IGRvZXMgdGhhdDoKPgo+IC0tLSBhL3NvdW5kL3NvYy9z
M2MyNHh4L3NtZGtfd205NzEzLmMKPiArKysgYi9zb3VuZC9zb2MvczNjMjR4eC9zbWRrX3dtOTcx
My5jCj4gQEAgLTk1LDYgKzk1LDcgQEAgZXJyOgo+IMKgc3RhdGljIHZvaWQgX19leGl0IHNtZGtf
ZXhpdCh2b2lkKQo+IMKgewo+IMKgIMKgIMKgIMKgcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIo
c21ka19zbmRfYWM5N19kZXZpY2UpOwo+Cj4gVGhpcyBwcmVleGlzdGluZyBsaW5lIGZyb20gdGhl
IGNvbnRleHQgaXMgY2xlYW5pbmcgdXAgdGhlIHNvYy1hdWRpbwo+IGRldmljZS4KPgo+ICsgwqAg
wqAgwqAgcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIoc21ka19zbmRfd205NzEzX2RldmljZSk7
Cj4KPiBUaGlzIG5ldyBsaW5lIGNsZWFucyB1cCB0aGUgd205NzEzLWNvZGVjIGRldmljZSB3aGlj
aCBpcyBhbHNvIGFkZGVkIGluCj4gdGhlIHByb2JlIGZ1bmN0aW9uICh5YXkgQUMnOTchKS4KPgo+
IFJlbG9hZGluZyB0aGUgbW9kdWxlIHdvcmtzLCBJJ3ZlIGJlZW4gZG9pbmcgdGhhdCByYXRoZXIg
YSBsb3QuCgpPaywgSSBmb3Jnb3QgdW5yZWdpc3RlciB3b3VsZCBmcmVlIHRoZSBvYmplY3QuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
