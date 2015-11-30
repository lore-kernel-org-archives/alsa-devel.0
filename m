From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 2/7] drm/i915: Add get_eld audio component
Date: Mon, 30 Nov 2015 18:48:13 +0200
Message-ID: <20151130164813.GU4437@intel.com>
References: <1448890671-2983-1-git-send-email-tiwai@suse.de>
 <1448890671-2983-3-git-send-email-tiwai@suse.de>
 <20151130152441.GS4437@intel.com> <20151130160933.GT4437@intel.com>
 <20151130163445.GA17050@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20151130163445.GA17050@phenom.ffwll.local>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, intel-gfx@lists.freedesktop.org, Vinod Koul <vinod.koul@intel.com>, Daniel Vetter <daniel.vetter@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBOb3YgMzAsIDIwMTUgYXQgMDU6MzQ6NDVQTSArMDEwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBPbiBNb24sIE5vdiAzMCwgMjAxNSBhdCAwNjowOTozM1BNICswMjAwLCBWaWxsZSBT
eXJqw6Rsw6Qgd3JvdGU6Cj4gPiBPbiBNb24sIE5vdiAzMCwgMjAxNSBhdCAwNToyNDo0MVBNICsw
MjAwLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6Cj4gPiA+IE9uIE1vbiwgTm92IDMwLCAyMDE1IGF0
IDAyOjM3OjQ2UE0gKzAxMDAsIFRha2FzaGkgSXdhaSB3cm90ZToKPiA+ID4gPiBJbXBsZW1lbnQg
YSBuZXcgaTkxNV9hdWRpb19jb21wb25lbnRfb3BzLCBnZXRfZWxkKCkuICBJdCdzIGNhbGxlZCBi
eQo+ID4gPiA+IHRoZSBhdWRpbyBkcml2ZXIgdG8gZmV0Y2ggdGhlIGN1cnJlbnQgRUxEIG9mIHRo
ZSBnaXZlbiBIRE1JL0RQIHBvcnQuCj4gPiA+ID4gSXQgcmV0dXJucyB0aGUgc2l6ZSBvZiBFTEQg
Ynl0ZXMgaWYgaXQncyB2YWxpZCwgb3IgemVybyBpZiB0aGUgYXVkaW8KPiA+ID4gPiBpcyBkaXNh
YmxlZCBvciB1bnBsdWdnZWQsIG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZS4KPiA+ID4gCj4gPiA+
IFdoeSBkbyB3ZSBuZWVkIHRoaXM/IElzbid0IGl0IHNvbWV0aGluZyB0aGUgZWxkIG5vdGlmeSBo
b29rIHNob3VsZAo+ID4gPiBwYXNzIGZyb20gaTkxNSB0byB0aGUgYXVkaW8gZHJpdmVyPwo+ID4g
PiAKPiA+ID4gQXQgbGVhc3Qgd2l0aCB0aGUgbG9ja2luZyB5b3UgaGF2ZSBmb3IgdGhpcywgdGhl
IGF1ZGlvIGRyaXZlciBjYW4gbm90Cj4gPiA+IGNhbGwgdGhpcyBmcm9tIHRoZSBlbGQgbm90aWZ5
IGhvb2sgc2luY2UgaXQgd291bGQgZGVhZGxvY2suCj4gPiAKPiA+IEhtbS4gQWN0dWFsbHkgdGhl
IGxvY2tpbmcgaXNuJ3QgcGVyaGFwcyBxdWl0ZSBsaWtlIHRoYXQgYXRtLiBCdXQgSSBndWVzcwo+
ID4gdGhlIG1vZGVfY29uZmlnLm11dGV4IHdpbGwgbWFrZSBpdCBzby4KPiAKPiBJZiB3ZSBuZWVk
IHRoaXMgd2UgY291bGQgY3JlYXRlIGEgc3Vic3RydWN0IGluIGRldl9wcml2IHdpdGggY29waWVz
IG9mCj4gZXZlcnl0aGluZywgd2hpY2ggd291bGQgb25seSBiZSBwcm90ZWN0ZWQgYnkgYXZfbXV0
ZXguIFRoYXQncyB0aGUgdXN1YWwKPiBhcHByb2FjaCB3ZSB1c2Ugd2hlbiBmYWNlZCB3aXRoIHRo
aXMga2luZCBvZiBsb2NraW5nIGludmVyc2lvbjoKPiBDb3B5L3VwZGF0ZSByZWxldmFudCBkYXRh
IGluIHRoZSBtb2Rlc2V0IC0+ZW5hYmxlL2Rpc2FibGUgaG9va3MsIHRoZW4ganVzdAo+IHVzZSB0
aGVzZSBsb2NhbCBsb2NrcyB0byBhY2Nlc3MgdGhvc2UgY29waWVzLiBVc3VhbGx5IHRoYXQncyBl
bm91Z2ggdG8KPiB1bnRhbmdsZSB0aGluZ3MsIHdpdGggbm8gbmVlZCB0byByZXNvcnQgdG8gd29y
a2Vycy4KClllYWgsIElJUkMgSSBzdWdnZXN0ZWQganVzdCB0aGF0IG9yaWdpbmFsbHkuCgotLSAK
VmlsbGUgU3lyasOkbMOkCkludGVsIE9UQwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2ludGVsLWdmeAo=
