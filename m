From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 2/5] soundwire: fix style issues
Date: Fri, 19 Apr 2019 12:14:34 -0500
Message-ID: <37c5af39-a1e4-adc3-e8a9-bcada8e3b35b@linux.intel.com>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E015FF896E2
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2019 19:14:37 +0200 (CEST)
In-Reply-To: <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
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
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Cj4+PiDCoCBlbnVtIHNkd19jb21tYW5kX3Jlc3BvbnNlCj4+PiDCoCBjZG5zX3hmZXJfbXNnX2Rl
ZmVyKHN0cnVjdCBzZHdfYnVzICpidXMsCj4+PiAtwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNkd19t
c2cgKm1zZywgc3RydWN0IHNkd19kZWZlciAqZGVmZXIpCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3Qgc2R3X21zZyAqbXNnLCBzdHJ1Y3Qgc2R3X2RlZmVyICpkZWZlcikKPj4KPj4g
dGhpcyBvbmUgdG9vLi4KPj4KPj4+IMKgIHN0YXRpYyBpbnQgY2Ruc19wb3J0X3BhcmFtcyhzdHJ1
Y3Qgc2R3X2J1cyAqYnVzLAo+Pj4gLcKgwqDCoMKgwqDCoMKgIHN0cnVjdCBzZHdfcG9ydF9wYXJh
bXMgKnBfcGFyYW1zLCB1bnNpZ25lZCBpbnQgYmFuaykKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IHNkd19wb3J0X3BhcmFtcyAqcF9wYXJhbXMsIHVuc2lnbmVkIGlu
dCBiYW5rKQo+Pgo+PiBoZXJlIGFzIHdlbGwuLiAoYW5kIGdpdmluZyB1cCBvbiByZXN0KQo+IAo+
IFBsZWFzZSBjaGVjayBmb3IgeW91cnNlbGYgdGhhdCB0aGlzIGlzIGEgZGlmZiBpbGx1c2lvbiB3
LyB0YWIgc3BhY2UuCgpWaW5vZCwgY2FuIHlvdSBwbGVhc2UgZG91YmxlLWNoZWNrLCB0aGUgYWxp
Z25tZW50IGlzc3VlcyB5b3UgcmVwb3J0ZWQgCmRvbid0IGV4aXN0LCBzZWUgZS5nLiBiZWxvdyB3
aGF0IHRoZSBjb2RlIGxvb2tzIGxpa2UgYWZ0ZXIgbWVyZ2UuCgoKaW50IHNkd190cmFuc2Zlcl9k
ZWZlcihzdHJ1Y3Qgc2R3X2J1cyAqYnVzLCBzdHJ1Y3Qgc2R3X21zZyAqbXNnLAogICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3Qgc2R3X2RlZmVyICpkZWZlcikKCmludCBzZHdfZmlsbF9tc2co
c3RydWN0IHNkd19tc2cgKm1zZywgc3RydWN0IHNkd19zbGF2ZSAqc2xhdmUsCiAgICAgICAgICAg
ICAgICAgIHUzMiBhZGRyLCBzaXplX3QgY291bnQsIHUxNiBkZXZfbnVtLCB1OCBmbGFncywgdTgg
KmJ1ZikKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
