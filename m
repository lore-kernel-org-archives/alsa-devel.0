From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/4] soundwire: cdns: fix check for number
	of messages
Date: Thu, 28 Mar 2019 14:58:27 +0000
Message-ID: <28b05dc7-f269-0091-53ab-4390f613fc09@linaro.org>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
 <20190328134134.22479-3-srinivas.kandagatla@linaro.org>
 <797b8525-dbcd-e52b-7b36-b80427a80186@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B3AFF80769
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 15:58:29 +0100 (CET)
Received: by mail-wm1-x344.google.com with SMTP id f3so3932131wmj.4
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 07:58:29 -0700 (PDT)
In-Reply-To: <797b8525-dbcd-e52b-7b36-b80427a80186@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org
Cc: sanyog.r.kale@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CgpPbiAyOC8wMy8yMDE5IDE0OjAzLCBQaWVycmUtTG91aXMgQm9zc2FydCB3cm90ZToKPj4gLS0t
Cj4+IMKgIGRyaXZlcnMvc291bmR3aXJlL2NhZGVuY2VfbWFzdGVyLmMgfCAyICstCj4+IMKgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zb3VuZHdpcmUvY2FkZW5jZV9tYXN0ZXIuYyAKPj4gYi9kcml2ZXJzL3Nv
dW5kd2lyZS9jYWRlbmNlX21hc3Rlci5jCj4+IGluZGV4IGNiNmEzMzFmNDQ4YS4uZDQxYWRiYzU3
OTE4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3NvdW5kd2lyZS9jYWRlbmNlX21hc3Rlci5jCj4+
ICsrKyBiL2RyaXZlcnMvc291bmR3aXJlL2NhZGVuY2VfbWFzdGVyLmMKPj4gQEAgLTQzNCw3ICs0
MzQsNyBAQCBjZG5zX3hmZXJfbXNnX2RlZmVyKHN0cnVjdCBzZHdfYnVzICpidXMsCj4+IMKgwqDC
oMKgwqAgaW50IGNtZCA9IDAsIHJldDsKPj4gwqDCoMKgwqDCoCAvKiBmb3IgZGVmZXIgb25seSAx
IG1lc3NhZ2UgaXMgc3VwcG9ydGVkICovCj4+IC3CoMKgwqAgaWYgKG1zZy0+bGVuID4gMSkKPiAK
PiBJIGFtIG5vdCBzdXJlIHRoaXMgaXMgYSB0eXBvLgo+IAoKQW0gYml0IGNvbmZ1c2VkIHdpdGgg
ZGVmZXIgZGF0YS1zdHJ1Y3R1cmUgaXRzZWxmLgoKSSB3YXMgYXNzdW1pbmcgdGhhdCBkZWZlci0+
bGVuZ3RoIGlzIG51bWJlciBvZiBzZHcgbWVzc2FnZXMgaW4gdGhlIApzdHJ1Y3R1cmUuIElmIGl0
cyBzYW1lIGFzIG1lc3NhZ2UgbGVuZ2h0IHRoZW4gc2R3X21zZy0+bGVuIGFuZCAKc2R3X2RlZmVy
LT5sZW5ndGggYXJlIHRvdGFsbHkgcmVkdW5kYW50LiBNYXkgYmUgd2Ugc2hvdWxkIGdldCByaWQg
b2YgCmxlbmdodCBmaWVsZCBpbiBkZWZlciB0byBhdm9pZCBjb25mdXNpb24/Cgo+IElSUkMgdGhl
IGhhcmR3YXJlIG9ubHkgZGVmZXIgZS5nLiBhIHNpbmdsZSB3cml0ZSB0aGF0IGNhbiBwZXJmb3Jt
IGJhbmsgCj4gc3dpdGNoZXMgYW5kIHdyaXRlcyBhdCBzcGVjaWZpYyB0aW1lcyBpbmRpY2F0ZWQg
d2l0aCBhbiBTU1AuIFdoYXQncyBtb3JlIApva2F5IGdvdCBpdC4KRG9lcyB0aGF0IG1lYW4gdGhh
dCBjYW5kZW5jZSBjb250cm9sbGVyIGNhbiBvbmx5IHN1cHBvcnQgMSBieXRlIGRlZmVyIAp0cmFu
c2ZlcnM/Cgo+IGlzIHRoYXQgdGhlIGRlZmVyIHN0cnVjdHVyZSBpcyBhY3R1YWxseSBtb2RpZmll
ZCBiZWxvdyB0aGlzIGNvZGUgKG5vdCAKPiBzaG93biBpbiB0aGUgZGlmZikgdG8gc2V0IGRlZmVy
Pmxlbmd0aCA9IG1zZy0+bGVuLCBzbyB0ZXN0aW5nIGJlZm9yZSB0aGUgCj4gdmFsdWUgaXMgc2V0
IGxvb2tzIG1vcmUgc3VzcGljaW91cyB0aGFuIHRoZSBjdXJyZW50IGNvZGUuCgpyZW1vdmluZyB0
aGUgbGVuZ3RoIGZpZWxkIGluIGRlZmVyIHNob3VsZCBnZXQgcmlkIG9mIHN1Y2ggaW5zdGFuY2Vz
LgoKLS1zcmluaQoKPiAKPiBWaW5vZCwgZG9lcyB0aGlzIHJpbmcgYSBiZWxsPwo+IAo+IAo+PiAr
wqDCoMKgIGlmIChkZWZlci0+bGVuZ3RoID4gMSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAtRU5PVFNVUFA7Cj4+IMKgwqDCoMKgwqAgcmV0ID0gY2Ruc19wcmVwX21zZyhjZG5zLCBtc2cs
ICZjbWQpOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6
Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
