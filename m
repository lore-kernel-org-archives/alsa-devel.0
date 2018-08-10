From: Emmanuel Gil Peyrot <linkmauve@jabberfr.org>
Subject: Re: [PATCH - hwmixvolume 1/9] hwmixvolume: replace
 PyGTK with gobject-introspection
Date: Fri, 10 Aug 2018 17:29:54 +0200
Message-ID: <20180810152954.GA21562@yun.org>
References: <20180808155637.5592-1-linkmauve@jabberfr.org>
 <20180808155637.5592-2-linkmauve@jabberfr.org>
 <s5h36vm2rtc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jabberfr.org (jabberfr.org [62.210.214.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 04FD426770B
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2018 17:29:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h36vm2rtc.wl-tiwai@suse.de>
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
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBBdWcgMTAsIDIwMTggYXQgMDQ6NTY6NDdQTSArMDIwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IE9uIFdlZCwgMDggQXVnIDIwMTggMTc6NTY6MjkgKzAyMDAsCj4gRW1tYW51ZWwgR2ls
IFBleXJvdCB3cm90ZToKPiA+IAo+ID4gVGhpcyBkb2VzbuKAmXQgd29yayB5ZXQsIHdlIHJlcXVp
cmUgR3RrwqAzLjAgcmF0aGVyIHRoYW4gMi4wIGFuZCB0aGUgQVBJCj4gPiBjaGFuZ2VkIHF1aXRl
IGEgbG90Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBFbW1hbnVlbCBHaWwgUGV5cm90IDxsaW5r
bWF1dmVAbGlua21hdXZlLmZyPgo+IAo+IFRoYW5rcyBmb3IgdGhlIHBhdGNoZXMuICBNb3N0IG9m
IGNoYW5nZXMgbG9vayBnb29kLCBidXQgYWxzbyBtb3N0IG9mCj4gcGF0Y2hlcyBoYXZlIG5vIGNo
YW5nZSBsb2cgYXQgYWxsLiAgVGhhdCdzIGFscmVhZHkgYSBiYWQgc2lnbi4KPiAKPiBDb3VsZCB5
b3UgZ2l2ZSBzb21lIGRldGFpbHMsIGVzcGVjaWFsbHkgd2h5IHRoZSBjaGFuZ2UgaXMgbmVlZGVk
LCBpbgo+IGVhY2ggcGF0Y2ggYW5kIHJlc3VibWl0IGFzIGEgcGF0Y2hzZXQ/ICBBdCBiZXN0LCBz
ZW5kIHdpdGggYSBjb3Zlcgo+IGxldHRlciBhbmQgYSB0aHJlYWQgYXMgYSBwYXRjaCBzZXQgYXQg
dGhlIG5leHQgdGltZSAoZ2l0LXNlbmQtZW1haWwKPiBjYW4gbWFuYWdlIGl0IHdlbGwpLgoKSSBh
Y3R1YWxseSB3cm90ZSBhIGNvdmVyIGxldHRlclsxXSwgYnV0IGl0IHNlZW1zIHlvdXIgZW1haWwg
c2VydmljZQpkaWRu4oCZdCBhY2NlcHQgdGhlIFVURi04IGVuY29kaW5nIG9mIGl0LCBJIHJlY2Vp
dmVkIGEgYm91bmNlIGVtYWlsIGFib3V0CnRoYXQuCgpJ4oCZbGwgc2VuZCBhIHYyIHdpdGggbW9y
ZSBkZXRhaWxlZCBjb21taXQgbWVzc2FnZXMsIHRoYW5rcy4KCj4gCj4gCj4gVGFrYXNoaQoKWzFd
IGh0dHBzOi8vbGlua21hdXZlLmZyL2ZpbGVzLzAwMDAtY292ZXItbGV0dGVyLnBhdGNoCgotLSAK
RW1tYW51ZWwgR2lsIFBleXJvdApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVj
dC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fs
c2EtZGV2ZWwK
