From: Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK4458 DAC
	driver
Date: Tue, 13 Feb 2018 09:22:24 +0000
Message-ID: <1518513744.25655.8.camel@nxp.com>
References: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
 <20180131170330.GB7763@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0046.outbound.protection.outlook.com [104.47.2.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 96F14266E42
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 10:22:27 +0100 (CET)
In-Reply-To: <20180131170330.GB7763@sirena.org.uk>
Content-Language: en-US
Content-ID: <EEEC3802193D804DA3A698232AF5AA61@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>, dl-linux-imx <linux-imx@nxp.com>, "mihai.serban@nxp.com" <mihai.serban@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, "mihai.serban@gmail.com" <mihai.serban@gmail.com>
List-Id: alsa-devel@alsa-project.org

SGkgTWFyaywNCg0KPiA+IA0KPiA+ICtzdGF0aWMgaW50IGFrNDQ1OF9od19wYXJhbXMoc3RydWN0
IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sDQo+ID4gKwkJCcKgwqDCoMKgc3RydWN0IHNu
ZF9wY21faHdfcGFyYW1zICpwYXJhbXMsDQo+ID4gKwkJCcKgwqDCoMKgc3RydWN0IHNuZF9zb2Nf
ZGFpICpkYWkpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYyA9IGRh
aS0+Y29kZWM7DQo+ID4gKwlzdHJ1Y3QgYWs0NDU4X3ByaXYgKmFrNDQ1OCA9DQo+ID4gc25kX3Nv
Y19jb2RlY19nZXRfZHJ2ZGF0YShjb2RlYyk7DQo+ID4gKwl1OCBmb3JtYXQ7DQo+ID4gKwlpbnQg
cGNtX3dpZHRoID0gbWF4KHBhcmFtc19waHlzaWNhbF93aWR0aChwYXJhbXMpLCBhazQ0NTgtDQo+
ID4gPnNsb3Rfd2lkdGgpOw0KPiA+ICsNCj4gPiArI2lmZGVmIEFLNDQ1OF9BQ0tTX1VTRV9NQU5V
QUxfTU9ERQ0KPiA+ICsJdTggZGZzMSwgZGZzMjsNCj4gPiArI2VuZGlmDQo+IFdoYXQncyB0aGlz
IGFuZCB3aHkgaXMgaXQgYSBjb21waWxlIHRpbWUgb3B0aW9uPw0KDQpUaGlzIGlzIHVzZWQgdG8g
c2V0IHRoZSBjb2RlYyBpbiBNYW51YWwgU2V0dGluZyBNb2RlLCBtZWFuaW5nIHRoYXQNCnRoZSBk
ZWZhdWx0IHNhbXBsaW5nIHNwZWVkIGlzIHNldCBiYXNlZCBvbiBERlMwIGFuZCBERlMxIGJpdHMu
IEluDQpBdXRvIFNldHRpbmcgTW9kZSwgdGhlIE1DTEsgZnJlcXVlbmN5IGlzIGRldGVjdGVkIGF1
dG9tYXRpY2FsbHkgYW5kDQpERlMgYml0cyBhcmUgaWdub3JlZC4NClRoaXMgY29tcGlsZSB0aW1l
IG9wdGlvbiBpcyB1c2VkIHRvIGtub3cgd2hlbiB0byBzZXQgdGhlIEFDS1MgYml0IGluDQppbml0
X3JlZyBmdW5jdGlvbiB0aGF0IHN3aXRjaGVzIGJldHdlZW4gbW9kZXMuDQpBdCB0aGlzIG1vbWVu
dCB3ZSBhcmUgb25seSB1c2luZyBBdXRvIE1vZGUgYW5kIEkgY2FuIHJlbW92ZSBpdCBpZg0KeW91
IHRoaW5rIGlzIG5vdCBuZWNlc3NhcnkuDQoNClRoYW5rIHlvdSwNCkNvc21pbgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
