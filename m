From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 02/14] ASoC: hdac_hdmi: Fix to warn instead of err for no
 connected nids
Date: Fri,  4 Dec 2015 02:38:50 +0530
Message-ID: <1449176942-3441-2-git-send-email-subhransu.s.prusty@intel.com>
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

SXQgaXMgcG9zc2libGUgdGhhdCBzb21lIHBpbiB3aWRnZXQgbWF5IHJldHVybiB3aXRoIG5vIGNv
bnZlcnRlcgpjb25uZWN0ZWQuIFNvIGRvbid0IHRocm93IGVycm9yIGlmIG5vbmUgYXJlIGZvdW5k
IHRvIGJlIGNvbm5lY3RlZC4KSW5zdGVhZCBwcmludCBhIHdhcm5pbmcgYW5kIGNvbnRpbnVlLgoK
U2lnbmVkLW9mZi1ieTogU3ViaHJhbnN1IFMuIFBydXN0eSA8c3ViaHJhbnN1LnMucHJ1c3R5QGlu
dGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogVmlub2QgS291bCA8dmlub2Qua291bEBpbnRlbC5jb20+
Ci0tLQogc291bmQvc29jL2NvZGVjcy9oZGFjX2hkbWkuYyB8IDEwICsrKysrKy0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2NvZGVjcy9oZGFjX2hkbWkuYyBiL3NvdW5kL3NvYy9jb2RlY3MvaGRhY19oZG1p
LmMKaW5kZXggOTI5ZjI3Yi4uNDI5ZmExNCAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy9o
ZGFjX2hkbWkuYworKysgYi9zb3VuZC9zb2MvY29kZWNzL2hkYWNfaGRtaS5jCkBAIC0zMTYsMTAg
KzMxNiwxMiBAQCBzdGF0aWMgaW50IGhkYWNfaGRtaV9xdWVyeV9waW5fY29ubmxpc3Qoc3RydWN0
IGhkYWNfZXh0X2RldmljZSAqaGRhYywKIAogCXBpbi0+bnVtX211eF9uaWRzID0gc25kX2hkYWNf
Z2V0X2Nvbm5lY3Rpb25zKCZoZGFjLT5oZGFjLCBwaW4tPm5pZCwKIAkJCXBpbi0+bXV4X25pZHMs
IEhEQV9NQVhfQ09OTkVDVElPTlMpOwotCWlmIChwaW4tPm51bV9tdXhfbmlkcyA9PSAwKSB7Ci0J
CWRldl9lcnIoJmhkYWMtPmhkYWMuZGV2LCAiTm8gY29ubmVjdGlvbnMgZm91bmRcbiIpOwotCQly
ZXR1cm4gLUVOT0RFVjsKLQl9CisJaWYgKHBpbi0+bnVtX211eF9uaWRzID09IDApCisJCWRldl93
YXJuKCZoZGFjLT5oZGFjLmRldiwgIk5vIGNvbm5lY3Rpb25zIGZvdW5kIGZvciBwaW46ICVkXG4i
LAorCQkJCQkJCQlwaW4tPm5pZCk7CisKKwlkZXZfZGJnKCZoZGFjLT5oZGFjLmRldiwgIm51bV9t
dXhfbmlkcyAlZCBmb3IgcGluOiAlZFxuIiwKKwkJCXBpbi0+bnVtX211eF9uaWRzLCBwaW4tPm5p
ZCk7CiAKIAlyZXR1cm4gcGluLT5udW1fbXV4X25pZHM7CiB9Ci0tIAoxLjkuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
