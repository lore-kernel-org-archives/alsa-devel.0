From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v4 1/2] ASoC: codecs: Add support for AK5558 ADC driver
Date: Fri, 16 Feb 2018 12:28:21 +0000
Message-ID: <1518784101.9517.21.camel@nxp.com>
References: <1518532174-11350-1-git-send-email-daniel.baluta@nxp.com>
         <1518532174-11350-2-git-send-email-daniel.baluta@nxp.com>
         <20180216121445.GH5886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180216121445.GH5886@sirena.org.uk>
Content-Language: en-US
Content-ID: <E59F09E99505474789D8B931C8BFEA55@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "pombredanne@nexb.com" <pombredanne@nexb.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin Samoila <cosmin.samoila@nxp.com>, "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "mihai.serban@gmail.com" <mihai.serban@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mihai.serban@nxp.com" <mihai.serban@nxp.com>
List-Id: alsa-devel@alsa-project.org

T24gVmksIDIwMTgtMDItMTYgYXQgMTI6MTQgKzAwMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+IE9u
IFR1ZSwgRmViIDEzLCAyMDE4IGF0IDA0OjI5OjMzUE0gKzAyMDAsIERhbmllbCBCYWx1dGEgd3Jv
dGU6DQo+IA0KPiA+IA0KPiA+ICsrKyBiL3NvdW5kL3NvYy9jb2RlY3MvYWs1NTU4LmMNCj4gPiBA
QCAtMCwwICsxLDQxNyBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MA0KPiA+ICsvKg0KPiBKdXN0IG1ha2UgdGhpcyBhIEMrKyBjb21tbWVudCwgZG9uJ3QgbWl4IEMg
YW5kIEMrKyAtIGl0IGxvb2tzIG5lYXRlci4NCj4gT3RoZXJ3aXNlIHRoaXMgbG9va3MgZ29vZCBz
byBJJ2xsIGFwcGx5LCBwbGVhc2Ugc2VuZCBhIGZvbGxvd3VwIHBhdGNoDQo+IGZvciB0aGUgYWJv
dmUuDQoNCkhpIE1hcmssDQoNCldpbGwgc2VuZCBhIHNlcGFyYXRlIHBhdGNoIHRvIGZpeCB0aGlz
Lg0KDQpBbnlob3csIGxldHMgbWFrZSBzdXJlIHRoYXQgSSBnb3QgaXQgcmlnaHQgYmVjYXVzZSBs
b29raW5nIGludG8NCnNvdW5kL3NvYy9jb2RlY3MgSSBjYW4gc2VlIGEgbWl4ZXMgb2Ygc3R5bGVz
Lg0KDQpTbywgZm9yIGFrNTU1OC5jIHRoZSBjb3JyZWN0IGNvZGUgc2hvdWxkIGJlOg0KDQovLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KLy8NCi8vIEF1ZGlvIGRyaXZlciBmb3Ig
QUs1NTU4IEFEQw0KLy8NCi8vIENvcHlyaWdodCAoQykgMjAxNSBBc2FoaSBLYXNlaSBNaWNyb2Rl
dmljZXMgQ29ycG9yYXRpb24NCi8vIENvcHlyaWdodCAyMDE4IE5YUA0KLy8NCg0KTm93LCBmb3Ig
dGhlIC5oIHRoZXJlIGlzIGEgdG90YWwgZGlmZmVyZW50IHN0b3J5LiBBcyBwZXLCoFBoaWxpcHBl
J3MNCmxpbmsgdG8gZG9jdW1lbnRhdGlvbiBbMV0NCg0KdGhlIC5oIGZpbGUgc2hvdWxkIHN0YXJ0
IHdpdGg6DQoNCkMgaGVhZGVyOgkvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogPFNQRFggTGlj
ZW5zZSBFeHByZXNzaW9uPiAqLw0KDQpTbywgaXMgdGhlIGhlYWRlciBhazU1NTguaCBsb29raW5n
IGxpa2UgdGhpcywgYWxsIHJpZ2h0Pw0KDQoNCi8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wICovDQovKg0KwqAqIEF1ZGlvIGRyaXZlciBoZWFkZXIgZm9yIEFLNTU1OA0KwqAqDQrC
oCogQ29weXJpZ2h0IChDKSAyMDE2IEFzYWhpIEthc2VpIE1pY3JvZGV2aWNlcyBDb3Jwb3JhdGlv
bg0KwqAqIENvcHlyaWdodCAyMDE4IE5YUA0KwqAqLw0KDQpBcmUgeW91IHdpbGxpbmcgdG8gdGFr
ZSBwYXRjaGVzIGZpeGluZyB0aGUgU1BEWCBpZGVudGlmaWVyIGZvciB0aGUgcmVzdCBvZiB0aGUg
Y29kZWNzIGluIHNvdW5jL3NvYy9jb2RlY3M/DQoNCkkndmUgZ290IGEgYnVuY2ggb2Ygc3R1ZGVu
dHMgbG9va2luZyBmb3IgY2xlYW51cCBwYXRjaGVzIGluIHRoZWlyIGFwcGxpY2F0aW9uIGZvciBH
b29nbGUgU3VtbWVyIG9mIENvZGUgOikuDQoNCnRoYW5rcywNCkRhbmllbC4NCg0KWzFdaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXgu
Z2l0L3RyZWUvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2xpY2Vuc2UtcnVsZXMucnN0I242Nw0KDQoN
Cg0K
