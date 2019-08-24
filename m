From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 11/35] ASoC: Intel: Merge sst_dsp_device
 into sst_pdata
Date: Sat, 24 Aug 2019 12:52:35 +0200
Message-ID: <70b4b3b3-0595-2ead-105b-02da405c64a4@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <20190822190425.23001-12-cezary.rojewski@intel.com>
 <4ecd54e1-a7c1-fec9-3487-9b0ef8442293@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68BF9F8014A
 for <alsa-devel@alsa-project.org>; Sat, 24 Aug 2019 12:52:40 +0200 (CEST)
In-Reply-To: <4ecd54e1-a7c1-fec9-3487-9b0ef8442293@linux.intel.com>
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

T24gMjAxOS0wOC0yMyAyMDo1NCwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6Cj4gCj4+IEBA
IC0yMDMsMTMgKzE5MiwxNSBAQCBzdHJ1Y3Qgc3N0X3BkYXRhIHsKPj4gwqDCoMKgwqDCoCAvKiBE
U1AgKi8KPj4gwqDCoMKgwqDCoCB1MzIgaWQ7Cj4+ICvCoMKgwqAgY29uc3QgY2hhciAqZndfbmFt
ZTsKPj4gK8KgwqDCoCBzdHJ1Y3Qgc3N0X29wcyAqb3BzOwo+PiArwqDCoMKgIHN0cnVjdCBzbmRf
c29jX2FjcGlfbWFjaCAqYm9hcmRzOwo+PiDCoMKgwqDCoMKgIHZvaWQgKmRzcDsKPj4gwqAgfTsK
PiAKPiBZb3UgYWxyZWFkeSBoYXZlIHRoZSBmd19uYW1lIGluc2lkZSBvZiBzdHJ1Y3Qgc25kX3Nv
Y19hY3BpX21hY2g6CgpJJ2xsIGNvbWUgYmFjayB0byB0aGF0IGxhdGVyLgpTZWUgUEFUQ0ggMjcv
MzUgYW5kIFVMTCBleGFtcGxlLgoKPiAKPiAvKiBEZXNjcmlwdG9yIGZvciBTU1QgQVNvQyBtYWNo
aW5lIGRyaXZlciAqLwo+IHN0cnVjdCBzbmRfc29jX2FjcGlfbWFjaCB7Cj4gIMKgwqDCoMKgY29u
c3QgdTggaWRbQUNQSV9JRF9MRU5dOwo+ICDCoMKgwqDCoGNvbnN0IGNoYXIgKmRydl9uYW1lOwo+
ICDCoMKgwqDCoGNvbnN0IGNoYXIgKmZ3X2ZpbGVuYW1lOwo+ICDCoMKgwqDCoGNvbnN0IGNoYXIg
KmJvYXJkOwo+ICDCoMKgwqDCoHN0cnVjdCBzbmRfc29jX2FjcGlfbWFjaCAqICgqbWFjaGluZV9x
dWlyaykodm9pZCAqYXJnKTsKPiAgwqDCoMKgwqBjb25zdCB2b2lkICpxdWlya19kYXRhOwo+ICDC
oMKgwqDCoHZvaWQgKnBkYXRhOwo+ICDCoMKgwqDCoHN0cnVjdCBzbmRfc29jX2FjcGlfbWFjaF9w
YXJhbXMgbWFjaF9wYXJhbXM7Cj4gIMKgwqDCoMKgY29uc3QgY2hhciAqc29mX2Z3X2ZpbGVuYW1l
Owo+ICDCoMKgwqDCoGNvbnN0IGNoYXIgKnNvZl90cGxnX2ZpbGVuYW1lOwo+IH07Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
