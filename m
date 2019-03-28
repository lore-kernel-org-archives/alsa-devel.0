From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/4] soundwire: bus: check if pm runtime is
 enabled before calling
Date: Thu, 28 Mar 2019 14:37:13 +0000
Message-ID: <5f4ef5ca-b90f-4e25-f006-78983fd2bcfc@linaro.org>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
 <20190328134134.22479-4-srinivas.kandagatla@linaro.org>
 <e2522fa7-298e-9385-9686-7c3ce3c8a03b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB20BF8071D
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 15:37:16 +0100 (CET)
Received: by mail-wm1-x343.google.com with SMTP id y197so1604829wmd.0
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 07:37:16 -0700 (PDT)
In-Reply-To: <e2522fa7-298e-9385-9686-7c3ce3c8a03b@linux.intel.com>
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
Cc: sanyog.r.kale@intel.com, alsa-devel@alsa-project.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

CgpPbiAyOC8wMy8yMDE5IDEzOjU1LCBQaWVycmUtTG91aXMgQm9zc2FydCB3cm90ZToKPiBPbiAz
LzI4LzE5IDk6NDEgQU0sIFNyaW5pdmFzIEthbmRhZ2F0bGEgd3JvdGU6Cj4+IENoZWNrIHRoZSBk
ZXZpY2UgaGFzIHBtIHJ1bnRpbWUgZW5hYmxlZCBiZWZvcmUgcmV0dXJuaW5nIGVycm9yLgo+Pgo+
PiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhcyBLYW5kYWdhdGxhIDxzcmluaXZhcy5rYW5kYWdhdGxh
QGxpbmFyby5vcmc+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL3NvdW5kd2lyZS9idXMuYyB8IDE2ICsr
KysrKysrKystLS0tLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvdW5kd2lyZS9idXMuYyBi
L2RyaXZlcnMvc291bmR3aXJlL2J1cy5jCj4+IGluZGV4IDFjYmZlZGZjMjBlZi4uMTAxNTYyYTZm
YjBkIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3NvdW5kd2lyZS9idXMuYwo+PiArKysgYi9kcml2
ZXJzL3NvdW5kd2lyZS9idXMuYwo+PiBAQCAtMzI3LDkgKzMyNywxMSBAQCBpbnQgc2R3X25yZWFk
KHN0cnVjdCBzZHdfc2xhdmUgKnNsYXZlLCB1MzIgYWRkciwgCj4+IHNpemVfdCBjb3VudCwgdTgg
KnZhbCkKPj4gwqDCoMKgwqDCoCBpZiAocmV0IDwgMCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiByZXQ7Cj4+IC3CoMKgwqAgcmV0ID0gcG1fcnVudGltZV9nZXRfc3luYyhzbGF2ZS0+YnVz
LT5kZXYpOwo+PiAtwqDCoMKgIGlmIChyZXQgPCAwKQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IHJldDsKPj4gK8KgwqDCoCBpZiAocG1fcnVudGltZV9lbmFibGVkKHNsYXZlLT5idXMtPmRldikp
IHsKPj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoc2xhdmUtPmJ1
cy0+ZGV2KTsKPiAKPiBJcyB0aGlzIGFuIHJlY29tbWVuZGVkL2FjY2VwdGVkIHNlcXVlbmNlIGlu
IGtlcm5lbCBjaXJjbGVzPyBJIGRpZCBhIAo+IHF1aWNrIGdpdCBncmVwIGFuZCBkb24ndCBzZWUg
YW55b25lIHVzaW5nIHRoaXMgc29ydCBvZiB0ZXN0cy4KClRoZXJlIGFyZSBsb3RzIG9mIHVzZXJz
IGluIGtlcm5lbCB3aXRoIHN1Y2ggc2VxdWVuY2VzLCBleDoKCmh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2RyaXZl
cnMvaW9tbXUvYXJtLXNtbXUuYz9oPXY1LjEtcmMyI24yNzkKCj4gCj4gCj4+ICvCoMKgwqDCoMKg
wqDCoCBpZiAocmV0IDwgMCkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsK
Pj4gK8KgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgcmV0ID0gc2R3X3RyYW5zZmVyKHNsYXZlLT5idXMs
ICZtc2cpOwo+PiDCoMKgwqDCoMKgIHBtX3J1bnRpbWVfcHV0KHNsYXZlLT5idXMtPmRldik7Cj4g
Cj4gYW5kIHRoZSB3ZWlyZCB0aGluZyBpcyB0aGF0IHlvdSBkb24ndCB0ZXN0IGZvciB0aGUgcHV0
KCkgY2FzZT8KPiAKPj4gQEAgLTM1NSw5ICszNTcsMTEgQEAgaW50IHNkd19ud3JpdGUoc3RydWN0
IHNkd19zbGF2ZSAqc2xhdmUsIHUzMiBhZGRyLCAKPj4gc2l6ZV90IGNvdW50LCB1OCAqdmFsKQo+
PiDCoMKgwqDCoMKgIGlmIChyZXQgPCAwKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJl
dDsKPj4gLcKgwqDCoCByZXQgPSBwbV9ydW50aW1lX2dldF9zeW5jKHNsYXZlLT5idXMtPmRldik7
Cj4+IC3CoMKgwqAgaWYgKHJldCA8IDApCj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+
PiArwqDCoMKgIGlmIChwbV9ydW50aW1lX2VuYWJsZWQoc2xhdmUtPmJ1cy0+ZGV2KSkgewo+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0ID0gcG1fcnVudGltZV9nZXRfc3luYyhzbGF2ZS0+YnVzLT5kZXYp
Owo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHJldCA8IDApCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiByZXQ7Cj4+ICvCoMKgwqAgfQo+PiDCoMKgwqDCoMKgIHJldCA9IHNkd190cmFu
c2ZlcihzbGF2ZS0+YnVzLCAmbXNnKTsKPj4gwqDCoMKgwqDCoCBwbV9ydW50aW1lX3B1dChzbGF2
ZS0+YnVzLT5kZXYpOwoKSSBzaG91bGQgYWRkIGEgY2hlY2sgaW4gdGhpcyBwYXRoIGFzIHdlbGwu
CgpUaGFua3MsCnNyaW5pCgo+Pgo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
