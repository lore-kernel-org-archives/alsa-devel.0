From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v2 05/14] ALSA: pcm: Add DRM helper to set constraint for
 format
Date: Fri, 4 Dec 2015 16:38:26 +0530
Message-ID: <20151204110818.GA7669@subhransu-desktop>
References: <1449176538-3250-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449176942-3441-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449176942-3441-5-git-send-email-subhransu.s.prusty@intel.com>
 <s5hio4fsexx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <s5hio4fsexx.wl-tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBEZWMgMDMsIDIwMTUgYXQgMDQ6NTc6MTRQTSArMDEwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IE9uIFRodSwgMDMgRGVjIDIwMTUgMjI6MDg6NTMgKzAxMDAsCj4gU3ViaHJhbnN1IFMu
IFBydXN0eSB3cm90ZToKPiA+IAo+ID4gU2V0dGluZyB0aGUgY29uc3RyYWludCBmb3JtYXQgYmFz
ZWQgb24gRUxEIHdhcyBtaXNzaW5nIGJpdCBpbgo+ID4gdGhlIHNvdW5kL2NvcmUgcGNtIGRybS4g
QWRkZWQgd2l0aCB0aGlzIHBhdGNoLgo+IAo+IE5vLCB5b3UgY2FuJ3QgZGVmaW5lIHRoZXNlIGhl
cmUuICBUaGUgZm9ybWF0IHJlYWxseSBkZXBlbmRzIG9uIHRoZQo+IGhhcmR3YXJlLCB3aGlsZSB0
aGUgcmF0ZSBhbmQgdGhlIGNoYW5uZWxzIGFyZSBpbmRlcGVuZGVudC4KClByb2JhYmx5IHRoZW4g
SSB3aWxsIG1vdmUgdGhpcyBkZWZpbml0aW9uIHRvIGRyaXZlci4KCj4gSG93IGRvIHlvdSBrbm93
IGl0J3MgbGl0dGxlLWVuZGlhbj8gIEFuZCB3aHkgaXQgbXVzdCBiZSBTMjRfTEUgZm9yCj4gMjRi
aXQsIG5vdCBTMzJfTEU/CgpSZWdhcmRpbmcgdGhlIGxpdHRsZS1lbmRpYW4sIEluIHRoZSBkcml2
ZXIgSSB0aGluayBJIHNob3VsZCBzZXQgdGhlCmNvbnN0cmFpbnQgZm9yIGJvdGggTEUgYW5kIEJF
LiBBbmQgdGhlIHBsYXRmb3JtIGFzIGl0IG9ubHkgc3VwcG9ydHMgTEUgYWxvbmUKaXQgd2lsbCBz
ZXQgdGhlIGNvbnN0cmFpbnQgYWNjb3JkaW5nbHkgYW5kIGVkaWFubmVzcyB3aWxsIGJlIHRha2Vu
IGNhcmUgb2YuCgpSZWdhcmRpbmcgdGhlIHNhbXBsZSBzaXplLCBmcm9tIHNob3J0IGF1ZGlvIGRl
c2NyaXB0b3IsIHRoZSBzYW1wbGVzIGNhbiBiZQpvbmUgb2YgMTYvMjAvMjQgYml0LiBJIGNvdWxk
IHVzZSB0aGUgZm9ybWF0IGJpdHMgZm9yIDE2IGFuZCAyNCBiaXRzIGJ1dApkb24ndCBrbm93IHdo
aWNoIGZvcm1hdCBiaXRzIG1hY3JvIGlzIHN1aXRhYmxlIGZvciAyMGJpdHMuIFNvIGtlcHQgaXQg
YXMKUzMyX0xFIGZvciAyMGJpdHMuIFNob3VsZCBJIGZpeCB0aGUgZm9ybWF0IGJpdHMgZm9yIDIw
Yml0cyB0byB1c2UgUzI0PwoKUmVnYXJkcywKU3ViaHJhbnN1Cgo+IAo+IAo+IFRha2FzaGkKCi0t
IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
