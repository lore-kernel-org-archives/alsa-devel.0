Return-Path: <SRS0=eYvk=35=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515C8C35250
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Feb 2020 09:32:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AB62080C
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Feb 2020 09:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kOcp0sQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AB62080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B8541677;
	Sun,  9 Feb 2020 10:31:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B8541677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581240759;
	bh=LpzUruyH6EAWJTF20QkOFXmVZm47SRn73RTFD9nw+uI=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kOcp0sQwlVxU9lJZ9YZ67AsK8lTi8DfpFlqUjQxern2Xz5NTpxlxWgVLVGik5SI4y
	 dLTQ3yajObUmVHuVzrsbgZslB88pUN9OxdJyslFDZUnpUICVn8ty+HcXqfgyUHIgj/
	 oHlHYodrlAaXRObkOi9BjNaMVDErbsQ0bc15DYoE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50AC1F800ED;
	Sun,  9 Feb 2020 10:31:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D403F80145; Sun,  9 Feb 2020 10:31:46 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4192FF800ED
 for <alsa-devel@alsa-project.org>; Sun,  9 Feb 2020 10:31:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4192FF800ED
Received: from [162.213.32.131] (helo=[0.0.0.0])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1j0iwD-0004se-Qh; Sun, 09 Feb 2020 09:31:38 +0000
To: Jaroslav Kysela <perex@perex.cz>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20191104224812.3393-1-ranjani.sridharan@linux.intel.com>
 <20191104224812.3393-3-ranjani.sridharan@linux.intel.com>
 <a87bce63-0413-d475-9b3c-19aa0f803232@perex.cz>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <d141c18c-6c65-453f-86fd-0735a044954f@canonical.com>
