From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] More robust i915 / audio binding
Date: Thu,  7 Apr 2016 12:57:21 +0200
Message-ID: <1460026644-30479-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: alsa-devel@alsa-project.org
Cc: Daniel Vetter <daniel.vetter@intel.com>, intel-gfx@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

SGksCgpoZXJlIGlzIGEgcGF0Y2hzZXQgdG8gbWFrZSB0aGUgaTkxNSAvIGF1ZGlvIGJpbmRpbmcg
bW9yZSByb2J1c3RseS4KSXQncyBiYXNlZCBvbiBJbXJlJ3Mgd29yayB0byBpbXBsZW1lbnQgdGhl
IHN0dWIgY29tcG9uZW50IG9wcyBmb3IKbm90aWZ5aW5nIHRoZSBpOTE1IGRpc2FibGVtZW50LgoK
ClRha2FzaGkKCj09PQoKSW1yZSBEZWFrICgxKToKICBkcm0vaTkxNS9oZGE6IEFkZCBhdWRpbyBj
b21wb25lbnQgc3R1YgoKVGFrYXNoaSBJd2FpICgyKToKICBBTFNBOiBoZGEgLSBJbW1lZGlhdGVs
eSBmYWlsIGlmIHRoZSBpOTE1IGF1ZGlvIGNvbXBvbmVudCBpcyBkaXNhYmxlZAogIEFMU0E6IGhk
YSAtIFN1cHBvcnQgZGVmZXJyZWQgaTkxNSBhdWRpbyBjb21wb25lbnQgYmluZGluZwoKIGRyaXZl
cnMvZ3B1L2RybS9pOTE1L2k5MTVfZHJ2LmMgICAgfCAzNCArKysrKysrKysrKysrLS0tLS0tLS0K
IGRyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2F1ZGlvLmMgfCA2MSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfZHJ2Lmgg
ICB8ICAyICsrCiBpbmNsdWRlL2RybS9pOTE1X2NvbXBvbmVudC5oICAgICAgIHwgIDUgKysrKwog
c291bmQvaGRhL2hkYWNfaTkxNS5jICAgICAgICAgICAgICB8IDI4ICsrKysrKysrKysrKy0tLS0t
CiA1IGZpbGVzIGNoYW5nZWQsIDExMCBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKCi0t
IAoyLjguMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
SW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
