From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/4] drm/i915: Add audio hotplug info callback
Date: Thu, 23 Jul 2015 17:26:16 +0200
Message-ID: <1437665179-9786-2-git-send-email-david.henningsson@canonical.com>
References: <1437665179-9786-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1437665179-9786-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: vinod.koul@intel.com, jani.nikula@linux.intel.com, daniel.vetter@intel.com, tiwai@suse.de, intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

VGhpcyBjYWxsYmFjayB3aWxsIGJlIGNhbGxlZCBieSB0aGUgaTkxNSBkcml2ZXIgdG8gbm90aWZ5
IHRoZSBoZGEKZHJpdmVyIHRoYXQgSERNSSBoYXMgYmVlbiBob3RwbHVnZ2VkLgoKU2lnbmVkLW9m
Zi1ieTogRGF2aWQgSGVubmluZ3Nzb24gPGRhdmlkLmhlbm5pbmdzc29uQGNhbm9uaWNhbC5jb20+
Ci0tLQogaW5jbHVkZS9kcm0vaTkxNV9jb21wb25lbnQuaCB8ICAgIDUgKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9pOTE1X2Nv
bXBvbmVudC5oIGIvaW5jbHVkZS9kcm0vaTkxNV9jb21wb25lbnQuaAppbmRleCBjOWE4YjY0Li5k
MDUzMDA4IDEwMDY0NAotLS0gYS9pbmNsdWRlL2RybS9pOTE1X2NvbXBvbmVudC5oCisrKyBiL2lu
Y2x1ZGUvZHJtL2k5MTVfY29tcG9uZW50LmgKQEAgLTI2LDYgKzI2LDcgQEAKIAogc3RydWN0IGk5
MTVfYXVkaW9fY29tcG9uZW50IHsKIAlzdHJ1Y3QgZGV2aWNlICpkZXY7CisJdm9pZCAqYXVkaW9f
cHRyOwogCiAJY29uc3Qgc3RydWN0IGk5MTVfYXVkaW9fY29tcG9uZW50X29wcyB7CiAJCXN0cnVj
dCBtb2R1bGUgKm93bmVyOwpAQCAtMzQsNiArMzUsMTAgQEAgc3RydWN0IGk5MTVfYXVkaW9fY29t
cG9uZW50IHsKIAkJdm9pZCAoKmNvZGVjX3dha2Vfb3ZlcnJpZGUpKHN0cnVjdCBkZXZpY2UgKiwg
Ym9vbCBlbmFibGUpOwogCQlpbnQgKCpnZXRfY2RjbGtfZnJlcSkoc3RydWN0IGRldmljZSAqKTsK
IAl9ICpvcHM7CisKKwljb25zdCBzdHJ1Y3QgaTkxNV9hdWRpb19jb21wb25lbnRfYXVkaW9fb3Bz
IHsKKwkJdm9pZCAoKmhvdHBsdWdfbm90aWZ5KSh2b2lkICphdWRpb19wdHIsIGludCBwb3J0LCBp
bnQgcG9ydF9tc3RfaW5kZXgpOworCX0gKmF1ZGlvX29wczsKIH07CiAKICNlbmRpZiAvKiBfSTkx
NV9DT01QT05FTlRfSF8gKi8KLS0gCjEuNy45LjUKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vaW50ZWwtZ2Z4Cg==
