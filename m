From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 14/14] ASoC: hdac_hdmi: Fix to keep display active while
 enumerating codec
Date: Fri,  4 Dec 2015 02:39:02 +0530
Message-ID: <1449176942-3441-14-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, patches.audio@intel.com, broonie@kernel.org, Ramesh Babu <ramesh.babu@intel.com>, Daniel Vetter <daniel.vetter@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

RnJvbTogUmFtZXNoIEJhYnUgPHJhbWVzaC5iYWJ1QGludGVsLmNvbT4KClRoZSBkaXNwbGF5IHBv
d2VyIHJlZmVyZW5jZSBjb3VudCBpcyBkZWNyZW1lbnRlZCB3aXRoIHRoZSBmaXJzdApleHBsaWNp
dCBjYWxsIHRvIHBtX3J1bnRpbWVfc3VzcGVuZC4gT3RoZXJ3aXNlIHRoZSBkaXNwbGF5IHBvd2Vy
CnJlZmVyZW5jZSBjb3VudCBpcyBiYWxhbmNlZCB3aXRoIHJ1bnRpbWUgcmVzdW1lL3N1c3BlbmQu
IFJlc3QKb2YgdGhlIHRpbWUgaXQgaXMga2VwdCBvZmYuCgpTaWduZWQtb2ZmLWJ5OiBSYW1lc2gg
QmFidSA8cmFtZXNoLmJhYnVAaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdWJocmFuc3UgUy4g
UHJ1c3R5IDxzdWJocmFuc3Uucy5wcnVzdHlAaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBWaW5v
ZCBLb3VsIDx2aW5vZC5rb3VsQGludGVsLmNvbT4KLS0tCiBzb3VuZC9zb2MvY29kZWNzL2hkYWNf
aGRtaS5jIHwgMTIgKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvaGRhY19oZG1pLmMgYi9zb3VuZC9zb2Mv
Y29kZWNzL2hkYWNfaGRtaS5jCmluZGV4IDczZjU2MTIuLmZiNDM0NjEgMTAwNjQ0Ci0tLSBhL3Nv
dW5kL3NvYy9jb2RlY3MvaGRhY19oZG1pLmMKKysrIGIvc291bmQvc29jL2NvZGVjcy9oZGFjX2hk
bWkuYwpAQCAtMTIzNiw2ICsxMjM2LDE4IEBAIHN0YXRpYyBpbnQgaGRhY19oZG1pX2Rldl9wcm9i
ZShzdHJ1Y3QgaGRhY19leHRfZGV2aWNlICplZGV2KQogCUlOSVRfTElTVF9IRUFEKCZoZG1pX3By
aXYtPnBpbl9saXN0KTsKIAlJTklUX0xJU1RfSEVBRCgmaGRtaV9wcml2LT5jdnRfbGlzdCk7CiAK
KwkvKgorCSAqIFR1cm5lZCBvZmYgaW4gdGhlIHJ1bnRpbWVfc3VzcGVuZCBkdXJpbmcgdGhlIGZp
cnN0IGV4cGxpY2l0CisJICogcG1fcnVudGltZV9zdXNwZW5kIGNhbGwuCisJICovCisJcmV0ID0g
c25kX2hkYWNfZGlzcGxheV9wb3dlcihlZGV2LT5oZGFjLmJ1cywgdHJ1ZSk7CisJaWYgKHJldCA8
IDApIHsKKwkJZGV2X2VycigmZWRldi0+aGRhYy5kZXYsCisJCQkiQ2Fubm90IHR1cm4gb24gZGlz
cGxheSBwb3dlciBvbiBpOTE1IGVycjogJWRcbiIsCisJCQlyZXQpOworCQlyZXR1cm4gcmV0Owor
CX0KKwogCXJldCA9IGhkYWNfaGRtaV9wYXJzZV9hbmRfbWFwX25pZChlZGV2LCAmaGRtaV9kYWlz
LCAmbnVtX2RhaXMpOwogCWlmIChyZXQgPCAwKSB7CiAJCWRldl9lcnIoJmNvZGVjLT5kZXYsICJG
YWlsZWQgaW4gcGFyc2UgYW5kIG1hcCBuaWQgd2l0aCBlcnI6ICVkXG4iLCByZXQpOwotLSAKMS45
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
