From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 02/12] drm/amd: remove amd gnb bus default runtime pm ops
Date: Thu,  6 Aug 2015 10:25:03 -0400
Message-ID: <1438871112-25946-3-git-send-email-alexander.deucher@amd.com>
References: <1438871112-25946-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1438871112-25946-1-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: broonie@kernel.org, airlied@gmail.com, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, lgirdwood@gmail.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

RnJvbTogTWFydXRoaSBTcmluaXZhcyBCYXl5YXZhcmFwdSA8TWFydXRoaS5CYXl5YXZhcmFwdUBh
bWQuY29tPgoKd2l0aCB0aGUgZGVmYXVsdCBnbmIgYnVzIHJ1bnRpbWUgcG0gb3BzLCBhbHNhIHBj
bSBkZXZpY2UgYXR0YWNoZWQgdG8KaXQgaXMgdW5hYmxlIHRvIGdldCBydW50aW1lIHN1c3BlbmRl
ZC9yZXN1bWVkLgoKU2lnbmVkLW9mZi1ieTogTWFydXRoaSBCYXl5YXZhcmFwdSA8bWFydXRoaS5i
YXl5YXZhcmFwdUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYnVzL2FtZF9nbmJfYnVz
LmMgfCA1IC0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2J1cy9hbWRfZ25iX2J1cy5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9idXMvYW1kX2duYl9idXMuYwppbmRleCAwNzFiMTZjLi4xM2Q1NTA2IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2J1cy9hbWRfZ25iX2J1cy5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYnVzL2FtZF9nbmJfYnVzLmMKQEAgLTE0MiwxMSArMTQyLDYgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBkZXZfcG1fb3BzIGFtZF9nbmJfYnVzX2RldmljZV9wbV9vcHMgPSB7CiAJLnRo
YXcgPSBhbWRfZ25iX2J1c19kZXZpY2VfcG1fdGhhdywKIAkucG93ZXJvZmYgPSBhbWRfZ25iX2J1
c19kZXZpY2VfcG1fcG93ZXJvZmYsCiAJLnJlc3RvcmUgPSBhbWRfZ25iX2J1c19kZXZpY2VfcG1f
cmVzdG9yZSwKLQlTRVRfUlVOVElNRV9QTV9PUFMoCi0JCXBtX2dlbmVyaWNfcnVudGltZV9zdXNw
ZW5kLAotCQlwbV9nZW5lcmljX3J1bnRpbWVfcmVzdW1lLAotCQlwbV9ydW50aW1lX2lkbGUKLQkp
CiB9OwogCiAvKiBUaGUgYnVzIHNob3VsZCBvbmx5IGJlIHJlZ2lzdGVyZWQgYnkgdGhlIGZpcnN0
IGFtZF9nbmIsIGJ1dCBmdXJ0aGVyCi0tIAoxLjguMy4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
