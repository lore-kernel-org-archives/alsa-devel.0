From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 00/11] ASoC: hdac_hdmi: Add multichannel support
Date: Tue, 12 Apr 2016 11:56:11 +0530
Message-ID: <20160412062605.GA8655@subhransu-desktop>
References: <1460437293-8509-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5hd1pvidpc.wl-tiwai@suse.de>
 <20160412055435.GX3351@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20160412055435.GX3351@sirena.org.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Jani Nikula <jani.nikula@intel.com>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, patches.audio@intel.com, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBBcHIgMTIsIDIwMTYgYXQgMDY6NTQ6MzVBTSArMDEwMCwgTWFyayBCcm93biB3cm90
ZToKPiBPbiBUdWUsIEFwciAxMiwgMjAxNiBhdCAwNzo0Mzo1OUFNICswMjAwLCBUYWthc2hpIEl3
YWkgd3JvdGU6Cj4gCj4gPiBCdXQgdGhlIHByb2JsZW0gaXMgbW9yZSBjb21wbGljYXRlZCBiZWNh
dXNlIHlvdSdyZSBjaGFuZ2luZyBkcm0gc3R1ZmYsCj4gPiB0b28uICBUaGlzIGlzIHVzdWFsbHkg
bWFuYWdlZCBpbiBkcm0gdHJlZS4gIFNvIHRoaXMgY3Jvc3Mgb3ZlciB0aHJlZQo+ID4gZGlmZmVy
ZW50IHRyZWVzLgo+IAo+IFRoZSBEUk0gZm9sa3MgdGVuZCB0byBsZWF2ZSB0aGlzIHVwIHRvIHVz
LCBvciBhdCBsZWFzdCByZXZpZXcgb24gYW55IG9mCj4gdGhlc2UgY3Jvc3NvdmVyIHBhdGNoZXMg
aGFzIGJlZW4gZXh0cmVtZWx5IGxpZ2h0Lgo+IAo+ID4gRG8gd2UgcmVhbGx5IG5lZWQgdGhpcz8g
IEV2ZW4gdGhlIGRpcmVjdCByZWZlcmVuY2UgaXMgcHJldHR5IG11Y2gKPiA+IG9idmlvdXMuICBl
LmcuIEkgc2VlIG5vIGJpZyBkaWZmZXJlbmNlIGJldHdlZW4gdHdvIGxpbmVzIGJlbG93Ogo+ID4g
CXNwa19hbGxvYyA9IGRybV9lbGRfZ2V0X3Nwa19hbGxvYyhzb21lX2VsZCk7Cj4gPiAJc3BrX2Fs
bG9jID0gc29tZV9lbGRbRFJNX0VMRF9TUEFFS0VSXTsKPiAKPiBUaGF0J2QgbWFrZSB0aGluZ3Mg
ZXZlbiBlYXNpZXIgb2YgY291cnNlLgoKVGFrYXNoaS9NYXJrLCBUaGFua3MgZm9yIHRoZSByZXZp
ZXcuIEFncmVlLCBhY2NvbW9kYXRpbmcgaW4gdGhlIGRyaXZlciBpcwplYXNpZXIgYW5kIHRoZSBp
bmxpbmUgZnVuY3Rpb24gZG9lc24ndCBtYWtlIG11Y2ggZGlmZmVyZW5jZS4gSSB3aWxsCmFjY29t
b2RhdGUgdGhlIGNoYW5nZSBpbiB0aGUgZHJpdmVyIGl0c2VsZi4KClNoYWxsIEkgcmVwb3N0IHRo
ZSBzZXJpZXMgd2l0aCB0aGVzZSBjaGFuZ2VzLCB3aGljaCBjYW4gYmUgcmV2aWV3ZWQgZnVydGhl
cgpvciB3YWl0IGZvciBtb3JlIHJldmlldyBjb21tZW50cyBiZWZvcmUgcmVwb3N0aW5nPwoKUmVn
YXJkcywKU3ViaHJhbnN1CgotLSAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
ZHJpLWRldmVsCg==
