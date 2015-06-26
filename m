From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 3/4] snd: add support for displayport
 multi-stream to hda codec.
Date: Fri, 26 Jun 2015 19:45:46 +0100
Message-ID: <1435344346.4661.16.camel@loki>
References: <1434513719-3580-1-git-send-email-airlied@gmail.com>
 <1434513719-3580-4-git-send-email-airlied@gmail.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B895171@SHSMSX101.ccr.corp.intel.com>
 <CAPM=9txJyV_q8ihnqXzyKF8NLbYQ85iuggQHpwe18dPCFdbgLA@mail.gmail.com>
 <s5hpp4s9ceq.wl-tiwai@suse.de> <20150622125429.GW25769@phenom.ffwll.local>
 <s5h7fqv7u7s.wl-tiwai@suse.de> <1434979769.2503.32.camel@loki>
 <1434986474.6176.53.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <s5hioafeoj4.wl-tiwai@suse.de>
 <1435045881.6176.76.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <1435315847.7153.52.camel@tkkaskin-mobl3.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1435315847.7153.52.camel@tkkaskin-mobl3.ger.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: "Kaskinen, Tanu" <tanu.kaskinen@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "pulseaudio-discuss@lists.freedesktop.org" <pulseaudio-discuss@lists.freedesktop.org>, "tiwai@suse.de" <tiwai@suse.de>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Lu,
 Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCAyMDE1LTA2LTI2IGF0IDExOjUwICswMTAwLCBLYXNraW5lbiwgVGFudSB3cm90ZToK
PiBPbiBUdWUsIDIwMTUtMDYtMjMgYXQgMTA6NTEgKzAzMDAsIFRhbnUgS2Fza2luZW4gd3JvdGU6
Cj4gPiAoQWRkZWQgcHVsc2VhdWRpby1kaXNjdXNzIHRvIENDLikKPiA+IAo+ID4gT24gTW9uLCAy
MDE1LTA2LTIyIGF0IDE3OjQ0ICswMjAwLCBUYWthc2hpIEl3YWkgd3JvdGU6Cj4gPiA+IEF0IE1v
biwgMjIgSnVuIDIwMTUgMTU6MjE6MTYgKzAwMDAsCj4gPiA+IEthc2tpbmVuLCBUYW51IHdyb3Rl
Ogo+ID4gPiA+IAo+ID4gPiA+IE9uIE1vbiwgMjAxNS0wNi0yMiBhdCAxNDoyOSArMDEwMCwgTGlh
bSBHaXJkd29vZCB3cm90ZToKPiA+ID4gPiA+IEJ0dywgdGhlIHRvcG9sb2d5IGNvcmUgbm93IGFs
c28gZHluYW1pY2FsbHkKPiA+ID4gPiA+IGNyZWF0ZXMvcmVtb3ZlcyBtaXhlciBjb250cm9scywg
Y2FuIFBBIGhhbmRsZSB0aGlzIGF0bSA/Cj4gPiA+ID4gCj4gPiA+ID4gTm8sIFBBIGNoZWNrcyB0
aGUgbWl4ZXIgY29udHJvbHMgb25seSB3aGVuIGxvYWRpbmcgYSBuZXcgY2FyZC4KPiA+ID4gPiBE
eW5hbWljYWxseSBhZGRlZCBjb250cm9scyBhcmUgaWdub3JlZC4gRHluYW1pY2FsbHkgcmVtb3Zl
ZCBjb250cm9scwo+ID4gPiA+IGp1c3QgY2F1c2Ugc2lsZW50IGZhaWx1cmUsIGF0IGxlYXN0IHdo
ZW4gc2V0dGluZyB2b2x1bWUgKEkgZGlkbid0IGNoZWNrCj4gPiA+ID4gb3RoZXIgdXNlIGNhc2Vz
KS4gVGhhdCBpcywgY2hhbmdpbmcgdGhlIHZvbHVtZSBhcHBlYXJzIHRvIHN1Y2NlZWQsIGJ1dAo+
ID4gPiA+IG5vdGhpbmcgYWN0dWFsbHkgaGFwcGVucy4KPiA+ID4gCj4gPiA+IFdvbid0IFBBIHVz
ZSBFTEQgb3Igb3RoZXIgaW5mb3JtYXRpb24/ICBUaGUgY29ycmVzcG9uZGluZyBjb250cm9scyB0
bwo+ID4gPiBIRE1JL0RQIHdpbGwgYmUgY3JlYXRlZCAvIGRlbGV0ZWQgZHluYW1pY2FsbHkgdG9n
ZXRoZXIgd2l0aCBhIFBDTQo+ID4gPiBkZXZpY2UsIEkgc3VwcG9zZS4KPiA+IAo+ID4gWWVzLCBQ
QSB1c2VzIEVMRC4gSWYgbWl4ZXIgY29udHJvbHMgYmVjb21lIGR5bmFtaWMgdG9vLCB0aGVuIHRo
YXQncwo+ID4gYW5vdGhlciB0aGluZyB0byBpbXBsZW1lbnQuCj4gCj4gTGlhbSwgaG93IGRvZXMg
dGhlIHVzZXJzcGFjZSBrbm93IHdoZW4gdGhlIG5ldyBQQ00gaXMgcmVhZHkgdG8gdXNlPyAKCkl0
J3MgZ2VuZXJhbGx5IHJlYWR5IHdoZW4gdGhlIFBDTSBpcyBjcmVhdGVkIGlpcmMuCgo+IElmCj4g
bmV3IG1peGVyIGNvbnRyb2xzIGFyZSBhZGRlZCB0b28sIGl0IGhhcyB0byBiZSBkZWZpbmVkIHdo
aWNoIGdldHMKPiBjcmVhdGVkIGZpcnN0OiB0aGUgUENNIGRldmljZSBvciB0aGUgbWl4ZXIgY29u
dHJvbHMuIEkgdGhpbmsgaXQgd291bGQgYmUKPiBiZXN0IGlmIHRoZSBtaXhlciBjb250cm9scyBn
ZXQgY3JlYXRlZCBmaXJzdCwgYW5kIHdoZW4gdGhlIG5ldyBQQ00KPiBkZXZpY2UgYXBwZWFycywg
aXQncyBpbW1lZGlhdGVseSBmdWxseSByZWFkeSB0byBiZSB1c2VkLgo+IAoKSSBhZ3JlZSwgYWRk
aW5nIG1peGVycyBmaXJzdCBtYWtlIHNlbnNlLgoKTGlhbSAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
