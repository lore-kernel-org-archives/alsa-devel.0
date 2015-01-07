From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support
	for audio
Date: Wed, 7 Jan 2015 18:08:25 +0100
Message-ID: <20150107180825.52334d4f@armhf>
References: <cover.1420628786.git.moinejf@free.fr>
 <0084acea5a3475a77531d6a77483f36d3469111a.1420628786.git.moinejf@free.fr>
 <54AD4511.30702@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 969B12619D9
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 18:06:09 +0100 (CET)
In-Reply-To: <54AD4511.30702@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Jackson <Andrew.Jackson@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAwNyBKYW4gMjAxNSAxNDozOToxMyArMDAwMApBbmRyZXcgSmFja3NvbiA8QW5kcmV3
LkphY2tzb25AYXJtLmNvbT4gd3JvdGU6Cgo+ID4gKyAgLSBhdWRpby1wb3J0czogbXVzdCBjb250
YWluIG9uZSBvciB0d28gdmFsdWVzIHNlbGVjdGluZyB0aGUgc291cmNlCj4gPiArCWluIHRoZSBh
dWRpbyBwb3J0Lgo+ID4gKwlUaGUgc291cmNlIHR5cGUgaXMgZ2l2ZW4gYnkgdGhlIGNvcnJlc3Bv
bmRpbmcgZW50cnkgaW4KPiA+ICsJdGhlIGF1ZGlvLXBvcnQtbmFtZXMgcHJvcGVydHkuICAKPiAK
PiBJIHRoaW5rIHRoYXQgdGhpcyBlbnRyeSBtaWdodCBiZW5lZml0IGZyb20gYSBsaXR0bGUgbW9y
ZSBleHBsYW5hdGlvbi4KPiBUaGUgdmFsdWUgc3BlY2lmaWVkIGhlcmUgc2VsZWN0cyB3aGljaCBw
aW5zIG9uIHRoZSBjaGlwIHByb3ZpZGUgdGhlCj4gYXVkaW8gaW5wdXQgZG9lc24ndCBpdD8gIElu
IHRoZSBvdXRsaW5lIGRhdGFzaGVldCB0aGF0IEkgaGF2ZSB0aGVzZSBhcmUKPiBsaXN0ZWQgaW4g
dGFibGUgMTc6Cj4gCj4gQXVkaW8gcG9ydCAJSW5wdXQgY29uZmlndXJhdGlvbgo+IAkJUy9QRElG
IAkJSTJTLWJ1cwo+IEFQMCAJCS0gCQlXUyAod29yZCBzZWxlY3QpCj4gQVAxIAkJUy9QRElGIGlu
cHV0IAlJMlMtYnVzIGNoYW5uZWwgMAo+IEFQMiAJCVMvUERJRiBpbnB1dCAJSTJTLWJ1cyBjaGFu
bmVsIDEKPiBBUDNbMV0gCQkJCUkyUy1idXMgY2hhbm5lbCAyCj4gQVA0WzFdIAkJCQlJMlMtYnVz
IGNoYW5uZWwgMwo+IEFDTEsgCQktIAkJU0NLIChJMlMtYnVzIGNsb2NrKQo+IAo+IFsxXSBEZXBl
bmRpbmcgb24gcGFja2FnZS4KCllvdXIgdGFibGUgaXMgY2xvc2UgdG8gdGhlIG9uZSBpbiB0aGUg
VERBOTk4M0IgZG9jdW1lbnRhdGlvbiBJIGhhdmUsCmJ1dCB0aGUgcGlucyBhcmUgbm90IGV4YWN0
bHkgdGhlIHNhbWU6CgpBUDAgCQlXUyAod29yZCBzZWxlY3QpCkFQMSAJCUkyUy1idXMgcG9ydCAw
CkFQMiAJCUkyUy1idXMgcG9ydCAxCkFQMyAJCUkyUy1idXMgcG9ydCAyCkFQNCAJCUkyUy1idXMg
cG9ydCAzCkFQNQkJTUNMSyAobWFzdGVyIGNsb2NrIGZvciBTL1BESUYpCkFQNgkJUy9QRElGIGlu
cHV0CkFQNwkJQVVYIChpbnRlcm5hbCB0ZXN0KQpBQ0xLIAkJU0NLIChJMlMtYnVzIGNsb2NrKQoK
VGhhdCdzIHdoeSBJIGRpZCBub3Qga25vdyBjbGVhcmx5IHdoeSBJIGhhZCB0byBzZXQgQVAyIGZv
ciBTL1BESUYgaW5wdXQKYW5kIChBUDAgKyBBUDEpIGZvciBJMlMgaW5wdXQgaW4gdGhlIEN1Ym94
LgoKVGhlbiwgdGhlIG9ubHkgbW9yZSBleHBsYW5hdGlvbiBJIGNvdWxkIGdpdmUgaXMgImhhdmUg
YSBsb29rIGF0IHRoZQphdWRpbyBpbnB1dCBmb3JtYXQgYW5kIGF0IHRoZSByZWdpc3RlciAweDFl
IHBhZ2UgMCBpbiB0aGUgZG9jdW1lbnRhdGlvbgpvZiB0aGUgVERBOTk4eCBjaGlwIi4KCkJUVywg
dGhlIHRkYTk5OHggZHJpdmVyIHN1cHBvcnRzIG9ubHkgdGhlIFREQTk5ODksIFREQTE5OTg4IGFu
ZApUREExOTk4OSBjaGlwcy4gSWYgdGhlIFREQTk5ODNCIHdvdWxkIGJlIHN1cHBvcnRlZCwgdGhl
IGF1ZGlvIHBvcnQKZGVmaW5pdGlvbnMgd291bGQgYmUgb2Ygbm8gdXNlLgoKU28sIHdoYXQgd291
bGQgeW91IHNlZSBhcyBhbiBleHBsYW5hdGlvbj8KCi0tIApLZW4gYXIgYydoZW50YcOxCXwJICAg
ICAgKiogQnJlaXpoIGhhIExpbnV4IGF0YXYhICoqCkplZgkJfAkJaHR0cDovL21vaW5lamYuZnJl
ZS5mci8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
