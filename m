From: "Rajwa, Marcin" <marcin.rajwa@linux.intel.com>
Subject: [PATCH v4 2/2] ASoC: SOF: Intel: fix reset of
	host_period_bytes
Date: Tue, 30 Jul 2019 12:22:37 +0200
Message-ID: <a1387cbf-9e1b-9d13-52ad-25985dd84a7a@linux.intel.com>
References: <9d92551a-fa10-4ecd-47f1-5b3b67824a12@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04618F800AB
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 12:22:40 +0200 (CEST)
In-Reply-To: <9d92551a-fa10-4ecd-47f1-5b3b67824a12@linux.intel.com>
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
To: alsa-devel@alsa-project.org, Keyon Jie <yang.jie@linux.intel.com>, ranjani.sridharan@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, marcin.rajwa@intel.com, kai.vehmanen@linux.intel.com
List-Id: alsa-devel@alsa-project.org

RnJvbTogTWFyY2luIFJhandhIDxtYXJjaW4ucmFqd2FAbGludXguaW50ZWwuY29tPgoKVGhpcyBw
YXRjaCBwcmV2ZW50cyB0aGUgcmVzZXQgb2YgaG9zdCBwZXJpb2QgYnl0ZXMKYW5kIHVzZXMgbm9f
c3RyZWFtX3Bvc2l0aW9uIHRvIHJlY29yZCByZXF1ZXN0cwpmb3Igc3RyZWFtIHBvc2l0aW9uLgoK
U2lnbmVkLW9mZi1ieTogTWFyY2luIFJhandhIDxtYXJjaW4ucmFqd2FAbGludXguaW50ZWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBLZXlvbiBKaWUgPHlhbmcuamllQGxpbnV4LmludGVsLmNvbT4KUmV2
aWV3ZWQtYnk6IFJhbmphbmkgU3JpZGhhcmFuIDxyYW5qYW5pLnNyaWRoYXJhbkBsaW51eC5pbnRl
bC5jb20+ClJldmlld2VkLWJ5OiBLYWkgVmVobWFuZW4gPGthaS52ZWhtYW5lbkBsaW51eC5pbnRl
bC5jb20+Ci0tLQogwqBzb3VuZC9zb2Mvc29mL2ludGVsL2hkYS1wY20uYyB8IDQgKystLQogwqAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3NvdW5kL3NvYy9zb2YvaW50ZWwvaGRhLXBjbS5jIGIvc291bmQvc29jL3NvZi9pbnRlbC9o
ZGEtcGNtLmMKaW5kZXggOWI3MzBmMTgzNTI5Li45NTY0MDdjZjU5ZWEgMTAwNjQ0Ci0tLSBhL3Nv
dW5kL3NvYy9zb2YvaW50ZWwvaGRhLXBjbS5jCisrKyBiL3NvdW5kL3NvYy9zb2YvaW50ZWwvaGRh
LXBjbS5jCkBAIC0xMTYsOSArMTE2LDkgQEAgaW50IGhkYV9kc3BfcGNtX2h3X3BhcmFtcyhzdHJ1
Y3Qgc25kX3NvZl9kZXYgKnNkZXYsCiDCoMKgwqAgwqAvKiBkaXNhYmxlIFNQSUIsIHRvIGVuYWJs
ZSBidWZmZXIgd3JhcCBmb3Igc3RyZWFtICovCiDCoMKgwqAgwqBoZGFfZHNwX3N0cmVhbV9zcGli
X2NvbmZpZyhzZGV2LCBzdHJlYW0sIEhEQV9EU1BfU1BJQl9ESVNBQkxFLCAwKTsKCi3CoMKgIMKg
Lyogc2V0IGhvc3RfcGVyaW9kX2J5dGVzIHRvIDAgaWYgbm8gSVBDIHBvc2l0aW9uICovCivCoMKg
IMKgLyogdXBkYXRlIG5vX3N0cmVhbV9wb3NpdGlvbiBmbGFnIGZvciBpcGMgcGFyYW1zICovCiDC
oMKgwqAgwqBpZiAoaGRhICYmIGhkYS0+bm9faXBjX3Bvc2l0aW9uKQotwqDCoCDCoMKgwqAgwqBp
cGNfcGFyYW1zLT5ob3N0X3BlcmlvZF9ieXRlcyA9IDA7CivCoMKgIMKgwqDCoCDCoGlwY19wYXJh
bXMtPm5vX3N0cmVhbV9wb3NpdGlvbiA9IDE7CgogwqDCoMKgIMKgaXBjX3BhcmFtcy0+c3RyZWFt
X3RhZyA9IGhzdHJlYW0tPnN0cmVhbV90YWc7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
