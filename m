From: =?UTF-8?B?QWxiaW4gU3RpZ8O2?= <albin.stigo@gmail.com>
Subject: Re: New to this list. Proposed patch to soc-utils.c
Date: Tue, 24 Oct 2017 16:44:27 +0200
Message-ID: <CAMc++1UMgatit46tEJDn4OOpA+N9vXT6-dQTVXbEVc2Kco3SnA@mail.gmail.com>
References: <CAMc++1XF4TM42+xxTSTOThGt8SWyfY_rjibSjPrHH+ZcKehLCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f175.google.com (mail-ua0-f175.google.com
 [209.85.217.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 23C70266DB1
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 16:44:28 +0200 (CEST)
Received: by mail-ua0-f175.google.com with SMTP id n22so15517708uaj.13
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 07:44:28 -0700 (PDT)
In-Reply-To: <CAMc++1XF4TM42+xxTSTOThGt8SWyfY_rjibSjPrHH+ZcKehLCg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

VG8gYW5zd2VyIG15IG93biBxdWVzdGlvbjsgSSByZWFsaXplIG5vdyB0aGF0ClNORFJWX1BDTV9S
QVRFX0NPTlRJTlVPVVMgaXMgZm9yIGFueXRoaW5nIGJldHdlZW4gLnJhdGVfbWluICYKLnJhdGVf
bWF4LiBBbmQgX0tOT1QgaXMgZm9yIG90aGVyIHNwZWNpZmljIHJhdGVzIHBlcmhhcHMgb3V0c2lk
ZSB0aGlzCnJhbmdlLiBJIGZlZWwgdGhpcyBpcyBub3QgbWFkZSB2ZXJ5IGNsZWFyIGluIGRvY3Vt
ZW50YXRpb24gLyBjb21tZW50cy4KCkkgdGhpbmsgU05EUlZfUENNX1JBVEVfQ09OVElOVU9VUyB3
b3VsZCBiZSBtb3JlIGFwcHJvcHJpYXRlIGZvcgpzbmQtc29jLWR1bW15IHRoYW4gU05EUlZfUENN
X1JBVEVfODAwMF8xOTIwMDA/CgpPciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nLi4/IFdvdWxkIHRo
aXMgYnJlYWsgYW55dGhpbmc/CgoKLS1BbGJpbgoKT24gVHVlLCBPY3QgMjQsIDIwMTcgYXQgMTI6
NDIgUE0sIEFsYmluIFN0aWfDtiA8YWxiaW4uc3RpZ29AZ21haWwuY29tPiB3cm90ZToKPiBIZWxs
bywKPgo+IEknbSBuZXcgdG8gdGhpcyBsaXN0IHNvIHBsZWFzZSBleGN1c2UgbXkgaWdub3JhbmNl
LiBJJ20gYW4KPiBhbmVzdGhlc2lvbG9naXN0IGJ5IHByb2Zlc3Npb24gc28gSSBtaWdodCBiZSBh
IGJpdCBvdXQgb2YgbXkgZGVwdGgKPiBoZXJlLi4uCj4KPiBJIHdhcyBkb2luZyBzb21lIGV4cGVy
aW1lbnRhdGlvbiB3aXRoIGN1c3RvbSBpMnMgY29kZWNzIChGUEdBcykgdXNpbmcKPiB0aGUgc25k
LXNvYy1kdW1teSBjb2RlYyAoZGVmaW5lZCBpbiBzb2MtdXRpbHMuYykuIEkgZm91bmQgdGhpcyBj
b2RlYwo+IHRvIGJlIG5lZWRsZXNzbHkgcmVzdHJpY3RpdmUgd2l0aCBzYW1wbGUgcmF0ZXMgYWxs
b3dlZAo+IChTTkRSVl9QQ01fUkFURV84MDAwXzE5MjAwMCkuIEkgbmVlZGVkIHRvIHVzZSBtb3Jl
ICJleG90aWMiIHNhbXBsZQo+IHJhdGVzIHNvIEkgY2FtZSB1cCB3aXRoIGEgcGF0Y2guCj4KPiBJ
IHB1cnBvc2UgdXNpbmcgU05EUlZfUENNX1JBVEVfS05PVCBhbmQgc2V0dGluZyBzb21lIGxpbWl0
czoKPiAucmF0ZV9taW4gPSA4MDAwLAo+IC5yYXRlX21heCA9IDM4NDAwMCwKPgo+IEl0J3MgbXkg
dW5kZXJzdGFuZGluZyB0aGF0IFNORFJWX1BDTV9SQVRFX0NPTlRJTklPVVMgaXMgdXNlZCBmb3IK
PiAia25vd24iIHJhdGVzIGFuZCBTTkRSVl9QQ01fUkFURV9LTk9UIGZvciBtb3JlIG9yIGxlc3Mg
YXJiaXRyYXJ5Cj4gcmF0ZXM/Cj4KPiBJJ20gd2lsbGluZyB0byBzdWJtaXQgbXkgcGF0Y2ggYnV0
IG1pZ2h0IG5lZWQgc29tZSBtZW50b3JpbmcgaW4gdGhlCj4gcHJvY2Vzcy4gSSBkb24ndCB0aGlu
ayB0aGlzIHNpbXBsZSBwYXRjaCBjb3VsZCBicmVhayBhbnl0aGluZy4uPwo+Cj4KPiAtLUFsYmlu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
