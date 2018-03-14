From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] sound: omap-twl4030: do not complain on
 -EPROBE_DEFER when initializing
Date: Wed, 14 Mar 2018 10:40:53 +0200
Message-ID: <e797abc4-4284-e24f-03a9-b491077696c4@ti.com>
References: <20180211212522.GA2411@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id EABEF26732A
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 09:40:54 +0100 (CET)
In-Reply-To: <20180211212522.GA2411@lenoch>
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
To: Ladislav Michl <ladis@linux-mips.org>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

CgpPbiAyMDE4LTAyLTExIDIzOjI1LCBMYWRpc2xhdiBNaWNobCB3cm90ZToKPiBEb24ndCBjb21w
bGFpbiBvbiAtRVBST0JFX0RFRkVSIHdoZW4gaW5pdGlhbGl6aW5nLCB0aGUgZHJpdmVyIHByb2Jl
Cj4gd2lsbCBiZSByZXRyaWVkIGxhdGVyLgo+IAo+IFNpZ25lZC1vZmYtYnk6IExhZGlzbGF2IE1p
Y2hsIDxsYWRpc0BsaW51eC1taXBzLm9yZz4KPiBBY2tlZC1ieTogSmFya2tvIE5pa3VsYSA8amFy
a2tvLm5pa3VsYUBiaXRtZXIuY29tPgoKQWNrZWQtYnk6IFBldGVyIFVqZmFsdXNpIDxwZXRlci51
amZhbHVzaUB0aS5jb20+Cgo+IC0tLQo+ICBDaGFuZ2VzOgo+ICAtdjI6IGZpeGVkIHR5cG8gaW4g
Y29tbWl0IGxvZywgYWRkZWQgSmFya2tvIE5pa3VsYSdzIGFjawo+IAo+ICBzb3VuZC9zb2Mvb21h
cC9vbWFwLXR3bDQwMzAuYyB8IDYgKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9vbWFwL29t
YXAtdHdsNDAzMC5jIGIvc291bmQvc29jL29tYXAvb21hcC10d2w0MDMwLmMKPiBpbmRleCBjY2Nj
MzE2NzQzZmEuLjdjMWY3MTg4NDc2OCAxMDA2NDQKPiAtLS0gYS9zb3VuZC9zb2Mvb21hcC9vbWFw
LXR3bDQwMzAuYwo+ICsrKyBiL3NvdW5kL3NvYy9vbWFwL29tYXAtdHdsNDAzMC5jCj4gQEAgLTMy
Miw4ICszMjIsMTAgQEAgc3RhdGljIGludCBvbWFwX3R3bDQwMzBfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikKPiAgCXNuZF9zb2NfY2FyZF9zZXRfZHJ2ZGF0YShjYXJkLCBwcml2
KTsKPiAgCXJldCA9IGRldm1fc25kX3NvY19yZWdpc3Rlcl9jYXJkKCZwZGV2LT5kZXYsIGNhcmQp
Owo+ICAJaWYgKHJldCkgewo+IC0JCWRldl9lcnIoJnBkZXYtPmRldiwgImRldm1fc25kX3NvY19y
ZWdpc3Rlcl9jYXJkKCkgZmFpbGVkOiAlZFxuIiwKPiAtCQkJcmV0KTsKPiArCQlpZiAocmV0ICE9
IC1FUFJPQkVfREVGRVIpCj4gKwkJCWRldl9lcnIoJnBkZXYtPmRldiwKPiArCQkJCSJkZXZtX3Nu
ZF9zb2NfcmVnaXN0ZXJfY2FyZCgpIGZhaWxlZDogJWRcbiIsCj4gKwkJCQlyZXQpOwo+ICAJCXJl
dHVybiByZXQ7Cj4gIAl9Cj4gIAo+IAoKLSBQw6l0ZXIKClRleGFzIEluc3RydW1lbnRzIEZpbmxh
bmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLgpZLXR1bm51cy9CdXNpbmVz
cyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
