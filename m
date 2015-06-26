From: "Kaskinen, Tanu" <tanu.kaskinen@intel.com>
Subject: Re: [Intel-gfx] [PATCH 3/4] snd: add support
 for displayport multi-stream to hda codec.
Date: Fri, 26 Jun 2015 10:50:49 +0000
Message-ID: <1435315847.7153.52.camel@tkkaskin-mobl3.ger.corp.intel.com>
References: <1434513719-3580-1-git-send-email-airlied@gmail.com>
 <1434513719-3580-4-git-send-email-airlied@gmail.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B895171@SHSMSX101.ccr.corp.intel.com>
 <CAPM=9txJyV_q8ihnqXzyKF8NLbYQ85iuggQHpwe18dPCFdbgLA@mail.gmail.com>
 <s5hpp4s9ceq.wl-tiwai@suse.de> <20150622125429.GW25769@phenom.ffwll.local>
 <s5h7fqv7u7s.wl-tiwai@suse.de> <1434979769.2503.32.camel@loki>
 <1434986474.6176.53.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <s5hioafeoj4.wl-tiwai@suse.de>
 <1435045881.6176.76.camel@tkkaskin-mobl3.ger.corp.intel.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <1435045881.6176.76.camel@tkkaskin-mobl3.ger.corp.intel.com>
Content-Language: en-US
Content-ID: <0FD37D2E1D61F64782287706EFE92228@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: "tiwai@suse.de" <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "pulseaudio-discuss@lists.freedesktop.org" <pulseaudio-discuss@lists.freedesktop.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "airlied@gmail.com" <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAyMDE1LTA2LTIzIGF0IDEwOjUxICswMzAwLCBUYW51IEthc2tpbmVuIHdyb3RlOg0K
PiAoQWRkZWQgcHVsc2VhdWRpby1kaXNjdXNzIHRvIENDLikNCj4gDQo+IE9uIE1vbiwgMjAxNS0w
Ni0yMiBhdCAxNzo0NCArMDIwMCwgVGFrYXNoaSBJd2FpIHdyb3RlOg0KPiA+IEF0IE1vbiwgMjIg
SnVuIDIwMTUgMTU6MjE6MTYgKzAwMDAsDQo+ID4gS2Fza2luZW4sIFRhbnUgd3JvdGU6DQo+ID4g
PiANCj4gPiA+IE9uIE1vbiwgMjAxNS0wNi0yMiBhdCAxNDoyOSArMDEwMCwgTGlhbSBHaXJkd29v
ZCB3cm90ZToNCj4gPiA+ID4gQnR3LCB0aGUgdG9wb2xvZ3kgY29yZSBub3cgYWxzbyBkeW5hbWlj
YWxseQ0KPiA+ID4gPiBjcmVhdGVzL3JlbW92ZXMgbWl4ZXIgY29udHJvbHMsIGNhbiBQQSBoYW5k
bGUgdGhpcyBhdG0gPw0KPiA+ID4gDQo+ID4gPiBObywgUEEgY2hlY2tzIHRoZSBtaXhlciBjb250
cm9scyBvbmx5IHdoZW4gbG9hZGluZyBhIG5ldyBjYXJkLg0KPiA+ID4gRHluYW1pY2FsbHkgYWRk
ZWQgY29udHJvbHMgYXJlIGlnbm9yZWQuIER5bmFtaWNhbGx5IHJlbW92ZWQgY29udHJvbHMNCj4g
PiA+IGp1c3QgY2F1c2Ugc2lsZW50IGZhaWx1cmUsIGF0IGxlYXN0IHdoZW4gc2V0dGluZyB2b2x1
bWUgKEkgZGlkbid0IGNoZWNrDQo+ID4gPiBvdGhlciB1c2UgY2FzZXMpLiBUaGF0IGlzLCBjaGFu
Z2luZyB0aGUgdm9sdW1lIGFwcGVhcnMgdG8gc3VjY2VlZCwgYnV0DQo+ID4gPiBub3RoaW5nIGFj
dHVhbGx5IGhhcHBlbnMuDQo+ID4gDQo+ID4gV29uJ3QgUEEgdXNlIEVMRCBvciBvdGhlciBpbmZv
cm1hdGlvbj8gIFRoZSBjb3JyZXNwb25kaW5nIGNvbnRyb2xzIHRvDQo+ID4gSERNSS9EUCB3aWxs
IGJlIGNyZWF0ZWQgLyBkZWxldGVkIGR5bmFtaWNhbGx5IHRvZ2V0aGVyIHdpdGggYSBQQ00NCj4g
PiBkZXZpY2UsIEkgc3VwcG9zZS4NCj4gDQo+IFllcywgUEEgdXNlcyBFTEQuIElmIG1peGVyIGNv
bnRyb2xzIGJlY29tZSBkeW5hbWljIHRvbywgdGhlbiB0aGF0J3MNCj4gYW5vdGhlciB0aGluZyB0
byBpbXBsZW1lbnQuDQoNCkxpYW0sIGhvdyBkb2VzIHRoZSB1c2Vyc3BhY2Uga25vdyB3aGVuIHRo
ZSBuZXcgUENNIGlzIHJlYWR5IHRvIHVzZT8gSWYNCm5ldyBtaXhlciBjb250cm9scyBhcmUgYWRk
ZWQgdG9vLCBpdCBoYXMgdG8gYmUgZGVmaW5lZCB3aGljaCBnZXRzDQpjcmVhdGVkIGZpcnN0OiB0
aGUgUENNIGRldmljZSBvciB0aGUgbWl4ZXIgY29udHJvbHMuIEkgdGhpbmsgaXQgd291bGQgYmUN
CmJlc3QgaWYgdGhlIG1peGVyIGNvbnRyb2xzIGdldCBjcmVhdGVkIGZpcnN0LCBhbmQgd2hlbiB0
aGUgbmV3IFBDTQ0KZGV2aWNlIGFwcGVhcnMsIGl0J3MgaW1tZWRpYXRlbHkgZnVsbHkgcmVhZHkg
dG8gYmUgdXNlZC4NCg0KLS0gDQpUYW51DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpwdWxzZWF1ZGlvLWRpc2N1c3MgbWFpbGluZyBsaXN0CnB1bHNlYXVk
aW8tZGlzY3Vzc0BsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3B1bHNlYXVkaW8tZGlzY3Vzcwo=
