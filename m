From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm: sti: fix prototypes after API change
Date: Tue, 5 Jul 2016 09:59:16 +1000
Message-ID: <CAPM=9tzjJZ_PCv-TT8xR0GEYOny9W6J72v-FLRDQrHr3phQRDg@mail.gmail.com>
References: <20160704131651.1083630-1-arnd@arndb.de>
 <20160704132230.GD6247@sirena.org.uk>
 <6436978.7TJhubtDTK@wuerfel> <20160704133810.GF6247@sirena.org.uk>
 <20160705094637.5076b8a0@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160705094637.5076b8a0@canb.auug.org.au>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: alsa-devel@alsa-project.org, kernel@stlinux.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

T24gNSBKdWx5IDIwMTYgYXQgMDk6NDYsIFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5iLmF1dWcu
b3JnLmF1PiB3cm90ZToKPiBIaSBEYXZlLAo+Cj4gT24gTW9uLCA0IEp1bCAyMDE2IDE1OjM4OjEw
ICswMjAwIE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4gd3JvdGU6Cj4+Cj4+IE9uIE1v
biwgSnVsIDA0LCAyMDE2IGF0IDAzOjM2OjU3UE0gKzAyMDAsIEFybmQgQmVyZ21hbm4gd3JvdGU6
Cj4+ID4gT24gTW9uZGF5LCBKdWx5IDQsIDIwMTYgMzoyMjozMCBQTSBDRVNUIE1hcmsgQnJvd24g
d3JvdGU6Cj4+Cj4+ID4gPiBJIHNlbnQgYSBwdWxsIHJlcXVlc3QgZm9yIHRoZSBBUEkgY2hhbmdl
IHRvIHRoZSBEUk0gcGVvcGxlIHdoaWNoIG1pZ2h0Cj4+ID4gPiBiZSBlYXNpZXIgZ2l2ZW4gdGhh
dCBpdCdzIGEgc2luZ2xlIGNvbW1pdCB0b3BpYyBicmFuY2ggcmF0aGVyIHRoYW4gdGhlCj4+ID4g
PiB3aG9sZSBvZiBEUk0uCj4+Cj4+ID4gQWdyZWVkLCB0aGF0IGlzIHByb2JhYmx5IHRoZSBiZXN0
IHdheSBmb3J3YXJkLiBEb2VzIHlvdXIgcHVsbCByZXF1ZXN0Cj4+ID4gYWxzbyBjb250YWluIGFu
IGVxdWl2YWxlbnQgb2YgbXkgdHdvIHBhdGNoZXM/Cj4+Cj4+IE5vLCBJIGp1c3Qgc2VudCBhIHB1
bGwgcmVxdWVzdCBmb3IgdGhlIEFQSSBjaGFuZ2UgLSBJIGRvbid0IGhhdmUgdGhlIG5ldwo+PiBw
YXRjaGVzIGluIG15IHRyZWUuCj4KPiBTbyB0byBiZSB2ZXJ5IGNsZWFyLCB3aGF0IHlvdSB3b3Vs
ZCBuZWVkIHRvIGRvIGlzIG1lcmdlIHRoZSBvbmUgY29tbWl0Cj4gYnJhbmNoIHRoYXQgTWFyayBz
ZW50IHlvdSBhIHB1bGwgcmVxdWVzdCBmb3I6Cj4KPiAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9icm9vbmllL3NvdW5kLmdpdCB0YWdzL2Fzb2MtaGRtaS1j
b2RlYy1wZGF0YQo+Cj4gYW5kIGFzIHBhcnQgb2YgdGhlIG1lcmdlIGNvbW1pdCAoc28gZS5nLiAi
Z2l0IGFwcGx5IDxwYXRjaD47IGdpdCBjb21taXQKPiAtLWFtZW5kIiBvbiB0b3Agb2YgdGhlIG1l
cmdlKSwgYWRkIHRoZSB0d28gcGF0Y2hlcyB3ZSBhcmUgdGFsa2luZyBhYm91dDoKPgo+ICAgImRy
bTogc3RpOiBmaXggcHJvdG90eXBlcyBhZnRlciBBUEkgY2hhbmdlIgo+ICAgImRybTogbWVkaWF0
ZWs6IGZpeCBwcm90b3R5cGVzIGFmdGVyIEFQSSBjaGFuZ2UiCj4KPiBUaGVuIGFueSBmdXJ0aGVy
IGNvbmZsaWN0cyBjYW4gaG9wZWZ1bGx5IGJlIGZpeGVkIHVwIGFzIHRoZXkgYXBwZWFyIGluCj4g
eW91ciB0cmVlIChpZiBhbnkpLiAgT3IgYmUgYXZvaWRlZCBieSBwZW9wbGUgZGV2ZWxvcGluZyBh
Z2FpbnN0IHlvdXIKPiB0cmVlLgoKVGhhbmtzIFN0ZXBoZW4sCgpJIHRoaW5rIEkndmUgZG9uZSBp
dCBjb3JyZWN0bHksIEkndmUganVzdCBwdXNoZWQgb3V0IGRybS1uZXh0IHdpdGggdGhlCnB1bGwg
YW5kIHRoZQp0d28gY2hhbmdlcyBhbWVuZGVkIGludG8gdGhlIG1lcmdlLgoKRGF2ZS4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
