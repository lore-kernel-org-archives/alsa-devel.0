From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 2/9] drm/i915: Add get_eld audio component
Date: Fri, 4 Dec 2015 16:54:32 +0100
Message-ID: <20151204155432.GB10243@phenom.ffwll.local>
References: <1448986198-3488-1-git-send-email-tiwai@suse.de>
 <1448986198-3488-3-git-send-email-tiwai@suse.de>
 <20151204102102.GM10243@phenom.ffwll.local>
 <s5hsi3i32ut.wl-tiwai@suse.de>
 <20151204150046.GR10243@phenom.ffwll.local>
 <s5hd1umz1mb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <s5hd1umz1mb.wl-tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBEZWMgMDQsIDIwMTUgYXQgMDQ6MTU6MjRQTSArMDEwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9pOTE1X2NvbXBvbmVudC5oIGIvaW5jbHVk
ZS9kcm0vaTkxNV9jb21wb25lbnQuaAo+IGluZGV4IDMwZDg5ZTBkYTJjNi4uMDU4ZDM5ZThkNTdm
IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvZHJtL2k5MTVfY29tcG9uZW50LmgKPiArKysgYi9pbmNs
dWRlL2RybS9pOTE1X2NvbXBvbmVudC5oCj4gQEAgLTM4LDYgKzM4LDcgQEAKPiAgICogQGNvZGVj
X3dha2Vfb3ZlcnJpZGU6IEVuYWJsZS9EaXNhYmxlIGdlbmVyYXRpbmcgdGhlIGNvZGVjIHdha2Ug
c2lnbmFsCj4gICAqIEBnZXRfY2RjbGtfZnJlcTogZ2V0IHRoZSBDb3JlIERpc3BsYXkgQ2xvY2sg
aW4gS0h6Cj4gICAqIEBzeW5jX2F1ZGlvX3JhdGU6IHNldCBuL2N0cyBiYXNlZCBvbiB0aGUgc2Ft
cGxlIHJhdGUKPiArICogQGdldF9lbGQ6IGZpbGwgdGhlIGF1ZGlvIHN0YXRlIGFuZCBFTEQgYnl0
ZXMgZm9yIHRoZSBnaXZlbiBwb3J0CgpPbmUgbW9yZTogWW91IHNlZW0gdG8gc3RpbGwgYmUgb24g
YW4gb2xkIGJhc2VsaW5lLCB3aXRoIHN3aXRjaGVkIHRvIHRoZQpuZXcgaW4tbGluZSBjb21tZW50
IGxheW91dC4gVGhhdCBhbGxvd3MgeW91IHRvIHNwZWMgdGhlIGNhbGxiYWNrIHNlbWFudGljcwpp
biBtdWNoIG1vcmUgZGV0YWlsIHNpbmNlIGl0IGFsbG93cyByZWFsIHBhcmFncmFwaHMuCi1EYW5p
ZWwKCj4gICAqLwo+ICBzdHJ1Y3QgaTkxNV9hdWRpb19jb21wb25lbnRfb3BzIHsKPiAgCXN0cnVj
dCBtb2R1bGUgKm93bmVyOwo+IEBAIC00Niw2ICs0Nyw4IEBAIHN0cnVjdCBpOTE1X2F1ZGlvX2Nv
bXBvbmVudF9vcHMgewo+ICAJdm9pZCAoKmNvZGVjX3dha2Vfb3ZlcnJpZGUpKHN0cnVjdCBkZXZp
Y2UgKiwgYm9vbCBlbmFibGUpOwo+ICAJaW50ICgqZ2V0X2NkY2xrX2ZyZXEpKHN0cnVjdCBkZXZp
Y2UgKik7Cj4gIAlpbnQgKCpzeW5jX2F1ZGlvX3JhdGUpKHN0cnVjdCBkZXZpY2UgKiwgaW50IHBv
cnQsIGludCByYXRlKTsKPiArCWludCAoKmdldF9lbGQpKHN0cnVjdCBkZXZpY2UgKiwgaW50IHBv
cnQsIGJvb2wgKmVuYWJsZWQsCj4gKwkJICAgICAgIHVuc2lnbmVkIGNoYXIgKmJ1ZiwgaW50IG1h
eF9ieXRlcyk7Cj4gIH07Cj4gIAo+ICBzdHJ1Y3QgaTkxNV9hdWRpb19jb21wb25lbnRfYXVkaW9f
b3BzIHsKPiAtLSAKPiAyLjYuMwo+IAoKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdhcmUgRW5naW5l
ZXIsIEludGVsIENvcnBvcmF0aW9uCmh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QK
SW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
