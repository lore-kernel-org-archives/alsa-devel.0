From: "Anand, Jerome" <jerome.anand@intel.com>
Subject: Re: [RFC PATCH v3 1/7] drm/i915: setup bridge for HDMI
 LPE audio driver
Date: Mon, 28 Nov 2016 01:50:14 +0000
Message-ID: <F6867404AABACB4D8EC371BF802A4B7C149269C2@fmsmsx101.amr.corp.intel.com>
References: <20161124235548.16440-1-jerome.anand@intel.com>
 <20161124235548.16440-2-jerome.anand@intel.com>
 <20161124133154.GQ31595@intel.com>
 <F6867404AABACB4D8EC371BF802A4B7C14925AAA@fmsmsx101.amr.corp.intel.com>
 <8760nbvnl0.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <8760nbvnl0.fsf@intel.com>
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
To: Jani Nikula <jani.nikula@linux.intel.com>, =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

SmFuaSwKCkxhc3QgdGltZSAsIGl0IHRvb2sgY2xvc2UgdG8gMTAgZGF5cyB3aGVuIG15IHBhdGNo
ZXMgd2VyZSByZWZsZWN0ZWQgb24gdGhlIGdmeCBtYWlsaW5nIGxpc3QuIE5vdCBzdXJlIHdoYXQg
aXMgdGhlIHByb2JsZW0gPz8gTGV0IG1lIHRyeSBzZW5kaW5nIGl0IGFnYWluID8/CgpSZWdhcmRz
LApKZXJvbWUKCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiBGcm9tOiBKYW5pIE5pa3Vs
YSBbbWFpbHRvOmphbmkubmlrdWxhQGxpbnV4LmludGVsLmNvbV0KPiBTZW50OiBGcmlkYXksIE5v
dmVtYmVyIDI1LCAyMDE2IDQ6MjIgUE0KPiBUbzogQW5hbmQsIEplcm9tZSA8amVyb21lLmFuYW5k
QGludGVsLmNvbT47IFZpbGxlIFN5cmrDpGzDpAo+IDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVs
LmNvbT4KPiBDYzogYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOyB0aXdhaUBzdXNlLmRlOyBp
bnRlbC0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBicm9vbmllQGtlcm5lbC5vcmc7IFVn
aHJlamEsIFJha2VzaCBBCj4gPHJha2VzaC5hLnVnaHJlamFAaW50ZWwuY29tPgo+IFN1YmplY3Q6
IFJlOiBbSW50ZWwtZ2Z4XSBbUkZDIFBBVENIIHYzIDEvN10gZHJtL2k5MTU6IHNldHVwIGJyaWRn
ZSBmb3IgSERNSQo+IExQRSBhdWRpbyBkcml2ZXIKPiAKPiAKPiBKZXJvbWUgLQo+IAo+IFRoZSBz
YW1lIGFzIGxhc3QgdGltZSwgSSBkaWRuJ3QgcmVjZWl2ZSBhbnkgb2YgdGhlIHBhdGNoZXMsIG5l
aXRoZXIgdGhlIGludGVsLQo+IGdmeCBub3IgYWxzYS1kZXZlbCBsaXN0IGFyY2hpdmVzIGhhdmUg
dGhlbSwgcGF0Y2h3b3JrIGRvZXNuJ3QgaGF2ZSB0aGVtLAo+IHRoZXkncmUgbm90IGluIGludGVs
LWdmeCBtb2RlcmF0aW9uIHF1ZXVldS4gSSBvbmx5IGhhdmUgdGhlIHJlcGxpZXMuCj4gCj4gUGxl
YXNlIGNoZWNrIHlvdXIgc2V0dXAsIGFuZCBtYWtlIHN1cmUgeW91ciBwYXRjaGVzIGFjdHVhbGx5
IGhpdCB0aGUgbGlzdHMuCj4gCj4gVGhhbmtzLAo+IEphbmkuCj4gCj4gCj4gLS0KPiBKYW5pIE5p
a3VsYSwgSW50ZWwgT3BlbiBTb3VyY2UgVGVjaG5vbG9neSBDZW50ZXIKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJ
bnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
