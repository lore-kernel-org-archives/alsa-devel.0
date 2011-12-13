From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v2] ASoC: Tegra machine ASoC driver for
 boards using ALC5332 codec
Date: Tue, 13 Dec 2011 09:23:14 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1751860ABB@HQMAIL01.nvidia.com>
References: <1323719154-18344-1-git-send-email-leon@leon.nu>
	<74CDBE0F657A3D45AFBB94109FB122FF175186086F@HQMAIL01.nvidia.com>
	<CALq1K=Kna7wdqcJ0cPV1bvurUqYfE9zcQ+ZxZEG1YompsqP3nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E68D103B30
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 18:23:24 +0100 (CET)
In-Reply-To: <CALq1K=Kna7wdqcJ0cPV1bvurUqYfE9zcQ+ZxZEG1YompsqP3nQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

TGVvbiBSb21hbm92c2t5IHdyb3RlIGF0IE1vbmRheSwgRGVjZW1iZXIgMTIsIDIwMTEgMTE6MzYg
UE06DQo+IE9uIE1vbiwgRGVjIDEyLCAyMDExIGF0IDIyOjIwLCBTdGVwaGVuIFdhcnJlbiA8c3dh
cnJlbkBudmlkaWEuY29tPiB3cm90ZToNCj4gPiBMZW9uIFJvbWFub3Zza3kgd3JvdGUgYXQgTW9u
ZGF5LCBEZWNlbWJlciAxMiwgMjAxMSAxMjo0NiBQTToNCj4gPj4gQXQgdGhpcyBzdGFnZSBvbmx5
IFRvc2hpYmEgQUMxMDAvRHluYWJvb2sgc3VwcG9ydGVkLg0KLi4uDQo+ID4+ICtzdGF0aWMgc3Ry
dWN0IHNuZF9zb2NfamFja19ncGlvIHRlZ3JhX2FsYzU2MzJfaHNfamFja19ncGlvID0gew0KPiA+
PiArIMKgIMKgIC5uYW1lID0gIkhlYWRzZXQgRGV0ZWN0IiwNCj4gPj4gKyDCoCDCoCAucmVwb3J0
ID0gU05EX0pBQ0tfSEVBRFNFVCwNCj4gPj4gKyDCoCDCoCAuZGVib3VuY2VfdGltZSA9IDE1MCwN
Cj4gPj4gK307DQo+ID4gLi4uDQo+ID4+ICtzdGF0aWMgaW50IHRlZ3JhX2FsYzU2MzJfYXNvY19p
bml0KHN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lICpydGQpDQo+ID4+ICt7DQo+ID4gLi4uDQo+
ID4+ICsgwqAgwqAgc25kX3NvY19qYWNrX2FkZF9ncGlvcygmdGVncmFfYWxjNTYzMl9oc19qYWNr
LA0KPiA+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDEsICZ0ZWdyYV9hbGM1NjMy
X2hzX2phY2tfZ3Bpbyk7DQo+ID4NCj4gPiBTaW5jZSB0ZWdyYV9hbGM1NjMyX2hzX2phY2tfZ3Bp
byBpcyBuZXZlciBzZXQsIGRvZXNuJ3QgdGhpcyBlbmQgdXAgdXNpbmcNCj4gPiBHUElPIDAgYXMg
dGhlIGhlYWRzZXQgZGV0ZWN0LCB3aGljaCBtb3N0IGxpa2VseSBpcyBzb21ldGhpbmcgY29tcGxl
dGVseQ0KPiA+IHVucmVsYXRlZCB0byBhdWRpby4NCj4NCj4gVGhpcyBpcyBpbml0aWFsIHN1cHBv
cnQgb2YgYm9hcmQgZmlsZSwgYXQgdGhlIGNvbWluZyBwYXRjaCBzZXQsIEknbGwNCj4gdXBkYXRl
IGJvYXJkLXBhejAwLXBpbm11eC5jIFsxXSB3aXRoIGF1ZGlvIHJlbGF0ZWQgcGlucyBhbmQgSSds
bCBhZGQNCj4gcGxhdGZvcm0gZGV2aWNlIHN1cHBvcnQuDQo+IEkgdGhpbmsgSXQgaXMgZWFzeSBm
b3IgcmV2aWV3IGluIHRoaXMgd2F5Lg0KDQpJJ20gZmluZSBhZGRpbmcgdGhlIGZlYXR1cmUgbGF0
ZXIuIEJ1dCwgSSB0aGluayB5b3Ugc2hvdWxkbid0IGNhbGwgDQpzbmRfc29jX2phY2tfYWRkX2dw
aW9zKCkgdW50aWwgdGhlIHBsYXRmb3JtIGRhdGEgaXMgdGhlcmUsIG9yIHlvdSdsbA0KZW5kIHVw
IGVuYWJsaW5nIHRoZSBmZWF0dXJlIGFscmVhZHksIGJ1dCB1c2luZyB0aGUgd3JvbmcgR1BJTy4N
Cg0KLS0gDQpudnB1YmxpYw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVj
dC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fs
c2EtZGV2ZWwK
