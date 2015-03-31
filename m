From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 09/11] sound/core: add IEC958 channel status helper
Date: Tue, 31 Mar 2015 10:13:29 +0100
Message-ID: <20150331091329.GP24899@n2100.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfYA-0002vc-Al@rmk-PC.arm.linux.org.uk>
 <551A5B2F.50203@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <551A5B2F.50203@rock-chips.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Yang Kuankuan <ykk@rock-chips.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBNYXIgMzEsIDIwMTUgYXQgMDQ6MzA6MzlBTSAtMDQwMCwgWWFuZyBLdWFua3VhbiB3
cm90ZToKPiA+Kwljc1swXSA9IElFQzk1OF9BRVMwX0NPTl9OT1RfQ09QWVJJR0hUIHwgSUVDOTU4
X0FFUzBfQ09OX0VNUEhBU0lTX05PTkU7Cj4gPisJY3NbMV0gPSBJRUM5NThfQUVTMV9DT05fR0VO
RVJBTDsKPiA+Kwljc1syXSA9IElFQzk1OF9BRVMyX0NPTl9TT1VSQ0VfVU5TUEVDIHwgSUVDOTU4
X0FFUzJfQ09OX0NIQU5ORUxfVU5TUEVDOwo+ID4rCWNzWzNdID0gSUVDOTU4X0FFUzNfQ09OX0NM
T0NLXzEwMDBQUE0gfCBmczsKPiA+Kwo+IAo+IFByZXR0eSBnb29kLCBhbHNvIHN1aXRhYmxlIHRv
IHJvY2tjaGlwIHBsYXRmb3JtLCBidXQgd2h5IG5vdCBhZGQgdGhlCj4gIklFQzk1OF9BRVMyX0NP
Tl9DSEFOTkVMX01BU0siICYgIklFQzk1OF9BRVMyX0NPTl9XT1JETEVOIiA/Cj4gCj4gU2VlbXMg
c2FtcGxlIGZyZXF1ZW5jeSAmIGNoYW5ubGUgbnVtYmVyICYgd29yZCBsZW5ndGggYXJlIHRoZSBi
YXNpYwo+IG1lc3NhZ2UgOikKCkkgd2FzIGRlYmF0aW5nIGFib3V0IHRoZSB3b3JkIGxlbmd0aCwg
YW5kIHRoYXQncyBzb21ldGhpbmcgSSdsbCBhZGQKbGF0ZXIgdG8gaXQgLSBidXQgb25seSBpZiBs
ZW5ndGggc2hvd3MgdGhhdCB3ZSBoYXZlIHRoZSA1dGggYnl0ZQphdmFpbGFibGUgaW4gdGhlIGJ1
ZmZlci4gIE1vc3QgdXNlcnMgc2VlbSB0byBvbmx5IHVzZSB0aGUgZmlyc3QgZm91cgpieXRlcy4K
CkFzIGZvciB0aGUgY2hhbm5lbCBudW1iZXIsIHRoaXMgaXMgaW50ZW50aW9uYWxseSBsZWZ0IHRv
IHRoZSBkcml2ZXIgLQptb3N0IGNhc2VzIEkndmUgZm91bmQgZWl0aGVyIHRoZSBkcml2ZXIgaXNu
J3QgaW50ZXJlc3RlZCwgb3Igd2hlcmUKdGhleSBhcmUgaW50ZXJlc3RlZCAodGhlIG9ubHkgY2Fz
ZSBJIGtub3cgb2YgaXMgbXkgZHdfaGRtaSBhaGIgYXVkaW8KZHJpdmVyKSwgaXQncyBtb3JlIGFw
cHJvcHJpYXRlIHRvIGdlbmVyYXRlIGEgYmFzZWxpbmUgY2hhbm5lbCBzdGF0dXMsCmFuZCBsZXQg
dGhlIGRyaXZlciBpdGVyYXRlIG92ZXIgdGhlIGNoYW5uZWxzIGFkZGluZyB0aGUgYXBwcm9wcmlh
dGUKY2hhbm5lbCBudW1iZXIgaW4uCgotLSAKRlRUQyBicm9hZGJhbmQgZm9yIDAuOG1pbGUgbGlu
ZTogY3VycmVudGx5IGF0IDEwLjVNYnBzIGRvd24gNDAwa2JwcyB1cAphY2NvcmRpbmcgdG8gc3Bl
ZWR0ZXN0Lm5ldC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
