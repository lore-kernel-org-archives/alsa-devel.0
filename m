From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: Question about soc_bind_dai_link()
Date: Tue, 1 Aug 2017 08:33:15 +0000
Message-ID: <1501576394.5647.21.camel@nxp.com>
References: <87k22nyelk.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20089.outbound.protection.outlook.com [40.107.2.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DA9D266847
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 10:33:16 +0200 (CEST)
In-Reply-To: <87k22nyelk.wl%kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <6A3E32F49C17A54394F2B944D1C2DF19@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "lars@metafoo.de" <lars@metafoo.de>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

T24gTWEsIDIwMTctMDgtMDEgYXQgMDY6NDcgKzAwMDAsIEt1bmlub3JpIE1vcmltb3RvIHdyb3Rl
Og0KPiBIaSBBTFNBIE1MDQo+IA0KPiBJIG5vdGljZWQgYSBsaXR0bGUgYml0IHN0cmFuZ2Ugb3Bl
cmF0aW9uIG9uIHNvY19iaW5kX2RhaV9saW5rKCkuDQo+IFRvIHJlc2VhcmNoIHBsYXRmb3JtLCBp
dCBpcyB1c2luZyBsaXN0X2Zvcl9lYWNoX2VudHJ5KCkuDQo+IEFmdGVyIGZpbmRpbmcgcGxhdGZv
cm0sIGl0IHNldHMgcnRkLT5wbGF0Zm9ybSwgYnV0IGl0IGRvZXNuJ3QgdXNlICJicmVhayIuDQo+
IFRoaXMgbWVhbnMsIHJ0ZC0+cGxhdGZvcm0gbWlnaHQgYmUgb3Zlcndyb3RlLg0KPiBJcyB0aGlz
IG9uIHB1cnBvc2UgPyBvciBidWcgPw0KPiANCj4gc3RhdGljIGludCBzb2NfYmluZF9kYWlfbGlu
ayhzdHJ1Y3Qgc25kX3NvY19jYXJkICpjYXJkLA0KPiAJc3RydWN0IHNuZF9zb2NfZGFpX2xpbmsg
KmRhaV9saW5rKQ0KPiB7DQo+IAkuLi4NCj4gCS8qIGZpbmQgb25lIGZyb20gdGhlIHNldCBvZiBy
ZWdpc3RlcmVkIHBsYXRmb3JtcyAqLw0KPiAJbGlzdF9mb3JfZWFjaF9lbnRyeShwbGF0Zm9ybSwg
JnBsYXRmb3JtX2xpc3QsIGxpc3QpIHsNCj4gCQlwbGF0Zm9ybV9vZl9ub2RlID0gcGxhdGZvcm0t
PmRldi0+b2Zfbm9kZTsNCj4gCQlpZiAoIXBsYXRmb3JtX29mX25vZGUgJiYgcGxhdGZvcm0tPmRl
di0+cGFyZW50LT5vZl9ub2RlKQ0KPiAJCQlwbGF0Zm9ybV9vZl9ub2RlID0gcGxhdGZvcm0tPmRl
di0+cGFyZW50LT5vZl9ub2RlOw0KPiANCj4gCQlpZiAoZGFpX2xpbmstPnBsYXRmb3JtX29mX25v
ZGUpIHsNCj4gCQkJaWYgKHBsYXRmb3JtX29mX25vZGUgIT0gZGFpX2xpbmstPnBsYXRmb3JtX29m
X25vZGUpDQo+IAkJCQljb250aW51ZTsNCj4gCQl9IGVsc2Ugew0KPiAJCQlpZiAoc3RyY21wKHBs
YXRmb3JtLT5jb21wb25lbnQubmFtZSwgcGxhdGZvcm1fbmFtZSkpDQo+IAkJCQljb250aW51ZTsN
Cj4gCQl9DQo+IA0KPiA9PgkJcnRkLT5wbGF0Zm9ybSA9IHBsYXRmb3JtOw0KPsKgDQoNClRoaXMg
aXNuJ3QgYWN0dWFsbHkgYSBidWcgYmVjYXVzZSB5b3UgcmVhY2ggaGVyZSBvbmx5IGlmIHRoZQ0K
Z2l2ZW4gcGxhdGZvcm0gaXMgZm91bmQuDQoNCkFueWhvdywgaW4gdGhlIHBhc3QgdGhlIHVzZWQg
dG8gYmUgYSBnb3RvIGhlcmUuIFRoaW5ncyBoYXZlIGNoYW5nZWQgd2l0aA0KDQpjb21taXQgYjE5
ZTZlN2I3NjNjNzE0NGJmZTJjZWNjZjk4OGI2NGQ2NmQ2ZGQwYQ0KQXV0aG9yOiBNYXJrIEJyb3du
IDxicm9vbmllQG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT4NCkRhdGU6wqDCoMKgV2VkIE1h
ciAxNCAyMToxODozOSAyMDEyICswMDAwDQoNCsKgwqDCoMKgQVNvQzogY29yZTogVXNlIGRyaXZl
ciBjb3JlIHByb2JlIGRlZmVycmFsDQoNCnRoYW5rcywNCkRhbmllbC4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
