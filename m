From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [RFC PATCH 4/5] drm: i915: add DisplayPort amp
 unmute for LPE audio mode
Date: Fri, 27 Jan 2017 17:46:23 +0200
Message-ID: <20170127154623.GE31595@intel.com>
References: <1485461141-14023-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1485461141-14023-5-git-send-email-pierre-louis.bossart@linux.intel.com>
 <87efzo4xxh.fsf@intel.com> <20170127131734.GP31595@intel.com>
 <20170127143547.GZ31595@intel.com> <s5hvat0ftsf.wl-tiwai@suse.de>
 <d37654f3-3d33-dafc-6069-aaf1beb35844@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <d37654f3-3d33-dafc-6069-aaf1beb35844@linux.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBKYW4gMjcsIDIwMTcgYXQgMDg6NTU6MTlBTSAtMDYwMCwgUGllcnJlLUxvdWlzIEJv
c3NhcnQgd3JvdGU6Cj4gCj4gCj4gPj4+Pj4gKyNkZWZpbmUgQVVEX1BPUlRfRU5fQl9EQkcJCTB4
NjJGMjAKPiA+Pj4+PiArI2RlZmluZSBBVURfUE9SVF9FTl9DX0RCRwkJMHg2MkYyOAo+ID4+Pj4+
ICsjZGVmaW5lIEFVRF9QT1JUX0VOX0RfREJHCQkweDYyRjJDCj4gPj4+IFRoZXNlIG1hdGNoIHRo
ZSBzcGVjLiBCdXQgdG8gbWF0Y2ggdGhlIHN0YW5kYXJkIGk5MTUgY29udmVudGlvbiB0aGV5Cj4g
Pj4+IHNob3VsZCBiZSBjYWxsZWQgX0FVRF9QT1JUX0VOX0JfREJHIGV0Yy4gU2FtZSBmb3J0aGUg
Y2hpY2tlbiBiaXQKPiA+Pj4gcmVnaXN0ZXIuCj4gPj4gQWN0dWFsbHkgdGhleSBqdXN0IG1hdGNo
IG9uZSB2ZXJzaW9uIG9mIHRoZSBzcGVjIEkgaGFkIGx5aW5nIGFyb3VuZC4KPiA+PiBBbm90aGVy
IHZlcnNpb25zIHNheXM6Cj4gPj4KPiA+PiBBVURfUE9SVF9FTl9CX0RCRyAweDYyRjIwCj4gPj4g
QVVEX1BPUlRfRU5fQ19EQkcgMHg2MkYzMAo+ID4+IEFVRF9QT1JUX0VOX0RfREJHIDB4NjJGMzQK
PiA+IFRoYXQncyBpdCEgIE5vdyBmaW5hbGx5IEkgY2FuIGhlYXIgdGhlIGF1ZGlvIGZyb20gRFAz
IHdpdGggdGhlCj4gPiBhZGRpdGlvbmFsIHBhdGNoIGJlbG93Lgo+IFdvdy4gVGhhbmtzIFZpbGxl
IGZvciBsb29raW5nIGludG8gdGhpcywgd2UgY291bGQgaGF2ZSBsb3N0IGEgbG90IG9mIAo+IHRp
bWUuIERvIHlvdSBoYXBwZW4gdG8ga25vdyBpZiB0aG9zZSBwcmV2aW91cyB2YWx1ZXMgYXJlIGR1
ZSB0byBwb29yIAo+IGRvY3VtZW50YXRpb24gb3IgYSBkaWZmZXJlbnQgc2tldyB3ZSdkIG5lZWQg
dG8gc3VwcG9ydCwgZS5nLiB3aXRoIGEgCj4gUENJLUlkIHF1aXJrPwoKTm8gaWRlYSByZWFsbHku
IFlvdSBzaG91bGQgcmVhbGx5IHRlc3QgdGhpcyBvbiBib3RoIENIViBhbmQgVkxWIHdpdGggYWxs
CnBvc3NpYmxlIHBvcnQvcGlwZSBjb21iaW5hdGlvbnMgdG8gbWFrZSBzdXJlIHdlIGdvdCBpdCBy
aWdodC4gSSB0cnVzdAp0aGVzZSBWTFYvQ0hWIGRvY3MgYWJvdXQgYXMgbXVjaCBhcyBJIHRydXN0
IG1vc3QgcG9saXRpY2lhbnMuCgpBbHRlcm5hdGl2ZWx5IHlvdSBjb3VsZCBqdXN0IHJlYWQgYWxs
IHRob3NlIHJlZ3Mgb24gYm90aCBwbGF0Zm9ybXMgYW5kCnNlZSBpZiB0aGUgdmFsdWVzIHlvdSBn
ZXQgZnJvbSB0aGVtIGNvbmZvcm0gdG8gYW55IHZpc2libGUgcGF0dGVybiB0aGF0CmNvdWxkIHRl
bGwgdXMgd2hpY2ggb2Zmc2V0cyBhcmUgdGhlIGNvcnJlY3Qgb25lcy4gVGhleSBtaWdodCBub3Qs
IGluCndoaWNoIGNhc2UgYWN0dWFsIHRlc3RpbmcgaXMgdGhlIGJlc3QgYmV0LgoKLS0gClZpbGxl
IFN5cmrDpGzDpApJbnRlbCBPVEMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
aW50ZWwtZ2Z4Cg==
