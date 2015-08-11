From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH] mfd: wm8994: Fix NULL pointer
 exception on missing pdata
Date: Tue, 11 Aug 2015 14:55:11 +0100
Message-ID: <20150811135511.GH18282@x1>
References: <1438911359-26949-1-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id D9002260569
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 15:55:15 +0200 (CEST)
Received: by wijp15 with SMTP id p15so177512187wij.0
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 06:55:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438911359-26949-1-git-send-email-ideal.song@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Inha Song <ideal.song@samsung.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCAwNyBBdWcgMjAxNSwgSW5oYSBTb25nIHdyb3RlOgoKPiBJZiB3ZSB1c2UgdGhlIGRl
dl9nZXRfcGxhdGRhdGEsIHBkYXRhIGNhbiBiZSBOVUxMIGluIERUIGVudmlyb25tZW50cy4KPiBB
Y3R1YWxseSwgTlVMTCBwb2ludGVyIGV4Y2VwdGlvbiBpcyBvY2N1cnMgd2l0aCBlcnJvciBtZXNz
YWdlcyBsaWtlIHRoaXM6Cj4gCj4gWyAgICAxLjIyNjU4M10gVW5hYmxlIHRvIGhhbmRsZSBrZXJu
ZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDA0NAo+
IFsgICAgMS40Njc5MTBdIFs8YzAyZjFlMzg+XSAod204OTk0X2lycV9pbml0KSBmcm9tIFs8YzAy
ZjFiZDQ+XSAod204OTk0X2kyY19wcm9iZSsweDY4NC8weDg1OCkKPiBbICAgIDEuNDc2MjQxXSBb
PGMwMmYxYmQ0Pl0gKHdtODk5NF9pMmNfcHJvYmUpIGZyb20gWzxjMDM3MWM3OD5dIChpMmNfZGV2
aWNlX3Byb2JlKzB4MTFjLzB4MTdjKQo+IAo+IEluIHdtODk5NC1jb3JlLCB3ZSBhbHJlYWR5IGNo
ZWNrZWQgd2hldGhlciBwbGF0Zm9ybSBkYXRhIGlzIE5VTEwgYW5kIHNldCB0aGUKPiB3bTg5OTQt
PnBkYXRhIHRvIHBsYXRmb3JtIGRhdGEgaWYgcGxhdGZvcm0gZGF0YSBpcyBub3QgTlVMTC4KPiBT
bywgd2UgY2FuIHVzZSB3bTg5OTQtPnBkYXRhIGluc3RlYWQgb2YgcGxhdGZvcm0gZGF0YS4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBJbmhhIFNvbmcgPGlkZWFsLnNvbmdAc2Ftc3VuZy5jb20+Cj4gQWNr
ZWQtYnk6IENoYXJsZXMgS2VlcGF4IDxja2VlcGF4QG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNv
bT4KPiAtLS0KPiAgZHJpdmVycy9tZmQvd204OTk0LWlycS5jIHwgMiArLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCkJpdCBsYXRlIGluIHRoZSBkYXkg
dG8gYXBwbHkgdGhpcyB0byAtZml4ZXMsIHNvIEknbGwgYXBwbHkgaXQgZm9yIHY0LjMKaW5zdGVh
ZC4KCkFwcGxpZWQsIHRoYW5rcy4KCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL3dtODk5NC1p
cnEuYyBiL2RyaXZlcnMvbWZkL3dtODk5NC1pcnEuYwo+IGluZGV4IDU1YzM4MGEuLjU1YzU5ZDkg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9tZmQvd204OTk0LWlycS5jCj4gKysrIGIvZHJpdmVycy9t
ZmQvd204OTk0LWlycS5jCj4gQEAgLTE5Myw3ICsxOTMsNyBAQCBpbnQgd204OTk0X2lycV9pbml0
KHN0cnVjdCB3bTg5OTQgKndtODk5NCkKPiAgewo+ICAJaW50IHJldDsKPiAgCXVuc2lnbmVkIGxv
bmcgaXJxZmxhZ3M7Cj4gLQlzdHJ1Y3Qgd204OTk0X3BkYXRhICpwZGF0YSA9IGRldl9nZXRfcGxh
dGRhdGEod204OTk0LT5kZXYpOwo+ICsJc3RydWN0IHdtODk5NF9wZGF0YSAqcGRhdGEgPSAmd204
OTk0LT5wZGF0YTsKPiAgCj4gIAlpZiAoIXdtODk5NC0+aXJxKSB7Cj4gIAkJZGV2X3dhcm4od204
OTk0LT5kZXYsCgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVE1pY3JvZWxlY3Ryb25pY3MgTGFuZGlu
ZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBT
b0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
