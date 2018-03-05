From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
Subject: Re: [BUG] Kernel crash on Allwinner H3 due to sound
	core changes
Date: Mon, 05 Mar 2018 22:30:23 +0100
Message-ID: <26212674.B0xcQEiVyd@jernej-laptop>
References: <2424862.oPtAVTfrB9@jernej-laptop>
 <63331816.68OamKINx1@jernej-laptop> <20180302124050.GF6255@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.siol.net (mailoutvs4.siol.net [213.250.19.137])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BF6026709D
 for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2018 22:30:26 +0100 (CET)
In-Reply-To: <20180302124050.GF6255@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org, wens@csie.org, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGksCgpEbmUgcGV0ZWssIDAyLiBtYXJlYyAyMDE4IG9iIDEzOjQwOjUwIENFVCBqZSBNYXJrIEJy
b3duIG5hcGlzYWwoYSk6Cj4gT24gVGh1LCBNYXIgMDEsIDIwMTggYXQgMTE6MjM6NTdQTSArMDEw
MCwgSmVybmVqIMWga3JhYmVjIHdyb3RlOgo+ID4gSSByZW1vdmVkIHBhcnRzIG9mIHRoZSBjb2Rl
IGZyb20gdGhlIHN1bjRpIGNvZGVjIGRyaXZlciBhbmQgaW50ZXJlc3RpbmdseQo+ID4gaXQgZG9l
c24ndCBjcmFzaCBpZiBJIHJlbW92ZSBmb2xsb3dpbmcgbGluZXM6Cj4gPiAKPiA+IHJldCA9IGRl
dm1fc25kX2RtYWVuZ2luZV9wY21fcmVnaXN0ZXIoJnBkZXYtPmRldiwgTlVMTCwgMCk7Cj4gPiBp
ZiAocmV0KSB7Cj4gPiAKPiA+IAlkZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gcmVnaXN0
ZXIgYWdhaW5zdCBETUFFbmdpbmVcbiIpOwo+ID4gCWdvdG8gZXJyX2Fzc2VydF9yZXNldDsKPiA+
IAo+ID4gfQo+ID4gCj4gPiBJcyBpdCBwb3NzaWJsZSB0aGF0IE5VTEwgcG9pbnRlciBjYXVzZXMg
dHJvdWJsZXMgc29tZXdoZXJlIGRvd24gdGhlIGxpbmU/Cj4gCj4gU2hvdWxkbid0IGJlLCB0aGF0
J3MganVzdCB0aGUgY29uZmlndXJhdGlvbiB3aGljaCBpcyBvcHRpb25hbCBhbmQgbm90Cj4gd2hh
dCB3ZSdyZSBjcmFzaGluZyB0cnlpbmcgdG8gcmVnaXN0ZXIsIHdlIGNhbiBtb3N0bHkgY29uZmln
dXJlIHRoaW5ncwo+IGJ5IHF1ZXJ5aW5nIHRoZSBjYXBhYmlsaXRpZXMgb2YgdGhlIERNQSBjb250
cm9sbGVyIHZpYSB0aGUgZG1hZW5naW5lIEFQSQo+IHRoZXNlIGRheXMuICBZb3UncmUgcmVtb3Zp
bmcgYWxsIHRoZSBETUEgc3VwcG9ydCB0aGVyZSBzbyBjdXR0aW5nIG91dCBhCj4gaHVnZSBzZWdt
ZW50IG9mIHRoZSBpbml0aWFsaXphdGlvbiBvZiBib3RoIHRoaXMgZHJpdmVyIGFuZCB0aGUgbWFj
aGluZQo+IGRyaXZlci4gIE90aGVyIHN1bnhpIGRldmljZXMgc2VlbSB0byBiZSBzdGFydGluZyBo
YXBwaWx5IGluIC1uZXh0IHNvCj4gdGhlcmUncyBzb21ldGhpbmcgc3lzdGVtIGRlcGVuZGVudCBo
ZXJlLi4uCgpJIGVuYWJsZWQgbWVtb3J5IGRlYnVnZ2luZyBhbmQgaXQgc2VlbXMgdGhhdCB0aGVy
ZSBpcyBhbiBpc3N1ZSBjYXVzZWQgYnkgCmxvYWRpbmcgc3VuNGktY29kZWMgZHJpdmVyIGFuZCBp
dCBpcyBzb21laG93IGNvbm5lY3RlZCB0byAKc25kX2RtYWVuZ2luZV9wY21fdW5yZWdpc3Rlcigp
LgoKSGVyZSBpcyByZWxldmFudCBkbWVzZzogaHR0cHM6Ly9wYXN0ZWJpbi5jb20vcmF3LzgwSzlH
UG5CCgpEb2VzIHRoaXMgdGVsbCBhbnl0aGluZz8KCkJlc3QgcmVnYXJkcywKSmVybmVqCgoKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
