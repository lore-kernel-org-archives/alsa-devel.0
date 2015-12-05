From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v2 05/14] ALSA: pcm: Add DRM helper to set constraint for
 format
Date: Sat, 5 Dec 2015 16:57:03 +0530
Message-ID: <20151205112655.GA2441@subhransu-desktop>
References: <1449176538-3250-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449176942-3441-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449176942-3441-5-git-send-email-subhransu.s.prusty@intel.com>
 <s5hio4fsexx.wl-tiwai@suse.de>
 <20151204110818.GA7669@subhransu-desktop>
 <s5hlh9a4uvc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <s5hlh9a4uvc.wl-tiwai@suse.de>
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

T24gRnJpLCBEZWMgMDQsIDIwMTUgYXQgMDY6NTk6MTlBTSArMDEwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IE9uIEZyaSwgMDQgRGVjIDIwMTUgMTI6MDg6MjYgKzAxMDAsCj4gU3ViaHJhbnN1IFMu
IFBydXN0eSB3cm90ZToKPiA+IAo+ID4gT24gVGh1LCBEZWMgMDMsIDIwMTUgYXQgMDQ6NTc6MTRQ
TSArMDEwMCwgVGFrYXNoaSBJd2FpIHdyb3RlOgo+ID4gPiBPbiBUaHUsIDAzIERlYyAyMDE1IDIy
OjA4OjUzICswMTAwLAo+ID4gPiBTdWJocmFuc3UgUy4gUHJ1c3R5IHdyb3RlOgo+ID4gPiA+IAo+
ID4gPiA+IFNldHRpbmcgdGhlIGNvbnN0cmFpbnQgZm9ybWF0IGJhc2VkIG9uIEVMRCB3YXMgbWlz
c2luZyBiaXQgaW4KPiA+ID4gPiB0aGUgc291bmQvY29yZSBwY20gZHJtLiBBZGRlZCB3aXRoIHRo
aXMgcGF0Y2guCj4gPiA+IAo+ID4gPiBObywgeW91IGNhbid0IGRlZmluZSB0aGVzZSBoZXJlLiAg
VGhlIGZvcm1hdCByZWFsbHkgZGVwZW5kcyBvbiB0aGUKPiA+ID4gaGFyZHdhcmUsIHdoaWxlIHRo
ZSByYXRlIGFuZCB0aGUgY2hhbm5lbHMgYXJlIGluZGVwZW5kZW50Lgo+ID4gCj4gPiBQcm9iYWJs
eSB0aGVuIEkgd2lsbCBtb3ZlIHRoaXMgZGVmaW5pdGlvbiB0byBkcml2ZXIuCj4gPiAKPiA+ID4g
SG93IGRvIHlvdSBrbm93IGl0J3MgbGl0dGxlLWVuZGlhbj8gIEFuZCB3aHkgaXQgbXVzdCBiZSBT
MjRfTEUgZm9yCj4gPiA+IDI0Yml0LCBub3QgUzMyX0xFPwo+ID4gCj4gPiBSZWdhcmRpbmcgdGhl
IGxpdHRsZS1lbmRpYW4sIEluIHRoZSBkcml2ZXIgSSB0aGluayBJIHNob3VsZCBzZXQgdGhlCj4g
PiBjb25zdHJhaW50IGZvciBib3RoIExFIGFuZCBCRS4gQW5kIHRoZSBwbGF0Zm9ybSBhcyBpdCBv
bmx5IHN1cHBvcnRzIExFIGFsb25lCj4gPiBpdCB3aWxsIHNldCB0aGUgY29uc3RyYWludCBhY2Nv
cmRpbmdseSBhbmQgZWRpYW5uZXNzIHdpbGwgYmUgdGFrZW4gY2FyZSBvZi4KPiA+IAo+ID4gUmVn
YXJkaW5nIHRoZSBzYW1wbGUgc2l6ZSwgZnJvbSBzaG9ydCBhdWRpbyBkZXNjcmlwdG9yLCB0aGUg
c2FtcGxlcyBjYW4gYmUKPiA+IG9uZSBvZiAxNi8yMC8yNCBiaXQuIEkgY291bGQgdXNlIHRoZSBm
b3JtYXQgYml0cyBmb3IgMTYgYW5kIDI0IGJpdHMgYnV0Cj4gPiBkb24ndCBrbm93IHdoaWNoIGZv
cm1hdCBiaXRzIG1hY3JvIGlzIHN1aXRhYmxlIGZvciAyMGJpdHMuIFNvIGtlcHQgaXQgYXMKPiA+
IFMzMl9MRSBmb3IgMjBiaXRzLiBTaG91bGQgSSBmaXggdGhlIGZvcm1hdCBiaXRzIGZvciAyMGJp
dHMgdG8gdXNlIFMyND8KPiAKPiBObyB5b3Ugc2VlbSBtaXN1bmRlcnN0YW5kaW5nIHRoZSBjb25j
ZXB0Li4uCgpTb3JyeSBhYm91dCB0aGF0LiAKCkkgcmUtcmVhZCB0aGUgc3BlYywgaXQgZG9lc24n
dCBtZW50aW9uIHRoZSBjb250YWluZXIgc2l6ZSBmb3IgdGhlIHNhbXBsZXMuCkFzc3VtaW5nIHRo
ZSBjb250YWluZXIgd2lsbCBiZSAzMiBiaXRzLCB0aGVuIEkgdGhpbmsgd2Ugc2hvdWxkIHVzZSBT
MjRfTEUKZm9yIGJvdGggMjAgYW5kIDI0IGJpdHMuCgpDYW4geW91IHBsZWFzZSBoZWxwIHRvIHVu
ZGVyc3RhbmQgd2hpY2ggY29uY2VwdCBJIGdvdCB3cm9uZyBoZXJlLgoKUmVnYXJkcywKU3ViaHJh
bnN1Cj4gCj4gCj4gVGFrYXNoaQoKLS0gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
