From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/7] drm/i915: Add get_eld audio component
Date: Mon, 30 Nov 2015 17:34:45 +0100
Message-ID: <20151130163445.GA17050@phenom.ffwll.local>
References: <1448890671-2983-1-git-send-email-tiwai@suse.de>
 <1448890671-2983-3-git-send-email-tiwai@suse.de>
 <20151130152441.GS4437@intel.com> <20151130160933.GT4437@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20151130160933.GT4437@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, intel-gfx@lists.freedesktop.org, Vinod Koul <vinod.koul@intel.com>, Daniel Vetter <daniel.vetter@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBOb3YgMzAsIDIwMTUgYXQgMDY6MDk6MzNQTSArMDIwMCwgVmlsbGUgU3lyasOkbMOk
IHdyb3RlOgo+IE9uIE1vbiwgTm92IDMwLCAyMDE1IGF0IDA1OjI0OjQxUE0gKzAyMDAsIFZpbGxl
IFN5cmrDpGzDpCB3cm90ZToKPiA+IE9uIE1vbiwgTm92IDMwLCAyMDE1IGF0IDAyOjM3OjQ2UE0g
KzAxMDAsIFRha2FzaGkgSXdhaSB3cm90ZToKPiA+ID4gSW1wbGVtZW50IGEgbmV3IGk5MTVfYXVk
aW9fY29tcG9uZW50X29wcywgZ2V0X2VsZCgpLiAgSXQncyBjYWxsZWQgYnkKPiA+ID4gdGhlIGF1
ZGlvIGRyaXZlciB0byBmZXRjaCB0aGUgY3VycmVudCBFTEQgb2YgdGhlIGdpdmVuIEhETUkvRFAg
cG9ydC4KPiA+ID4gSXQgcmV0dXJucyB0aGUgc2l6ZSBvZiBFTEQgYnl0ZXMgaWYgaXQncyB2YWxp
ZCwgb3IgemVybyBpZiB0aGUgYXVkaW8KPiA+ID4gaXMgZGlzYWJsZWQgb3IgdW5wbHVnZ2VkLCBv
ciBhIG5lZ2F0aXZlIGVycm9yIGNvZGUuCj4gPiAKPiA+IFdoeSBkbyB3ZSBuZWVkIHRoaXM/IElz
bid0IGl0IHNvbWV0aGluZyB0aGUgZWxkIG5vdGlmeSBob29rIHNob3VsZAo+ID4gcGFzcyBmcm9t
IGk5MTUgdG8gdGhlIGF1ZGlvIGRyaXZlcj8KPiA+IAo+ID4gQXQgbGVhc3Qgd2l0aCB0aGUgbG9j
a2luZyB5b3UgaGF2ZSBmb3IgdGhpcywgdGhlIGF1ZGlvIGRyaXZlciBjYW4gbm90Cj4gPiBjYWxs
IHRoaXMgZnJvbSB0aGUgZWxkIG5vdGlmeSBob29rIHNpbmNlIGl0IHdvdWxkIGRlYWRsb2NrLgo+
IAo+IEhtbS4gQWN0dWFsbHkgdGhlIGxvY2tpbmcgaXNuJ3QgcGVyaGFwcyBxdWl0ZSBsaWtlIHRo
YXQgYXRtLiBCdXQgSSBndWVzcwo+IHRoZSBtb2RlX2NvbmZpZy5tdXRleCB3aWxsIG1ha2UgaXQg
c28uCgpJZiB3ZSBuZWVkIHRoaXMgd2UgY291bGQgY3JlYXRlIGEgc3Vic3RydWN0IGluIGRldl9w
cml2IHdpdGggY29waWVzIG9mCmV2ZXJ5dGhpbmcsIHdoaWNoIHdvdWxkIG9ubHkgYmUgcHJvdGVj
dGVkIGJ5IGF2X211dGV4LiBUaGF0J3MgdGhlIHVzdWFsCmFwcHJvYWNoIHdlIHVzZSB3aGVuIGZh
Y2VkIHdpdGggdGhpcyBraW5kIG9mIGxvY2tpbmcgaW52ZXJzaW9uOgpDb3B5L3VwZGF0ZSByZWxl
dmFudCBkYXRhIGluIHRoZSBtb2Rlc2V0IC0+ZW5hYmxlL2Rpc2FibGUgaG9va3MsIHRoZW4ganVz
dAp1c2UgdGhlc2UgbG9jYWwgbG9ja3MgdG8gYWNjZXNzIHRob3NlIGNvcGllcy4gVXN1YWxseSB0
aGF0J3MgZW5vdWdoIHRvCnVudGFuZ2xlIHRoaW5ncywgd2l0aCBubyBuZWVkIHRvIHJlc29ydCB0
byB3b3JrZXJzLgotRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJ
bnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVs
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
