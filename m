From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: boards: Add Cometlake machine
 driver support
Date: Thu, 8 Aug 2019 14:06:47 -0500
Message-ID: <2ec1119e-cd4c-71a6-1f52-e9a586f1aeaf@linux.intel.com>
References: <1565251120-13082-1-git-send-email-mac.chiang@intel.com>
 <334b227c-10fb-ec2e-10d0-68587806eb8c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7EB32F803F3
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 21:06:50 +0200 (CEST)
In-Reply-To: <334b227c-10fb-ec2e-10d0-68587806eb8c@linux.intel.com>
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
To: mac.chiang@intel.com, alsa-devel@alsa-project.org
Cc: sathya.prakash.m.r@intel.com, broonie@kernel.org, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

Cj4+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvaW50ZWwvY29tbW9uL3NvYy1pbnRlbC1xdWlya3Mu
aCAKPj4gYi9zb3VuZC9zb2MvaW50ZWwvY29tbW9uL3NvYy1pbnRlbC1xdWlya3MuaAo+PiBpbmRl
eCA0NzE4ZmQzLi5lNjM1N2QzIDEwMDY0NAo+PiAtLS0gYS9zb3VuZC9zb2MvaW50ZWwvY29tbW9u
L3NvYy1pbnRlbC1xdWlya3MuaAo+PiArKysgYi9zb3VuZC9zb2MvaW50ZWwvY29tbW9uL3NvYy1p
bnRlbC1xdWlya3MuaAo+PiBAQCAtMzYsNiArMzYsNyBAQCBTT0NfSU5URUxfSVNfQ1BVKGJ5dCwg
SU5URUxfRkFNNl9BVE9NX1NJTFZFUk1PTlQpOwo+PiDCoCBTT0NfSU5URUxfSVNfQ1BVKGNodCwg
SU5URUxfRkFNNl9BVE9NX0FJUk1PTlQpOwo+PiDCoCBTT0NfSU5URUxfSVNfQ1BVKGFwbCwgSU5U
RUxfRkFNNl9BVE9NX0dPTERNT05UKTsKPj4gwqAgU09DX0lOVEVMX0lTX0NQVShnbGssIElOVEVM
X0ZBTTZfQVRPTV9HT0xETU9OVF9QTFVTKTsKPj4gK1NPQ19JTlRFTF9JU19DUFUoY21sLCBJTlRF
TF9GQU02X0tBQllMQUtFX01PQklMRSk7Cj4+IMKgIHN0YXRpYyBpbmxpbmUgYm9vbCBzb2NfaW50
ZWxfaXNfYnl0X2NyKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+IMKgIHsKPj4gQEAg
LTExMCw2ICsxMTEsMTAgQEAgc3RhdGljIGlubGluZSBib29sIHNvY19pbnRlbF9pc19nbGsodm9p
ZCkKPj4gwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4+IMKgIH0KPj4gK3N0YXRpYyBpbmxpbmUg
Ym9vbCBzb2NfaW50ZWxfaXNfY21sKHZvaWQpCj4+ICt7Cj4+ICvCoMKgwqAgcmV0dXJuIGZhbHNl
Owo+PiArfQo+PiDCoCAjZW5kaWYKPj4gwqDCoCAjZW5kaWYgLyogX1NORF9TT0NfSU5URUxfUVVJ
UktTX0ggKi8KPiAKPiBIdW1tLCB3aGljaCBicmFuY2ggZG9lcyB0aGlzIGFwcGx5IGFnYWluc3Q/
IEl0J3Mgbm90IGluIE1hcmsncyB0cmVlIG5vciAKPiBpbiB0aGUgU09GIHRyZWUsIHNvIGhvdyBk
aWQgeW91IHRlc3QgdGhpcz8KPiAKPiBJIHJlbWVtYmVyIHN1Ym1pdHRpbmcgdGhpcyBxdWlyayBz
dWdnZXN0aW9uIGJ1dCBpdCB3YXMgbm90IGFwcHJvdmVkIAo+IHVwc3RyZWFtLCBvciBuZWVkZWQg
bW9yZSB3b3JrICh0aGlzIHdhcyBiZWZvcmUgSSBkcm9wcGVkIGV2ZXJ5dGhpbmcgdG8gCj4gd29y
ayBvbiBTb3VuZFdpcmUpLiBZb3UgbWF5IGhhdmUgdG8gZG8gdGhpcyBtYW51YWxseSBmb3Igbm93
IHdpdGggdGhlIAo+IGNwdV9pZCBtZXRob2QsIGFuZCB3ZSdsbCByZXBsYWNlIGl0IGxhdGVyIHdp
dGggYSBiZXR0ZXIgc29sdXRpb24uCgpQbGVhc2UgaWdub3JlIHRoaXMgbGFzdCBjb21tZW50LCBJ
IG5lZWQgbW9yZSBjb2ZmZWUgYmVmb3JlIHJldmlld2luZy4gClRoZSBjb2RlIHdhcyBpbmRlZWQg
bWVyZ2VkLi4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
czovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
