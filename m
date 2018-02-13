From: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [PATCH v3 1/2] ASoC: codecs: Add support for AK5558 ADC driver
Date: Tue, 13 Feb 2018 12:15:20 +0000
Message-ID: <1518524119.17642.15.camel@nxp.com>
References: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com>
         <1517850115-24340-2-git-send-email-daniel.baluta@nxp.com>
         <20180212120213.GB12976@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180212120213.GB12976-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Content-ID: <CDB44FFC22D9194A9A45C96998A96FBA-jdb/QiT5osKcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: dl-linux-imx <linux-imx-3arQi8VN3Tc@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cosmin Samoila <cosmin.samoila-3arQi8VN3Tc@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org" <wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, "andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "S.j. Wang" <shengjiu.wang-3arQi8VN3Tc@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "mihai.serban-3arQi8VN3Tc@public.gmane.org" <mihai.serban-3arQi8VN3Tc@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

T24gTHUsIDIwMTgtMDItMTIgYXQgMTI6MDIgKzAwMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+IE9u
IE1vbiwgRmViIDA1LCAyMDE4IGF0IDA3OjAxOjU0UE0gKzAyMDAsIERhbmllbCBCYWx1dGEgd3Jv
dGU6DQo+ID4gDQo+ID4gQUs1NTU4IGlzIGEgMzItYml0LCA3Njgga0haIHNhbXBsaW5nLCBkaWZm
ZXJlbnRpYWwgaW5wdXQgQURDDQo+ID4gZm9yIGRpZ2l0YWwgYXVkaW8gc3lzdGVtcy4NCj4gPiAN
Cj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvc291bmQvc29jL2NvZGVjcy9hazU1NTguYw0K
PiA+IEBAIC0wLDAgKzEsNjE4IEBADQo+ID4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wICovDQo+ID4gKy8qDQo+ID4gKyAqIEF1ZGlvIGRyaXZlciBmb3IgQUs1NTU4IEFEQw0K
PiBQbGVhc2UgZG9uJ3QgbWl4IEMrKyBhbmQgQyBzdHlsZSBjb21tZW50cyAtIGp1c3QgbWFrZSB0
aGUgZW50aXJlIGNvbW1lbnQNCj4gQysrLg0KPiANClN1cmUuIFdpbGwgdXNlOg0KLy8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCg0KPiA+IA0KPiA+ICtzdGF0aWMgY29uc3QgY2hh
ciAqIGNvbnN0IHRkbV90ZXh0c1tdID0gew0KPiA+ICsJIk9mZiIsICJURE0xMjgiLMKgwqAiVERN
MjU2IiwgIlRETTUxMiIsDQo+ID4gK307DQo+IFRoaXMgbG9va3MgbGlrZSBpdCBzaG91bGQgYmUg
YSBzZXRfdGRtX3Nsb3QoKSBvcGVyYXRpb24sIGFuZCBpbmRlZWQNCj4gc2V0X3RkbV9zbG90KCkg
YXBwZWFycyB0byBiZSBpbXBsZW1lbnRlZCBhbmQgZHVwbGljYXRlIHRoaXMuDQo+IA0KDQpZdXAs
IHdpbGwgcmVtb3ZlIHRoaXMuIEF0IGZpcnN0IHRoZXJlIHdhcyBubyBzZXRfdGRtX3Nsb3QuDQo+
ID4gDQo+ID4gK3N0YXRpYyBjb25zdCBjaGFyICogY29uc3QgZHNkb25fdGV4dHNbXSA9IHsNCj4g
PiArCSJQQ00iLCAiRFNEIiwNCj4gPiArfTsNCj4gVGhpcyBsb29rcyBsaWtlIGl0J3Mgc2V0dGlu
ZyB0aGUgREFJIGZvcm1hdD8NCg0KRGl0dG8uIFdpbGwgcmVtb3ZlLg0KDQo+IA0KPiA+IA0KPiA+
ICsJU05EX1NPQ19EQVBNX01VWCgiQUs1NTU4IENoMSBFbmFibGUiLCBTTkRfU09DX05PUE0sIDAs
IDAsDQo+ID4gKwkJCcKgJmFrNTU1OF9jaGFubmVsMV9tdXhfY29udHJvbCksDQo+IE9uL29mZiBj
b250cm9scyBzaG91bGQgYmUgc3dpdGNoZXMgbm90IG11eGVzLCB0aG91Z2ggaWYgdGhpcyBpcyBq
dXN0DQo+IHNlbGVjdGluZyB3aGljaCBjaGFubmVscyBhcmUgYWN0aXZlIChyYXRoZXIgdGhhbiBh
IG11dGUpIEknZCBub3QgZXhwZWN0DQo+IGl0IHRvIGJlIGEgY29udHJvbCBhdCBhbGwgLSB0aGUg
Ym9hcmQgY2FuIHNheSBpZiBpbnB1dHMgYXJlIGRpc2FibGVkLg0KDQpPSywgYWdyZWUgdGhhdCBp
ZiB3ZSB3YW50IHRvIGhhdmUgYSB3YXkgdG8gc2VsZWN0IHdoaWNoIGNoYW5uZWxzIGFyZSBhY3Rp
dmUNCndlIHNob3VsZCB1c2UgYSBzd2l0Y2guDQoNCldpbGwgcmVtb3ZlIHRoaXMgY29udHJvbCBm
b3Igbm93Lg0KDQo+IA0KPiA+IA0KPiA+ICtzdGF0aWMgaW50IGFrNTU1OF9zZXRfbWNraShzdHJ1
Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMsIGludCBmcywgaW50IHJjbGspDQo+ID4gK3sNCj4gPiAr
CXU4wqDCoG1vZGU7DQo+ID4gKw0KPiA+ICsJbW9kZSA9IHNuZF9zb2NfcmVhZChjb2RlYywgQUs1
NTU4XzAyX0NPTlRST0wxKTsNCj4gPiArCW1vZGUgJj0gfkFLNTU1OF9DS1M7DQo+ID4gKwltb2Rl
IHw9IEFLNTU1OF9DS1NfQVVUTzsNCj4gPiArDQo+ID4gKwlzbmRfc29jX3VwZGF0ZV9iaXRzKGNv
ZGVjLCBBSzU1NThfMDJfQ09OVFJPTDEsIEFLNTU1OF9DS1MsIG1vZGUpOw0KPiA+ICsNCj4gPiAr
CXJldHVybiAwOw0KPiA+ICt9DQo+IFRoaXMgYXBwZWFycyB0byBqdXN0IGlnbm9yZSB0aGUgcGFy
YW1ldGVycz8NCg0KVGhlc2UgYXJlIGxlZnQgb3ZlcnMgZnJvbSBhIHYxIGNsZWFudXAuIFdpbGwg
Zml4Lg0KDQoNCnRoYW5rcyBNYXJrISBXaWxsIHNlbmQgdjQgYXNhcC4NCg0KdGhhbmtzLA0KRGFu
aWVsLg==
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
