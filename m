From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Baytrail: Fix implicit
	fallthrough warning
Date: Wed, 28 Aug 2019 11:45:01 +0200
Message-ID: <c9156b17-7e48-cf5b-55f8-ff0fad591e8b@intel.com>
References: <20190822120135.13515-1-cezary.rojewski@intel.com>
 <ed82f3b9-92da-dced-2fef-dee92ca67f10@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E4AAF8973B
 for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2019 11:45:05 +0200 (CEST)
In-Reply-To: <ed82f3b9-92da-dced-2fef-dee92ca67f10@linux.intel.com>
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

T24gMjAxOS0wOC0yMiAxNjowOCwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6Cj4gT24gOC8y
Mi8xOSA3OjAxIEFNLCBDZXphcnkgUm9qZXdza2kgd3JvdGU6Cj4+IFNlcGFyYXRlIF9TVVNQRU5E
IGZyb20gX1BBVVNFX1BVU0ggdG8gZW5zdXJlIGNvZGUgaXMgaGFuZGxlZCBjb3JyZWN0bHkKPj4g
d2hpbGUgZml4aW5nIHdhcm5pbmcgcmVwb3J0ZWQgZHVyaW5nIGNvbXBpbGF0aW9uLgo+Pgo+PiBG
aXhlczogYjgwZDE5YzE2NmM0ICgiQVNvQzogSW50ZWw6IFJlc3RvcmUgQmF5dHJhaWwgQURTUCBz
dHJlYW1zIG9ubHkgCj4+IHdoZW4gQURTUCB3YXMgaW4gcmVzZXQiKQo+PiBTaWduZWQtb2ZmLWJ5
OiBDZXphcnkgUm9qZXdza2kgPGNlemFyeS5yb2pld3NraUBpbnRlbC5jb20+Cj4+IC0tLQo+PiDC
oCBzb3VuZC9zb2MvaW50ZWwvYmF5dHJhaWwvc3N0LWJheXRyYWlsLXBjbS5jIHwgMiArKwo+PiDC
oCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9zb3Vu
ZC9zb2MvaW50ZWwvYmF5dHJhaWwvc3N0LWJheXRyYWlsLXBjbS5jIAo+PiBiL3NvdW5kL3NvYy9p
bnRlbC9iYXl0cmFpbC9zc3QtYmF5dHJhaWwtcGNtLmMKPj4gaW5kZXggOWNiYzk4MmQ0NmE5Li5l
ZGRiMjRhYjgwNzIgMTAwNjQ0Cj4+IC0tLSBhL3NvdW5kL3NvYy9pbnRlbC9iYXl0cmFpbC9zc3Qt
YmF5dHJhaWwtcGNtLmMKPj4gKysrIGIvc291bmQvc29jL2ludGVsL2JheXRyYWlsL3NzdC1iYXl0
cmFpbC1wY20uYwo+PiBAQCAtMTkzLDYgKzE5Myw4IEBAIHN0YXRpYyBpbnQgc3N0X2J5dF9wY21f
dHJpZ2dlcihzdHJ1Y3QgCj4+IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sIGludCBjbWQp
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4gwqDCoMKgwqDCoCBjYXNlIFNORFJWX1BD
TV9UUklHR0VSX1NVU1BFTkQ6Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBwZGF0YS0+cmVzdG9yZV9z
dHJlYW0gPSBmYWxzZTsKPj4gK8KgwqDCoMKgwqDCoMKgIHNzdF9ieXRfc3RyZWFtX3BhdXNlKGJ5
dCwgcGNtX2RhdGEtPnN0cmVhbSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBicmVhazsKPiAKPiB3aHkg
bm90IGp1c3QgYSAvKiBmYWxsdGhyb3VnaCAqLyBzdGF0ZW1lbnQ/Cj4gCgpKdXN0IGEgbWF0dGVy
IG9mIHRhc3RlLiBTZW5kaW5nIHYyIHdpdGggdXBkYXRlLgoKPj4gwqDCoMKgwqDCoCBjYXNlIFNO
RFJWX1BDTV9UUklHR0VSX1BBVVNFX1BVU0g6Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzc3RfYnl0
X3N0cmVhbV9wYXVzZShieXQsIHBjbV9kYXRhLT5zdHJlYW0pOwo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgYnJlYWs7Cj4+Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
