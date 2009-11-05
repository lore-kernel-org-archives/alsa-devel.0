From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC - Add support for upto 16 channels on
	OMAP MCBSP
Date: Thu, 5 Nov 2009 09:51:43 +0200
Message-ID: <20091105095143.995beeea.jhnikula@gmail.com>
References: <1257357235.2887.499.camel@odin>
	<20091104185534.GA22055@xora.vm.bytemark.co.uk>
	<1257364009.2887.665.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 49AFD1038A9
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 08:50:53 +0100 (CET)
Received: by fxm1 with SMTP id 1so404633fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2009 23:50:53 -0800 (PST)
In-Reply-To: <1257364009.2887.665.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAwNCBOb3YgMjAwOSAxOTo0Njo0OSArMDAwMApMaWFtIEdpcmR3b29kIDxscmdAc2xp
bWxvZ2ljLmNvLnVrPiB3cm90ZToKCj4gPiA+ICsJLyogY2FsYyBiZXN0IGZyYW1lIHNpemUgZm9y
IHJhdGUgYW5kIGNsb2NrIGRpdmlkZXIgKi8KPiA+ID4gKwlkbyB7Cj4gPiA+ICsJCWZyYW1lX3Np
emUgPSAobWNic3BfZGF0YS0+aW5fZnJlcSAvIGRpdikgLyBwYXJhbXNfcmF0ZShwYXJhbXMpOwo+
ID4gPiArCQlwcl9kZWJ1ZygiZnJlcSAlZCwgcmF0ZSAlZCwgZnJhbWUgc2l6ZSAlZCwgZGl2ICVk
XG4iLAo+ID4gPiArCQkJCW1jYnNwX2RhdGEtPmluX2ZyZXEsIHBhcmFtc19yYXRlKHBhcmFtcyks
IGZyYW1lX3NpemUsIGRpdik7Cj4gPiA+ICsKPiA+ID4gKwkJaWYgKGZyYW1lX3NpemUgPiAyNTYp
Cj4gPiA+ICsJCQlkaXYrKzsKPiA+ID4gKwl9IHdoaWxlIChmcmFtZV9zaXplID4gMjU2KTsKPiA+
ID4gKwoKVGhpcyB3b3VsZCBiZSBiZXR0ZXIgaWYgaXQgdHJpZXMgdG8gY2FsY3VsYXRlIG1pbmlt
dW0gZnJhbWUgc2l6ZS4gTm93CnRoZSBhbGdvcml0aG0gc3RvcHMgd2hlbiB0aGUgZnJhbWVfc2l6
ZSBpcyAyNTYgYW5kIGxlYWRzIHRvIGhpZ2hlcgpiaXQgY2xvY2suCgpFLmcuIDQgKiAxNmJpdHMg
KiA0OCBrSHogYW5kIHVzaW5nIDk2IE1IeiBpbnRlcm5hbCBjbG9jazoKCkFsZ29yaXRobTogZGl2
ID0gOCwgZnJhbWVfc2l6ZSA9IDI1MCBhbmQgYml0IGNsb2NrID0gMTIgTUh6LgoKUG9zc2libGUg
ZGl2aWRlcnMgYW5kIGZyYW1lX3NpemVzOgoKMjUqODAgKC0+IGJlc3QsIGJpdCBjbG9jayA9IDMu
ODQwIE1IeikKMjAqMTAwCjE2KjEyNQoxMCoyMDAKOCoyNTAKCj4gPiBUaGlzIGNodW5rIGNoYW5n
ZXMgdGhlIHNlbWFudGljcyBvZiBvdGhlciBkZXZpY2VzIHdoaWNoIEkgaGF2ZSBuZXZlciB0ZXN0
ZWQuCj4gPiAKPiA+IEkgYWxzbyBkb250IGtub3cgaG93IG11Y2ggZGFtYWdlIGl0IGRvZXMgaWYg
aXQgZG9lcyB0byBzbGF2ZSBtb2RlLiBJbiBmYWN0Cj4gPiBJIHRoaW5rIGl0IG1pZ2h0IGJyZWFr
IGl0IGluIGNhc2VzIHdoaWNoIGFyZSBhY3R1YWxseSBhbGxvd2FibGUgYXMgaXQgdXNlcwo+ID4g
dGhlIG9tYXAgYXMgaXRzIGNsb2NrIGNvbnN0cmFpbnQgYW5kIG5vdCB0aGUgY2xvY2sgc291cmNl
Lgo+ID4gCj4gCklSQ0MsIHRoZSBDTEtHRFYgZG9lc24ndCBoYXZlIGVmZmVjdCB3aGlsZSBPTUFQ
IGlzIHNsYXZlIGJ1dCBJIGNhbiB0ZXN0CnRoYXQgd2l0aCBCZWFnbGUuCgo+IEJ0dywgdGhpcyBo
YXMgYmVlbiByZXdvcmtlZCB0byBhdm9pZCBhbGwgSTJTIHBhdGhzIHNpbmNlIHlvdSBsYXN0IHdv
cmtlZAo+IG9uIGl0Lgo+IApQcm9iYWJseSB0aGF0IGlzIG5vdCBuZWNlc3NhcnkgaWYgdGhlIGFs
Z29yaXRobSBhYm92ZSBmaW5kcyBhIGZyYW1lCnNpemUgKMK9IGZvciBkdWFsLXBoYXNlIGZyYW1l
cykgd2hpY2ggZG9lc24ndCBleGNlZWQgSTJTIHdvcmQgc2l6ZT8KVW5pZm9ybSBjb2RlIGlzIGFs
bHdheXMgYmV0dGVyIDotKQoKCi0tIApKYXJra28KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
