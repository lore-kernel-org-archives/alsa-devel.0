From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 3/5] ALSA: x86: intel_hdmi: set config
	bitfields for DP mode
Date: Thu, 26 Jan 2017 14:05:39 -0600
Message-ID: <1485461141-14023-4-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485461141-14023-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1485461141-14023-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org
Cc: tiwai@suse.de, Daniel Vetter <daniel.vetter@ffwll.ch>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

VGhlc2UgYml0cyB3ZXJlIHNldCBpbiBsZWdhY3kgYW5kIG5vdCBpbiB1cHN0cmVhbSBjb2RlLCBh
bmQgYXJlCmFwcGFyZW50bHkgdGVzdGVkIGZvciB3aGVuIHdyaXRpbmcgYSBjb25maWcgaW4gRFAg
bW9kZQoKRklYTUU6IGlzIHRoaXMgZXZlbiBuZWVkZWQ/CgpTaWduZWQtb2ZmLWJ5OiBQaWVycmUt
TG91aXMgQm9zc2FydCA8cGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tPgotLS0K
IHNvdW5kL3g4Ni9pbnRlbF9oZG1pX2F1ZGlvLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc291bmQveDg2L2ludGVsX2hkbWlfYXVkaW8uYyBi
L3NvdW5kL3g4Ni9pbnRlbF9oZG1pX2F1ZGlvLmMKaW5kZXggNDE1NWIzOC4uNzY4ZTZlMyAxMDA2
NDQKLS0tIGEvc291bmQveDg2L2ludGVsX2hkbWlfYXVkaW8uYworKysgYi9zb3VuZC94ODYvaW50
ZWxfaGRtaV9hdWRpby5jCkBAIC0zOTYsNiArMzk2LDcgQEAgc3RhdGljIGludCBzbmRfaW50ZWxo
YWRfcHJvZ19hdWRpb19jdHJsX3YyKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFt
LAogCWVsc2UKIAkJY2ZnX3ZhbC5jZmdfcmVneF92Mi5sYXlvdXQgPSBMQVlPVVQxOwogCisJY2Zn
X3ZhbC5jZmdfcmVneF92Mi52YWxfYml0ID0gMTsKIAloYWRfd3JpdGVfcmVnaXN0ZXIoQVVEX0NP
TkZJRywgY2ZnX3ZhbC5jZmdfcmVndmFsKTsKIAlyZXR1cm4gMDsKIH0KQEAgLTQ0Nyw2ICs0NDgs
NyBAQCBzdGF0aWMgaW50IHNuZF9pbnRlbGhhZF9wcm9nX2F1ZGlvX2N0cmxfdjEoc3RydWN0IHNu
ZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCiAKIAl9CiAKKwljZmdfdmFsLmNmZ19yZWd4LnZh
bF9iaXQgPSAxOwogCWhhZF93cml0ZV9yZWdpc3RlcihBVURfQ09ORklHLCBjZmdfdmFsLmNmZ19y
ZWd2YWwpOwogCXJldHVybiAwOwogfQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
