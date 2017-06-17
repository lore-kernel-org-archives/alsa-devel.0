From: =?UTF-8?Q?Hans_Peter_M=C3=B6ller?= <hmoller@uc.cl>
Subject: Re: [PATCH 1/2] ALSA: line6: add support for POD HD500X
Date: Sat, 17 Jun 2017 15:03:40 -0400
Message-ID: <CALSLyV5gupzszWrBghO9+_FONH_3O0cy8GWi03WOjxBLsCjh5w@mail.gmail.com>
References: <1497636857-13944-1-git-send-email-hmoller@uc.cl>
 <s5hd1a2ob35.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E3E7266D6A
 for <alsa-devel@alsa-project.org>; Sat, 17 Jun 2017 21:03:41 +0200 (CEST)
Received: by mail-qk0-f193.google.com with SMTP id j126so2470851qkj.2
 for <alsa-devel@alsa-project.org>; Sat, 17 Jun 2017 12:03:41 -0700 (PDT)
In-Reply-To: <s5hd1a2ob35.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org, =?UTF-8?Q?Andrej_Krut=C3=A1k?= <dev@andree.sk>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

TXkgbWlzdGFrZSwgMjAxNywgc29ycnkuIFNob3VsZCBJIGdlbmVyYXRlIGFnYWluIHRoZSAyIGNv
bW1pdHM/IG9yIGEgdGhpcmQKanVzdCBjb3JyZWN0aW5nIHRoYXQ/IEhvdyBzaG91bGQgSSBoYW5k
bGUgaXQ/CmJyZ2RzCkhQTQoKT24gU2F0LCBKdW4gMTcsIDIwMTcgYXQgMTI6MDMgUE0sIFRha2Fz
aGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4gd3JvdGU6Cgo+IE9uIEZyaSwgMTYgSnVuIDIwMTcgMjA6
MTQ6MTYgKzAyMDAsCj4gSGFucyBQLiBNw7ZsbGVyIEVibmVyIHdyb3RlOgo+ID4KPiA+IEFkZCBz
dXBwb3J0IGZvciB0aGUgTGluZTYgUE9EIEhENTAwWCBtdWx0aSBlZmZlY3QgcHJvY2Vzc29yIGZv
ciBwbGF5YmFjawo+IGFuZCBjYXB0dXJlIChpbi9vdXQgYXVkaW8pIHRocm91Z2ggVVNCLgo+ID4K
PiA+IFNpZ25lZC1vZmYtYnk6IEhhbnMgUC4gTW9sbGVyIDxobW9sbGVyQHVjLmNsPgo+ID4gLS0t
Cj4gPiAgc291bmQvdXNiL2xpbmU2L3BvZGhkLmMgfCAxNyArKysrKysrKysrKysrKysrLQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4g
ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9saW5lNi9wb2RoZC5jIGIvc291bmQvdXNiL2xpbmU2L3Bv
ZGhkLmMKPiA+IGluZGV4IDZhYjIzZTUuLmUzODlmOTIgMTAwNjQ0Cj4gPiAtLS0gYS9zb3VuZC91
c2IvbGluZTYvcG9kaGQuYwo+ID4gKysrIGIvc291bmQvdXNiL2xpbmU2L3BvZGhkLmMKPiA+IEBA
IC0zLDYgKzMsNyBAQAo+ID4gICAqCj4gPiAgICogQ29weXJpZ2h0IChDKSAyMDExIFN0ZWZhbiBI
YWpub2N6aSA8c3RlZmFuaGFAZ21haWwuY29tPgo+ID4gICAqIENvcHlyaWdodCAoQykgMjAxNSBB
bmRyZWogS3J1dGFrIDxkZXZAYW5kcmVlLnNrPgo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAxNSBI
YW5zIFAuIE1vbGxlciA8aG1vbGxlckB1Yy5jbD4KPgo+IFdhcyB0aGUgY29kZSB3cml0dGVuIGlu
IHR3byB5ZWFycyBhZ28/ICBPdGhlcndpc2UgcHV0IDIwMTcuCj4gKE9yIHlvdSBjYW4gb21pdCBz
dWNoIGEgY2hhbmdlLCB0b28uICBUaGUgY2hhbmdlIGhpc3RvcnkgY2FuIGJlCj4gIHRyYWNrZWQg
dmlhIGdpdCBub3dhZGF5cy4pCj4KPgo+IHRoYW5rcywKPgo+IFRha2FzaGkKPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
