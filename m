From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: omap: sdma-pcm: Fix modpost
	warning
Date: Tue, 15 May 2018 09:35:49 +0300
Message-ID: <108dde99-6b28-9315-ede7-bc78579bcc6b@ti.com>
References: <20180511122055.14206-1-peter.ujfalusi@ti.com>
 <20180511122055.14206-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BB80266F46
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 08:35:07 +0200 (CEST)
In-Reply-To: <20180511122055.14206-2-peter.ujfalusi@ti.com>
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
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
Cc: tony@atomide.com, alsa-devel@alsa-project.org, aaro.koskinen@iki.fi
List-Id: alsa-devel@alsa-project.org

CgpPbiAyMDE4LTA1LTExIDE1OjIwLCBQZXRlciBVamZhbHVzaSB3cm90ZToKPiBXQVJOSU5HOiBt
b2Rwb3N0OiBtaXNzaW5nIE1PRFVMRV9MSUNFTlNFKCkgaW4gc291bmQvc29jL29tYXAvc25kLXNv
Yy1zZG1hLm8KPiBzZWUgaW5jbHVkZS9saW51eC9tb2R1bGUuaCBmb3IgbW9yZSBpbmZvcm1hdGlv
bgo+IFdBUk5JTkc6IG1vZHBvc3Q6IG1pc3NpbmcgTU9EVUxFX0xJQ0VOU0UoKSBpbiBzb3VuZC9z
b2Mvb21hcC9zbmQtc29jLXNkbWEubwo+IHNlZSBpbmNsdWRlL2xpbnV4L21vZHVsZS5oIGZvciBt
b3JlIGluZm9ybWF0aW9uCj4gCj4gQWRkIHRoZSBtaXNzaW5nIE1PRFVMRV9MSUNFTlNFLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IFBldGVyIFVqZmFsdXNpIDxwZXRlci51amZhbHVzaUB0aS5jb20+Cj4g
LS0tCj4gIHNvdW5kL3NvYy9vbWFwL3NkbWEtcGNtLmMgfCA1ICsrKysrCj4gIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL29tYXAvc2Rt
YS1wY20uYyBiL3NvdW5kL3NvYy9vbWFwL3NkbWEtcGNtLmMKPiBpbmRleCBmN2IyYjViNjlkMjcu
LjQwM2I5MGUyYzg5YiAxMDA2NDQKPiAtLS0gYS9zb3VuZC9zb2Mvb21hcC9zZG1hLXBjbS5jCj4g
KysrIGIvc291bmQvc29jL29tYXAvc2RtYS1wY20uYwo+IEBAIC00LDYgKzQsNyBAQAo+ICAgKiAg
QXV0aG9yOiBQZXRlciBVamZhbHVzaSA8cGV0ZXIudWpmYWx1c2lAdGkuY29tPgo+ICAgKi8KPiAg
Cj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KPiAgI2luY2x1ZGUgPHNvdW5kL2NvcmUuaD4K
PiAgI2luY2x1ZGUgPHNvdW5kL3BjbS5oPgo+ICAjaW5jbHVkZSA8c291bmQvcGNtX3BhcmFtcy5o
Pgo+IEBAIC02NiwzICs2Nyw3IEBAIGludCBzZG1hX3BjbV9wbGF0Zm9ybV9yZWdpc3RlcihzdHJ1
Y3QgZGV2aWNlICpkZXYsCj4gIAlyZXR1cm4gZGV2bV9zbmRfZG1hZW5naW5lX3BjbV9yZWdpc3Rl
cihkZXYsIGNvbmZpZywgZmxhZ3MpOwo+ICB9Cj4gIEVYUE9SVF9TWU1CT0xfR1BMKHNkbWFfcGNt
X3BsYXRmb3JtX3JlZ2lzdGVyKTsKPiArCj4gK01PRFVMRV9BVVRIT1IoIlBldGVyIFVqZmFsdXNp
IDxwZXRlci51amZhbHVzaUB0aS5jb20+Iik7Cj4gK01PRFVMRV9ERVNDUklQVElPTigic0RNQSBQ
Q00gQVNvQyBwbGF0Zm9ybSBkcml2ZXIiKTsKPiArTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwoKVGhl
IFNQRFggbGluZSBpcyB0ZWxsaW5nIEdQTC0yLjAsIEkgc2hvdWxkIGhhdmUgIkdQTCB2MiIKCnJl
c2VuZGluZy4KCi0gUMOpdGVyCgpUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2Fs
YW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEt
NC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
