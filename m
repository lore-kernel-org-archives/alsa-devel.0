From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 1/9] drm/i915: Remove superfluous NULL check
Date: Tue,  1 Dec 2015 17:09:50 +0100
Message-ID: <1448986198-3488-2-git-send-email-tiwai@suse.de>
References: <1448986198-3488-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1448986198-3488-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, David Henningsson <david.henningsson@canonical.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

dG9faW50ZWxfY3J0YygpIGFsd2F5cyByZXR1cm5zIGEgbm9uLU5VTEwgcG9pbnRlci4KClNpZ25l
ZC1vZmYtYnk6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vaTkxNS9pbnRlbF9hdWRpby5jIHwgNCAtLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9hdWRpby5jIGIv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfYXVkaW8uYwppbmRleCA0ZGNjZDliMDAzYTEuLjBj
MzhjYzZjODJhZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfYXVkaW8u
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9hdWRpby5jCkBAIC02NTYsMTAgKzY1
Niw2IEBAIHN0YXRpYyBpbnQgaTkxNV9hdWRpb19jb21wb25lbnRfc3luY19hdWRpb19yYXRlKHN0
cnVjdCBkZXZpY2UgKmRldiwKIAkJaW50ZWxfZGlnX3BvcnQgPSBlbmNfdG9fZGlnX3BvcnQoJmlu
dGVsX2VuY29kZXItPmJhc2UpOwogCQlpZiAocG9ydCA9PSBpbnRlbF9kaWdfcG9ydC0+cG9ydCkg
ewogCQkJY3J0YyA9IHRvX2ludGVsX2NydGMoaW50ZWxfZW5jb2Rlci0+YmFzZS5jcnRjKTsKLQkJ
CWlmICghY3J0YykgewotCQkJCURSTV9ERUJVR19LTVMoIiVzOiBjcnRjIGlzIE5VTExcbiIsIF9f
ZnVuY19fKTsKLQkJCQljb250aW51ZTsKLQkJCX0KIAkJCXBpcGUgPSBjcnRjLT5waXBlOwogCQkJ
YnJlYWs7CiAJCX0KLS0gCjIuNi4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2ludGVsLWdmeAo=