Date: Sun, 9 Feb 2020 17:31:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a87bce63-0413-d475-9b3c-19aa0f803232@perex.cz>
Content-Language: en-US
Cc: tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
Subject: Re: [alsa-devel] [PATCH v2 2/2] ASoC: SOF: topology: set trigger
 order for FE DAI link
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Ck9uIDIwMTkvMTEvMTkg5LiK5Y2INjo0NCwgSmFyb3NsYXYgS3lzZWxhIHdyb3RlOgo+IERuZSAw
NC4gMTEuIDE5IHYgMjM6NDggUmFuamFuaSBTcmlkaGFyYW4gbmFwc2FsKGEpOgo+PiBTZXQgdHJp
Z2dlciBvcmRlciBmb3IgRkUgREFJIGxpbmtzIHRvIFNORF9TT0NfRFBDTV9UUklHR0VSX1BPU1QK
Pj4gdG8gdHJpZ2dlciB0aGUgQkUgREFJJ3MgYmVmb3JlIHRoZSBGRSBEQUkncy4gVGhpcyBwcmV2
ZW50cyB0aGUKPj4geHJ1bnMgc2VlbiBvbiBwbGF5YmFjayBwaXBlbGluZXMgdXNpbmcgdGhlIGxp
bmsgRE1BLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBSYW5qYW5pIFNyaWRoYXJhbiA8cmFuamFuaS5z
cmlkaGFyYW5AbGludXguaW50ZWwuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmUtTG91aXMg
Qm9zc2FydCAKPj4gPHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbT4KPj4gLS0t
Cj4+IMKgIHNvdW5kL3NvYy9zb2YvdG9wb2xvZ3kuYyB8IDQgKysrKwo+PiDCoCAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvc29mL3Rv
cG9sb2d5LmMgYi9zb3VuZC9zb2Mvc29mL3RvcG9sb2d5LmMKPj4gaW5kZXggZTBlMmFlNzM0NjMy
Li5lNzA3NjY5MjExOWIgMTAwNjQ0Cj4+IC0tLSBhL3NvdW5kL3NvYy9zb2YvdG9wb2xvZ3kuYwo+
PiArKysgYi9zb3VuZC9zb2Mvc29mL3RvcG9sb2d5LmMKPj4gQEAgLTI5NTEsNiArMjk1MSwxMCBA
QCBzdGF0aWMgaW50IHNvZl9saW5rX2xvYWQoc3RydWN0IAo+PiBzbmRfc29jX2NvbXBvbmVudCAq
c2NvbXAsIGludCBpbmRleCwKPj4gwqDCoMKgwqDCoCBpZiAoIWxpbmstPm5vX3BjbSkgewo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgbGluay0+bm9uYXRvbWljID0gdHJ1ZTsKPj4gwqAgK8KgwqDCoMKg
wqDCoMKgIC8qIHNldCB0cmlnZ2VyIG9yZGVyICovCj4+ICvCoMKgwqDCoMKgwqDCoCBsaW5rLT50
cmlnZ2VyWzBdID0gU05EX1NPQ19EUENNX1RSSUdHRVJfUE9TVDsKPj4gK8KgwqDCoMKgwqDCoMKg
IGxpbmstPnRyaWdnZXJbMV0gPSBTTkRfU09DX0RQQ01fVFJJR0dFUl9QT1NUOwo+PiArCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCAvKiBub3RoaW5nIG1vcmUgdG8gZG8gZm9yIEZFIGRhaSBsaW5rcyAq
Lwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+IMKgwqDCoMKgwqAgfQo+Pgo+Cj4g
SXQgc2VlbXMgdGhhdCB0aGlzIHBhdGNoIGJyZWFrcyB0aGUgc2lnbmVkIDEuMyBmaXJtd2FyZS4g
VGVzdGVkIG9uIAo+IExlbm92byBDYXJib24gWDEgN3RoIGdlbi4KPgo+IGh0dHBzOi8vZ2l0aHVi
LmNvbS90aGVzb2Zwcm9qZWN0L3NvZi9pc3N1ZXMvMjEwMgo+Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgSmFyb3NsYXYKPgpBbHNvIG1ldCB0aGlzIHByb2JsZW0sIHRo
aXMgcGF0Y2ggaXMgbWVyZ2VkIHRvIDUuNCBzdGFibGUga2VybmVsLCB3aGVuIEkgCnJ1biB0aGUg
NS40IHN0YWJsZSBrZXJuZWwgb24gdGhlIExlbm92byBDYXJib24geDEgN3RoIGdlbiBvciBEZWxs
IERtaWMgCm1hY2hpbmVzLMKgIHRoZSBzb2YgZHJpdmVyIHdpbGwgcHJpbnQgZXJyb3IgbG9ncyBy
ZXBlYXRlZGx5IGFuZCB0aGUgc29mIApmYWlscyB0byB3b3JrLiBJIHRyaWVkIHdpdGggYm90aCAx
LjMgYW5kIDEuNCBmaXJtd2FyZS4gSWYgSSByZXZlcnRlZCAKdGhpcyBwYXRjaCBmcm9tIDUuNCBz
dGFibGUga2VybmVsLCB0aGUgc29mIGRyaXZlciB3aWxsIHdvcmsgd2l0aCBib3RoIAoxLjMgYW5k
IDEuNCBmaXJtd2FyZS4KCkkgYWxzbyB0cmllZCB0aGUgNS41LXJjMSBrZXJuZWwsIHRoaXPCoCBr
ZXJuZWwgYWxyZWFkeSBpbmNsdWRlcyB0aGlzIApwYXRjaCwgYnV0IHRoZXJlIGlzIG5vIGlzc3Vl
IGZvciB0aGlzIGtlcm5lbCwgdGhlIHNvZiBkcml2ZXIgd29ya3Mgd2VsbC4gClNvIGxvb2tzIGxp
a2Ugb25seSBiYWNrcG9ydCB0aGlzIHBhdGNoIHRvIDUuNCBzdGFibGUga2VybmVsIGlzIG5vdCAK
ZW5vdWdoLCBlaXRoZXIgd2UgcmV2ZXJ0IHRoaXMgcGF0Y2ggb3Igd2UgYmFja3BvcnQgbW9yZSBw
YXRjaGVzIHRvIDUuNCAKc3RhYmxlIGtlcm5lbC4KCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
