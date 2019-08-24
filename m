From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 21/35] ASoC: Intel: Expose ACPI loading
 members
Date: Sat, 24 Aug 2019 11:58:33 +0200
Message-ID: <c9c7b4a2-b50a-697e-e4f3-8c5426a7f2d7@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <20190822190425.23001-22-cezary.rojewski@intel.com>
 <30929d7b-787d-3b6e-d806-02487b85ab8d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ADFC7F80391
 for <alsa-devel@alsa-project.org>; Sat, 24 Aug 2019 11:58:36 +0200 (CEST)
In-Reply-To: <30929d7b-787d-3b6e-d806-02487b85ab8d@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

T24gMjAxOS0wOC0yMyAyMTozMiwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6Cj4gCj4+IGRp
ZmYgLS1naXQgYS9zb3VuZC9zb2MvaW50ZWwvY29tbW9uL3NzdC1kc3AuaCAKPj4gYi9zb3VuZC9z
b2MvaW50ZWwvY29tbW9uL3NzdC1kc3AuaAo+PiBpbmRleCA2M2MyOWJiNDVjZjEuLmEyYWM3OTk4
ZmJkYiAxMDA2NDQKPj4gLS0tIGEvc291bmQvc29jL2ludGVsL2NvbW1vbi9zc3QtZHNwLmgKPj4g
KysrIGIvc291bmQvc29jL2ludGVsL2NvbW1vbi9zc3QtZHNwLmgKPj4gQEAgLTE2Niw2ICsxNjYs
MjcgQEAKPj4gwqAgI2RlZmluZSBTU1RfUE1DU19QU19NQVNLwqDCoMKgIDB4Mwo+PiDCoCBzdHJ1
Y3Qgc3N0X2RzcDsKPj4gK3N0cnVjdCBwbGF0Zm9ybV9kZXZpY2U7Cj4gCj4gdGhhdCBzaG91bGQg
YmUgaGFuZGxlZCB3aXRoIGFuIGluY2x1ZGUsIG5vdCByZWRlZmluaW5nIGEgdHlwZSBoZXJlLgo+
IAoKQWNrLgoKPj4gKwo+PiArLyogRGVzY3JpcHRvciBmb3Igc2V0dGluZyB1cCBTU1QgcGxhdGZv
cm0gZGF0YSAqLwo+PiArc3RydWN0IHNzdF9hY3BpX2Rlc2Mgewo+PiArwqDCoMKgIGNvbnN0IGNo
YXIgKmRydl9uYW1lOwo+PiArwqDCoMKgIHN0cnVjdCBzbmRfc29jX2FjcGlfbWFjaCAqbWFjaGlu
ZXM7Cj4+ICvCoMKgwqAgLyogUGxhdGZvcm0gcmVzb3VyY2UgaW5kZXhlcy4gTXVzdCBzZXQgdG8g
LTEgaWYgbm90IHVzZWQgKi8KPj4gK8KgwqDCoCBpbnQgcmVzaW5kZXhfbHBlX2Jhc2U7Cj4+ICvC
oMKgwqAgaW50IHJlc2luZGV4X3BjaWNmZ19iYXNlOwo+PiArwqDCoMKgIGludCByZXNpbmRleF9m
d19iYXNlOwo+PiArwqDCoMKgIGludCBpcnFpbmRleF9ob3N0X2lwYzsKPj4gK8KgwqDCoCBpbnQg
cmVzaW5kZXhfZG1hX2Jhc2U7Cj4+ICvCoMKgwqAgLyogVW5pcXVlIG51bWJlciBpZGVudGlmeWlu
ZyB0aGUgU1NUIGNvcmUgb24gcGxhdGZvcm0gKi8KPj4gK8KgwqDCoCBpbnQgc3N0X2lkOwo+PiAr
wqDCoMKgIC8qIERNQSBvbmx5IHZhbGlkIHdoZW4gcmVzaW5kZXhfZG1hX2Jhc2UgIT0gLTEqLwo+
PiArwqDCoMKgIGludCBkbWFfZW5naW5lOwo+PiArwqDCoMKgIGludCBkbWFfc2l6ZTsKPj4gK307
Cj4+ICsKPj4gK2ludCBzc3RfYWNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KTsKPj4gK2ludCBzc3RfYWNwaV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldik7
Cj4+IMKgIC8qCj4+IMKgwqAgKiBTU1QgUGxhdGZvcm0gRGF0YS4KPj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
