Return-Path: <SRS0=fcCl=2X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDF5C2D0DC
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jan 2020 21:21:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82DA21582
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jan 2020 21:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eVflwORe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82DA21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E175516A3;
	Thu,  2 Jan 2020 22:20:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E175516A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578000070;
	bh=ihkf/eN/1eG7cFhR1DyjNqxZPfh9am9ULQVc8lot+yA=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eVflwORe3oMGr0lqnB222+z7rQSp5YfR8/XEpELYHF4pjO5MN0SgNzLMOf4n7L5BM
	 bTb5eaCqm5mHMzvLMo/OOSUeba2TDmw5sJAxmmSYO+7DNVGTiZmw2wj/96IxWmORwd
	 0b6QJ0+j/1S7PvY6nZmVEGjzCgfhj66iA4vI30CE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 562D6F80278;
	Thu,  2 Jan 2020 22:18:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1DD63F8021C; Thu,  2 Jan 2020 22:18:36 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC2E1F8013E
 for <alsa-devel@alsa-project.org>; Thu,  2 Jan 2020 22:18:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC2E1F8013E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Jan 2020 13:18:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,388,1571727600"; d="scan'208";a="224819833"
Received: from ybabin-mobl1.amr.corp.intel.com (HELO [10.252.139.105])
 ([10.252.139.105])
 by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2020 13:18:30 -0800
To: Bernie Innocenti <bernie@codewiz.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
References: <1ae8f294-a6c7-d104-8e57-a86cf5b9b07c@codewiz.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f2c43959-aa1f-6136-f387-e4f44c2f889d@linux.intel.com>
Date: Thu, 2 Jan 2020 12:00:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1ae8f294-a6c7-d104-8e57-a86cf5b9b07c@codewiz.org>
Content-Language: en-US
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: SOF: Intel: Fix CFL and CML FW
 nocodec binary names.
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

CgpPbiAxMi8yOS8xOSA2OjE1IFBNLCBCZXJuaWUgSW5ub2NlbnRpIHdyb3RlOgo+IEdyZWV0aW5n
cyBMaWFtIGFuZCBQaWVycmUsCj4gCj4gID4gQEAgLTE0OSw3ICsxNDksNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHNvZl9kZXZfZGVzYyBjbWxfZGVzYyA9IHsKPiAgPsKgwqDCoMKgIC5jaGlwX2lu
Zm8gPSAmY25sX2NoaXBfaW5mbywKPiAgPsKgwqDCoMKgIC5kZWZhdWx0X2Z3X3BhdGggPSAiaW50
ZWwvc29mIiwKPiAgPsKgwqDCoMKgIC5kZWZhdWx0X3RwbGdfcGF0aCA9ICJpbnRlbC9zb2YtdHBs
ZyIsCj4gID4twqDCoMKgIC5ub2NvZGVjX2Z3X2ZpbGVuYW1lID0gInNvZi1jbmwucmkiLAo+ICA+
K8KgwqDCoCAubm9jb2RlY19md19maWxlbmFtZSA9ICJzb2YtY21sLnJpIiwKPiAKPiBXaGVyZSBp
cyB0aGlzIG5ldyBmaXJtd2FyZSBmaWxlPyBUaGlzIHBhdGNoIGhhcyBmbG93biBpbnRvIEZlZG9y
YSAKPiBrZXJuZWxzIDUuNC41LTMwMS5mYzMxIGFuZCA1LjUuMC0wLnJjMy5naXQwLjEuZmMzMiwg
YW5kIG5vdyBJJ20gZ2V0dGluZyAKPiB0aGlzIGVycm9yIHdoZW4gdGhlIG1vZHVsZSBsb2FkcyBv
biBhIFRoaW5rcGFkIFgxIEdlbiA3Ogo+IAo+ICDCoCBzb2YtYXVkaW8tcGNpIDAwMDA6MDA6MWYu
MzogRGlyZWN0IGZpcm13YXJlIGxvYWQgZm9yIAo+IGludGVsL3NvZi9zb2YtY21sLnJpIGZhaWxl
ZCB3aXRoIGVycm9yIC0yCj4gCj4gVGhlIG90aGVyIC5yaSBmaWxlcyBjb21lIHdpdGggYWxzYS1m
aXJtd2FyZSwgYnV0IHNvZi1jbWwucmkgaXMgYWJzZW50IGluIAo+IHRoZSBsYXRlc3QgdXBzdHJl
YW0gcmVsZWFzZSAoYWxzYS1maXJtd2FyZS0xLjIuMSkuCj4gCj4gVGhlIG9ubHkgcmVmZXJlbmNl
IEkgY291bGQgZmluZCBpcyB0aGlzIHN5bWxpbmssIGJ1dCBpdCdzIG5vdCBjbGVhciB0byAKPiBt
ZSBob3cgYW5kIHdoZW4gaXQgd2lsbCBnZXQgaW50byBkaXN0cmlidXRpb25zOgo+IAo+IAo+IGh0
dHBzOi8vZ2l0aHViLmNvbS90aGVzb2Zwcm9qZWN0L2xpbnV4LWZpcm13YXJlL2NvbW1pdC9iZWZm
NzMyZTY2NDJiZDc3ZGFjNWRkMDg1MTQyNjRmMDU1ZmM0ZDEwI2RpZmYtNzZjMTQxNzEyNTYzY2M5
ZDQ3MzBlYjYzYWNiMzZhZDVSMzgwNy1SMzgwOCAKClllcywgc29ycnkgZm9yIHRoZSBkZWxheS4g
d2UgcnVuIG91dCBvZiB0aW1lIGF0IHRoZSBlbmQgb2YgMjAxOSAobmVlZGVkIAp0byB2ZXJpZnkg
dGhlIGNvbXBpbGF0aW9uIG9mIHRoZSBmaXJtd2FyZSBzaWduZWQgd2l0aCB0aGUgY29tbXVuaXR5
IGtleSAKYW5kIG1hdGNoaW5nIGNoYW5nZXMgaW4gdGhlIFNPRiBkcml2ZXIgdG8gc2VsZWN0IHRo
ZSByaWdodCBmaWxlcyBbMV0pLiAKT25jZSB0aGlzIGlzIGRvbmUsIHdlIHdpbGwgbWFrZSBhIHB1
bGwgcmVxdWVzdCBzbyB0aGF0IHRoZSByZWxlYXNlcyBmbG93IAppbnRvIGxpbnV4LWZpcm13YXJl
LgoKWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS90aGVzb2Zwcm9qZWN0L2xpbnV4L3B1bGwvMTY0Ngpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
