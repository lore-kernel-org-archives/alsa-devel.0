Return-Path: <SRS0=GCF0=3R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D06FC33C9E
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:53:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1730B2467B
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="r1ausY0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1730B2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F54E167A;
	Tue, 28 Jan 2020 11:52:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F54E167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580208782;
	bh=xIXF7+DXbdSxrqkeL6lKRMvRnhEYJMexyVjJtuHnffI=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r1ausY0cHMGmMSbh9/xcXR9Ugaoy8XIRdtj3l9W2IZum8ejKW8N19iDfh6VRaKIO/
	 HmsLOduiWDnLIUink2iPeZ2bn1Uxg3nQ80jixnbiWxLJNI9pkw+PUFZR6GFZrsiDee
	 1g8njtJSADEIuqUNChiyfAag8YJ2vy/cmZZoBK5w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18ACEF801F8;
	Tue, 28 Jan 2020 11:49:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F7BEF80228; Tue, 28 Jan 2020 11:49:52 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA94FF800FF
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2020 11:49:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA94FF800FF
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jan 2020 02:49:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,373,1574150400"; d="scan'208";a="231880021"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.237.137.172])
 ([10.237.137.172])
 by orsmga006.jf.intel.com with ESMTP; 28 Jan 2020 02:49:44 -0800
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20200127121243.15813-1-cezary.rojewski@intel.com>
 <20200127121243.15813-8-cezary.rojewski@intel.com>
 <2631f178-81e5-4981-ce3b-34819a82a29a@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <f9f26195-1821-b536-550f-2b046c28547c@intel.com>
Date: Tue, 28 Jan 2020 11:49:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <2631f178-81e5-4981-ce3b-34819a82a29a@linux.intel.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com
Subject: Re: [alsa-devel] [PATCH v2 07/11] ASoC: SOF: Implement Probe IPC API
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

T24gMjAyMC0wMS0yNyAyMjowMSwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6Cj4gCj4+ICsv
KioKPj4gKyAqIHNvZl9pcGNfcHJvYmVfcG9pbnRzX3JlbW92ZSAtIGRpc2Nvbm5lY3Qgc3BlY2lm
aWVkIHByb2Jlcwo+PiArICogQHNkZXY6wqDCoMKgIFNPRiBzb3VuZCBkZXZpY2UKPj4gKyAqIEBk
ZXNjOsKgwqDCoCBMaXN0IG9mIHByb2JlIHBvaW50cyB0byBkaXNjb25uZWN0Cj4+ICsgKiBAbnVt
X2Rlc2M6wqDCoMKgIE51bWJlciBvZiBlbGVtZW50cyBpbiBAZGVzYwo+PiArICoKPj4gKyAqIFJl
bW92ZXMgcHJldmlvdXNseSBjb25uZWN0ZWQgcHJvYmVzIGZyb20gbGlzdCBvZiBhY3RpdmUgcHJv
YmUKPj4gKyAqIHBvaW50cyBhbmQgZnJlZXMgYWxsIHJlc291cmNlcyBvbiBEU1Agc2lkZS4KPj4g
KyAqLwo+PiAraW50IHNvZl9pcGNfcHJvYmVfcG9pbnRzX3JlbW92ZShzdHJ1Y3Qgc25kX3NvZl9k
ZXYgKnNkZXYsCj4+ICvCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgKmJ1ZmZlcl9pZCwgc2l6
ZV90IG51bV9idWZmZXJfaWQpCj4+ICt7Cj4gCj4gY3BwY2hlY2sgd2FybmluZzoKPiAKPiBbc291
bmQvc29jL3NvZi9wcm9iZS5oOjgzXSAtPiBbc291bmQvc29jL3NvZi9wcm9iZS5jOjI2NV06IChz
dHlsZSwgCj4gaW5jb25jbHVzaXZlKSBGdW5jdGlvbiAnc29mX2lwY19wcm9iZV9wb2ludHNfcmVt
b3ZlJyBhcmd1bWVudCAzIG5hbWVzIAo+IGRpZmZlcmVudDogZGVjbGFyYXRpb24gJ251bV9pZCcg
ZGVmaW5pdGlvbiAnbnVtX2J1ZmZlcl9pZCcuCj4gCj4gY3BwY2hlY2sgLS1wbGF0Zm9ybT11bml4
MzIgLS1mb3JjZSAtLW1heC1jb25maWdzPTEwMjQgLS1pbmNvbmNsdXNpdmUgCj4gLS1lbmFibGU9
YWxsIHNvdW5kL3NvYy9zb2YKClRoYW5rcyBmb3Igc3BvdHRpbmcgdGhpcyBvdXQgUGllcnJlISBX
YXJuaW5nIGFubmloaWxhdGVkIGluIHYzLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
