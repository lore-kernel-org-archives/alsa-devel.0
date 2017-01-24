From: "Anand, Jerome" <jerome.anand@intel.com>
Subject: Re: [PATCH v4 2/5] drm/i915: Add support for audio
 driver notifications
Date: Tue, 24 Jan 2017 08:42:20 +0000
Message-ID: <F6867404AABACB4D8EC371BF802A4B7C149608D9@fmsmsx101.amr.corp.intel.com>
References: <20170120222232.27791-1-jerome.anand@intel.com>
 <20170120222232.27791-3-jerome.anand@intel.com> <871svu82mt.fsf@intel.com>
 <942a0a36-5d1b-030d-770b-f8bcb3122a4f@linux.intel.com>
 <87bmuxdjs5.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <87bmuxdjs5.fsf@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Jani Nikula <jani.nikula@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

Cgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogSmFuaSBOaWt1bGEgW21haWx0
bzpqYW5pLm5pa3VsYUBsaW51eC5pbnRlbC5jb21dCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAy
NCwgMjAxNyAxMjozMSBQTQo+IFRvOiBQaWVycmUtTG91aXMgQm9zc2FydCA8cGllcnJlLWxvdWlz
LmJvc3NhcnRAbGludXguaW50ZWwuY29tPjsgQW5hbmQsCj4gSmVyb21lIDxqZXJvbWUuYW5hbmRA
aW50ZWwuY29tPjsgaW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgYWxzYS0KPiBkZXZl
bEBhbHNhLXByb2plY3Qub3JnCj4gQ2M6IHRpd2FpQHN1c2UuZGU7IGJyb29uaWVAa2VybmVsLm9y
ZzsgVWdocmVqYSwgUmFrZXNoIEEKPiA8cmFrZXNoLmEudWdocmVqYUBpbnRlbC5jb20+Cj4gU3Vi
amVjdDogUmU6IFtJbnRlbC1nZnhdIFtQQVRDSCB2NCAyLzVdIGRybS9pOTE1OiBBZGQgc3VwcG9y
dCBmb3IgYXVkaW8gZHJpdmVyCj4gbm90aWZpY2F0aW9ucwo+IAo+IE9uIE1vbiwgMjMgSmFuIDIw
MTcsIFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDxwaWVycmUtCj4gbG91aXMuYm9zc2FydEBsaW51eC5p
bnRlbC5jb20+IHdyb3RlOgo+ID4+PiAgI2luY2x1ZGUgPGRybS9kcm1QLmg+Cj4gPj4+IEBAIC02
MzAsNiArNjMxLDEwIEBAIHZvaWQgaW50ZWxfYXVkaW9fY29kZWNfZW5hYmxlKHN0cnVjdAo+IGlu
dGVsX2VuY29kZXIgKmludGVsX2VuY29kZXIsCj4gPj4+ICAJaWYgKGFjb21wICYmIGFjb21wLT5h
dWRpb19vcHMgJiYgYWNvbXAtPmF1ZGlvX29wcy0KPiA+cGluX2VsZF9ub3RpZnkpCj4gPj4+ICAJ
CWFjb21wLT5hdWRpb19vcHMtPnBpbl9lbGRfbm90aWZ5KGFjb21wLT5hdWRpb19vcHMtCj4gPmF1
ZGlvX3B0ciwKPiA+Pj4gIAkJCQkJCSAoaW50KSBwb3J0LCAoaW50KSBwaXBlKTsKPiA+Pj4gKwo+
ID4+PiArCWlmIChIQVNfTFBFX0FVRElPKGRldl9wcml2KSkKPiA+Pj4gKwkJaW50ZWxfbHBlX2F1
ZGlvX25vdGlmeShkZXZfcHJpdiwgY29ubmVjdG9yLT5lbGQsIHBvcnQsCj4gPj4+ICsJCQljcnRj
X3N0YXRlLT5wb3J0X2Nsb2NrKTsKPiA+Pgo+ID4+IFNlZW1zIHVubmVjZXNzYXJ5IHRvIGNoZWNr
IGZvciBIQVNfTFBFX0FVRElPICh3aGljaCB5b3UnbGwgY2hhbmdlIHRvCj4gPj4gZGV2X3ByaXYt
PmxwZV9hdWRpby5wbGF0ZGV2LCByaWdodCA7KSBib3RoIGluIHRoZSBjYWxsZXIgYW5kIGNhbGxl
ZS4KPiA+PiBQaWNrIG9uZS4KPiA+Cj4gPiBJZiB3ZSB0ZXN0IGluc2lkZSBvZiB0aGUgZnVuY3Rp
b24sIGl0J2QgbWVhbiBhbiB1bmNvbmRpdGlvbmFsIGp1bXAgdG8KPiA+IHRlc3QgYSBmZWF0dXJl
IHRoYXQgZXhpc3RzIG9uIG9ubHkgdHdvIHBsYXRmb3JtcyBvdXQgb2YgdGhlIGRvemVuIG9yCj4g
PiBzbyB0aGF0IHRoaXMgaTkxNSBkcml2ZXIgaGFuZGxlcy4gTm8gb2JqZWN0aW9uIHRvIGRvIHRo
ZSBjaGFuZ2UgYnV0IGlzCj4gPiB0aGlzIHJlYWxseSBkZXNpcmVkPwo+IAo+ICpzaHJ1Zyogbm8g
YmlnIGRlYWwgdG8gY2hlY2sgaW4gYm90aC4KPiAKClRoYW5rcyBmb3IgdGhlIGFjayBKYW5pLgpJ
dCB3YXMgYWRkZWQgYmFzZWQgb24gb25lIHJldmlldyBjb21tZW50LiBJJ2xsIHJlbW92ZSBpdCBo
ZXJlIGFuZCBoYXZlIHRoZSBjaGVjayBvbmx5IGluc2lkZSB0aGUgQVBJCgo+IEJSLAo+IEphbmku
Cj4gCj4gPgo+ID4KPiAKPiAtLQo+IEphbmkgTmlrdWxhLCBJbnRlbCBPcGVuIFNvdXJjZSBUZWNo
bm9sb2d5IENlbnRlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1n
ZngK
