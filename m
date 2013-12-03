From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] ASoC: ux500_pcm: Differentiate between
 pdata and DT initialisation
Date: Tue, 3 Dec 2013 10:03:34 +0000
Message-ID: <20131203100334.GI11828@lee--X1>
References: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
 <1386007222-10081-2-git-send-email-lee.jones@linaro.org>
 <529CCDAF.7050205@metafoo.de> <20131203083600.GB11828@lee--X1>
 <529D9CD1.3020208@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id CF1D926514A
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 11:03:41 +0100 (CET)
Received: by mail-ie0-f169.google.com with SMTP id e14so23844198iej.0
 for <alsa-devel@alsa-project.org>; Tue, 03 Dec 2013 02:03:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <529D9CD1.3020208@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linus.walleij@linaro.org, broonie@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAwMyBEZWMgMjAxMywgTGFycy1QZXRlciBDbGF1c2VuIHdyb3RlOgoKPiBPbiAxMi8w
My8yMDEzIDA5OjM2IEFNLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPk9uIE1vbiwgMDIgRGVjIDIwMTMs
IExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToKPiA+Cj4gPj5PbiAxMi8wMi8yMDEzIDA3OjAwIFBN
LCBMZWUgSm9uZXMgd3JvdGU6Cj4gPj4+SWYgYm9vdGluZyB3aXRoIGZ1bGwgRFQgc3VwcG9ydCAo
aS5lLiBETUEgdG9vLCB0aGUgbGFzdCBwaWVjZSBvZiB0aGUKPiA+Pj5wdXp6bGUpLCB0aGVuIHdl
IGRvbid0IG5lZWQgdG8gdXNlIHRoZSBjb21wYXRpYmxlIHJlcXVlc3QgY2hhbm5lbCBjYWxsCj4g
Pj4+YmFjay4gV2UgYWxzbyByZXF1aXJlIHNsaWdodGx5IGRpZmZlcmVudCBmbGFncyB0byBpbmZv
cm0gdGhlIGNvcmUgdGhhdAo+ID4+PndlIGFyZSBib290aW5nIHdpdGggRFQuCj4gPj4KPiA+Pkkg
ZG9uJ3QgdGhpbmsgeW91IG5lZWQgZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIERUIGFuZCBub24tRFQg
aGVyZS4KPiA+PklmIHRoZSBTTkRfRE1BRU5HSU5FX1BDTV9GTEFHX0NPTVBBVCBpcyBzZXQgYW5k
IHRoZQo+ID4+U05EX0RNQUVOR0lORV9QQ01fRkxBR19OT19EVCBpcyBub3Qgc2V0IGl0IHdpbGwg
Zmlyc3QgdHJ5IHRvIHJlcXVlc3QgdGhlCj4gPj5jaGFubmVscyBmcm9tIHRoZSBEVCBpZiB0aGF0
IGZhaWxzIGl0IHdpbGwgZmFsbGJhY2sgdG8gdGhlIGNvbXBhdCBwYXRoLiBTbwo+ID4+YWxsIHRo
aXMgcGF0Y2ggbmVlZHMgdG8gZG8gaXMgcmVtb3ZlIHRoZSBTTkRfRE1BRU5HSU5FX1BDTV9GTEFH
X05PX0RULCB0aGF0Cj4gPj5zaG91bGQgYmUgaXQuCj4gPgo+ID5JIGhhdmUgbm8gd2F5IG9mIHRl
c3RpbmcgdGhhdCwgYXMgd2UgYXJlIGN1cnJlbnRseSA4MCUgdGhyb3VnaAo+ID5zaHV0dGluZyBk
b3duIHBsYXRmb3JtIGRhdGEgYWx0b2dldGhlci4gSW4gZmFjdCwgSSB0aGluayB0aGVyZSBpcyBv
bmx5Cj4gPkFTb0MgdG8gYmUgY29udmVydGVkLiBNb3N0IG9mIHRoaXMgc3R1ZmYgaXMgZ29pbmcg
dG8gYmUgcmlwcGVkIG91dAo+ID53aXRoaW4gdGhlIG5leHQgY291cGxlIG9mIHdlZWtzIGluIGFu
eSBjYXNlLiBJdCB3aWxsIGhhcHBlbiBhcyBzb29uIGFzCj4gPkkgY2FuIGZpbmQgYW4gaG91ciBv
ciB0d28gdG8gd29yayBvbiBpdC4KPiA+Cj4gPkZvciB0aGF0IHJlYXNvbiBJIGRpZG4ndCB3YW50
IHRvIGRpc3R1cmIgdGhlIGN1cnJlbnQgc2VtYW50aWNzLiBJJ3ZlCj4gPmFscmVhZHkgZm91bmQg
dGhhdCBhIGJ1bmNoIG9mIGhlIGdlbmVyaWMgKG9oLCB5b3UgY2FuIGp1c3QgdXNlIHRoZQo+ID5j
ZW50cmFsKSBmdW5jdGlvbnMgKGZvciB0aGF0KSBkb24ndCBhY3R1YWxseSB3b3JrIGZvciB1cyBm
b3Igb25lCj4gPnJlYXNvbiBvciBhbm90aGVyLgo+IAo+IEFsbCBTTkRfRE1BRU5HSU5FX1BDTV9G
TEFHX05PX0RUIGRvZXMgaXMgdG8gc2tpcCB0cnlpbmcgdG8gcmVxdWVzdAo+IHRoZSBjaGFubmVs
IGZyb20gdGhlIGR0LiBJZiBvZl9ub2RlIGlzIE5VTEwgdGhpcyBzdGVwIHdpbGwgYmUKPiBza2lw
cGVkIGFueXdheS4gU28gb25seSBzZXR0aW5nIFNORF9ETUFFTkdJTkVfUENNX0ZMQUdfTk9fRFQg
aWYgd2UKPiBhbHJlYWR5IGtub3cgdGhhdCB0aGUgbm9kZSBpcyBOVUxMIGlzIHJlZHVuZGFudC4K
CkknbGwganVzdCBoYXZlIHRvIHRydXN0IHlvdSBvbiB0aGlzIGFuZCByZXN1Ym1pdCB3aXRoIHRo
ZSBvdGhlciBwYXRjaC4KCi0tIApMZWUgSm9uZXMKTGluYXJvIFNUTWljcm9lbGVjdHJvbmljcyBM
YW5kaW5nIFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3Ig
QVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
