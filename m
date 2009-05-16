From: mAdVax <madvax@free.fr>
Subject: Re: emu10k1 TRAM access ?
Date: Sat, 16 May 2009 21:28:06 +0000 (UTC)
Message-ID: <loom.20090516T212123-884@post.gmane.org>
References: <4A0C115E.8010306@free.fr> <s5hskj6a2rl.wl%tiwai@suse.de>
	<4A0DD70C.8050109@free.fr> <4A0E9655.2000008@free.fr>
	<s5h63g184pr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F3FF246C7
	for <alsa-devel@alsa-project.org>;
	Sat, 16 May 2009 23:30:04 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M5RSF-0007mC-25
	for alsa-devel@alsa-project.org; Sat, 16 May 2009 21:30:03 +0000
Received: from 144.161.87-79.rev.gaoland.net ([79.87.161.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 16 May 2009 21:30:03 +0000
Received: from madvax by 144.161.87-79.rev.gaoland.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 16 May 2009 21:30:03 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

VGFrYXNoaSBJd2FpIDx0aXdhaSA8YXQ+IHN1c2UuZGU+IHdyaXRlczoKCj4gCj4gQXQgU2F0LCAx
NiBNYXkgMjAwOSAxMjozMjo1MyArMDIwMCwKPiBtQWRWYXggd3JvdGU6Cj4gPiAKPiA+IG1BZFZh
eCBhIMOpY3JpdCA6Cj4gPiAKPiA+ICA+IERvbid0IHlvdSAoYW55b25lKSBvbmx5IHJlbWVtYmVy
IGlmIGxvb2t1cCB0YWJsZSBoYXMgYmVlbiBpbXBsZW1lbnRlZCA/Cj4gPiAKPiA+IEkgYW5zd2Vy
IHRvIG15IG93biBxdWVzdGlvbi4KPiA+IEFjY29yZGluZyB0byBhbiBvbGQgcG9zdCBvbiBreCBm
b3J1bSwgbG9va3VwIHRhYmxlcyBvbmx5IHdvcmsgb24gZW11MTBrMiAKPiA+IGNoaXBzLCBhbmQg
YXJlIG5ldmVyIGJlZW4gaW1wbGVtZW50ZWQgaW4ga3ggZHJpdmVyLiBJIGZlYXIgdGhhdCBub2Jv
ZHkgCj4gPiBrbm93cyBob3cgdG8gaGFuZGxlIHRoaXMgc3R1ZmYuCj4gPiAKPiA+IEVtdTEwazEg
aXMgcXVpdGUgb2xkLiBTaG91bGQgSSBzd2l0Y2ggdG8gWC1GaSA/IENhbiB0aGUgRFNQIGJlIHVz
ZWQgYnkgCj4gPiB0aGUgdXNlciA/IEluIGEgbmVhciBmdXR1cmUgPwo+IAo+IFRvIGJlIHdhcm5l
ZCwgZW11MjBreCBoYXZlIG11Y2ggbGVzcyBvcGVuIGluZm9ybWF0aW9uIHRoYW4gZW11MTBrMS4u
Lgo+IFRoZSBjdXJyZW50IGRyaXZlciBqdXN0IHN1cHBvcnRzIHRoZSBub3JtYWwgUENNLCBhbmQg
bm8gcmVhbCBEU1AKPiBwYXJ0cyBhcmUgc3VwcG9ydGVkLgoKSSBzZWUuLi4gSXQncyBhIHNoYW1l
LiBObyBvdGhlciBjb21wZXRpdG9yIHdpdGggJ29wZW4nIGRzcCA/CgpJJ20gc3RpY2tlZCB3aXRo
IG15IEF1ZGlneSBmb3IgbG9uZy4gU2hlJ3Mgbm90IHNvIGJhZCwgYWZ0ZXIgYWxsIDspCgpUaGFu
ayB5b3UKClhhdmllcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
