From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 1/2] ASoC: da7213: Delete an error message
 for a failed memory allocation in da7213_fw_to_pdata()
Date: Fri, 24 Nov 2017 11:43:09 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1B11A1@SW-EX-MBX01.diasemi.com>
References: <babe2503-46f1-2e1e-b482-62cd3e89f246@users.sourceforge.net>
 <6dc71b14-4c14-82f6-9dad-92bfa9854de2@users.sourceforge.net>
 <2E89032DDAA8B9408CB92943514A0337014C1B116F@SW-EX-MBX01.diasemi.com>
 <alpine.DEB.2.20.1711241231560.3316@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 01BC7266E3A
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 12:43:13 +0100 (CET)
In-Reply-To: <alpine.DEB.2.20.1711241231560.3316@hadrien>
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
To: Julia Lawall <julia.lawall@lip6.fr>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, SF Markus Elfring <elfring@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

T24gMjQgTm92ZW1iZXIgMjAxNyAxMTozMywgSnVsaWEgTGF3YWxsIHdyb3RlOg0KDQo+IE9uIEZy
aSwgMjQgTm92IDIwMTcsIEFkYW0gVGhvbXNvbiB3cm90ZToNCj4gDQo+ID4gT24gMjMgTm92ZW1i
ZXIgMjAxNyAxNzozMywgU0YgTWFya3VzIEVsZnJpbmcgd3JvdGU6DQo+ID4NCj4gPiA+IEZyb206
IE1hcmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4NCj4gPiA+IERh
dGU6IFRodSwgMjMgTm92IDIwMTcgMTc6NTY6NTQgKzAxMDANCj4gPiA+DQo+ID4gPiBPbWl0IGFu
IGV4dHJhIG1lc3NhZ2UgZm9yIGEgbWVtb3J5IGFsbG9jYXRpb24gZmFpbHVyZSBpbiB0aGlzIGZ1
bmN0aW9uLg0KPiA+DQo+ID4gSSdtIG5vdCBzdXJlIHRoaXMgaXMgYW4gZXh0cmEgbWVzc2FnZS4g
V2UgZG9uJ3QgcmV0dXJuIC1FTk9NRU0gYXMgYSByZXN1bHQgb2YNCj4gPiB0aGlzIG9wZXJhdGlv
biBhbmQgcHJvYmUgd29uJ3QgZmFpbCBvbiB0aGlzLiBTbyBkb2VzIGRldm1fa3phbGxvYygpIHBy
aW50IGVycm9yDQo+ID4gbWVzc2FnZXM/DQo+IA0KPiBVbmxlc3MgdGhlcmUgaXMgTk8gV0FSTiwg
YSBiYWNrdHJhY2Ugd2lsbCBiZSBnZW5lcmF0ZWQgaW4gdGhlIG91dCBvZg0KPiBtZW1vcnkgY2Fz
ZS4NCj4gDQo+IGp1bGlhDQoNCk9rLCBmYWlyIGVub3VnaC4gSW4gd2hpY2ggY2FzZToNCg0KQWNr
ZWQtYnk6IEFkYW0gVGhvbXNvbiA8QWRhbS5UaG9tc29uLk9wZW5zb3VyY2VAZGlhc2VtaS5jb20+
DQoNCj4gDQo+ID4NCj4gPiA+IFRoaXMgaXNzdWUgd2FzIGRldGVjdGVkIGJ5IHVzaW5nIHRoZSBD
b2NjaW5lbGxlIHNvZnR3YXJlLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBF
bGZyaW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4NCj4gPiA+IC0tLQ0KPiA+ID4g
IHNvdW5kL3NvYy9jb2RlY3MvZGE3MjEzLmMgfCA0ICstLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdp
dCBhL3NvdW5kL3NvYy9jb2RlY3MvZGE3MjEzLmMgYi9zb3VuZC9zb2MvY29kZWNzL2RhNzIxMy5j
DQo+ID4gPiBpbmRleCA0MWQ5YjFkYTI3YzIuLmQxYjc3YTBlM2I3NCAxMDA2NDQNCj4gPiA+IC0t
LSBhL3NvdW5kL3NvYy9jb2RlY3MvZGE3MjEzLmMNCj4gPiA+ICsrKyBiL3NvdW5kL3NvYy9jb2Rl
Y3MvZGE3MjEzLmMNCj4gPiA+IEBAIC0xNjU0LDEwICsxNjU0LDggQEAgc3RhdGljIHN0cnVjdCBk
YTcyMTNfcGxhdGZvcm1fZGF0YQ0KPiA+ID4gIAl1MzIgZndfdmFsMzI7DQo+ID4gPg0KPiA+ID4g
IAlwZGF0YSA9IGRldm1fa3phbGxvYyhjb2RlYy0+ZGV2LCBzaXplb2YoKnBkYXRhKSwgR0ZQX0tF
Uk5FTCk7DQo+ID4gPiAtCWlmICghcGRhdGEpIHsNCj4gPiA+IC0JCWRldl93YXJuKGNvZGVjLT5k
ZXYsICJGYWlsZWQgdG8gYWxsb2NhdGUgbWVtb3J5IGZvciBwZGF0YVxuIik7DQo+ID4gPiArCWlm
ICghcGRhdGEpDQo+ID4gPiAgCQlyZXR1cm4gTlVMTDsNCj4gPiA+IC0JfQ0KPiA+ID4NCj4gPiA+
ICAJaWYgKGRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJkbGcsbWljYmlhczEtbHZsIiwg
JmZ3X3ZhbDMyKSA+PSAwKQ0KPiA+ID4gIAkJcGRhdGEtPm1pY2JpYXMxX2x2bCA9IGRhNzIxM19v
Zl9taWNiaWFzX2x2bChjb2RlYywgZndfdmFsMzIpOw0KPiA+ID4gLS0NCj4gPiA+IDIuMTUuMA0K
PiA+IE4/Pz8/P3I/P3k/Pz8/Pz9YPz/Hp3Y/Pz8p3rp7Lm4/Pz8/P3o/3pY2Pz8/Pz8pPz8/Pz8q
wqwNCj4gamc/Pz8gPz8/Pz/domovPz8/ej/elj8/Pz/emT8/Pz8mPynfoT9hPz8/Pz8/P0c/Pz8/
PyA/Pzordj8/P3c/Pz8/DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
