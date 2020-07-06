Return-Path: <SRS0=aG7p=AR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B07CC433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:03:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2407520702
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="igvKKz1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2407520702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95C331615;
	Mon,  6 Jul 2020 22:02:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95C331615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594065780;
	bh=ttDXbpynqgW1PV/DO9FLYuCvO0lJZmGpt4Z7ZkYHL7E=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=igvKKz1j93IM2yc/xL50MqG8sUpAcVbSgCXYl3hTIETIyqZmWUDgloZ5+BFcfVOCi
	 8pzz/0OwCAwVHComJSTwaG/JwZqHMgAYnmFTyCUdur+bReAFZeEu2dqidGeHum8zSZ
	 ivrN5DOwGgrovBTYvSQEnjHSL4sbAX1Tio6eziwY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 256BFF8015A;
	Mon,  6 Jul 2020 22:02:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65475F8011F; Mon,  6 Jul 2020 22:02:08 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39338F8011F
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2020 22:02:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39338F8011F
IronPort-SDR: 5Kd4YUQzGWruO8b3csgK5jshWZm/sD/6SMVrb5vyPyl1S/CZPUCHnmY7GxwOHWpAakavGXztNs
 6omxJS+qDYeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="149010100"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="149010100"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 13:01:56 -0700
IronPort-SDR: VUKmUR10U1sqJH7T02+wDHBv+uUKDaJvr0GbreOnsgCn9gIadahb1LRg3YFuOQq7g7sQ11uoW6
 HoW+kw/MMJaA==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="315276273"
Received: from mghaithx-mobl1.ger.corp.intel.com (HELO [10.254.110.83])
 ([10.254.110.83])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 13:01:55 -0700
Subject: Re: [PATCH v2 03/10] topology: decode: Remove decoding values for
 enum control
To: Piotr Maziarz <piotrx.maziarz@linux.intel.com>, alsa-devel@alsa-project.org
References: <1594026363-30276-1-git-send-email-piotrx.maziarz@linux.intel.com>
 <1594026363-30276-4-git-send-email-piotrx.maziarz@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c1f9f8f8-184e-7472-9c68-c0da13f5375a@linux.intel.com>
Date: Mon, 6 Jul 2020 14:54:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1594026363-30276-4-git-send-email-piotrx.maziarz@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@intel.com
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 7/6/20 4:05 AM, Piotr Maziarz wrote:
> Values have no representation in UCM file, therefore there is no need to

Sorry, I don't get the logical assertion here. What is the link or 
dependency between UCM and topology?

> populate them. Also memory for values wasn't allocated which was causing
> undefined behaviour.
> 
> Change-Id: I86b990d20808091eb61fb6710b35a0c1f1cbce10
> ---
>   src/topology/ctl.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/src/topology/ctl.c b/src/topology/ctl.c
> index 0aa49ab..02e482e 100644
> --- a/src/topology/ctl.c
> +++ b/src/topology/ctl.c
> @@ -1367,11 +1367,8 @@ int tplg_decode_control_enum1(snd_tplg_t *tplg,
>   		et->texts = tplg_calloc(heap, sizeof(char *) * ec->items);
>   		if (!et->texts)
>   			return -ENOMEM;
> -		for (i = 0; i < ec->items; i++) {
> -			unsigned int j = i * sizeof(int) * ENUM_VAL_SIZE;
> +		for (i = 0; i < ec->items; i++)
>   			et->texts[i] = ec->texts[i];
> -			et->values[i] = (int *)&ec->values[j];
> -		}
>   	}
>   
>   	et->map = tplg_calloc(heap, sizeof(struct snd_tplg_channel_map_template));
> 
