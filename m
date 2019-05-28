From: Eran Ben Elisha <eranbe@mellanox.com>
Subject: Re: [PATCH 5/5] [RFC] devlink: Fix uninitialized error code in
 devlink_fmsg_prepare_skb()
Date: Tue, 28 May 2019 14:40:08 +0000
Message-ID: <0f92eb11-20b5-c50b-1577-d3896f28c73b@mellanox.com>
References: <20190528142424.19626-1-geert@linux-m68k.org>
 <20190528142424.19626-6-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528142424.19626-6-geert@linux-m68k.org>
Content-Language: en-US
Content-ID: <CEDEDE15ABD92A47A1D0AAA6F6441A4F@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Igor Konopko <igor.j.konopko@intel.com>, David Howells <dhowells@redhat.com>, "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Matias Bjorling <mb@lightnvm.io>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

DQoNCk9uIDUvMjgvMjAxOSA1OjI0IFBNLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+IFdp
dGggZ2NjIDQuMToNCj4gDQo+ICAgICAgbmV0L2NvcmUvZGV2bGluay5jOiBJbiBmdW5jdGlvbiDi
gJhkZXZsaW5rX2Ztc2dfcHJlcGFyZV9za2LigJk6DQo+ICAgICAgbmV0L2NvcmUvZGV2bGluay5j
OjQzMjU6IHdhcm5pbmc6IOKAmGVycuKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRo
aXMgZnVuY3Rpb24NCj4gDQo+IEluZGVlZCwgaWYgdGhlIGxpc3QgaGFzIGxlc3MgdGhhbiAqc3Rh
cnQgZW50cmllcywgYW4gdW5pbml0aWFsaXplZCBlcnJvcg0KPiBjb2RlIHdpbGwgYmUgcmV0dXJu
ZWQuDQoNClRoZSBsb2dpYyBndWFyYW50ZWVzIHRoYXQgc3RhcnQgaXMgc21hbGxlciB0aGFuIHRo
ZSBsZW5ndGggb2YgdGhlIGxpc3QuDQpidXQgSSBndWVzcyB0aGF0IHRoZSBjb21waWxlciBjYW4n
dCBkZXRlY3QgdGhhdC4NCg0KUmV2aWV3ZWQtYnk6IEVyYW4gQmVuIEVsaXNoYSA8ZXJhbmJlQG1l
bGxhbm94LmNvbT4NCg0KPiANCj4gRml4IHRoaXMgYnkgcHJlaW5pdGlhbGl6aW5nIGVyciB0byB6
ZXJvLg0KPiANCj4gRml4ZXM6IDFkYjY0ZTg3MzNmNjUzODEgKCJkZXZsaW5rOiBBZGQgZGV2bGlu
ayBmb3JtYXR0ZWQgbWVzc2FnZSAoZm1zZykgQVBJIikNCj4gU2lnbmVkLW9mZi1ieTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gLS0tDQo+IEkgZG9uJ3Qga25v
dyBpZiB0aGlzIGNhbiByZWFsbHkgaGFwcGVuLCBhbmQgaWYgdGhpcyBpcyB0aGUgcmlnaHQgZml4
Lg0KPiBQZXJoYXBzIGVyciBzaG91bGQgYmUgaW5pdGlhbGl6ZWQgdG8gc29tZSB2YWxpZCBlcnJv
ciBjb2RlIGluc3RlYWQ/DQo+IC0tLQ0KPiAgIG5ldC9jb3JlL2RldmxpbmsuYyB8IDIgKy0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9uZXQvY29yZS9kZXZsaW5rLmMgYi9uZXQvY29yZS9kZXZsaW5rLmMNCj4gaW5k
ZXggZDQzYmM1MmI4ODQwZDc2Yi4uOTEzNzdlNGVhZTlhNDNjMSAxMDA2NDQNCj4gLS0tIGEvbmV0
L2NvcmUvZGV2bGluay5jDQo+ICsrKyBiL25ldC9jb3JlL2RldmxpbmsuYw0KPiBAQCAtNDMyMSw4
ICs0MzIxLDggQEAgZGV2bGlua19mbXNnX3ByZXBhcmVfc2tiKHN0cnVjdCBkZXZsaW5rX2Ztc2cg
KmZtc2csIHN0cnVjdCBza19idWZmICpza2IsDQo+ICAgew0KPiAgIAlzdHJ1Y3QgZGV2bGlua19m
bXNnX2l0ZW0gKml0ZW07DQo+ICAgCXN0cnVjdCBubGF0dHIgKmZtc2dfbmxhdHRyOw0KPiArCWlu
dCBlcnIgPSAwOw0KPiAgIAlpbnQgaSA9IDA7DQo+IC0JaW50IGVycjsNCj4gICANCj4gICAJZm1z
Z19ubGF0dHIgPSBubGFfbmVzdF9zdGFydF9ub2ZsYWcoc2tiLCBERVZMSU5LX0FUVFJfRk1TRyk7
DQo+ICAgCWlmICghZm1zZ19ubGF0dHIpDQo+IA0K
