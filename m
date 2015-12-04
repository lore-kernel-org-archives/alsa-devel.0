From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 1/9] drm/i915: Remove superfluous NULL
	check
Date: Fri, 4 Dec 2015 14:16:46 +0200
Message-ID: <20151204121646.GU4437@intel.com>
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
CgpFaD8gdG9faW50ZWxfY3J0YyhOVUxMKSBzaG91bGQgcmV0dXJuIE5VTEwgb3Igd2UgbWlnaHQg
aGF2ZSB0b25zIG9mCmJyZWFrYWdlIG9uIG91ciBoYW5kcy4gT3IgbWF5YmUgdGhlIGF0b21pYyB3
b3JrIGhhcyBnb3R0ZW4gcmlkIG9mIHRoYXQKYXNzdW1wdGlvbiwgYnV0IGF0IGxlYXN0IHdlIHVz
ZWQgdG8gZGVwZW5kIG9uIHRoYXQgaGVhdmlseS4KCj4gCj4gU2lnbmVkLW9mZi1ieTogVGFrYXNo
aSBJd2FpIDx0aXdhaUBzdXNlLmRlPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRl
bF9hdWRpby5jIHwgNCAtLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQo+IAo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9hdWRpby5jIGIvZHJpdmVy
cy9ncHUvZHJtL2k5MTUvaW50ZWxfYXVkaW8uYwo+IGluZGV4IDRkY2NkOWIwMDNhMS4uMGMzOGNj
NmM4MmFlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2F1ZGlvLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9hdWRpby5jCj4gQEAgLTY1NiwxMCAr
NjU2LDYgQEAgc3RhdGljIGludCBpOTE1X2F1ZGlvX2NvbXBvbmVudF9zeW5jX2F1ZGlvX3JhdGUo
c3RydWN0IGRldmljZSAqZGV2LAo+ICAJCWludGVsX2RpZ19wb3J0ID0gZW5jX3RvX2RpZ19wb3J0
KCZpbnRlbF9lbmNvZGVyLT5iYXNlKTsKPiAgCQlpZiAocG9ydCA9PSBpbnRlbF9kaWdfcG9ydC0+
cG9ydCkgewo+ICAJCQljcnRjID0gdG9faW50ZWxfY3J0YyhpbnRlbF9lbmNvZGVyLT5iYXNlLmNy
dGMpOwo+IC0JCQlpZiAoIWNydGMpIHsKPiAtCQkJCURSTV9ERUJVR19LTVMoIiVzOiBjcnRjIGlz
IE5VTExcbiIsIF9fZnVuY19fKTsKPiAtCQkJCWNvbnRpbnVlOwo+IC0JCQl9Cj4gIAkJCXBpcGUg
PSBjcnRjLT5waXBlOwo+ICAJCQlicmVhazsKPiAgCQl9Cj4gLS0gCj4gMi42LjMKCi0tIApWaWxs
ZSBTeXJqw6Rsw6QKSW50ZWwgT1RDCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
aW50ZWwtZ2Z4Cg==
