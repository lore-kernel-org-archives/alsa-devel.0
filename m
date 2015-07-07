From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] mfd: wm5110: Add register patch for
	rev E and above
Date: Tue, 7 Jul 2015 08:11:40 +0100
Message-ID: <20150707071140.GJ3182@x1>
References: <1435838281-15873-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1435838281-15873-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B7B72614F1
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 09:11:47 +0200 (CEST)
Received: by wiga1 with SMTP id a1so247815773wig.0
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2015 00:11:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1435838281-15873-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCAwMiBKdWwgMjAxNSwgQ2hhcmxlcyBLZWVwYXggd3JvdGU6Cgo+IEFkZCBhIHJlZ2lz
dGVyIHBhdGNoIGZvciByZXYgRSBhbmQgYWJvdmUgdGhhdCBjb25maWd1cmVzIHRoZSBsb2NhdGlv
biBvZgo+IHNvbWUgd3JpdGUgc2VxdWVuY2VzIHRvIGFzc2lzdCB3aXRoIHRoZSBoZWFkcGhvbmUg
ZW5hYmxlcy4KCkkgdGhpbmsgYSBjb21tZW50IHRvIHRoYXQgZWZmZWN0IHdvdWxkIG5vdCBnbyBh
bWlzcy4KCllvdSBrbm93IHRoZSBydWxlcywgZWl0aGVyIGRlZmluZSBtYWdpYyBudW1iZXJzIG9y
IGNvbW1lbnQgdGhlbS4KCj4gU2lnbmVkLW9mZi1ieTogQ2hhcmxlcyBLZWVwYXggPGNrZWVwYXhA
b3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPgo+IC0tLQo+ICBkcml2ZXJzL21mZC93bTUxMTAt
dGFibGVzLmMgfCAgIDEzICsrKysrKysrKysrKy0KPiAgMSBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC93
bTUxMTAtdGFibGVzLmMgYi9kcml2ZXJzL21mZC93bTUxMTAtdGFibGVzLmMKPiBpbmRleCA2MmE0
YWExLi4wNWJlZjIzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbWZkL3dtNTExMC10YWJsZXMuYwo+
ICsrKyBiL2RyaXZlcnMvbWZkL3dtNTExMC10YWJsZXMuYwo+IEBAIC0yNDksNiArMjQ5LDE1IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnX2RlZmF1bHQgd201MTEwX3JldmRfcGF0Y2hbXSA9IHsK
PiAgCXsgMHg4MCwgMHgwIH0sCj4gIH07Cj4gIAo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ19k
ZWZhdWx0IHdtNTExMF9yZXZlX3BhdGNoW10gPSB7Cj4gKwl7IDB4ODAsIDB4MyB9LAo+ICsJeyAw
eDgwLCAweDMgfSwKPiArCXsgMHg0YiwgMHgxMzggfSwKPiArCXsgMHg0YywgMHgxM2QgfSwKPiAr
CXsgMHg4MCwgMHgwIH0sCj4gKwl7IDB4ODAsIDB4MCB9LAo+ICt9Owo+ICsKPiAgLyogV2UgdXNl
IGEgZnVuY3Rpb24gc28gd2UgY2FuIHVzZSBBUlJBWV9TSVpFKCkgKi8KPiAgaW50IHdtNTExMF9w
YXRjaChzdHJ1Y3QgYXJpem9uYSAqYXJpem9uYSkKPiAgewo+IEBAIC0yNjYsNyArMjc1LDkgQEAg
aW50IHdtNTExMF9wYXRjaChzdHJ1Y3QgYXJpem9uYSAqYXJpem9uYSkKPiAgCQkJCQkgICAgIHdt
NTExMF9yZXZkX3BhdGNoLAo+ICAJCQkJCSAgICAgQVJSQVlfU0laRSh3bTUxMTBfcmV2ZF9wYXRj
aCkpOwo+ICAJZGVmYXVsdDoKPiAtCQlyZXR1cm4gMDsKPiArCQlyZXR1cm4gcmVnbWFwX3JlZ2lz
dGVyX3BhdGNoKGFyaXpvbmEtPnJlZ21hcCwKPiArCQkJCQkgICAgIHdtNTExMF9yZXZlX3BhdGNo
LAo+ICsJCQkJCSAgICAgQVJSQVlfU0laRSh3bTUxMTBfcmV2ZV9wYXRjaCkpOwo+ICAJfQo+ICB9
Cj4gIEVYUE9SVF9TWU1CT0xfR1BMKHdtNTExMF9wYXRjaCk7CgotLSAKTGVlIEpvbmVzCkxpbmFy
byBTVE1pY3JvZWxlY3Ryb25pY3MgTGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3Bl
biBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwg
VHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
