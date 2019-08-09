From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 12/15] ASoC: ti: rx51: use
 snd_soc_dai_link_component for aux_dev
Date: Fri, 9 Aug 2019 12:46:05 +0300
Message-ID: <09cd9fa0-28da-3e0e-3ad0-92a2a8598f28@ti.com>
References: <87zhkk6wdy.wl-kuninori.morimoto.gx@renesas.com>
 <87imr86w96.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F040F800E4
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2019 11:46:03 +0200 (CEST)
In-Reply-To: <87imr86w96.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <maxime.ripard@bootlin.com>, Jie Yang <yang.jie@linux.intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Richard Fontana <rfontana@redhat.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Jerome Brunet <jbrunet@baylibre.com>, Anders Roxell <anders.roxell@linaro.org>, Kevin Hilman <khilman@baylibre.com>, YueHaibing <yuehaibing@huawei.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@google.com>, Chen-Yu Tsai <wens@csie.org>, Georgii Staroselski i <georgii.staroselskii@emlid.com>, Danny Milosavljevic <dannym@scratchpost.org>, Hans de Goede <hdegoede@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Alexios Zavras <alexios.zavras@intel.com>Sangbeom Kim <s>
List-Id: alsa-devel@alsa-project.org

CgpPbiAwOC8wOC8yMDE5IDguNTQsIEt1bmlub3JpIE1vcmltb3RvIHdyb3RlOgo+IEZyb206IEt1
bmlub3JpIE1vcmltb3RvIDxrdW5pbm9yaS5tb3JpbW90by5neEByZW5lc2FzLmNvbT4KPiAKPiBX
ZSBjYW4gdXNlIHNuZF9zb2NfZGFpX2xpbmtfY29tcG9uZW50IHRvIHNwZWNpZnkgYXV4X2Rldi4K
PiBMZXQncyB1c2UgaXQuCgpBY2tlZC1ieTogUGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNp
QHRpLmNvbT4KCj4gCj4gU2lnbmVkLW9mZi1ieTogS3VuaW5vcmkgTW9yaW1vdG8gPGt1bmlub3Jp
Lm1vcmltb3RvLmd4QHJlbmVzYXMuY29tPgo+IC0tLQo+ICBzb3VuZC9zb2MvdGkvcng1MS5jIHwg
MTQgKysrKysrLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgOCBk
ZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3RpL3J4NTEuYyBiL3NvdW5k
L3NvYy90aS9yeDUxLmMKPiBpbmRleCBjY2QwZThhLi41ODhmNjgwIDEwMDY0NAo+IC0tLSBhL3Nv
dW5kL3NvYy90aS9yeDUxLmMKPiArKysgYi9zb3VuZC9zb2MvdGkvcng1MS5jCj4gQEAgLTMxOSwx
MiArMzE5LDEwIEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19kYWlfbGluayByeDUxX2RhaVtdID0g
ewo+ICAKPiAgc3RhdGljIHN0cnVjdCBzbmRfc29jX2F1eF9kZXYgcng1MV9hdXhfZGV2W10gPSB7
Cj4gIAl7Cj4gLQkJLm5hbWUgPSAiVExWMzIwQUlDMzRiIiwKPiAtCQkuY29kZWNfbmFtZSA9ICJ0
bHYzMjBhaWMzeC1jb2RlYy4yLTAwMTkiLAo+ICsJCS5kbGMgPSBDT01QX0FVWCgidGx2MzIwYWlj
M3gtY29kZWMuMi0wMDE5IiksCj4gIAl9LAo+ICAJewo+IC0JCS5uYW1lID0gIlRQQTYxMzIwQTIi
LAo+IC0JCS5jb2RlY19uYW1lID0gInRwYTYxMzBhMi4yLTAwNjAiLAo+ICsJCS5kbGMgPSBDT01Q
X0FVWCgidHBhNjEzMGEyLjItMDA2MCIpLAo+ICAJfSwKPiAgfTsKPiAgCj4gQEAgLTM5Nyw4ICsz
OTUsOCBAQCBzdGF0aWMgaW50IHJ4NTFfc29jX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpCj4gIAkJCWRldl9lcnIoJnBkZXYtPmRldiwgIkF1eGlsaWFyeSBDb2RlYyBub2RlIGlz
IG5vdCBwcm92aWRlZFxuIik7Cj4gIAkJCXJldHVybiAtRUlOVkFMOwo+ICAJCX0KPiAtCQlyeDUx
X2F1eF9kZXZbMF0uY29kZWNfbmFtZSA9IE5VTEw7Cj4gLQkJcng1MV9hdXhfZGV2WzBdLmNvZGVj
X29mX25vZGUgPSBkYWlfbm9kZTsKPiArCQlyeDUxX2F1eF9kZXZbMF0uZGxjLm5hbWUgPSBOVUxM
Owo+ICsJCXJ4NTFfYXV4X2RldlswXS5kbGMub2Zfbm9kZSA9IGRhaV9ub2RlOwo+ICAJCXJ4NTFf
Y29kZWNfY29uZlswXS5kZXZfbmFtZSA9IE5VTEw7Cj4gIAkJcng1MV9jb2RlY19jb25mWzBdLm9m
X25vZGUgPSBkYWlfbm9kZTsKPiAgCj4gQEAgLTQwNyw4ICs0MDUsOCBAQCBzdGF0aWMgaW50IHJ4
NTFfc29jX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIAkJCWRldl9lcnIo
JnBkZXYtPmRldiwgIkhlYWRwaG9uZSBhbXBsaWZpZXIgbm9kZSBpcyBub3QgcHJvdmlkZWRcbiIp
Owo+ICAJCQlyZXR1cm4gLUVJTlZBTDsKPiAgCQl9Cj4gLQkJcng1MV9hdXhfZGV2WzFdLmNvZGVj
X25hbWUgPSBOVUxMOwo+IC0JCXJ4NTFfYXV4X2RldlsxXS5jb2RlY19vZl9ub2RlID0gZGFpX25v
ZGU7Cj4gKwkJcng1MV9hdXhfZGV2WzFdLmRsYy5uYW1lID0gTlVMTDsKPiArCQlyeDUxX2F1eF9k
ZXZbMV0uZGxjLm9mX25vZGUgPSBkYWlfbm9kZTsKPiAgCQlyeDUxX2NvZGVjX2NvbmZbMV0uZGV2
X25hbWUgPSBOVUxMOwo+ICAJCXJ4NTFfY29kZWNfY29uZlsxXS5vZl9ub2RlID0gZGFpX25vZGU7
Cj4gIAl9Cj4gCgotIFDDqXRlcgoKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2th
bGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIx
LTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
