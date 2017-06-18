From: =?UTF-8?Q?Hans_Peter_M=C3=B6ller?= <hmoller@uc.cl>
Subject: Re: [PATCH 1/2] ALSA: line6: add support for POD HD500X
Date: Sun, 18 Jun 2017 19:15:22 -0400
Message-ID: <CALSLyV5yO-_ZYJs8ZV2jV9aaeZRXTnqLB62wvoo9gVGBM9O7MA@mail.gmail.com>
References: <1497636857-13944-1-git-send-email-hmoller@uc.cl>
 <s5hd1a2ob35.wl-tiwai@suse.de>
 <CALSLyV5gupzszWrBghO9+_FONH_3O0cy8GWi03WOjxBLsCjh5w@mail.gmail.com>
 <s5h7f0anwfp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AFEE266C25
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 01:15:24 +0200 (CEST)
Received: by mail-qk0-f193.google.com with SMTP id u8so4966637qka.0
 for <alsa-devel@alsa-project.org>; Sun, 18 Jun 2017 16:15:24 -0700 (PDT)
In-Reply-To: <s5h7f0anwfp.wl-tiwai@suse.de>
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

SWYgeW91IGNhbiBkbyBpdCwgSSB3b3VsZCBhcHByZWNpYXRlIGl0LgpUaGFua3MuCgpicmdkcwpI
UE0KCk9uIFNhdCwgSnVuIDE3LCAyMDE3IGF0IDU6MjAgUE0sIFRha2FzaGkgSXdhaSA8dGl3YWlA
c3VzZS5kZT4gd3JvdGU6Cgo+IE9uIFNhdCwgMTcgSnVuIDIwMTcgMjE6MDM6NDAgKzAyMDAsCj4g
SGFucyBQZXRlciBNw7ZsbGVyIHdyb3RlOgo+ID4KPiA+IE15IG1pc3Rha2UsIDIwMTcsIHNvcnJ5
LiBTaG91bGQgSSBnZW5lcmF0ZSBhZ2FpbiB0aGUgMiBjb21taXRzPyBvciBhCj4gdGhpcmQKPiA+
IGp1c3QgY29ycmVjdGluZyB0aGF0PyBIb3cgc2hvdWxkIEkgaGFuZGxlIGl0Pwo+Cj4gSXQncyBi
YXNpY2FsbHkgdXAgdG8geW91LiAgSSBjYW4gZml4IGl0IGluIG15IHNpZGUgZm9yIHN1Y2ggYSB0
cml2aWFsCj4gdGhpbmcsIHRvbywgc28gbm8gbmVlZCBmb3IgcmVzZW5kIHVubGVzcyBhbnlvbmUg
ZWxzZSBmaW5kcyBtb3JlCj4gaXNzdWUuCj4KPgo+IHRoYW5rcywKPgo+IFRha2FzaGkKPgo+ID4g
YnJnZHMKPiA+IEhQTQo+ID4KPiA+IE9uIFNhdCwgSnVuIDE3LCAyMDE3IGF0IDEyOjAzIFBNLCBU
YWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+IHdyb3RlOgo+ID4KPiA+ID4gT24gRnJpLCAxNiBK
dW4gMjAxNyAyMDoxNDoxNiArMDIwMCwKPiA+ID4gSGFucyBQLiBNw7ZsbGVyIEVibmVyIHdyb3Rl
Ogo+ID4gPiA+Cj4gPiA+ID4gQWRkIHN1cHBvcnQgZm9yIHRoZSBMaW5lNiBQT0QgSEQ1MDBYIG11
bHRpIGVmZmVjdCBwcm9jZXNzb3IgZm9yCj4gcGxheWJhY2sKPiA+ID4gYW5kIGNhcHR1cmUgKGlu
L291dCBhdWRpbykgdGhyb3VnaCBVU0IuCj4gPiA+ID4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBI
YW5zIFAuIE1vbGxlciA8aG1vbGxlckB1Yy5jbD4KPiA+ID4gPiAtLS0KPiA+ID4gPiAgc291bmQv
dXNiL2xpbmU2L3BvZGhkLmMgfCAxNyArKysrKysrKysrKysrKysrLQo+ID4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gPiA+Cj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9saW5lNi9wb2RoZC5jIGIvc291bmQvdXNiL2xpbmU2L3Bv
ZGhkLmMKPiA+ID4gPiBpbmRleCA2YWIyM2U1Li5lMzg5ZjkyIDEwMDY0NAo+ID4gPiA+IC0tLSBh
L3NvdW5kL3VzYi9saW5lNi9wb2RoZC5jCj4gPiA+ID4gKysrIGIvc291bmQvdXNiL2xpbmU2L3Bv
ZGhkLmMKPiA+ID4gPiBAQCAtMyw2ICszLDcgQEAKPiA+ID4gPiAgICoKPiA+ID4gPiAgICogQ29w
eXJpZ2h0IChDKSAyMDExIFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAZ21haWwuY29tPgo+ID4g
PiA+ICAgKiBDb3B5cmlnaHQgKEMpIDIwMTUgQW5kcmVqIEtydXRhayA8ZGV2QGFuZHJlZS5zaz4K
PiA+ID4gPiArICogQ29weXJpZ2h0IChDKSAyMDE1IEhhbnMgUC4gTW9sbGVyIDxobW9sbGVyQHVj
LmNsPgo+ID4gPgo+ID4gPiBXYXMgdGhlIGNvZGUgd3JpdHRlbiBpbiB0d28geWVhcnMgYWdvPyAg
T3RoZXJ3aXNlIHB1dCAyMDE3Lgo+ID4gPiAoT3IgeW91IGNhbiBvbWl0IHN1Y2ggYSBjaGFuZ2Us
IHRvby4gIFRoZSBjaGFuZ2UgaGlzdG9yeSBjYW4gYmUKPiA+ID4gIHRyYWNrZWQgdmlhIGdpdCBu
b3dhZGF5cy4pCj4gPiA+Cj4gPiA+Cj4gPiA+IHRoYW5rcywKPiA+ID4KPiA+ID4gVGFrYXNoaQo+
ID4gPgo+ID4gWzIgIDx0ZXh0L2h0bWw7IFVURi04IChxdW90ZWQtcHJpbnRhYmxlKT5dCj4gPgo+
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
