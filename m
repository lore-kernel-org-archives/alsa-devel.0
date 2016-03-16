From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re:
 =?utf-8?q?=E2=9C=97_Fi=2ECI=2EBAT=3A_failure_for_drm/?=
 =?utf-8?q?i915/bxt=3A_Fix_off-by-one_error_in_Broxton_PLL_IDs_=28rev3=29?=
Date: Wed, 16 Mar 2016 17:50:20 +0200
Message-ID: <87twk6777n.fsf@intel.com>
References: <1457977942-11772-1-git-send-email-imre.deak@intel.com>
 <20160316073153.17251.51881@emeril.freedesktop.org>
 <1458118123.27377.11.camel@intel.com> <6454956.W1mfK3ePPj@fractal>
 <20160316153706.GT14170@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20160316153706.GT14170@phenom.ffwll.local>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>, Tomi Sarvela <tomi.p.sarvela@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAxNiBNYXIgMjAxNiwgRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPiB3cm90
ZToKPiBbIHRleHQvcGxhaW4gXQo+IE9uIFdlZCwgTWFyIDE2LCAyMDE2IGF0IDAyOjM3OjI0UE0g
KzAyMDAsIFRvbWkgU2FydmVsYSB3cm90ZToKPj4gT24gV2VkbmVzZGF5IDE2IE1hcmNoIDIwMTYg
MTA6NDg6NDMgSW1yZSBEZWFrIHdyb3RlOgo+PiA+IFRvbWksIG5vdGljZWQgdHdvIHRoaW5ncyB0
aGF0IG1heWJlIGluZnJhc3RydWN0dXJlIHJlbGF0ZWQsIHNlZSBiZWxvdzoKPj4gPiAKPj4gPiA+
IFRlc3QgZHJ2X21vZHVsZV9yZWxvYWRfYmFzaWM6Cj4+ID4gPiAgICAgICAgICAgICAgICAgc2tp
cCAgICAgICAtPiBQQVNTICAgICAgIChiZHctbnVjaTcpCj4+ID4gPiBUZXN0IGdlbV9yaW5nZmls
bDoKPj4gPiA+ICAgICAgICAgU3ViZ3JvdXAgYmFzaWMtZGVmYXVsdC1zMzoKPj4gPiA+ICAgICAg
ICAgICAgICAgICBwYXNzICAgICAgIC0+IERNRVNHLVdBUk4gKHNrbC1udWNpNSkKPj4gPiA+IFRl
c3QgZ2VtX3N0b3JlZHdfbG9vcDoKPj4gPiA+ICAgICAgICAgU3ViZ3JvdXAgYmFzaWMtYnNkOgo+
PiA+ID4gICAgICAgICAgICAgICAgIHBhc3MgICAgICAgLT4gRE1FU0ctV0FSTiAoc2tsLW51Y2k1
KQo+PiA+ID4gICAgICAgICBTdWJncm91cCBiYXNpYy1ic2QxOgo+PiA+ID4gICAgICAgICAgICAg
ICAgIHBhc3MgICAgICAgLT4gRE1FU0ctV0FSTiAoc2tsLW51Y2k1KQo+PiA+IAo+PiA+IFVucmVs
YXRlZCBwbGF0Zm9ybS4gQWxsIG9mIHRoZSBhYm92ZSBhcmUgU05EIHJlc3VtZSBmYWlsdXJlcy4g
VmlsbGUKPj4gPiBzYWlkIGhlIGNvbnRhY3RlZCBUYWthc2hpIGFib3V0IHRoZW0uCj4+IAo+PiBT
TkQgaXMgcmVjdXJyaW5nIHByb2JsZW0uIEknZCBsaWtlIHRvIHNlZSBkcm0taW50ZWwtbmlnaHRs
eSBub3QgYnJlYWtpbmcgd2hlbiAKPj4gcHVsbGluZyBzb3VuZCB1cGRhdGVzLgo+Cj4gV2UgbmVl
ZCB0byBlc2NhbGF0ZSB0aGlzIGFnYWluLCBzbmQgdGVhbSBzZXJpb3VzbHkgc3Vja3MgYXQgcXVh
bGl0eQo+IGNvbnRyb2wgOiggQWRkaW5nIExpYmluJlRha2FzaGkuIElmIHRoaXMgZG9lc24ndCBp
bXByb3ZlIEkgbmVlZCB0byB0aHJvdwo+IHNvdW5kIHRyZWVzIG91dCBvZiAtbmlnaHRseSBmb3Ig
cmVhbC4KCldpdGggdGhhdCwgd2UnZCBnZXQgbW9yZSBzdGFibGUgQ0ksIGJ1dCB3ZSdkIGFsc28g
b25seSBzZWUgdGhlIGZhaWx1cmVzCm9uY2UgdGhlIHNvdW5kIHRyZWVzIGdldCBtZXJnZWQgdXBz
dHJlYW0uIFdlIGRvbid0IHdhbnQgdGhhdCBlaXRoZXIuCgpPbmUgaWRlYSB3b3VsZCBiZSB0byBo
YXZlIHNlcGFyYXRlIENJIHJ1bnMgZm9yIHVwZGF0aW5nIHRyZWVzIG5vdCBpbiBvdXIKY29udHJv
bC4gQnV0IHdlJ3JlIHByZXR0eSBmYXIgZnJvbSBtYWtpbmcgdGhhdCBoYXBwZW4uCgpCUiwKSmFu
aS4KCgoKLS0gCkphbmkgTmlrdWxhLCBJbnRlbCBPcGVuIFNvdXJjZSBUZWNobm9sb2d5IENlbnRl
cgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1n
ZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK
