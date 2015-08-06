From: libin.yang@intel.com
Subject: [PATCH 1/4] drm/i915: Add audio set_ncts callback
Date: Thu,  6 Aug 2015 14:52:54 +0800
Message-ID: <1438843977-4269-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de, intel-gfx@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

RnJvbTogTGliaW4gWWFuZyA8bGliaW4ueWFuZ0BpbnRlbC5jb20+CgpBZGQgdGhlIHNldF9uY3Rz
IGNhbGxiYWNrLgoKV2l0aCB0aGUgY2FsbGJhY2ssIGF1ZGlvIGRyaXZlciBjYW4gdHJpZ2dlcgpp
OTE1IGRyaXZlciB0byBzZXQgdGhlIHByb3BlciBOL0NUUwpiYXNlZCBvbiBkaWZmZXJlbnQgc2Ft
cGxlIHJhdGVzLgoKU2lnbmVkLW9mZi1ieTogTGliaW4gWWFuZyA8bGliaW4ueWFuZ0BpbnRlbC5j
b20+Ci0tLQogaW5jbHVkZS9kcm0vaTkxNV9jb21wb25lbnQuaCB8IDIgKysKIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9pOTE1X2NvbXBv
bmVudC5oIGIvaW5jbHVkZS9kcm0vaTkxNV9jb21wb25lbnQuaAppbmRleCBjOWE4YjY0Li43MzA1
ODgxIDEwMDY0NAotLS0gYS9pbmNsdWRlL2RybS9pOTE1X2NvbXBvbmVudC5oCisrKyBiL2luY2x1
ZGUvZHJtL2k5MTVfY29tcG9uZW50LmgKQEAgLTMzLDYgKzMzLDggQEAgc3RydWN0IGk5MTVfYXVk
aW9fY29tcG9uZW50IHsKIAkJdm9pZCAoKnB1dF9wb3dlcikoc3RydWN0IGRldmljZSAqKTsKIAkJ
dm9pZCAoKmNvZGVjX3dha2Vfb3ZlcnJpZGUpKHN0cnVjdCBkZXZpY2UgKiwgYm9vbCBlbmFibGUp
OwogCQlpbnQgKCpnZXRfY2RjbGtfZnJlcSkoc3RydWN0IGRldmljZSAqKTsKKwkJaW50ICgqc2V0
X25jdHMpKHN0cnVjdCBkZXZpY2UgKiwgaW50IHBvcnQsIGludCBkZXZfZW50cnksCisJCQkJCWlu
dCByYXRlKTsKIAl9ICpvcHM7CiB9OwogCi0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9pbnRlbC1nZngK
