From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 4/7] ASoC: Automatically calculate clock
 ratio for WM8580
Date: Tue, 31 Aug 2010 15:46:44 +0900
Message-ID: <AANLkTimG-LqfTG1x++uME1DaAAysgqS=5zwjHE_o0hsR@mail.gmail.com>
References: <20100813193305.GB3778@sirena.org.uk>
	<1281728107-25386-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=6Op9C3adxhN8HsZu9FewFYqeCWRoQs=P3LP18@mail.gmail.com>
	<20100815110924.GA25723@opensource.wolfsonmicro.com>
	<AANLkTi=9Y=uhX2b+Y=OMGCVA=gJNif8HwXe3Eg517nbq@mail.gmail.com>
	<20100816102010.GB3276@rakim.wolfsonmicro.main>
	<AANLkTinTYo6_BBSkhTt8Km-MR4wwexDS3orFJdNSiufT@mail.gmail.com>
	<20100816151958.GE3276@rakim.wolfsonmicro.main>
	<AANLkTindYfm3vh_OgF-0tt_MS+Uxii2s7Dw=Kk487RTd@mail.gmail.com>
	<20100817094605.GC18622@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F98610381B
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 08:46:44 +0200 (CEST)
Received: by wyb32 with SMTP id 32so7307594wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 23:46:44 -0700 (PDT)
In-Reply-To: <20100817094605.GC18622@rakim.wolfsonmicro.main>
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
Cc: Seungwhan Youn <sw.youn@samsung.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBBdWcgMTcsIDIwMTAgYXQgNjo0NiBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFR1ZSwgQXVnIDE3LCAyMDEwIGF0
IDA4OjE0OjQzQU0gKzA5MDAsIEphc3NpIEJyYXIgd3JvdGU6Cj4KPj4gSSBndWVzcyBtb3N0IHF1
YWxpdHkgY29uc2Npb3VzIHByb2R1Y3RzIGNhbiBhZmZvcmQgdG8gYXR0YWNoIGEgZGVkaWNhdGVk
Cj4+IE9TQyB0byBhIGdvb2QgQ09ERUMuIEEgQ09ERUMgYWxyZWFkeSBzcGVjaWZpZXMgdGhlIGNs
b2NrcyBpdCBzdXBwb3J0Cj4+IGFuZCB1c3VhbGx5IGNvbWVzIHdpdGggJ3ByZWZlcnJlZCcgaW5w
dXQgY2xvY2tzLiBTbywganVzdCBoYXZpbmcgYSBzcGVjaWZpZWQKPj4gcmF0aW5nIGFjY3VyYXRl
IGVub3VnaCBPU0MgY2FuIHRha2UgY2FyZSBvZiBxdWFsaXR5LiBPbiB0aGUgb3RoZXIgaGFuZAo+
PiB0aGUgY2xvY2sgc291cmNlcyBvbiBDUFUgc2lkZSBhcmUgbm90IHBhcnRpY3VsYXJseSBhY2N1
cmF0ZSBmb3IgYXVkaW8tY2xvY2sKPj4gZ2VuZXJhdGlvbi4gT3Igc28gaGF2ZSBJIHNlZW4gc28g
ZmFyLgo+Cj4gUmlnaHQsIHRoaXMgc2hvdWxkbid0IGJlIGFuIGlzc3VlIHdpdGggdGhlIGNoYW5n
ZSBJIHByb3Bvc2VkIC0gdGhlCj4gY2xvY2tzIGFyZSBzdGlsbCByb290ZWQgZnJvbSB0aGUgQ09E
RUMgYW5kIGl0cyBjbG9jayBnZW5lcmF0aW9uCj4gZmFjaWxpdGllcyB3b3VsZCBzdGlsbCBiZSB1
c2VkLCBpdCdzIGp1c3QgdGhhdCB0aGV5IGdldCByb3V0ZWQKPiBkaWZmZXJlbnRseS4KPgo+IFRo
ZSBpc3N1ZSB3aXRoIHVzaW5nIG1vc3QgQ1BVIGNsb2NrcyBpc24ndCByZWFsbHkgdGhlIGRlZGlj
YXRlZAo+IG9zY2lsbGF0b3Igc28gbXVjaCBhcyB0aGUgYWJpbGl0eSB0byBnZW5lcmF0ZSBub24t
aW50ZWdlciBkaXZpc2lvbnMgb2YKPiB3aGF0ZXZlciBpbnB1dCBjbG9jayBpcyBhdmFpbGFibGUu
IMKgSWYgdGhpcyBjYW4ndCBiZSBkb25lIHRoZW4gaXQgY2FuIGJlCj4gaGFyZCB0byBnZW5lcmF0
ZSB0aGUgZnVsbCByYW5nZSBvZiBjb21tb24gYXVkaW8gZnJlcXVlbmNpZXMuCgpPaywgbm93IHRo
YXQgSSBhbSBmYWNlZCB3aXRoIHN1cHBvcnRpbmcgbGF0ZXN0IFNNREtzIHRoYXQgdXNlIGNvZGVj
cwpvdGhlciB0aGFuIFdNODU4MCAobGlrZSB3bTg5OTQpLCBJIHRoaW5rIHdlJ2QgYmV0dGVyIGJy
ZWFrIHRoZSBNQUNISU5FCmRyaXZlciBpbnRvIFNNREsgc3BlY2lmaWMgKHNldHVwIENQVSBtYXN0
ZXIsIENPREVDIHNsYXZlIGFuZApyb290LWNsb2NrIHNvdXJjZWQgYWNjIHRvIG9wdGlvbiBwcm92
aWRlZCB2YWkgcGxhdGZvcm1fZGF0YSkKYW5kIENPREVDIHNwZWNpZmljIHBhcnQuClRoYXQgd2ls
bCBhbHNvIGhlbHAgY29kZSByZXVzZS4KCkFueSBvcGluaW9ucywgYmVmb3JlIEkgc3RhcnQgd29y
a2luZyBvbiBpdD8KClRoYW5rcywKSmFzc2kKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
