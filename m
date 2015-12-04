From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v2 11/14] drm/edid: Add API to help find connection type
Date: Fri, 4 Dec 2015 16:00:24 +0530
Message-ID: <20151204103024.GC6256@subhransu-desktop>
References: <1449176538-3250-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449176942-3441-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449176942-3441-11-git-send-email-subhransu.s.prusty@intel.com>
 <s5hegf3se1p.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <s5hegf3se1p.wl-tiwai@suse.de>
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

T24gVGh1LCBEZWMgMDMsIDIwMTUgYXQgMDU6MTY6MzRQTSArMDEwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IE9uIFRodSwgMDMgRGVjIDIwMTUgMjI6MDg6NTkgKzAxMDAsCj4gU3ViaHJhbnN1IFMu
IFBydXN0eSB3cm90ZToKPiA+IAo+ID4gVG8gZmlsbCB0aGUgYXVkaW8gaW5mb2ZyYW1lIGl0IGlz
IHJlcXVpcmVkIHRvIGlkZW50aWZ5IHRoZQo+ID4gY29ubmVjdGlvbiB0eXBlIGFzIERQIG9yIEhE
TUkuIFRoaXMgcGF0Y2ggYWRkcyBhbiBBUEkgd2hpY2gKPiA+IHBhcnNlcyBFTEQgYW5kIHJldHVy
bnMgdGhlIGRpc3BsYXkgdHlwZSBvZiBjb25uZWN0ZWQuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6
IFN1YmhyYW5zdSBTLiBQcnVzdHkgPHN1YmhyYW5zdS5zLnBydXN0eUBpbnRlbC5jb20+Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBWaW5vZCBLb3VsIDx2aW5vZC5rb3VsQGludGVsLmNvbT4KPiA+IENjOiBE
YXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gPiBDYzogZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+ID4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAaW50ZWwu
Y29tPgo+ID4gLS0tCj4gPiAgaW5jbHVkZS9kcm0vZHJtX2VkaWQuaCB8IDEyICsrKysrKysrKysr
Kwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2RybS9kcm1fZWRpZC5oIGIvaW5jbHVkZS9kcm0vZHJtX2VkaWQuaAo+ID4g
aW5kZXggMmFmOTc2OS4uMDcyZGU5MCAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvZHJtL2RybV9l
ZGlkLmgKPiA+ICsrKyBiL2luY2x1ZGUvZHJtL2RybV9lZGlkLmgKPiA+IEBAIC00MDMsNiArNDAz
LDE4IEBAIHN0YXRpYyBpbmxpbmUgaW50IGRybV9lbGRfc2l6ZShjb25zdCB1aW50OF90ICplbGQp
Cj4gPiAgCXJldHVybiBEUk1fRUxEX0hFQURFUl9CTE9DS19TSVpFICsgZWxkW0RSTV9FTERfQkFT
RUxJTkVfRUxEX0xFTl0gKiA0Owo+ID4gIH0KPiA+ICAKPiA+ICsvKioKPiA+ICsgKiBkcm1fZWxk
X2dldF9jb25uX3R5cGUgLSBHZXQgZGV2aWNlIHR5cGUgaGRtaS9kcCBjb25uZWN0ZWQKPiA+ICsg
KiBAZWxkOiBwb2ludGVyIHRvIGFuIGVsZCBtZW1vcnkgc3RydWN0dXJlCj4gPiArICoKPiA+ICsg
KiBUaGUgY2FsbGVyIG5lZWQgdG8gdXNlIERSTV9FTERfQ09OTl9UWVBFX0hETUkgb3IgRFJNX0VM
RF9DT05OX1RZUEVfRFAgdG8KPiA+ICsgKiBpZGVudGlmeSB0aGUgZGlzcGxheSB0eXBlIGNvbm5l
Y3RlZC4KPiAKPiBDb25zdGFudHMgc2hvdWxkIGJlIG1hcmtlZCB3aXRoICclJy4KClN1cmUgd2ls
bCBhZGQgaXQuIAoKUmVnYXJkcywKU3ViaHJhbnN1Cj4gCj4gCj4gVGFrYXNoaQoKLS0gCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
