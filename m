From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v3 05/15] drm: bridge/dw_hdmi: combine
 hdmi_set_clock_regenerator_n() and hdmi_regenerate_cts()
Date: Thu, 5 Feb 2015 23:54:49 +0800
Message-ID: <CAGS+omC_vWBdoWvzy96A5kFOKEeqaKRcPzNhNc20--+MoAPHyA@mail.gmail.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
 <1422976340-30118-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1422976340-30118-1-git-send-email-ykk@rock-chips.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Yakir Yang <ykk@rock-chips.com>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, dri-devel <dri-devel@lists.freedesktop.org>, Douglas Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <mmind00@googlemail.com>, Pawel Moll <pawel.moll@arm.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jyri Sarha <jsarha@ti.com>, Ben Zhang <benzh@chromium.org>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Yao <mark.yao@rock-chips.com>, Fabio Estevam <fabio.estevam@freescale.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kumar
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBGZWIgMywgMjAxNSBhdCAxMToxMiBQTSwgWWFraXIgWWFuZyA8eWtrQHJvY2stY2hp
cHMuY29tPiB3cm90ZToKPiBTaWduZWQtb2ZmLWJ5OiBZYWtpciBZYW5nIDx5a2tAcm9jay1jaGlw
cy5jb20+CgpSZXZpZXdlZC1ieTogRGFuaWVsIEt1cnR6IDxkamt1cnR6QGNocm9taXVtLm9yZz4K
Cj4gLS0tCj4gQ2hhbmdlcyBpbiB2MzoKPiAtIENvbWJpbmUgaGRtaV9zZXRfY2xvY2tfcmVnZW5l
cmF0b3JfbigpIGFuZCBoZG1pX3JlZ2VuZXJhdGVfY3RzKCkKPgo+IENoYW5nZXMgaW4gdjI6IE5v
bmUKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2R3X2hkbWkuYyB8IDE2ICsrKysrKy0tLS0t
LS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9kd19oZG1pLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYnJpZGdlL2R3X2hkbWkuYwo+IGluZGV4IDdiNWI2NjQuLjI2MjE2M2YgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9kd19oZG1pLmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYnJpZGdlL2R3X2hkbWkuYwo+IEBAIC0xOTYsMTkgKzE5NiwxNiBAQCBzdGF0
aWMgdm9pZCBoZG1pX21hc2tfd3JpdGViKHN0cnVjdCBkd19oZG1pICpoZG1pLCB1OCBkYXRhLCB1
bnNpZ25lZCBpbnQgcmVnLAo+ICAgICAgICAgaGRtaV9tb2RiKGhkbWksIGRhdGEgPDwgc2hpZnQs
IG1hc2ssIHJlZyk7Cj4gIH0KPgo+IC1zdGF0aWMgdm9pZCBoZG1pX3NldF9jbG9ja19yZWdlbmVy
YXRvcl9uKHN0cnVjdCBkd19oZG1pICpoZG1pLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHZhbHVlKQo+ICtzdGF0aWMgdm9pZCBoZG1pX3Nl
dF9jbG9ja19yZWdlbmVyYXRvcihzdHJ1Y3QgZHdfaGRtaSAqaGRtaSwKPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgbiwgdW5zaWduZWQgaW50IGN0
cykKPiAgewo+IC0gICAgICAgaGRtaV93cml0ZWIoaGRtaSwgdmFsdWUgJiAweGZmLCBIRE1JX0FV
RF9OMSk7Cj4gLSAgICAgICBoZG1pX3dyaXRlYihoZG1pLCAodmFsdWUgPj4gOCkgJiAweGZmLCBI
RE1JX0FVRF9OMik7Cj4gLSAgICAgICBoZG1pX3dyaXRlYihoZG1pLCAodmFsdWUgPj4gMTYpICYg
MHgwZiwgSERNSV9BVURfTjMpOwo+ICsgICAgICAgaGRtaV93cml0ZWIoaGRtaSwgbiAmIDB4ZmYs
IEhETUlfQVVEX04xKTsKPiArICAgICAgIGhkbWlfd3JpdGViKGhkbWksIChuID4+IDgpICYgMHhm
ZiwgSERNSV9BVURfTjIpOwo+ICsgICAgICAgaGRtaV93cml0ZWIoaGRtaSwgKG4gPj4gMTYpICYg
MHgwZiwgSERNSV9BVURfTjMpOwo+Cj4gICAgICAgICAvKiBuc2hpZnQgZmFjdG9yID0gMCAqLwo+
ICAgICAgICAgaGRtaV9tb2RiKGhkbWksIDAsIEhETUlfQVVEX0NUUzNfTl9TSElGVF9NQVNLLCBI
RE1JX0FVRF9DVFMzKTsKPiAtfQo+Cj4gLXN0YXRpYyB2b2lkIGhkbWlfcmVnZW5lcmF0ZV9jdHMo
c3RydWN0IGR3X2hkbWkgKmhkbWksIHVuc2lnbmVkIGludCBjdHMpCj4gLXsKPiAgICAgICAgIC8q
IE11c3QgYmUgc2V0L2NsZWFyZWQgZmlyc3QgKi8KPiAgICAgICAgIGhkbWlfbW9kYihoZG1pLCAw
LCBIRE1JX0FVRF9DVFMzX0NUU19NQU5VQUwsIEhETUlfQVVEX0NUUzMpOwo+Cj4gQEAgLTM3NCw4
ICszNzEsNyBAQCBzdGF0aWMgdm9pZCBoZG1pX3NldF9jbGtfcmVnZW5lcmF0b3Ioc3RydWN0IGR3
X2hkbWkgKmhkbWksCj4gICAgICAgICAgICAgICAgIF9fZnVuY19fLCBoZG1pLT5zYW1wbGVfcmF0
ZSwgaGRtaS0+cmF0aW8sCj4gICAgICAgICAgICAgICAgIHBpeGVsX2NsaywgY2xrX24sIGNsa19j
dHMpOwo+Cj4gLSAgICAgICBoZG1pX3NldF9jbG9ja19yZWdlbmVyYXRvcl9uKGhkbWksIGNsa19u
KTsKPiAtICAgICAgIGhkbWlfcmVnZW5lcmF0ZV9jdHMoaGRtaSwgY2xrX2N0cyk7Cj4gKyAgICAg
ICBoZG1pX3NldF9jbG9ja19yZWdlbmVyYXRvcihoZG1pLCBjbGtfbiwgY2xrX2N0cyk7Cj4gIH0K
Pgo+ICBzdGF0aWMgdm9pZCBoZG1pX2luaXRfY2xrX3JlZ2VuZXJhdG9yKHN0cnVjdCBkd19oZG1p
ICpoZG1pKQo+IC0tCj4gMi4xLjIKPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
