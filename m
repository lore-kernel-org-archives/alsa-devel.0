Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40AAC2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:29:11 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9DF20702
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9DF20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77C84829;
	Mon, 27 Jan 2020 13:28:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77C84829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580128149;
	bh=t62zt1bCnnz5D+WHiXMDW5pBHW6aHlhjsMmBawh6MFI=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WMPBLjgUcWTYuC8buTMJbIsCd98KXV2GbN2PJkLZYA0G2GW2tPO9FKjiryEfolhfk
	 gc8A838tR045RUv2eGPTMV7K9NpY63t7DHPUs7UuImLKnoHmK7314YLbW1YHIIP1L1
	 oRY6ukmOXM4N5I/C+vYbvMv8HSAceiMp6PXEasaA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F36C4F80082;
	Mon, 27 Jan 2020 13:28:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 022C2F8021E; Mon, 27 Jan 2020 13:28:14 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BFBD9F80082
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 13:28:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BFBD9F80082
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jan 2020 04:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; d="scan'208";a="223229377"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.237.137.172])
 ([10.237.137.172])
 by fmsmga008.fm.intel.com with ESMTP; 27 Jan 2020 04:28:04 -0800
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20200124190413.18154-1-cezary.rojewski@intel.com>
 <20200124190413.18154-9-cezary.rojewski@intel.com>
 <d74dc038-78fa-b81c-5014-6ed3668641b1@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <18e42c09-c09b-3916-c6e7-6431609bac7c@intel.com>
Date: Mon, 27 Jan 2020 13:28:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <d74dc038-78fa-b81c-5014-6ed3668641b1@linux.intel.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com
Subject: Re: [alsa-devel] [PATCH 08/12] ASoC: SOF: Generic probe compress
	operations
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

T24gMjAyMC0wMS0yNCAyMTowMCwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6Cj4gCj4+ICtp
bnQgc29mX3Byb2JlX2NvbXByX29wZW4oc3RydWN0IHNuZF9jb21wcl9zdHJlYW0gKmNzdHJlYW0s
Cj4+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgc25kX3NvY19kYWkgKmRhaSkKPj4gK3sKPj4gK8Kg
wqDCoCBzdHJ1Y3Qgc25kX3NvZl9kZXYgKnNkZXYgPQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNuZF9zb2NfY29tcG9uZW50X2dldF9kcnZkYXRhKGRhaS0+Y29tcG9uZW50KTsK
Pj4gK8KgwqDCoCBpbnQgcmV0Owo+PiArCj4+ICvCoMKgwqAgcmV0ID0gc25kX3NvZl9wcm9iZV9j
b21wcl9hc3NpZ24oc2RldiwgY3N0cmVhbSwgZGFpKTsKPj4gK8KgwqDCoCBpZiAocmV0IDwgMCkg
ewo+PiArwqDCoMKgwqDCoMKgwqAgZGV2X2VycihkYWktPmRldiwgIkZhaWxlZCB0byBhc3NpZ24g
cHJvYmUgc3RyZWFtOiAlZFxuIiwgcmV0KTsKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7
Cj4+ICvCoMKgwqAgfQo+PiArCj4+ICvCoMKgwqAgc2Rldi0+ZXh0cmFjdG9yID0gcmV0Owo+IAo+
IGNvdWxkIHlvdSBlaXRoZXIgcmVuYW1lIHRoZSAnZXh0cmFjdG9yJyBmaWVsZCB0byBzb21ldGhp
bmcgbWVhbmluZ2Z1bCBvciAKPiBhZGQgYSBjb21tZW50IG9uIHdoYXQgaXMgc3RvcmVkIGluIHRo
aXMgZmllbGQ/IEEgc3RyZWFtIHRhZz8gYSBkZXZpY2UgCj4gbnVtYmVyPyBJdCdzIG9ubHkgdXNl
ZCBvbmNlIGZvciB0aGUgaW5pdC4KCidleHRyYWN0b3InIGlzIF92ZXJ5XyBtZWFuaW5nZnVsIGFu
ZCBleHBsaWNpdCBzbyB0aGUgbmFtaW5nIHNob3VsZCBzdGF5LiAKUmV3b3JkaW5nIHRvIHN0cmVh
bV90YWcgLyBkZXYgbnVtIG9yIGFueXRoaW5nIG9mIHRoYXQgc29ydCB3b3VsZCBhY2hpZXZlIAp0
aGUgZXhhY3Qgb3Bwb3NpdGU6IGFtYmlndWl0eS4gQ29kZSBhcm91bmQgJ2V4dHJhY3RvcicgdXNh
Z2UgY2xlYXJseSAKc3RhdGVzIHdoYXQgaXQgaXMgZm9yLiBJJ2QgcmF0aGVyIHByZWZlciBzdWNo
IGRlc2NyaXB0aW9ucyB0byBzdGF5IAp3aXRoaW4gRG9jdW1lbnRhdGlvbiAtIHdoaWNoIHdpbGwg
YmUgcmVsZWFzZWQgb24gYSBsYXRlciBkYXRlIGFzIFNPRidzIApwcm9iZXMgYXJlIHZlcnksIHZl
cnkgZnJlc2ggc3ViamVjdC4KCkN6YXJlawpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
