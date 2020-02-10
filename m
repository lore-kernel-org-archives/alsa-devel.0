Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD2C352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:44:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9D52082F
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qMqSccoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9D52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8FD91686;
	Mon, 10 Feb 2020 15:43:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8FD91686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581345883;
	bh=gJHHb23T9BMLTcn1NTRQ5hy/L7rTYUfUceeiddINhLg=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qMqSccoDFbRguxHgCTqa45RXuPfYdDlrfjqSeshTiAVGuQ1JdDy3bByLMxq14BIGj
	 xkfN3B3Cm+vNAWTX90M3i3MBO74D9UtUOZ7U9qeYJmpze6OA0gGWZUER7b7tzxq6d6
	 QPYnl42TsDhhBR2gvdnFIOgQ/7pGtZatm+8bN/sk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94CCEF8027D;
	Mon, 10 Feb 2020 15:42:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB08BF8027D; Mon, 10 Feb 2020 15:42:13 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16A78F8014F
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 15:42:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16A78F8014F
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Feb 2020 06:42:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; d="scan'208";a="226213722"
Received: from ykatsuma-mobl1.gar.corp.intel.com (HELO [10.251.140.95])
 ([10.251.140.95])
 by fmsmga007.fm.intel.com with ESMTP; 10 Feb 2020 06:42:08 -0800
To: Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
 robh+dt@kernel.org
References: <20200210095817.13226-1-daniel.baluta@oss.nxp.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <73c72736-ca09-1501-4978-e0041b605aed@linux.intel.com>
Date: Mon, 10 Feb 2020 08:23:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210095817.13226-1-daniel.baluta@oss.nxp.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [alsa-devel] [RESEND 0/4] Add a better separation between i.MX8
 families
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

CgpPbiAyLzEwLzIwIDM6NTggQU0sIERhbmllbCBCYWx1dGEgd3JvdGU6Cj4gRnJvbTogRGFuaWVs
IEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPgo+IAo+IFNvIGZhciB0aGUgaW1wbGVtZW50
YXRpb24gd2FzIGRlc2lnbmVkIHRvIHN1cHBvcnQgIGEgZ2VuZXJpYyBwbGF0Zm9ybQo+IG5hbWVk
IGkuTVg4LiBBbnlob3csIG5vdyB3b3JraW5nIHdpdGggc3BlY2lmaWMgaS5NWDggaW5zdGFuY2Vz
IHdlIG5lZWQKPiB0byBhY2NvdW50IGZvciB0aGUgZGlmZmVyZW5jZXMuCj4gCj4gaS5NWDggbmFt
aW5nIGNhbiBiZSBjb25mdXNpbmcgYXQgdGhlIGZpcnN0IGdsYW5jZSwgc28gd2UgbmVlZCB0byBo
YXZlCj4gYSBjbGVhbiBzZXBhcmF0aW9uIGJldHdlZW4gZGlmZmVyZW50IHBsYXRmb3Jtcy4KPiAK
PiBIZXJlIGlzIHRoZSBzcGxpdCBvZiBpLk1YOCBwZXIgcGxhdGZvcm1zLiBOb3RpY2UgdGhhdCBp
Lk1YOCBuYW1lcwo+IHRoZSBlbnRpcmUgZmFtaWx5LCBidXQgYWxzbyBhIHN1Yi1mYW1pbHkuCj4g
Cj4gaW14OAo+IOKUnOKUgOKUgCBpbXg4Cj4g4pSCwqDCoCDilJTilIDilIAgaW14OHFtICgqKQo+
IOKUnOKUgOKUgCBpbXg4bQo+IOKUgsKgwqAg4pSc4pSA4pSAIGlteDhtbQo+IOKUgsKgwqAg4pSc
4pSA4pSAIGlteDhtbgo+IOKUgsKgwqAg4pSc4pSA4pSAIGlteDhtcCAoKikKPiDilILCoMKgIOKU
lOKUgOKUgCBpbXg4bXEKPiDilJTilIDilIAgaW14OHgKPiAgICAgIOKUlOKUgOKUgCBpbXg4cXhw
ICgqKQo+IAo+IFBsYXRmb3JtcyBtYXJrZWQgd2l0aCAoKikgY29udGFpbiBhIERTUC4gSW4gdGhl
IGZ1dHVyZSB0aGVyZSBtaWdodCBiZQo+IG1vcmUgcGxhdGZvcm1zLgo+IAo+IFRoaXMgcGF0Y2hz
ZXJpZXMgZG9lcyB0aGUgZm9sbG93aW5nOgo+IAkqIHJlbmFtZXMgaW14OCB0byBpbXg4eCAoYmVj
YXVzZSB0aGUgb25seSBzdXBwb3J0ZWQgcGxhdGZvcm0gbm93Cj4gICAgICAgICAgaXMgaW14OHF4
cCkuCj4gICAgICAgICAgKiBhZGRzIHN1cHBvcnQgZm9yIGlteDggKHdoaWNoIGlzIGlteDhxbSkK
PiAKPiBQYXVsIE9sYXJ1ICg0KToKPiAgICBBU29DOiBTT0Y6IFJlbmFtZSBpLk1YOCBwbGF0Zm9y
bSB0byBpLk1YOFgKPiAgICBBU29DOiBTT0Y6IGlteDg6IEFkZCBvcHMgZm9yIGkuTVg4UU0KPiAg
ICBBU29DOiBTT0Y6IEFkZCBpLk1YOFFNIGRldmljZSBkZXNjcmlwdG9yCj4gICAgZHQtYmluZGlu
Z3M6IGRzcDogZnNsOiBBZGQgZnNsLGlteDhxbS1kc3AgZW50cnkKClJldmlld2VkLWJ5OiBQaWVy
cmUtTG91aXMgQm9zc2FydCA8cGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tPgoK
PiAKPiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RzcC9mc2wsZHNwLnlhbWwgICAgICB8ICAx
ICsKPiAgIHNvdW5kL3NvYy9zb2YvaW14L2lteDguYyAgICAgICAgICAgICAgICAgICAgICB8IDU3
ICsrKysrKysrKysrKysrKysrKy0KPiAgIHNvdW5kL3NvYy9zb2Yvc29mLW9mLWRldi5jICAgICAg
ICAgICAgICAgICAgICB8IDEwICsrKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgNjUgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
