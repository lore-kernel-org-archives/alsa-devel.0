From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 10/15] drm/edid: Add API to help find connection type
Date: Tue,  8 Dec 2015 02:54:24 +0530
Message-ID: <1449523469-4395-10-git-send-email-subhransu.s.prusty@intel.com>
References: <1449523078-4311-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, patches.audio@intel.com, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

VG8gZmlsbCB0aGUgYXVkaW8gaW5mb2ZyYW1lIGl0IGlzIHJlcXVpcmVkIHRvIGlkZW50aWZ5IHRo
ZQpjb25uZWN0aW9uIHR5cGUgYXMgRFAgb3IgSERNSS4gVGhpcyBwYXRjaCBhZGRzIGFuIEFQSSB3
aGljaApwYXJzZXMgRUxEIGFuZCByZXR1cm5zIHRoZSBkaXNwbGF5IHR5cGUgb2YgY29ubmVjdGVk
LgoKU2lnbmVkLW9mZi1ieTogU3ViaHJhbnN1IFMuIFBydXN0eSA8c3ViaHJhbnN1LnMucHJ1c3R5
QGludGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogVmlub2QgS291bCA8dmlub2Qua291bEBpbnRlbC5j
b20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGludGVs
LmNvbT4KLS0tCiBpbmNsdWRlL2RybS9kcm1fZWRpZC5oIHwgMTIgKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2Ry
bV9lZGlkLmggYi9pbmNsdWRlL2RybS9kcm1fZWRpZC5oCmluZGV4IDJhZjk3NjkuLjhjNTM3YTAg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZHJtL2RybV9lZGlkLmgKKysrIGIvaW5jbHVkZS9kcm0vZHJt
X2VkaWQuaApAQCAtNDAzLDYgKzQwMywxOCBAQCBzdGF0aWMgaW5saW5lIGludCBkcm1fZWxkX3Np
emUoY29uc3QgdWludDhfdCAqZWxkKQogCXJldHVybiBEUk1fRUxEX0hFQURFUl9CTE9DS19TSVpF
ICsgZWxkW0RSTV9FTERfQkFTRUxJTkVfRUxEX0xFTl0gKiA0OwogfQogCisvKioKKyAqIGRybV9l
bGRfZ2V0X2Nvbm5fdHlwZSAtIEdldCBkZXZpY2UgdHlwZSBoZG1pL2RwIGNvbm5lY3RlZAorICog
QGVsZDogcG9pbnRlciB0byBhbiBlbGQgbWVtb3J5IHN0cnVjdHVyZQorICoKKyAqIFRoZSBjYWxs
ZXIgbmVlZCB0byB1c2UgJURSTV9FTERfQ09OTl9UWVBFX0hETUkgb3IgJURSTV9FTERfQ09OTl9U
WVBFX0RQIHRvCisgKiBpZGVudGlmeSB0aGUgZGlzcGxheSB0eXBlIGNvbm5lY3RlZC4KKyAqLwor
c3RhdGljIGlubGluZSB1OCBkcm1fZWxkX2dldF9jb25uX3R5cGUoY29uc3QgdWludDhfdCAqZWxk
KQoreworCXJldHVybiBlbGRbRFJNX0VMRF9TQURfQ09VTlRfQ09OTl9UWVBFXSAmIERSTV9FTERf
Q09OTl9UWVBFX01BU0s7Cit9CisKIHN0cnVjdCBlZGlkICpkcm1fZG9fZ2V0X2VkaWQoc3RydWN0
IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvciwKIAlpbnQgKCpnZXRfZWRpZF9ibG9jaykodm9pZCAq
ZGF0YSwgdTggKmJ1ZiwgdW5zaWduZWQgaW50IGJsb2NrLAogCQkJICAgICAgc2l6ZV90IGxlbiks
Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
