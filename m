From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v4 2/5] drm/i915: Add support for audio
	driver notifications
Date: Tue, 24 Jan 2017 09:00:42 +0200
Message-ID: <87bmuxdjs5.fsf@intel.com>
References: <20170120222232.27791-1-jerome.anand@intel.com>
 <20170120222232.27791-3-jerome.anand@intel.com> <871svu82mt.fsf@intel.com>
 <942a0a36-5d1b-030d-770b-f8bcb3122a4f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <942a0a36-5d1b-030d-770b-f8bcb3122a4f@linux.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>, intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, rakesh.a.ughreja@intel.com
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAyMyBKYW4gMjAxNywgUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5i
b3NzYXJ0QGxpbnV4LmludGVsLmNvbT4gd3JvdGU6Cj4+PiAgI2luY2x1ZGUgPGRybS9kcm1QLmg+
Cj4+PiBAQCAtNjMwLDYgKzYzMSwxMCBAQCB2b2lkIGludGVsX2F1ZGlvX2NvZGVjX2VuYWJsZShz
dHJ1Y3QgaW50ZWxfZW5jb2RlciAqaW50ZWxfZW5jb2RlciwKPj4+ICAJaWYgKGFjb21wICYmIGFj
b21wLT5hdWRpb19vcHMgJiYgYWNvbXAtPmF1ZGlvX29wcy0+cGluX2VsZF9ub3RpZnkpCj4+PiAg
CQlhY29tcC0+YXVkaW9fb3BzLT5waW5fZWxkX25vdGlmeShhY29tcC0+YXVkaW9fb3BzLT5hdWRp
b19wdHIsCj4+PiAgCQkJCQkJIChpbnQpIHBvcnQsIChpbnQpIHBpcGUpOwo+Pj4gKwo+Pj4gKwlp
ZiAoSEFTX0xQRV9BVURJTyhkZXZfcHJpdikpCj4+PiArCQlpbnRlbF9scGVfYXVkaW9fbm90aWZ5
KGRldl9wcml2LCBjb25uZWN0b3ItPmVsZCwgcG9ydCwKPj4+ICsJCQljcnRjX3N0YXRlLT5wb3J0
X2Nsb2NrKTsKPj4KPj4gU2VlbXMgdW5uZWNlc3NhcnkgdG8gY2hlY2sgZm9yIEhBU19MUEVfQVVE
SU8gKHdoaWNoIHlvdSdsbCBjaGFuZ2UgdG8KPj4gZGV2X3ByaXYtPmxwZV9hdWRpby5wbGF0ZGV2
LCByaWdodCA7KSBib3RoIGluIHRoZSBjYWxsZXIgYW5kCj4+IGNhbGxlZS4gUGljayBvbmUuCj4K
PiBJZiB3ZSB0ZXN0IGluc2lkZSBvZiB0aGUgZnVuY3Rpb24sIGl0J2QgbWVhbiBhbiB1bmNvbmRp
dGlvbmFsIGp1bXAgdG8gCj4gdGVzdCBhIGZlYXR1cmUgdGhhdCBleGlzdHMgb24gb25seSB0d28g
cGxhdGZvcm1zIG91dCBvZiB0aGUgZG96ZW4gb3Igc28gCj4gdGhhdCB0aGlzIGk5MTUgZHJpdmVy
IGhhbmRsZXMuIE5vIG9iamVjdGlvbiB0byBkbyB0aGUgY2hhbmdlIGJ1dCBpcyB0aGlzIAo+IHJl
YWxseSBkZXNpcmVkPwoKKnNocnVnKiBubyBiaWcgZGVhbCB0byBjaGVjayBpbiBib3RoLgoKQlIs
CkphbmkuCgo+Cj4KCi0tIApKYW5pIE5pa3VsYSwgSW50ZWwgT3BlbiBTb3VyY2UgVGVjaG5vbG9n
eSBDZW50ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
SW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
