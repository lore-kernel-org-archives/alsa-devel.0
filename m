Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8F0C33CB1
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:58:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC17C2073A
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Iumjm0xZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC17C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B885A17B4;
	Thu, 16 Jan 2020 16:57:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B885A17B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579190297;
	bh=FfMT2LBjY7msELvqWr9zpYLiSbvcqX4haZx3T+dSgbg=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Iumjm0xZHI1SXVFE3ICDjpq7QWMgXGyNTzOiYP/UsEbCN4QKUddUTLEE3POCxSBkX
	 a6ChWVI+R9iVvslbTNkv46TRtU7/+3cy67tbJdqwsChI7eO2JYlhrOUG/m6JzD1rIZ
	 jC9bLR7p4jxSHpgcv2Het5UAU4wwPSwBTha97bkw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 300DEF8014D;
	Thu, 16 Jan 2020 16:57:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24771F8014E; Thu, 16 Jan 2020 16:57:26 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7953AF80086
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 16:57:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7953AF80086
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Jan 2020 07:57:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,326,1574150400"; d="scan'208";a="274042229"
Received: from frederic-mobl1.amr.corp.intel.com (HELO [10.251.150.187])
 ([10.251.150.187])
 by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2020 07:57:14 -0800
To: Vinod Koul <vkoul@kernel.org>
References: <20200114233124.13888-1-pierre-louis.bossart@linux.intel.com>
 <20200116120459.GP2818@vkoul-mobl> <20200116120918.GR2818@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bd2dc7aa-d626-6efc-9ba2-9212a23855c4@linux.intel.com>
Date: Thu, 16 Jan 2020 08:27:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116120918.GR2818@vkoul-mobl>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] soundwire: cadence: fix kernel-doc
 parameter descriptions
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

CgpPbiAxLzE2LzIwIDY6MDkgQU0sIFZpbm9kIEtvdWwgd3JvdGU6Cj4gT24gMTYtMDEtMjAsIDE3
OjM1LCBWaW5vZCBLb3VsIHdyb3RlOgo+PiBPbiAxNC0wMS0yMCwgMTc6MzEsIFBpZXJyZS1Mb3Vp
cyBCb3NzYXJ0IHdyb3RlOgo+Pj4gRml4IHByZXZpb3VzIHVwZGF0ZSwgYmFkIGdpdCBtZXJnZSBs
aWtlbHkuIG9vcHMuCj4+Cj4+IEFwcGxpZWQsIHRoYW5rcwo+IAo+IEJ0dyBJIHN0aWxsIGhhdmUg
dGhlc2Ugd2FybnMgb24gbXkgbmV4dCB3aXRoIFc9MQo+IAo+IGRyaXZlcnMvc291bmR3aXJlL2lu
dGVsX2luaXQuYzoxOTM6Nzogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhz
ZHdfaW50ZWxfaW5pdOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCj4gICB2b2lkICpzZHdfaW50
ZWxfaW5pdChhY3BpX2hhbmRsZSAqcGFyZW50X2hhbmRsZSwgc3RydWN0IHNkd19pbnRlbF9yZXMg
KnJlcykKPiAgICAgICAgIF5+fn5+fn5+fn5+fn5+Cj4gZHJpdmVycy9zb3VuZHdpcmUvY2FkZW5j
ZV9tYXN0ZXIuYzoxMDIyOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdj
bG9ja19zdG9wX2V4aXQnIG5vdCBkZXNjcmliZWQgaW4gJ3Nkd19jZG5zX2luaXQnCj4gICAgTEQg
W01dICBkcml2ZXJzL3NvdW5kd2lyZS9zb3VuZHdpcmUtY2FkZW5jZS5vCj4gZHJpdmVycy9zb3Vu
ZHdpcmUvaW50ZWxfaW5pdC5jOjIxNDogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1l
bWJlciAnY3R4JyBub3QgZGVzY3JpYmVkIGluICdzZHdfaW50ZWxfZXhpdCcKPiBkcml2ZXJzL3Nv
dW5kd2lyZS9pbnRlbF9pbml0LmM6MjE0OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1l
dGVyICdhcmcnIGRlc2NyaXB0aW9uIGluICdzZHdfaW50ZWxfZXhpdCcKCkFsbCBvZiB0aGlzIGlz
IHJlcGxhY2VkIGJ5IG5ldyBjb2RlIGFscmVhZHkgc3VibWl0dGVkIGZvciByZXZpZXcuIHRyeSAK
b3VyIFNPRiB1cHN0cmVhbS9zb3VuZHdpcmUgYnJhbmNoIGFuZCB5b3UnbGwgc2VlLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2Et
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
