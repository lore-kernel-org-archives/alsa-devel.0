From: kbuild test robot <lkp@intel.com>
Subject: [PATCH] ALSA: fix resource_size.cocci warnings
Date: Tue, 24 Jan 2017 23:41:46 +0800
Message-ID: <20170124154146.GA7724@lkp-ivb-ep02.lkp.intel.com>
References: <201701242304.nWL6PHfB%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20170124225753.9045-4-jerome.anand@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Jerome Anand <jerome.anand@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, intel-gfx@lists.freedesktop.org, broonie@kernel.org, rakesh.a.ughreja@intel.com, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

c291bmQveDg2L2ludGVsX2hkbWlfbHBlX2F1ZGlvLmM6NDk4OjI0LTI3OiBFUlJPUjogTWlzc2lu
ZyByZXNvdXJjZV9zaXplIHdpdGggcmVzX21taW8KCgogVXNlIHJlc291cmNlX3NpemUgZnVuY3Rp
b24gb24gcmVzb3VyY2Ugb2JqZWN0CiBpbnN0ZWFkIG9mIGV4cGxpY2l0IGNvbXB1dGF0aW9uLgoK
R2VuZXJhdGVkIGJ5OiBzY3JpcHRzL2NvY2NpbmVsbGUvYXBpL3Jlc291cmNlX3NpemUuY29jY2kK
CkNDOiBKZXJvbWUgQW5hbmQgPGplcm9tZS5hbmFuZEBpbnRlbC5jb20+ClNpZ25lZC1vZmYtYnk6
IEZlbmdndWFuZyBXdSA8ZmVuZ2d1YW5nLnd1QGludGVsLmNvbT4KLS0tCgogaW50ZWxfaGRtaV9s
cGVfYXVkaW8uYyB8ICAgIDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIg
ZGVsZXRpb25zKC0pCgotLS0gYS9zb3VuZC94ODYvaW50ZWxfaGRtaV9scGVfYXVkaW8uYworKysg
Yi9zb3VuZC94ODYvaW50ZWxfaGRtaV9scGVfYXVkaW8uYwpAQCAtNDk1LDggKzQ5NSw3IEBAIHN0
YXRpYyBpbnQgaGRtaV9scGVfYXVkaW9fcHJvYmUoc3RydWN0IHAKIAkJKHVuc2lnbmVkIGludCly
ZXNfbW1pby0+ZW5kKTsKIAogCW1taW9fc3RhcnQgPSBpb3JlbWFwX25vY2FjaGUocmVzX21taW8t
PnN0YXJ0LAotCQkJCShzaXplX3QpKChyZXNfbW1pby0+ZW5kIC0gcmVzX21taW8tPnN0YXJ0KQot
CQkJCQkJKyAxKSk7CisJCQkJKHNpemVfdCkocmVzb3VyY2Vfc2l6ZShyZXNfbW1pbykpKTsKIAlp
ZiAoIW1taW9fc3RhcnQpIHsKIAkJZGV2X2VycigmaGxwZV9wZGV2LT5kZXYsICJDb3VsZCBub3Qg
Z2V0IGlvcmVtYXBcbiIpOwogCQlyZXR1cm4gLUVBQ0NFUzsKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
