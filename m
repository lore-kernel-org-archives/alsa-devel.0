From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC
	driver
Date: Thu, 1 Feb 2018 09:05:55 +0000
Message-ID: <1517475954.8615.18.camel@nxp.com>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
 <CAHp75Vdd58U1y-LOQGg=rePOWf1LeQsZxn2ykzBhXL013ztW3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0069.outbound.protection.outlook.com [104.47.1.69])
 by alsa0.perex.cz (Postfix) with ESMTP id ECCF4267692
 for <alsa-devel@alsa-project.org>; Thu,  1 Feb 2018 10:05:59 +0100 (CET)
In-Reply-To: <CAHp75Vdd58U1y-LOQGg=rePOWf1LeQsZxn2ykzBhXL013ztW3Q@mail.gmail.com>
Content-Language: en-US
Content-ID: <DA9525180D80B24B8DCE8EB3B512EFEF@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>, "mihai.serban@nxp.com" <mihai.serban@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "mihai.serban@gmail.com" <mihai.serban@gmail.com>
List-Id: alsa-devel@alsa-project.org

SGkgRmFiaW8sIEFuZHksDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cy4gSSB3aWxs
IGFkZHJlc3MgdGhlbSBhbmQgc2VuZCB2Mi4NCg0KRmV3IGNvbW1lbnRzIGlubGluZS4NCg0KT24g
TWksIDIwMTgtMDEtMzEgYXQgMTg6MTIgKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4g
T24gV2VkLCBKYW4gMzEsIDIwMTggYXQgMjo1NyBQTSwgRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJh
bHV0YUBueHAuY29tPiB3cm90ZToNCj4gPiANCj4gPiBBSzU1NTggaXMgYSAzMi1iaXQsIDc2OCBr
SFogc2FtcGxpbmcsIGRpZmZlcmVudGlhbCBpbnB1dCBBREMNCj4gPiBmb3IgZGlnaXRhbCBhdWRp
byBzeXN0ZW1zLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEp1bmljaGkgV2FrYXN1Z2kgPHdh
a2FzdWdpLmpiQG9tLmFzYWhpLWthc2VpLmNvLmpwPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1paGFp
IFNlcmJhbiA8bWloYWkuc2VyYmFuQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hlbmdq
aXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhbmll
bCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCj4gNCBhdXRob3JzIG9mIHRoZSBjb2Rl
PyENCg0KVGhlIGNvZGUgaGFzIGEgdmVyeSBsb25nIGhpc3RvcnkuIEkgd2lsbCBhZGQgdW5kZXIg
ZWFjaCBTb0IgdGhlIHNwZWNpZmljDQpjb250cmlidXRpb24uDQoNCk1paGFpIGdvdCB0aGUgY29k
ZSBmcm9twqBKdW5pY2hpIGFuZCByZXdvcmtlZCBpdCBmb3IgNC45LiBUaGVuIFNoZW5naml1IGFu
ZA0KbWUgYWRkZWQgdmFyaW91c8KgZmVhdHVyZXMgYW5kIGNsZWFudXBzLg0KDQpBY2NvcmRpbmcg
dG8gRENPIFsxXSBhbGwgU29CIGFyZSB2YWxpZCBhbmQgcmVxdWlyZWQuDQoNCg0KPiA+ICtNT0RV
TEVfQVVUSE9SKCJKdW5pY2hpIFdha2FzdWdpIDx3YWthc3VnaS5qYkBvbS5hc2FoaS1rYXNlaS5j
by5qcD4iKTsNCj4gPiArTU9EVUxFX0FVVEhPUigiTWloYWkgU2VyYmFuIDxtaWhhaS5zZXJiYW5A
bnhwLmNvbT4iKTsNCj4gNCBTb0JzLCAyIEF1dGhvcnMuIFBsZWFzZSwgZml4IGFjY29yZGluZ2x5
Lg0KDQpIZXJlIEkgd291bGQgcHJlZmVyIHRvIGxpc3QgSnVuaWNoaSBhbmQgTWloYWkgYmVjYXVz
ZSB0aGV5IHdlcmUgdGhlIG1haW4gY29udHJpYnV0b3JzLg0KQW55IG90aGVyIHN1Z2dlc3Rpb24/
DQoNCnRoYW5rcywNCkRhbmllbC4NCg0KWzFdIFsxXcKgaHR0cHM6Ly9kZXZlbG9wZXJjZXJ0aWZp
Y2F0ZS5vcmcvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
