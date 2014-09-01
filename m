From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv2 1/2] ASoC: simple-card: Fix bug of forgetting decrement
 DT node's refcount
Date: Mon, 1 Sep 2014 06:52:26 +0000
Message-ID: <11d26ed010ad4cc9b90f44bff56340c3@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1409535327-11449-1-git-send-email-Li.Xiubo@freescale.com>
	<1409535327-11449-2-git-send-email-Li.Xiubo@freescale.com>
 <20140901083728.01454558@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140901083728.01454558@armhf>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "jsarha@ti.com" <jsarha@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

DQo+ID4gU2lnbmVkLW9mZi1ieTogWGl1Ym8gTGkgPExpLlhpdWJvQGZyZWVzY2FsZS5jb20+DQo+
ID4gLS0tDQo+ID4gIHNvdW5kL3NvYy9nZW5lcmljL3NpbXBsZS1jYXJkLmMgfCAxICsNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvc291
bmQvc29jL2dlbmVyaWMvc2ltcGxlLWNhcmQuYyBiL3NvdW5kL3NvYy9nZW5lcmljL3NpbXBsZS0N
Cj4gY2FyZC5jDQo+ID4gaW5kZXggZmQ4YjA0NS4uOWUxNzBmZSAxMDA2NDQNCj4gPiAtLS0gYS9z
b3VuZC9zb2MvZ2VuZXJpYy9zaW1wbGUtY2FyZC5jDQo+ID4gKysrIGIvc291bmQvc29jL2dlbmVy
aWMvc2ltcGxlLWNhcmQuYw0KPiA+IEBAIC0zNjAsNiArMzYwLDcgQEAgc3RhdGljIGludCBhc29j
X3NpbXBsZV9jYXJkX3BhcnNlX29mKHN0cnVjdCBkZXZpY2Vfbm9kZQ0KPiAqbm9kZSwNCj4gPiAg
CQkJfQ0KPiA+ICAJCQlpKys7DQo+ID4gIAkJfQ0KPiA+ICsJCW9mX25vZGVfcHV0KG5wKTsNCj4g
PiAgCX0gZWxzZSB7DQo+ID4gIAkJcmV0ID0gYXNvY19zaW1wbGVfY2FyZF9kYWlfbGlua19vZihu
b2RlLCBkZXYsDQo+ID4gIAkJCQkJCSAgIGRhaV9saW5rLCBkYWlfcHJvcHMsIHRydWUpOw0KPiAN
Cj4gTm8uIG5wIGlzIE5VTEwgYXQgZW5kIG9mIGxvb3AuDQo+IA0KDQpXZWxsLCB5ZXMsIHlvdSBh
cmUgcmlnaHQuDQoNClRoYW5rcywNCg0KQlJzDQpYaXVibw0KDQo=
