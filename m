From: <Codrin.Ciubotariu@microchip.com>
Subject: Re: [PATCH 3/5] ASoC: atmel_ssc_dai: implement left-justified data
 mode
Date: Thu, 25 Jul 2019 13:15:36 +0000
Message-ID: <1da85885-4b5c-fcfa-a7b7-d8ef8102debe@microchip.com>
References: <cover.1563819483.git.mirq-linux@rere.qmqm.pl>
 <ca3d0b124cdf6e2d0ec158a7948f08dd8abfd3b7.1563819483.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ca3d0b124cdf6e2d0ec158a7948f08dd8abfd3b7.1563819483.git.mirq-linux@rere.qmqm.pl>
Content-Language: en-US
Content-ID: <E0CC02D8A42C3844AF3645A1BCA91C23@namprd11.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: mirq-linux@rere.qmqm.pl, alsa-devel@alsa-project.org
Cc: alexandre.belloni@bootlin.com, lgirdwood@gmail.com, tiwai@suse.com, Ludovic.Desroches@microchip.com, broonie@kernel.org, perex@perex.cz, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMjIuMDcuMjAxOSAyMToyNywgTWljaGHFgiBNaXJvc8WCYXcgd3JvdGU6DQo+IEV4dGVybmFs
IEUtTWFpbA0KPiANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhxYIgTWlyb3PFgmF3IDxtaXJx
LWxpbnV4QHJlcmUucW1xbS5wbD4NCj4gLS0tDQo+ICAgc291bmQvc29jL2F0bWVsL2F0bWVsX3Nz
Y19kYWkuYyB8IDEzICsrKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9hdG1lbC9hdG1lbF9zc2NfZGFp
LmMgYi9zb3VuZC9zb2MvYXRtZWwvYXRtZWxfc3NjX2RhaS5jDQo+IGluZGV4IGIyOTkyNDk2ZTUy
Zi4uMDQ1NDFkN2MzM2ZlIDEwMDY0NA0KPiAtLS0gYS9zb3VuZC9zb2MvYXRtZWwvYXRtZWxfc3Nj
X2RhaS5jDQo+ICsrKyBiL3NvdW5kL3NvYy9hdG1lbC9hdG1lbF9zc2NfZGFpLmMNCj4gQEAgLTU2
NCw3ICs1NjQsMjAgQEAgc3RhdGljIGludCBhdG1lbF9zc2NfaHdfcGFyYW1zKHN0cnVjdCBzbmRf
cGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLA0KPiAgIA0KPiAgIAlzd2l0Y2ggKHNzY19wLT5kYWlm
bXQgJiBTTkRfU09DX0RBSUZNVF9GT1JNQVRfTUFTSykgew0KPiAgIA0KPiArCWNhc2UgU05EX1NP
Q19EQUlGTVRfTEVGVF9KOg0KPiArCQkvKiBsZWZ0LWp1c3RpZmllZCBmb3JtYXQgKi8NCj4gKwkJ
ZnNfb3N5bmMgPSBTU0NfRlNPU19QT1NJVElWRTsNCj4gKw0KPiArCQlyY21yID0JICBTU0NfQkYo
UkNNUl9TVFRETFksIDApDQo+ICsJCQl8IFNTQ19CRihSQ01SX1NUQVJULCBTU0NfU1RBUlRfUklT
SU5HX1JGKTsNCj4gKw0KPiArCQl0Y21yID0JICBTU0NfQkYoVENNUl9TVFRETFksIDApDQo+ICsJ
CQl8IFNTQ19CRihUQ01SX1NUQVJULCBTU0NfU1RBUlRfUklTSU5HX1JGKTsNCj4gKw0KPiArCQli
cmVhazsNCj4gKw0KPiAgIAljYXNlIFNORF9TT0NfREFJRk1UX0kyUzoNCj4gKwkJLyogSTJTIGZv
cm1hdCA9IGxlZnQtanVzdGlmaWVkIHdpdGggc3RhcnQgYml0IGFuZCBpbnZlcnRlZCBMUkNMSyAq
Lw0KPiAgIAkJZnNfb3N5bmMgPSBTU0NfRlNPU19ORUdBVElWRTsNCj4gICANCj4gICAJCXJjbXIg
PQkgIFNTQ19CRihSQ01SX1NUVERMWSwgMSkNCj4gDQoNClJldmlld2VkLWJ5OiBDb2RyaW4gQ2l1
Ym90YXJpdSA8Y29kcmluLmNpdWJvdGFyaXVAbWljcm9jaGlwLmNvbT4NCg0KVGhhbmtzIGFuZCBi
ZXN0IHJlZ2FyZHMsDQpDb2RyaW4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
