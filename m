From: Cosmin Samoila <cosmin.samoila-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK4458 DAC driver
Date: Fri, 9 Feb 2018 10:22:16 +0000
Message-ID: <1518171736.19973.7.camel@nxp.com>
References: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
         <20180131170330.GB7763@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180131170330.GB7763-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Content-ID: <E42495FC0835B74085021FA379D47FFD-jdb/QiT5osKcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: dl-linux-imx <linux-imx-3arQi8VN3Tc@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org" <wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org>, "mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "S.j. Wang" <shengjiu.wang-3arQi8VN3Tc@public.gmane.org>, Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "mihai.serban-3arQi8VN3Tc@public.gmane.org" <mihai.serban-3arQi8VN3Tc@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

SGkgTWFyaywNCg0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHNvY19lbnVtIGFrNDQ1OF9kYWNf
ZW51bVtdID0gew0KPiA+ICsvKjAqLwlTT0NfRU5VTV9TSU5HTEUoQUs0NDU4XzAxX0NPTlRST0wy
LCAxLA0KPiA+ICsJCQlBUlJBWV9TSVpFKGFrNDQ1OF9kZW1fc2VsZWN0X3RleHRzKSwNCj4gPiAr
CQkJYWs0NDU4X2RlbV9zZWxlY3RfdGV4dHMpLA0KPiA+ICsvKjEqLwlTT0NfRU5VTV9TSU5HTEUo
QUs0NDU4XzBBX0NPTlRST0w2LCAwLA0KPiBUaGUgZmFjdCB0aGF0IHlvdSBuZWVkIHRoZXNlIGNv
bW1lbnRzIGlzIHdoeSB0aGVzZSBhcnJheXMgYXJlIGEgYmFkDQo+IGlkZWENCj4gLSBqdXN0IHVz
ZSBpbmRpdmlkdWFsbHkgbmFtZWQgdmFyaWFibGVzIGFzIG90aGVyIGRyaXZlcnMgZG8uDQo+IA0K
PiA+IA0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgYWs0NDU4X3Nu
ZF9jb250cm9sc1tdID0gew0KPiA+ICsJU09DX1NJTkdMRV9UTFYoIkFLNDQ1OCBMMWNoIERpZ2l0
YWwgVm9sdW1lIiwNCj4gPiArCQnCoMKgwqDCoMKgwqDCoEFLNDQ1OF8wM19MQ0hBVFQsIDAvKnNo
aWZ0Ki8sIDB4RkYvKm1heA0KPiA+IHZhbHVlKi8sDQo+ID4gKwkJwqDCoMKgwqDCoMKgwqAwLypp
bnZlcnQqLywgbGF0dF90bHYpLA0KPiA+ICsJU09DX1NJTkdMRV9UTFYoIkFLNDQ1OCBSMWNoIERp
Z2l0YWwgVm9sdW1lIiwNCj4gPiArCQnCoMKgwqDCoMKgwqDCoEFLNDQ1OF8wNF9SQ0hBVFQsIDAs
IDB4RkYsIDAsIHJhdHRfdGx2KSwNCj4gSXQnZCBiZSBtb3JlIGlkaW9tYXRpYyB0byBjb21iaW5l
IHRoZXNlIGludG8gc3RlcmVvIHBhaXJzIHRoYW4gaGF2ZQ0KPiB0aGVtDQo+IGFzIHNpbmdsZSBj
aGFubmVsIGNvbnRyb2xzLg0KPiANCj4gPiANCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKiBjb25z
dCBhazQ0NThfZGFjX3NlbGVjdF90ZXh0c1tdID0geyAiT0ZGIiwNCj4gPiAiT04iIH07DQo+IFRo
aXMgbG9va3MgbGlrZSB0aGUgdXNlcnMgc2hvdWxkIGJlIHN3aXRjaCBjb250cm9scyAtIHdoYXQn
cyB0aGUgZ29hbA0KPiBoZXJlPw0KPiANCj4gPiANCg0KSSB0aGluayB0aGlzIGlzIHRvIGFsbG93
IHVzZXJzIHRvIHN3aXRjaCBvZmYgc291bmQgZm9yIGFsbCBjaGFubmVscyBidXQNCml0IHNlZW1z
IHNpbGx5IHRvIGhhdmUgNCBjb250cm9scyBkb2luZyB0aGUgc2FtZSB0aGluZy4NCldlIG5vdyBo
YXZlIHR3byBvcHRpb25zOg0KLSBvbmUgY29udHJvbCB0byBzd2l0Y2ggb2ZmIHNvdW5kIGZvciBh
bGwgY2hhbm5lbHMNCi0gb25lIGNvbnRyb2xsIHBlciBEQUMNCg0KV2hhdCBkbyB5b3UgbWVhbiBi
eSAidXNlcnMgc2hvdWxkIGJlIHN3aXRjaCBjb250cm9scyIgPw0KU2hvdWxkIHdlIHVzZSBTTkRf
U09DX0RBUE1fU1dJVENIIGluc3RlYWQgb2YgU05EX1NPQ19EQVBNX01VWD8NCg0KV2UgYXJlIHN0
aWxsIGxlYXJpbmcgdGhlIGlubmVyIGRldGFpbHMgb2YgQVNvQy4NClRoYW5rIHlvdSBmb3IgeW91
ciBoZWxwLg0KDQpDb3NtaW4=
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
