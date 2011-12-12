From: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
Subject: Re: [PATCH] ALSA: hda: invert mute led polarity for
	HP	laptops
Date: Mon, 12 Dec 2011 14:07:50 -0200
Message-ID: <1323706070.3811.21.camel@oberon.sagui.org>
References: <1323018809.3883.2.camel@oberon.sagui.org>
	<s5hhb16uj1l.wl%tiwai@suse.de>
	<1323698159.3811.14.camel@oberon.sagui.org>
	<s5h39cpvqc5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from horatio.sagui.org (horatio.sagui.org [173.230.138.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B93624576
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 17:07:54 +0100 (CET)
In-Reply-To: <s5h39cpvqc5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

RW0gU2VnLCAyMDExLTEyLTEyIMOgcyAxNTowNCArMDEwMCwgVGFrYXNoaSBJd2FpIGVzY3JldmV1
Ogo+IEF0IE1vbiwgMTIgRGVjIDIwMTEgMTE6NTU6NTkgLTAyMDAsCj4gR3VzdGF2byBNYWNpZWwg
RGlhcyBWaWVpcmEgd3JvdGU6Cj4gPiBVbmZvcnR1bmF0ZWx5IG5vLiBBY3R1YWxseSwgaXQgYXBw
ZWFycyBzb21lb25lIGF0IEhQIGlzIHB1bGxpbmcgYQo+IHByYW5rCj4gPiBvbiB1cy4gSW4gYSBQ
YXZpbGlvbiBkbTQgdGhlIEJJT1Mgc3RyaW5nIGlzICJIUF9NdXRlX0xFRF9QX0ciLCB3aGVyZQo+
IFAKPiA+IGFuZCBHIGFyZSBub3QgbnVtYmVycywgYnV0IHRoZSBhY3R1YWwgbGV0dGVycy4KPiAK
PiBEb2gsIHRoZXkgZm9yZ290IHRvIGZpbGwgdGhlIHJpZ2h0IG51bWJlcnMgdGhlcmUuICBPYnZp
b3VzbHkgYSBCSU9TCj4gYnVnLgo+IAo+IEZvciBzdWNoIG1hY2hpbmVzLCB0aGUgSURzIHNob3Vs
ZCBiZSBleHBsaWNpdGx5IGNoZWNrZWQgaW5zdGVhZCBvZgo+IG1hcmtpbmcgYWxsIG1hY2hpbmVz
IHdpdGggdGhpcyBjb2RlYy4gIFRoYXQgaXMsIHRoZSBpbmZsdWVuY2UgbXVzdCBiZQo+IGFzIHNt
YWxsIGFzIHBvc3NpYmxlLiAgT3IsIGp1c3QgY2hlY2sgIkhQX011dGVfTEVEX1BfRyIgc3RyaW5n
IGFzIGFuCj4gaWRlbnRpZmllciBvZiBiYWQgbWFjaGluZXMsIGFuZCBhcHBseSBhIHNwZWNpYWwg
aGFuZGxpbmcuCgpJIGNhbiBkbyBib3RoLCB0byBiZSBkb3VibGUgc3VyZS4gSnVzdCB0ZWxsIG1l
IHdoaWNoIElEIHRvIHVzZS4gSQphc3N1bWVkIHRoYXQgY29kZWMtPnN1YnN5c3RlbV9pZCB3YXMg
dW5pcXVlIGVub3VnaCAoYnkgaW5zcGVjdGluZwpocF9ibGlrZV9zeXN0ZW0odTMyKSkKCj4gCj4g
QlRXLCBub3cgSURUIGd1eXMgYW5kIEkgYXJlIGRpc2N1c3NpbmcgYWJvdXQgZHJvcHBpbmcgdGhl
IGZhbGxiYWNrCj4gY2FzZSBmb3IgOTJIRDgzeCBjb2RlY3MgYmVjYXVzZSBpdCBjYW4gYnJlYWsg
cG90ZW50aWFsbHkgdGhlIEVBUEQuCj4gWW91ciBwYXRjaCB3b24ndCB3b3JrIGFueSBtb3JlIGlm
IHRoYXQgY2hhbmdlIGlzIGFwcGxpZWQuICBTbywgYSBtb3JlCj4gc29saWQgZml4IHdvdWxkIGJl
IG5lZWRlZCBhbnl3YXkuCgpJdCdzIGEgQklPUyBidWcuIEFueSBmaXggaXMgZ29pbmcgdG8gc3Vj
ay4gOikKCkFicmHDp29zLApHdXN0YXZvCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
