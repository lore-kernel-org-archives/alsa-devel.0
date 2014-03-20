From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH v2 16/16] ASoC: fsl-ssi: Use regmap
Date: Thu, 20 Mar 2014 06:07:31 +0000
Message-ID: <5b62326226b54b1da0addf839cbcd104@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-17-git-send-email-mpa@pengutronix.de>
 <1394894616.578942243@f331.i.mail.ru> <20140318081019.GJ11360@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn14138.inbound.protection.outlook.com [207.46.163.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B05E2651FD
 for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2014 07:07:35 +0100 (CET)
In-Reply-To: <20140318081019.GJ11360@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTYvMTZdIEFTb0M6IGZzbC1zc2k6IFVzZSByZWdt
YXANCj4gDQo+IE9uIFNhdCwgTWFyIDE1LCAyMDE0IGF0IDA2OjQzOjM2UE0gKzA0MDAsIEFsZXhh
bmRlciBTaGl5YW4gd3JvdGU6DQo+ID4g0KHRg9Cx0LHQvtGC0LAsIDE1INC80LDRgNGC0LAgMjAx
NCwgMTM6NDQgKzAxOjAwINC+0YIgTWFya3VzIFBhcmdtYW5uIDxtcGFAcGVuZ3V0cm9uaXguZGU+
Og0KPiA+ID4gVGhpcyBwYXRjaCByZXBsYWNlcyB0aGUgc3NpIHNwZWNpZmljIGZ1bmN0aW9ucyB3
cml0ZV9zc2ksIHJlYWRfc3NpIGFuZA0KPiA+ID4gd3JpdGVfc3NpX21hc2sgYnkgc3RhbmRhcmQg
cmVnbWFwIGZ1bmN0aW9uIGNhbGxzLg0KPiA+IC4uLg0KPiA+ID4gZGlmZiAtLWdpdCBhL3NvdW5k
L3NvYy9mc2wvZnNsX3NzaS5jIGIvc291bmQvc29jL2ZzbC9mc2xfc3NpLmMNCj4gPiAuLi4NCj4g
PiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ21hcF9jb25maWcgZnNsX3NzaV9yZWdjb25maWcg
PSB7DQo+ID4gPiArCS5tYXhfcmVnaXN0ZXIgPSBDQ1NSX1NTSV9TQUNDRElTLA0KPiA+ID4gKwku
cmVnX2JpdHMgPSAzMiwNCj4gPiA+ICsJLnZhbF9iaXRzID0gMzIsDQo+ID4gPiArCS5yZWdfc3Ry
aWRlID0gNCwNCj4gPiA+ICsjaWZkZWYgUFBDDQo+ID4gPiArCS52YWxfZm9ybWF0X2VuZGlhbiA9
IFJFR01BUF9FTkRJQU5fQklHLA0KPiA+ID4gKyNlbmRpZg0KPiA+ID4gK307DQo+ID4NCj4gPiBX
aHkgd2UgY2Fubm90IHVzZSBSRUdNQVBfRU5ESUFOX05BVElWRSBoZXJlIGZvciBhbGwgY2FzZXM/
DQo+ID4gVGhlb3JldGljYWxseSwgd2UgY2FuIHVzZSBmb3IgaS5NWCBTT0NzIHdpdGggZGlmZmVy
ZW50IGVuZGlhbm5lc3MsDQo+ID4gc28gdGhpcyB3aWxsIGhlbHAgdXMuDQo+IA0KPiBJIGNhbiBj
aGFuZ2UgYW5kIHRlc3QgaXQgb24gaS5NWCwgYnV0IEkgYW0gbm90IHN1cmUgaWYgaXQgaGVscHMg
d2l0aCB0aGUNCj4gUFBDIHNpdHVhdGlvbiBhcyBJIGRvbid0IGhhdmUgdGhlIGhhcmR3YXJlLg0K
PiANCg0KRm9yIHRoZSBzY2VuYXJpbyBvZiBQb3dlclBDKGZvciBDUFUgYW5kIGRldmljZXMgbW9z
dGx5IGFyZSBpbiBCRSBtb2RlKToNCkNQVQkJU1NJDQpCRQkJQkUJd2UgY2FuIGp1c3QgdXNlIHRo
ZSBSRUdNQVBfRU5ESUFOX05BVElWRSBoZXJlLg0KDQpGb3IgdGhlIHNjZW5hcmlvIG9mIEFSTShm
b3IgQ1BVIGFuZCBkZXZpY2VzIG1vc3RseSBhcmUgaW4gTEUgbW9kZSk6DQpDUFUJCVNTSQ0KTEUJ
CUxFCXdlIGNhbiBhbHNvIGp1c3QgdXNlIHRoZSBSRUdNQVBfRU5ESUFOX05BVElWRSBoZXJlLg0K
DQpXaGlsZSBmb3IgdGhlIHNjZW5hcmlvIGxpa2Ugb3VyIExTMShBUk0pIHBsYXRmb3JtLg0KQ1BV
CQlTU0kNCkxFCQlCRQl0aGVuIHNob3VsZCB3ZSBzZXQgdGhlIC52YWxfZm9ybWF0X2VuZGlhbiB0
bw0KCQkJUkVHTUFQX0VORElBTl9CSUcNCg0KDQpBbmQgc28gbm90IG9ubHkgZm9yIFBvd2VyUEMs
IGJ1dCBhbHNvIG1heWJlIGZvciBBUk0gcGxhdGZvcm1zLg0KU28gaGVyZSBob3cgYWJvdXQganVz
dCBhZGRpbmcgb25lIEJvb2xlYW4gcHJvcGVydHkgbGlrZSAnYmlnLWVuZGlhbicgaW4gRFQgbm9k
ZQ0KdG8gbGVhcm4gdGhlIGVuZGlhbm5lc3Mgb2YgdGhlIGRldmljZXMgZHluYW1pY2FsbHkgPyAg
DQoNClRoYW5rcywNCjopDQoNCkJlc3QgUmVnYXJkcywNClhpdWJvDQoNCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
