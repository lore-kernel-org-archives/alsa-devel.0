From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 06/13] PM / Domains: export symbols to add/remove devices from
 genpd
Date: Fri,  4 Dec 2015 18:40:34 -0500
Message-ID: <1449272440-8735-7-git-send-email-alexander.deucher@amd.com>
References: <1449272440-8735-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1449272440-8735-1-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: broonie@kernel.org, airlied@gmail.com, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, rajeevkumar.linux@gmail.com
Cc: Alex Deucher <alexander.deucher@amd.com>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, lgirdwood@gmail.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

RnJvbTogTWFydXRoaSBTcmluaXZhcyBCYXl5YXZhcmFwdSA8TWFydXRoaS5CYXl5YXZhcmFwdUBh
bWQuY29tPgoKRHJpdmVycyB3aGljaCBjYW4gYmUgYnVpbHQgYXMgbG9hZGFibGUgbW9kdWxlIG5l
ZWRzIHN5bWJvbHMKLSBwbV9nZW5wZF9hZGRfZGV2aWNlL3BtX2dlbnBkX3JlbW92ZV9kZXZpY2Ug
dG8gYWRkL3JlbW92ZSBkZXZpY2VzCnRvL2Zyb20gZ2VucGQuIFRob3NlIGRyaXZlcnMgY3JlYXRl
IHBsYXRmb3JtIGRldmljZXMsIHdoaWNoIGNvbWVzCnVuZGVyIGEgcG93ZXJkb21haW4uCgpTaWdu
ZWQtb2ZmLWJ5OiBNYXJ1dGhpIEJheXlhdmFyYXB1IDxtYXJ1dGhpLmJheXlhdmFyYXB1QGFtZC5j
b20+ClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvZG9tYWluLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL3Bvd2VyL2RvbWFpbi5j
IGIvZHJpdmVycy9iYXNlL3Bvd2VyL2RvbWFpbi5jCmluZGV4IGUwM2IxYWQuLjhmZTZlNzAgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvYmFzZS9wb3dlci9kb21haW4uYworKysgYi9kcml2ZXJzL2Jhc2Uv
cG93ZXIvZG9tYWluLmMKQEAgLTEyNTIsNiArMTI1Miw3IEBAIGludCBfX3BtX2dlbnBkX2FkZF9k
ZXZpY2Uoc3RydWN0IGdlbmVyaWNfcG1fZG9tYWluICpnZW5wZCwgc3RydWN0IGRldmljZSAqZGV2
LAogCiAJcmV0dXJuIHJldDsKIH0KK0VYUE9SVF9TWU1CT0xfR1BMKF9fcG1fZ2VucGRfYWRkX2Rl
dmljZSk7CiAKIC8qKgogICogcG1fZ2VucGRfcmVtb3ZlX2RldmljZSAtIFJlbW92ZSBhIGRldmlj
ZSBmcm9tIGFuIEkvTyBQTSBkb21haW4uCkBAIC0xMzAyLDYgKzEzMDMsNyBAQCBpbnQgcG1fZ2Vu
cGRfcmVtb3ZlX2RldmljZShzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4gKmdlbnBkLAogCiAJcmV0
dXJuIHJldDsKIH0KK0VYUE9SVF9TWU1CT0xfR1BMKHBtX2dlbnBkX3JlbW92ZV9kZXZpY2UpOwog
CiAvKioKICAqIHBtX2dlbnBkX2FkZF9zdWJkb21haW4gLSBBZGQgYSBzdWJkb21haW4gdG8gYW4g
SS9PIFBNIGRvbWFpbi4KLS0gCjEuOC4zLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCg==
