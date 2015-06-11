From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: tas2552: Use devm_gpiod_get_optional
	for enable-gpio
Date: Thu, 11 Jun 2015 13:22:55 +0300
Message-ID: <5579617F.3050106@ti.com>
References: <1433947565.19912.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id DB8DC261721
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 12:23:00 +0200 (CEST)
In-Reply-To: <1433947565.19912.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Dan Murphy <dmurphy@ti.com>
List-Id: alsa-devel@alsa-project.org

T24gMDYvMTAvMjAxNSAwNTo0NiBQTSwgQXhlbCBMaW4gd3JvdGU6Cj4gY29tbWl0IGVhMTc4ZDE0
NTZkYyAoIkFTb0M6IHRhczI1NTI6IE1ha2UgdGhlIGVuYWJsZS1ncGlvIHJlYWxseSBvcHRpb25h
bCIpCj4gbWFrZXMgZW5hYmxlLWdwaW8gb3B0aW9uYWwuIGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFs
KCkgaXMgdGhlIGJldHRlcgo+IGZ1bmN0aW9uIGZvciBvcHRpb25hbCBncGlvLCBzbyBsZXQncyBz
d2l0Y2ggdG8gdXNlIGl0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxpbkBp
bmdpY3MuY29tPgoKQWNrZWQtYnk6IFBldGVyIFVqZmFsdXNpIDxwZXRlci51amZhbHVzaUB0aS5j
b20+Cgo+IC0tLQo+ICBzb3VuZC9zb2MvY29kZWNzL3RhczI1NTIuYyB8IDExICsrKystLS0tLS0t
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvdGFzMjU1Mi5jIGIvc291bmQvc29jL2NvZGVj
cy90YXMyNTUyLmMKPiBpbmRleCAxNjlhNzAzLi40ZjI1YTdkIDEwMDY0NAo+IC0tLSBhL3NvdW5k
L3NvYy9jb2RlY3MvdGFzMjU1Mi5jCj4gKysrIGIvc291bmQvc29jL2NvZGVjcy90YXMyNTUyLmMK
PiBAQCAtNzAzLDEzICs3MDMsMTAgQEAgc3RhdGljIGludCB0YXMyNTUyX3Byb2JlKHN0cnVjdCBp
MmNfY2xpZW50ICpjbGllbnQsCj4gIAlpZiAoZGF0YSA9PSBOVUxMKQo+ICAJCXJldHVybiAtRU5P
TUVNOwo+ICAKPiAtCWRhdGEtPmVuYWJsZV9ncGlvID0gZGV2bV9ncGlvZF9nZXQoZGV2LCAiZW5h
YmxlIiwgR1BJT0RfT1VUX0xPVyk7Cj4gLQlpZiAoSVNfRVJSKGRhdGEtPmVuYWJsZV9ncGlvKSkg
ewo+IC0JCWlmIChQVFJfRVJSKGRhdGEtPmVuYWJsZV9ncGlvKSA9PSAtRVBST0JFX0RFRkVSKQo+
IC0JCQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsKPiAtCj4gLQkJZGF0YS0+ZW5hYmxlX2dwaW8gPSBO
VUxMOwo+IC0JfQo+ICsJZGF0YS0+ZW5hYmxlX2dwaW8gPSBkZXZtX2dwaW9kX2dldF9vcHRpb25h
bChkZXYsICJlbmFibGUiLAo+ICsJCQkJCQkgICAgR1BJT0RfT1VUX0xPVyk7Cj4gKwlpZiAoSVNf
RVJSKGRhdGEtPmVuYWJsZV9ncGlvKSkKPiArCQlyZXR1cm4gUFRSX0VSUihkYXRhLT5lbmFibGVf
Z3Bpbyk7Cj4gIAo+ICAJZGF0YS0+dGFzMjU1Ml9jbGllbnQgPSBjbGllbnQ7Cj4gIAlkYXRhLT5y
ZWdtYXAgPSBkZXZtX3JlZ21hcF9pbml0X2kyYyhjbGllbnQsICZ0YXMyNTUyX3JlZ21hcF9jb25m
aWcpOwo+IAoKCi0tIApQw6l0ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
