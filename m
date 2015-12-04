From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 1/9] drm/i915: Remove superfluous NULL
 check
Date: Fri, 4 Dec 2015 11:21:24 +0100
Message-ID: <20151204102124.GN10243@phenom.ffwll.local>
References: <1448986198-3488-1-git-send-email-tiwai@suse.de>
 <1448986198-3488-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1448986198-3488-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBEZWMgMDEsIDIwMTUgYXQgMDU6MDk6NTBQTSArMDEwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IHRvX2ludGVsX2NydGMoKSBhbHdheXMgcmV0dXJucyBhIG5vbi1OVUxMIHBvaW50ZXIu
Cj4gCj4gU2lnbmVkLW9mZi1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgoKUXVldWVk
IGZvciAtbmV4dCwgdGhhbmtzIGZvciB0aGUgcGF0Y2guCi1EYW5pZWwKCj4gLS0tCj4gIGRyaXZl
cnMvZ3B1L2RybS9pOTE1L2ludGVsX2F1ZGlvLmMgfCA0IC0tLS0KPiAgMSBmaWxlIGNoYW5nZWQs
IDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2lu
dGVsX2F1ZGlvLmMgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9hdWRpby5jCj4gaW5kZXgg
NGRjY2Q5YjAwM2ExLi4wYzM4Y2M2YzgyYWUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2k5MTUvaW50ZWxfYXVkaW8uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2F1
ZGlvLmMKPiBAQCAtNjU2LDEwICs2NTYsNiBAQCBzdGF0aWMgaW50IGk5MTVfYXVkaW9fY29tcG9u
ZW50X3N5bmNfYXVkaW9fcmF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gIAkJaW50ZWxfZGlnX3Bv
cnQgPSBlbmNfdG9fZGlnX3BvcnQoJmludGVsX2VuY29kZXItPmJhc2UpOwo+ICAJCWlmIChwb3J0
ID09IGludGVsX2RpZ19wb3J0LT5wb3J0KSB7Cj4gIAkJCWNydGMgPSB0b19pbnRlbF9jcnRjKGlu
dGVsX2VuY29kZXItPmJhc2UuY3J0Yyk7Cj4gLQkJCWlmICghY3J0Yykgewo+IC0JCQkJRFJNX0RF
QlVHX0tNUygiJXM6IGNydGMgaXMgTlVMTFxuIiwgX19mdW5jX18pOwo+IC0JCQkJY29udGludWU7
Cj4gLQkJCX0KPiAgCQkJcGlwZSA9IGNydGMtPnBpcGU7Cj4gIAkJCWJyZWFrOwo+ICAJCX0KPiAt
LSAKPiAyLjYuMwo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdAo+IEludGVsLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
aW50ZWwtZ2Z4CgotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29y
cG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pbnRlbC1nZngK
