From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC PATCH 4/5] ASoC: remove those unnecessary
	#ifdef CONFIG_PXA3xx .. #endif
Date: Thu, 23 Apr 2009 17:18:18 +0800
Message-ID: <f17812d70904230218t3d7da731j7baebb704b26910b@mail.gmail.com>
References: <f17812d70904222206h27c58e40t5c8383133df1a7d0@mail.gmail.com>
	<20090423081715.GA30105@sirena.org.uk>
	<f17812d70904230133l34f77174sc18d4f30879dac64@mail.gmail.com>
	<20090423090419.GA29567@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id B9B80103861
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 11:18:18 +0200 (CEST)
Received: by qyk1 with SMTP id 1so852330qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2009 02:18:18 -0700 (PDT)
In-Reply-To: <20090423090419.GA29567@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBBcHIgMjMsIDIwMDkgYXQgNTowNCBQTSwgRGFuaWVsIE1hY2sgPGRhbmllbEBjYWlh
cS5kZT4gd3JvdGU6Cj4gT24gVGh1LCBBcHIgMjMsIDIwMDkgYXQgMDQ6MzM6MzRQTSArMDgwMCwg
RXJpYyBNaWFvIHdyb3RlOgo+PiBPbiBUaHUsIEFwciAyMywgMjAwOSBhdCA0OjE3IFBNLCBNYXJr
IEJyb3duIDxicm9vbmllQHNpcmVuYS5vcmcudWs+IHdyb3RlOgo+PiA+IFRoaXMgaXNuJ3QgZG9u
ZSBmb3IgY29tcGlsZXIgb3B0aW1pc2F0aW9uIC0gaXQncyBkb25lIGJlY2F1c2UgdGhlCj4+ID4g
cmVnaXN0ZXIgYml0IG1hY3JvcyBhcmUgb25seSBkZWZpbmVkIGlmIFBYQTN4eCBzdXBwb3J0IGlz
IGJlaW5nIGJ1aWx0Cj4+ID4gaW4uIMKgSSd2ZSBubyBwcm9ibGVtIHdpdGggcmVtb3ZpbmcgdGhv
c2UgZ3VhcmRzIGJ1dCB3aXRob3V0IHRoYXQgeW91J2xsCj4+ID4gZ2V0IGJ1aWxkIGZhaWx1cmVz
IG9uIFBYQTJ4eC4KPj4gPgo+Pgo+PiBZZWFoLCBpbmRlZWQuIFRoaXMgaXMgYSBydXNoIChzbyB0
aGUgdGl0bGUgaXMgUkZDKSwgc29ycnkuIEknbGwgZ2V0IHRob3NlCj4+IGNvbmRpdGlvbmFsICNp
ZmRlZiAuLiAjZW5kaWYgcmVtb3ZlZCBhcyB3ZWxsIGluIHRoZSBzc3AtcmVncy5oLCBpdAo+PiBh
bHdheXMgbWFrZXMgbWUgdXBzZXQuCj4KPiBXZWxsLCBJIHB1dCB0aGVtIGluIHRoZXJlIHRvIGNs
ZWFybHkgc3RhdGUgd2hpY2ggQ1BVcyBoYXZlIHN1cHBvcnQKPiBmb3IgdGhpcyBwYXJ0aWN1bGFy
IGZlYXR1cmUuIEVzcGVjaWFsbHkgZm9yIFBYQXMsIHdoZXJlIGV2ZW4gcmVnaXN0ZXIKPiBkZWZp
bml0aW9ucyBhcmUgY29uc2lkZXJlZCBjb25maWRlbnRpYWwsIHRoaXMgbWlnaHQgaGVscCBwZW9w
bGUgZmlzaGluZwo+IGluIG11ZGR5IHdhdGVycy4gU29tZSBjb21tZW50IHdvdWxkIGRvIGFzIHdl
bGwsIHRob3VnaC4KPgoKWWVhaCwgSSBmdWxseSB1bmRlcnN0YW5kIHRoYXQuIEFjdHVhbGx5IHRo
ZXNlIGFyZSBpbmNsdXNpdmUgI2lmZGVmIC4uCndoaWNoIGFjdHVhbGx5IGRvZXNuJ3QgaHVydC4g
KFVubGlrZSAjaWZkZWYgLi4gI2Vsc2UgLi4gI2VuZGlmKS4KCkJ1dCBzaW5jZSB0aGUgY29tcGls
ZXIgY2FuIGFjdHVhbGx5IG9wdGltaXplIGl0IGF3YXksIGFuZCBpdCdzIHF1aXRlCm9idmlvdXMg
cHhhM3h4IHNwZWNpZmljIGJ5IGlmIChjcHVfaXNfcHhhM3h4KCkpIC4uICwgSSdtIGEgYml0IGlu
dGVuZGVkCnRvIHJlbW92ZSB0aGVtIGF3YXksIG5vPwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
