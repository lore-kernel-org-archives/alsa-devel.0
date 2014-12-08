From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/5] drm/i915: add dev_to_i915_priv helper
Date: Mon, 8 Dec 2014 21:27:56 +0100
Message-ID: <20141208202756.GK27182@phenom.ffwll.local>
References: <1418056929-7977-1-git-send-email-imre.deak@intel.com>
 <1418056929-7977-2-git-send-email-imre.deak@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1418056929-7977-2-git-send-email-imre.deak@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Imre Deak <imre.deak@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBEZWMgMDgsIDIwMTQgYXQgMDY6NDI6MDVQTSArMDIwMCwgSW1yZSBEZWFrIHdyb3Rl
Ogo+IFRoaXMgd2lsbCBiZSBuZWVkZWQgYnkgbGF0ZXIgcGF0Y2hlcywgc28gZmFjdG9yIGl0IG91
dC4KPiAKPiBObyBmdW5jdGlvbmFsIGNoYW5nZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBJbXJlIERl
YWsgPGltcmUuZGVha0BpbnRlbC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2k5
MTVfZHJ2LmMgIHwgMTUgKysrKysrLS0tLS0tLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2lu
dGVsX2Rydi5oIHwgIDggKysrKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspLCA5IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkx
NS9pOTE1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9kcnYuYwo+IGluZGV4IDcx
YmUzYzkuLjMyYzJlMzMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9k
cnYuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfZHJ2LmMKPiBAQCAtOTIzLDEw
ICs5MjMsMTAgQEAgaTkxNV9wY2lfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+ICAKPiAg
c3RhdGljIGludCBpOTE1X3BtX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQo+ICB7Cj4gLQlz
dHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsKPiAtCXN0cnVjdCBkcm1fZGV2
aWNlICpkcm1fZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOwo+ICsJc3RydWN0IGRybV9pOTE1
X3ByaXZhdGUgKmRldl9wcml2ID0gZGV2X3RvX2k5MTVfcHJpdihkZXYpOwo+ICsJc3RydWN0IGRy
bV9kZXZpY2UgKmRybV9kZXYgPSBkZXZfcHJpdi0+ZGV2Owo+ICAKPiAtCWlmICghZHJtX2RldiB8
fCAhZHJtX2Rldi0+ZGV2X3ByaXZhdGUpIHsKPiArCWlmICghZHJtX2RldiB8fCAhZGV2X3ByaXYp
IHsKCmJ0dyBhbGwgY2hlY2tzIGZvciBkcm1fZGV2IGFuZCBkZXZfcHJpdmF0ZSBhcmUgcmVtbmFu
dHMgZnJvbSB0aGUgb2xkIHVtcwpkYXlzIGFuZCBjYW4gYWxsIGJlIGtpbGxlZC4gV2l0aCBmaXJl
LCBwbGVhc2UuCi1EYW5pZWwKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdhcmUgRW5naW5lZXIsIElu
dGVsIENvcnBvcmF0aW9uCis0MSAoMCkgNzkgMzY1IDU3IDQ4IC0gaHR0cDovL2Jsb2cuZmZ3bGwu
Y2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwt
Z2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK
