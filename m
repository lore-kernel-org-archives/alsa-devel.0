From: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: Move clock operation to PM runtime
Date: Mon, 22 Apr 2019 11:02:22 +0000
Message-ID: <1555930942.31656.4.camel@nxp.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
         <20190420155846.10027-3-daniel.baluta@nxp.com>
         <20190421055406.GC683@Asurada-Nvidia.nvidia.com>
Reply-To: Viorel Suman <viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190421055406.GC683@Asurada-Nvidia.nvidia.com>
Content-Language: en-US
Content-ID: <5B80DF74A62A7F4296B3B96D49E701F6@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "perex@perex.cz" <perex@perex.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

SGkgTmljb2xpbiwNCg0KT24gU2IsIDIwMTktMDQtMjAgYXQgMjI6NTQgLTA3MDAsIE5pY29saW4g
Q2hlbiB3cm90ZToNCj4gT24gU2F0LCBBcHIgMjAsIDIwMTkgYXQgMDM6NTk6MDVQTSArMDAwMCwg
RGFuaWVsIEJhbHV0YSB3cm90ZToNCj4gPiANCj4gPiBUdXJuIG9mZi9vbiBjbG9ja3Mgd2hlbiBk
ZXZpY2UgZW50ZXJzIHN1c3BlbmQvcmVzdW1lLiBUaGlzDQo+ID4gaGVscHMgc2F2aW5nIHBvd2Vy
Lg0KPiA+IA0KPiA+IEBAIC05MzQsNiArOTMzLDI1IEBAIHN0YXRpYyBpbnQgZnNsX3NhaV9ydW50
aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+IMKgc3RhdGljIGludCBmc2xfc2Fp
X3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiDCoHsNCj4gPiDCoAlzdHJ1
Y3QgZnNsX3NhaSAqc2FpID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKwlpbnQgcmV0Ow0K
PiA+ICsNCj4gPiArCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShzYWktPmJ1c19jbGspOw0KPiA+
ICsJaWYgKHJldCkgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSBidXMg
Y2xvY2s6ICVkXG4iLCByZXQpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJaWYgKHNhaS0+bWNsa19zdHJlYW1zICYgQklUKFNORFJWX1BDTV9TVFJFQU1fUExBWUJB
Q0spKSB7DQo+ID4gKwkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHNhaS0+bWNsa19jbGtbc2Fp
LT5tY2xrX2lkWzFdXSk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJZ290byBkaXNhYmxlX2J1
c19jbGs7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKHNhaS0+bWNsa19zdHJlYW1zICYgQklU
KFNORFJWX1BDTV9TVFJFQU1fQ0FQVFVSRSkpIHsNCj4gPiArCQlyZXQgPSBjbGtfcHJlcGFyZV9l
bmFibGUoc2FpLT5tY2xrX2Nsa1tzYWktPm1jbGtfaWRbMF1dKTsNCj4gPiArCQlpZiAocmV0KQ0K
PiA+ICsJCQlnb3RvIGRpc2FibGVfdHhfY2xrOw0KPiA+ICsJfQ0KPiBUaGUgZHJpdmVyIG9ubHkg
ZW5hYmxlcyBtY2xrX2Nsa3MgZm9yIEkyUyBtYXN0ZXIgbW9kZS4gQnV0IHRoaXMNCj4gY2hhbmdl
IGVuYWJsZXMgdGhlbSBmb3IgSTJTIHNsYXZlIG1vZGUgYWxzby4gSXQgZG9lc24ndCBzb3VuZCBh
DQo+IHJpZ2h0IHRoaW5nIHRvIG1lIHNpbmNlIHdlIGFyZSBzdXBwb3NlZCB0byBzYXZlIHBvd2Vy
Pw0KDQpUaGlzIGNoYW5nZSBkb2VzIG5vdCBlbmFibGUgdGhlbSBmb3IgSTJTIHNsYXZlIG1vZGUs
IHBsZWFzZSBjaGVjayAiZnNsX3NhaV9od19wYXJhbXMiDQphbmQgImZzbF9zYWlfaHdfZnJlZSIg
ZnVuY3Rpb25zOiB0aGUgZmllbGQgInNhaS0+bWNsa19zdHJlYW1zIiBpcyBtb2RpZmllZCBvbmx5
IGZvcg0KdGhlIGNhc2Ugd2hlbiAiaWYgKCFzYWktPmlzX3NsYXZlX21vZGUpIjsNCg0KUmVnYXJk
cywNClZpb3JlbA==
