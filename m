From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH 1/2] ASoC: da7218: Add bindings documentation for DA7218
 audio codec
Date: Thu, 5 Nov 2015 17:59:29 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D460C91F@SW-EX-MBX01.diasemi.com>
References: <cover.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <b7132781a4a41a20549e13b1835bb7f808f6be82.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <20151105145856.GM18409@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151105145856.GM18409@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

T24gTm92ZW1iZXIgMDUsIDIwMTUgMTQ6NTksIE1hcmsgQnJvd24gd3JvdGU6DQoNCj4gPiArLSBk
bGcsbGRvLWx2bCA6IFJlcXVpcmVkIGludGVybmFsIExETyB2b2x0YWdlIChtVikgbGV2ZWwNCj4g
PiArCVs8MTA1MD4sIDwxMTAwPiwgPDEyMDA+LCA8MTQwMD5dDQo+IA0KPiBXaHkgd291bGQgdGhp
cyBldmVyIGJlIGFueXRoaW5nIG90aGVyIHRoYW4gdGhlIG1pbmltdW0gdm9sdGFnZSwgYW5kDQo+
IG1pZ2h0IHdlIG5vdCB3YW50IHRvIHZhcnkgaXQgYXQgcnVudGltZT8NCg0KTm9ybWFsbHkgeW91
IGFyZSBjb3JyZWN0IGFuZCB5b3UnbGwgd2FudCBtaW5pbXVtIHZvbHRhZ2UgZm9yIHRoZSBkaWdp
dGFsIGVuZ2luZQ0KYnV0IHRoZXJlIG1heSBiZSB0aGUgcG9zc2liaWxpdHkgZm9yIGNlcnRhaW4g
cGxhdGZvcm0gc2NlbmFyaW9zIHRoYXQgdG8gbWVldA0KdGltaW5ncyBhIGhpZ2hlciB2b2x0YWdl
IGlzIHJlcXVpcmVkLiBXb3VsZCBwcmVmZXIgdG8gbGVhdmUgdGhpcyBpbiBpbiBjYXNlIGl0DQpp
cyByZXF1aXJlZCBpbiB0aGUgZnV0dXJlLiBBcyBhIHNpZGUsIHRoZSBkZWZhdWx0IHNldHRpbmcg
aXMgdGhlIGxvd2VzdCB2b2x0YWdlLA0KaWYgdGhpcyBiaW5kaW5nIGlzIG5vdCBwcm92aWRlZC4N
Cg0KPiANCj4gPiArLSBkbGcsYmlxdWFkLWNmZyA6IExpc3Qgb2YgZGF0YSAmIGFkZHJlc3MgcGFp
cnMgdG8gY29uZmlndXJlIEJpUXVhZCBmaWx0ZXJzDQo+ID4gKwlbIDwge2RhdGExfSB7YWRkcjF9
IHtkYXRhMn0ge2FkZHIyfSAuLi4gPjsgXQ0KPiA+ICstIGRsZyxzdC1iaXF1YWQtY2ZnIDogTGlz
dCBvZiBkYXRhICYgYWRkcmVzcyBwYWlycyB0byBjb25maWd1cmUgU2lkZXRvbmUNCj4gPiArCQkg
ICAgICBCaVF1YWQgZmlsdGVycw0KPiA+ICsJWyA8IHtkYXRhMX0ge2FkZHIxfSB7ZGF0YTJ9IHth
ZGRyMn0gLi4uID47IF0NCj4gDQo+IFRoZXNlIGxvb2sgbGlrZSBEU1AgY29lZmZpY2llbnRzIHdo
aWNoIEkgd291bGQgdGhlcmVmb3JlIGV4cGVjdCB0byBiZQ0KPiBjb25maWd1cmFibGUgYXQgcnVu
dGltZSB2aWEgYSBiaW5hcnkgY29udHJvbCByYXRoZXIgdGhhbiBzcGVjaWZpZWQgaW4NCj4gdGhl
IERUIC0gd2h5IGFyZSB0aGV5IGluIHRoZSBEVD8NCg0KVGhlIGV4cGVjdGF0aW9uIHdhcyB0aGVz
ZSB3b3VsZCBiZSBzZXQgb25jZSBhbmQgbGVmdCBmb3IgYSBwbGF0Zm9ybSwgd2hpY2ggaXMNCndo
eSBJIGFkZGVkIHRoZW0gdG8gdGhlIERULiBIb3dldmVyIHRoZXJlJ3Mgbm8gcmVhc29uIHRoZXkg
Y291bGRuJ3QgYmUgbW92ZWQNCnRvIGJpbmFyeSBjb250cm9sLiBIYXZpbmcgbG9va2VkIGF0IG90
aGVyIGNvZGVjcywgSSBhc3N1bWUgU05EX1NPQ19CWVRFUyogd291bGQNCmJlIHRoZSBwcmVmZXJy
ZWQgbWV0aG9kIGZvciBzZXR0aW5nIHRoaXMga2luZCBvZiBkYXRhPw0K
