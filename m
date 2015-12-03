From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 01/14] ASoC: hdac_hdmi: Fix to check num nodes correctly
Date: Fri,  4 Dec 2015 02:38:49 +0530
Message-ID: <1449176942-3441-1-git-send-email-subhransu.s.prusty@intel.com>
References: <1449176538-3250-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1449176538-3250-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, patches.audio@intel.com, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

Y29tbWl0IDNjODNhYzIzMjUzYyAoIkFTb0M6IGhkYWNfaGRtaTogY2hlY2sgZXJyb3IgcmV0dXJu
IikgZml4ZXMKdGhlIHN0YXRpYyBjaGVja2VyIHdhcm5pbmcgcmVwb3J0ZWQgYnkgRGFuIENhcnBl
bnRlcjoKCglzb3VuZC9zb2MvY29kZWNzL2hkYWNfaGRtaS5jOjQxNiBoZGFjX2hkbWlfcGFyc2Vf
YW5kX21hcF9uaWQoKQoJd2FybjogdW5zaWduZWQgJ2hkYWMtPm51bV9ub2RlcycgaXMgbmV2ZXIg
bGVzcyB0aGFuIHplcm8uCgpCdXQgaXQgZG9lc24ndCBmaXggdGhlIGlzc3VlIGNvbXBsZXRlbHku
CgpJdCdzIGFsc28gYSBmYWlsdXJlIGlmIG5vIHN1YiBub2RlcyBmb3VuZCBmb3IgYW4gYWZnIG5v
ZGUuIFNvIG1vZGlmeQp0aGUgcmV0dXJuIGNvbmRpdGlvbiBhcHByb3ByaWF0ZWx5LgoKQ2M6IERh
biBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4KU2lnbmVkLW9mZi1ieTogU3Vi
aHJhbnN1IFMuIFBydXN0eSA8c3ViaHJhbnN1LnMucHJ1c3R5QGludGVsLmNvbT4KU2lnbmVkLW9m
Zi1ieTogVmlub2QgS291bCA8dmlub2Qua291bEBpbnRlbC5jb20+Ci0tLQogc291bmQvc29jL2Nv
ZGVjcy9oZGFjX2hkbWkuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvaGRhY19oZG1pLmMg
Yi9zb3VuZC9zb2MvY29kZWNzL2hkYWNfaGRtaS5jCmluZGV4IDFhMmYzM2IuLjkyOWYyN2IgMTAw
NjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvaGRhY19oZG1pLmMKKysrIGIvc291bmQvc29jL2Nv
ZGVjcy9oZGFjX2hkbWkuYwpAQCAtNDE1LDcgKzQxNSw3IEBAIHN0YXRpYyBpbnQgaGRhY19oZG1p
X3BhcnNlX2FuZF9tYXBfbmlkKHN0cnVjdCBoZGFjX2V4dF9kZXZpY2UgKmVkZXYpCiAJaW50IGN2
dF9uaWQgPSAwLCBwaW5fbmlkID0gMDsKIAogCW51bV9ub2RlcyA9IHNuZF9oZGFjX2dldF9zdWJf
bm9kZXMoaGRhYywgaGRhYy0+YWZnLCAmbmlkKTsKLQlpZiAoIW5pZCB8fCBudW1fbm9kZXMgPCAw
KSB7CisJaWYgKCFuaWQgfHwgbnVtX25vZGVzIDw9IDApIHsKIAkJZGV2X3dhcm4oJmhkYWMtPmRl
diwgIkhETUk6IGZhaWxlZCB0byBnZXQgYWZnIHN1YiBub2Rlc1xuIik7CiAJCXJldHVybiAtRUlO
VkFMOwogCX0KLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ry
aS1kZXZlbAo=
