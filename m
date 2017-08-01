From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: Question about soc_bind_dai_link()
Date: Tue, 1 Aug 2017 08:54:25 +0000
Message-ID: <1501577664.5647.25.camel@nxp.com>
References: <87k22nyelk.wl%kuninori.morimoto.gx@renesas.com>
 <1501576394.5647.21.camel@nxp.com>
 <87bmnzy92z.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0071.outbound.protection.outlook.com [104.47.0.71])
 by alsa0.perex.cz (Postfix) with ESMTP id C427C266847
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 10:54:27 +0200 (CEST)
In-Reply-To: <87bmnzy92z.wl%kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <F1C81EFB857AAB4AB6D8714A09A519EE@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

T24gTWEsIDIwMTctMDgtMDEgYXQgMDg6NDcgKzAwMDAsIEt1bmlub3JpIE1vcmltb3RvIHdyb3Rl
Og0KPiBIaQ0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gc3RhdGljIGludCBzb2NfYmluZF9kYWlf
bGluayhzdHJ1Y3Qgc25kX3NvY19jYXJkICpjYXJkLA0KPiA+ID4gCXN0cnVjdCBzbmRfc29jX2Rh
aV9saW5rICpkYWlfbGluaykNCj4gPiA+IHsNCj4gPiA+IAkuLi4NCj4gPiA+IAkvKiBmaW5kIG9u
ZSBmcm9tIHRoZSBzZXQgb2YgcmVnaXN0ZXJlZCBwbGF0Zm9ybXMgKi8NCj4gPiA+IAlsaXN0X2Zv
cl9lYWNoX2VudHJ5KHBsYXRmb3JtLCAmcGxhdGZvcm1fbGlzdCwgbGlzdCkgew0KPiA+ID4gCQlw
bGF0Zm9ybV9vZl9ub2RlID0gcGxhdGZvcm0tPmRldi0+b2Zfbm9kZTsNCj4gPiA+IAkJaWYgKCFw
bGF0Zm9ybV9vZl9ub2RlICYmIHBsYXRmb3JtLT5kZXYtPnBhcmVudC0+b2Zfbm9kZSkNCj4gPiA+
IAkJCXBsYXRmb3JtX29mX25vZGUgPSBwbGF0Zm9ybS0+ZGV2LT5wYXJlbnQtPm9mX25vZGU7DQo+
ID4gPiANCj4gPiA+IAkJaWYgKGRhaV9saW5rLT5wbGF0Zm9ybV9vZl9ub2RlKSB7DQo+ID4gPiAJ
CQlpZiAocGxhdGZvcm1fb2Zfbm9kZSAhPSBkYWlfbGluay0+cGxhdGZvcm1fb2Zfbm9kZSkNCj4g
PiA+IAkJCQljb250aW51ZTsNCj4gPiA+IAkJfSBlbHNlIHsNCj4gPiA+IAkJCWlmIChzdHJjbXAo
cGxhdGZvcm0tPmNvbXBvbmVudC5uYW1lLCBwbGF0Zm9ybV9uYW1lKSkNCj4gPiA+IAkJCQljb250
aW51ZTsNCj4gPiA+IAkJfQ0KPiA+ID4gDQo+ID4gPiA9PgkJcnRkLT5wbGF0Zm9ybSA9IHBsYXRm
b3JtOw0KPiA+ID4gwqANCj4gPiBUaGlzIGlzbid0IGFjdHVhbGx5IGEgYnVnIGJlY2F1c2UgeW91
IHJlYWNoIGhlcmUgb25seSBpZiB0aGUNCj4gPiBnaXZlbiBwbGF0Zm9ybSBpcyBmb3VuZC4NCj4g
VGhhbmtzLiBZZXMsIGFueSBjYXNlcyBpdCBpcyBub3QgYSBiaWcgZGVhbC4NCj4gSW4gbXkgY2Fz
ZXMgaXQgcmVhY2hlcyBoZXJlIG9ubHkgb25jZSwgYmVjYXVzZSBteSBzeXN0ZW0NCj4gcmVnaXN0
ZXJzIDEgcGxhdGZvcm0gb25seS4NCj4gSSBkb24ndCBrbm93IGRldGFpbCwgYnV0IHNvbWUgYm9h
cmQgaXMgcmVnaXN0ZXJpbmcgMiBwbGF0Zm9ybXMNCj4gKG93biBwbGF0Zm9ybSBhbmQgZG1hZW5n
aW5lID8pDQo+IEluIHN1Y2ggY2FzZSwgcnRkLT5wbGF0Zm9ybSB3YXMgb3Zlcndyb3RlID8NCg0K
Tm8sIGJlY2F1c2Ugd2Ugb25seSBkbyB0aGUgYXNzaWdubWVudCBydGQtPnBsYXRmb3JtID0gcGxh
dGZvcm0gaWYNCg0KcGxhdGZvcm1fb2Zfbm9kZSA9PSBkYWlfbGluay0+cGxhdGZvcm1fb2Zfbm9k
ZSBPUiBwbGF0Zm9ybS0+bmFtZSA9PSBwbGF0Zm9ybV9uYW1lLg0KDQpJbiBjYXNlIHdlIGFyZSBy
ZWdpc3RlcmluZyAyIHBsYXRmb3JtcyAobGlrZSB5b3Ugc2FpZDogb3duIHBsYXRmb3JtIGFuZCBk
bWFlbmdpbmUpDQp0aGV5IHdpbGwgYmUgaGF2aW5nIGRpZmZlcmVudCBuYW1lcy9vZl9ub2Rlcy4N
Cg0KPiBJdCBzZWVtcyBleGlzdGluZyBzdWNoIGJvYXJkIGlzIHdvcmtpbmcsIHRodXMgdGhpcyBp
cyBub3QgYSBiaWcgZGVhbC4NCj4gSnVzdCBxdWVzdGlvbg0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
