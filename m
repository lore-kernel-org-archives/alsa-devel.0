From: <Codrin.Ciubotariu@microchip.com>
Subject: Re: [PATCH 01/23] ASoC: atmel: atmel-pcm:dma.c: use
 devm_snd_dmaengine_pcm_register()
Date: Thu, 27 Jun 2019 08:20:16 +0000
Message-ID: <e6327e0c-a657-4fe5-4513-562835783eb0@microchip.com>
References: <8736jvkcy1.wl-kuninori.morimoto.gx@renesas.com>
 <871rzfkcxb.wl-kuninori.morimoto.gx@renesas.com>
 <20190627094316.35057063@xxx>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from esa2.microchip.iphmx.com (esa2.microchip.iphmx.com
 [68.232.149.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60A86F806F0
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 10:20:25 +0200 (CEST)
In-Reply-To: <20190627094316.35057063@xxx>
Content-Language: en-US
Content-ID: <CCC201A28C074040BA6EDCE333FA7EEE@namprd11.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: amadeuszx.slawinski@linux.intel.com, kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

T24gMjcuMDYuMjAxOSAxMDo0MywgQW1hZGV1c3ogU8WCYXdpxYRza2kgd3JvdGU6DQo+IEV4dGVy
bmFsIEUtTWFpbA0KPiANCj4gDQo+IE9uIDI3IEp1biAyMDE5IDExOjAwOjAxICswOTAwDQo+IEt1
bmlub3JpIE1vcmltb3RvIDxrdW5pbm9yaS5tb3JpbW90by5neEByZW5lc2FzLmNvbT4gd3JvdGU6
DQo+IA0KPj4gRnJvbTogS3VuaW5vcmkgTW9yaW1vdG8gPGt1bmlub3JpLm1vcmltb3RvLmd4QHJl
bmVzYXMuY29tPg0KPj4NCj4+IFdlIGhhdmUgZGV2bV94eHggdmVyc2lvbiBvZiBzbmRfZG1hZW5n
aW5lX3BjbV9yZWdpc3RlciwNCj4+IGxldCdzIHVzZSBpdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBLdW5pbm9yaSBNb3JpbW90byA8a3VuaW5vcmkubW9yaW1vdG8uZ3hAcmVuZXNhcy5jb20+DQo+
PiAtLS0NCj4+ICAgc291bmQvc29jL2F0bWVsL2F0bWVsLXBjbS1kbWEuYyB8IDQgKystLQ0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvYXRtZWwvYXRtZWwtcGNtLWRtYS5jDQo+PiBiL3NvdW5k
L3NvYy9hdG1lbC9hdG1lbC1wY20tZG1hLmMgaW5kZXggMDQyZTU5My4uOWFiZjA3MiAxMDA2NDQN
Cj4+IC0tLSBhL3NvdW5kL3NvYy9hdG1lbC9hdG1lbC1wY20tZG1hLmMNCj4+ICsrKyBiL3NvdW5k
L3NvYy9hdG1lbC9hdG1lbC1wY20tZG1hLmMNCj4+IEBAIC0xMTEsMTMgKzExMSwxMyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHNuZF9kbWFlbmdpbmVfcGNtX2NvbmZpZw0KPj4gYXRtZWxfZG1hZW5n
aW5lX3BjbV9jb25maWcgPSB7DQo+PiAgIGludCBhdG1lbF9wY21fZG1hX3BsYXRmb3JtX3JlZ2lz
dGVyKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+ICAgew0KPj4gLQlyZXR1cm4gc25kX2RtYWVuZ2lu
ZV9wY21fcmVnaXN0ZXIoZGV2LA0KPj4gJmF0bWVsX2RtYWVuZ2luZV9wY21fY29uZmlnLCAwKTsN
Cj4+ICsJcmV0dXJuIGRldm1fc25kX2RtYWVuZ2luZV9wY21fcmVnaXN0ZXIoZGV2LA0KPj4gKwkJ
CQkJJmF0bWVsX2RtYWVuZ2luZV9wY21fY29uZmlnLA0KPj4gMCk7IH0NCj4+ICAgRVhQT1JUX1NZ
TUJPTChhdG1lbF9wY21fZG1hX3BsYXRmb3JtX3JlZ2lzdGVyKTsNCj4+ICAgDQo+PiAgIHZvaWQg
YXRtZWxfcGNtX2RtYV9wbGF0Zm9ybV91bnJlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+
ICAgew0KPj4gLQlzbmRfZG1hZW5naW5lX3BjbV91bnJlZ2lzdGVyKGRldik7DQo+PiAgIH0NCj4+
ICAgRVhQT1JUX1NZTUJPTChhdG1lbF9wY21fZG1hX3BsYXRmb3JtX3VucmVnaXN0ZXIpOw0KPj4g
ICANCj4gDQo+IERvIHdlIG5lZWQgdG8ga2VlcCBlbXB0eSBmdW5jdGlvbj8NCg0KTW9zdCBwcm9i
YWJseSBub3QuLi4gS3VuaW5vcmksIGxldCBtZSBrbm93IGlmIHlvdSB3YW50IG1lIHRvIHJlbW92
ZSANCmF0bWVsX3BjbV9kbWFfcGxhdGZvcm1fdW5yZWdpc3RlcigpIGZyb20gZXZlcnl3aGVyZS4N
Cg0KVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLg0KDQpCZXN0IHJlZ2FyZHMsDQpDb2RyaW4NCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
