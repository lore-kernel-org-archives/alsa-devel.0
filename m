From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 02/11] drm/edid: Add API to get speaker allocation
Date: Tue, 12 Apr 2016 10:31:24 +0530
Message-ID: <1460437293-8509-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1460437293-8509-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1460437293-8509-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: alsa-devel@alsa-project.org
Cc: Jani Nikula <jani.nikula@intel.com>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, patches.audio@intel.com, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogU3ViaHJhbnN1IFMuIFBydXN0eSA8c3ViaHJhbnN1LnMucHJ1c3R5QGlu
dGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogVmlub2QgS291bCA8dmlub2Qua291bEBpbnRlbC5jb20+
CkNjOiBKYW5pIE5pa3VsYSA8amFuaS5uaWt1bGFAaW50ZWwuY29tPgpDYzogRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPgpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpD
YzogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBpbnRlbC5jb20+Ci0tLQogaW5jbHVkZS9k
cm0vZHJtX2VkaWQuaCB8IDkgKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJtX2VkaWQuaCBiL2luY2x1ZGUvZHJtL2Ry
bV9lZGlkLmgKaW5kZXggZGVjNjIyMS4uOTkxNDJkMSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9kcm0v
ZHJtX2VkaWQuaAorKysgYi9pbmNsdWRlL2RybS9kcm1fZWRpZC5oCkBAIC00MTUsNiArNDE1LDE1
IEBAIHN0YXRpYyBpbmxpbmUgdTggZHJtX2VsZF9nZXRfY29ubl90eXBlKGNvbnN0IHVpbnQ4X3Qg
KmVsZCkKIAlyZXR1cm4gZWxkW0RSTV9FTERfU0FEX0NPVU5UX0NPTk5fVFlQRV0gJiBEUk1fRUxE
X0NPTk5fVFlQRV9NQVNLOwogfQogCisvKioKKyAqIGRybV9lbGRfZ2V0X3Nwa19hbGxvYyAtIEdl
dCBFTEQgc3BlYWtlciBhbGxvY2F0aW9uCisgKiBAZWxkOiBwb2ludGVyIHRvIGFuIGVsZCBtZW1v
cnkgc3RydWN0dXJlCisgKi8KK3N0YXRpYyBpbmxpbmUgY29uc3QgdTggZHJtX2VsZF9nZXRfc3Br
X2FsbG9jKGNvbnN0IHVpbnQ4X3QgKmVsZCkKK3sKKwlyZXR1cm4gZWxkW0RSTV9FTERfU1BFQUtF
Ul07Cit9CisKIHN0cnVjdCBlZGlkICpkcm1fZG9fZ2V0X2VkaWQoc3RydWN0IGRybV9jb25uZWN0
b3IgKmNvbm5lY3RvciwKIAlpbnQgKCpnZXRfZWRpZF9ibG9jaykodm9pZCAqZGF0YSwgdTggKmJ1
ZiwgdW5zaWduZWQgaW50IGJsb2NrLAogCQkJICAgICAgc2l6ZV90IGxlbiksCi0tIAoxLjkuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
