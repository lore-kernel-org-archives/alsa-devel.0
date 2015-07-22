From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2 0/4] i915 to call hda driver on HDMI
	plug/unplug
Date: Wed, 22 Jul 2015 17:28:07 +0200
Message-ID: <1437578891-8197-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: vinod.koul@intel.com, jani.nikula@linux.intel.com, daniel.vetter@intel.com, tiwai@suse.de, intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Q2hhbmdlcyBzaW5jZSBwcmV2aW91cyB2ZXJzaW9uOgoKICogUmVuYW1lcyBhbmQgcmVmYWN0b3Jp
bmdzIGFjY29yZGluZyB0byBEYW5pZWwncyBhbmQgVGFrYXNoaSdzIHN1Z2dlc3Rpb25zLgoKICog
RGVidWcgbWVzc2FnZSBzbGlnaHRseSBpbXByb3ZlZC4KCiAqIEJyYXN3ZWxsIG5vdyBoYXMgYWxs
IHRocmVlIHBpbnMgdG9vLCBCYXl0cmFpbCBzdGlsbCBoYXMgb25seSBvbmUgcGluLgogICBJdCB3
b3VsZCBzdGlsbCBiZSBnb29kIHdpdGggc29tZSBjb25maXJtYXRpb24gZnJvbSBJbnRlbCB0aGF0
IHRoaXMgaXMgCiAgIGNvcnJlY3QuCgpEYXZpZCBIZW5uaW5nc3NvbiAoNCk6CiAgZHJtL2k5MTU6
IEFkZCBhdWRpbyBob3RwbHVnIGluZm8gc3RydWN0CiAgZHJtL2k5MTU6IENhbGwgYXVkaW8gaG90
cGx1ZyBub3RpZnkgZnVuY3Rpb24KICBBTFNBOiBoZGEgLSBEaXNwYXRjaCBpbmNvbWluZyBIRE1J
IGhvdHBsdWcgaTkxNSBjYWxsYmFjawogIEFMU0E6IGhkYSAtIFdha2UgdGhlIGNvZGVjIHVwIG9u
IGhvdHBsdWcgbm90aWZ5IGV2ZW50cwoKIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfZHJ2Lmgg
ICAgfCAgICAxICsKIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2F1ZGlvLmMgfCAgIDQxICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogaW5jbHVkZS9kcm0vaTkxNV9jb21w
b25lbnQuaCAgICAgICB8ICAgMTggKysrKysrKysrKysrKysrKwogaW5jbHVkZS9zb3VuZC9oZGF1
ZGlvLmggICAgICAgICAgICB8ICAgIDQgKysrKwogc291bmQvaGRhL2hkYWNfaTkxNS5jICAgICAg
ICAgICAgICB8ICAgMjYgKysrKysrKysrKysrKysrKysrKysrKysKIHNvdW5kL3BjaS9oZGEvcGF0
Y2hfaGRtaS5jICAgICAgICAgfCAgIDEzICsrKysrKysrKysrLQogNiBmaWxlcyBjaGFuZ2VkLCAx
MDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKLS0gCjEuNy45LjUKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxp
c3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
