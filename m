From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 11/14] drm/edid: Add API to help find connection type
Date: Fri,  4 Dec 2015 02:38:59 +0530
Message-ID: <1449176942-3441-11-git-send-email-subhransu.s.prusty@intel.com>
References: <1449176538-3250-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449176942-3441-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1449176942-3441-1-git-send-email-subhransu.s.prusty@intel.com>
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
bV9lZGlkLmggYi9pbmNsdWRlL2RybS9kcm1fZWRpZC5oCmluZGV4IDJhZjk3NjkuLjA3MmRlOTAg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZHJtL2RybV9lZGlkLmgKKysrIGIvaW5jbHVkZS9kcm0vZHJt
X2VkaWQuaApAQCAtNDAzLDYgKzQwMywxOCBAQCBzdGF0aWMgaW5saW5lIGludCBkcm1fZWxkX3Np
emUoY29uc3QgdWludDhfdCAqZWxkKQogCXJldHVybiBEUk1fRUxEX0hFQURFUl9CTE9DS19TSVpF
ICsgZWxkW0RSTV9FTERfQkFTRUxJTkVfRUxEX0xFTl0gKiA0OwogfQogCisvKioKKyAqIGRybV9l
bGRfZ2V0X2Nvbm5fdHlwZSAtIEdldCBkZXZpY2UgdHlwZSBoZG1pL2RwIGNvbm5lY3RlZAorICog
QGVsZDogcG9pbnRlciB0byBhbiBlbGQgbWVtb3J5IHN0cnVjdHVyZQorICoKKyAqIFRoZSBjYWxs
ZXIgbmVlZCB0byB1c2UgRFJNX0VMRF9DT05OX1RZUEVfSERNSSBvciBEUk1fRUxEX0NPTk5fVFlQ
RV9EUCB0bworICogaWRlbnRpZnkgdGhlIGRpc3BsYXkgdHlwZSBjb25uZWN0ZWQuCisgKi8KK3N0
YXRpYyBpbmxpbmUgdTggZHJtX2VsZF9nZXRfY29ubl90eXBlKGNvbnN0IHVpbnQ4X3QgKmVsZCkK
K3sKKwlyZXR1cm4gZWxkW0RSTV9FTERfU0FEX0NPVU5UX0NPTk5fVFlQRV0gJiBEUk1fRUxEX0NP
Tk5fVFlQRV9NQVNLOworfQorCiBzdHJ1Y3QgZWRpZCAqZHJtX2RvX2dldF9lZGlkKHN0cnVjdCBk
cm1fY29ubmVjdG9yICpjb25uZWN0b3IsCiAJaW50ICgqZ2V0X2VkaWRfYmxvY2spKHZvaWQgKmRh
dGEsIHU4ICpidWYsIHVuc2lnbmVkIGludCBibG9jaywKIAkJCSAgICAgIHNpemVfdCBsZW4pLAot
LSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
