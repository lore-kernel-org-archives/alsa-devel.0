From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC PATCH asoc] IIO: ADC:
 stm32_dfsdm_stop_filter() can be static
Date: Wed, 10 Jan 2018 16:32:06 +0100
Message-ID: <76d70ab9-43a7-88b0-1a76-a3a0275cabaf@st.com>
References: <201801102320.fKoiIrHz%fengguang.wu@intel.com>
 <20180110152305.GA83560@lkp-sb05>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 362012676F6
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 16:32:13 +0100 (CET)
In-Reply-To: <20180110152305.GA83560@lkp-sb05>
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
To: kbuild test robot <fengguang.wu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mark Brown <broonie@kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexandre TORGUE <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org

QWNrZWQtYnk6IEFybmF1ZCBQb3VsaXF1ZW4gPGFybmF1ZC5wb3VsaXF1ZW5Ac3QuY29tPgoKT24g
MDEvMTAvMjAxOCAwNDoyMyBQTSwga2J1aWxkIHRlc3Qgcm9ib3Qgd3JvdGU6Cj4gCj4gRml4ZXM6
IGUyZTY3NzFjNjQ2MiAoIklJTzogQURDOiBhZGQgU1RNMzIgREZTRE0gc2lnbWEgZGVsdGEgQURD
IHN1cHBvcnQiKQo+IFNpZ25lZC1vZmYtYnk6IEZlbmdndWFuZyBXdSA8ZmVuZ2d1YW5nLnd1QGlu
dGVsLmNvbT4KPiAtLS0KPiDCoHN0bTMyLWRmc2RtLWFkYy5jIHzCoMKgwqAgOCArKysrLS0tLQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL3N0bTMyLWRmc2RtLWFkYy5jCj4gYi9kcml2ZXJz
L2lpby9hZGMvc3RtMzItZGZzZG0tYWRjLmMKPiBpbmRleCBiMDNjYTNmLi5lNjI4ZDA0IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9zdG0zMi1kZnNkbS1hZGMuYwo+ICsrKyBiL2RyaXZl
cnMvaWlvL2FkYy9zdG0zMi1kZnNkbS1hZGMuYwo+IEBAIC0yNTQsNyArMjU0LDcgQEAgc3RhdGlj
IGludCBzdG0zMl9kZnNkbV9zdGFydF9maWx0ZXIoc3RydWN0Cj4gc3RtMzJfZGZzZG0gKmRmc2Rt
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIERGU0RNX0NSMV9SU1dTVEFSVCgxKSk7Cj4gwqB9Cj4gwqAKPiAtdm9p
ZCBzdG0zMl9kZnNkbV9zdG9wX2ZpbHRlcihzdHJ1Y3Qgc3RtMzJfZGZzZG0gKmRmc2RtLCB1bnNp
Z25lZCBpbnQgZmxfaWQpCj4gK3N0YXRpYyB2b2lkIHN0bTMyX2Rmc2RtX3N0b3BfZmlsdGVyKHN0
cnVjdCBzdG0zMl9kZnNkbSAqZGZzZG0sIHVuc2lnbmVkCj4gaW50IGZsX2lkKQo+IMKgewo+IMKg
wqDCoMKgwqDCoMKgwqAgLyogRGlzYWJsZSBjb252ZXJzaW9uICovCj4gwqDCoMKgwqDCoMKgwqDC
oCByZWdtYXBfdXBkYXRlX2JpdHMoZGZzZG0tPnJlZ21hcCwgREZTRE1fQ1IxKGZsX2lkKSwKPiBA
QCAtMjk2LDkgKzI5Niw5IEBAIHN0YXRpYyBpbnQgc3RtMzJfZGZzZG1fZmlsdGVyX2NvbmZpZ3Vy
ZShzdHJ1Y3QKPiBzdG0zMl9kZnNkbSAqZGZzZG0sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgREZTRE1fQ1IxX1JT
WU5DKGZsLT5zeW5jX21vZGUpKTsKPiDCoH0KPiDCoAo+IC1pbnQgc3RtMzJfZGZzZG1fY2hhbm5l
bF9wYXJzZV9vZihzdHJ1Y3Qgc3RtMzJfZGZzZG0gKmRmc2RtLAo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaWlv
X2RldiAqaW5kaW9fZGV2LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAqY2gpCj4gK3N0
YXRpYyBpbnQgc3RtMzJfZGZzZG1fY2hhbm5lbF9wYXJzZV9vZihzdHJ1Y3Qgc3RtMzJfZGZzZG0g
KmRmc2RtLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYs
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlpb19jaGFuX3NwZWMgKmNoKQo+IMKgewo+
IMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHN0bTMyX2Rmc2RtX2NoYW5uZWwgKmRmX2NoOwo+IMKg
wqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqb2Zfc3RyOwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
