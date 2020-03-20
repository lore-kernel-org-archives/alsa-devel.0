Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C957C4332B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:20:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E7E20784
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TwQ6Gk5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E7E20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E99E81655;
	Fri, 20 Mar 2020 19:19:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E99E81655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584728433;
	bh=AxutlDpzQW9EoFsh/f4r4ImmOZ+0DtsisuQF9F9XY00=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TwQ6Gk5pQHoiK09X5cX000kUyagCKPwGhbc089TKV6RXDrH1wNwYgiP/dTEYtgNST
	 ZbN3oXhDXJrahQXwWPoIetZsMii40EhWG+wLJWwHbBolY3VkMpA+tgR0vFHy6YlfJQ
	 jKwAFeiQI3HYRn/7VZ1OIsnIvxXIXpkzlLmV3Zb0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24F14F8028C;
	Fri, 20 Mar 2020 19:18:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 276E0F8028C; Fri, 20 Mar 2020 19:18:09 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3DF7F80227
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 19:18:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3DF7F80227
IronPort-SDR: EYImUzJg5mfiF2S1slUaO4Ls2WHAuXh+grCQnm+udVXAW7hulc+7K+zIeWopNz7giCRsVuOUE5
 5+fGIsYcHZVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 11:18:04 -0700
IronPort-SDR: zbi2N4p/jkWWXG5sygpgaZcdsWnUMpYX5W4p6Y/W5HV3X5nuDH7+9Oz5xclUjfXH7BP4Q7V1oz
 hi6rn+uhtmcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; d="scan'208";a="392230416"
Received: from manallet-mobl.amr.corp.intel.com (HELO [10.255.34.12])
 ([10.255.34.12])
 by orsmga004.jf.intel.com with ESMTP; 20 Mar 2020 11:18:01 -0700
Subject: Re: [PATCH] soundwire: stream: only change state if needed
To: Vinod Koul <vkoul@kernel.org>
References: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
 <20200320141528.GI4885@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f212f561-27aa-265c-3f4c-45b2336ac145@linux.intel.com>
Date: Fri, 20 Mar 2020 09:33:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320141528.GI4885@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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



On 3/20/20 9:15 AM, Vinod Koul wrote:
> On 17-03-20, 05:51, Pierre-Louis Bossart wrote:
>> In a multi-cpu DAI context, the stream routines may be called from
>> multiple DAI callbacks. Make sure the stream state only changes for
>> the first call, and don't return error messages if the target state is
>> already reached.
> 
> For stream-apis we have documented explicitly in Documentation/driver-api/soundwire/stream.rst
> 
> "Bus implements below API for allocate a stream which needs to be called once
> per stream. From ASoC DPCM framework, this stream state maybe linked to
> .startup() operation.
> 
> .. code-block:: c
> 
>    int sdw_alloc_stream(char * stream_name); "
> 
> This is documented for all stream-apis.
> 
> This can be resolved by moving the calling of these APIs from
> master-dais/slave-dais to machine-dais. They are unique in the card.

this change is about prepare/enable/disable/deprepare, not allocation or 
startup.

I see no reason to burden the machine driver with all these steps. It's 
not because QCOM needs this transition that everyone does.

As discussed earlier, QCOM cannot use this functionality because the 
prepare/enable and disable/deprepare are done in the hw_params and 
hw_free respectively. This was never the intended use, but Intel let it 
happen so I'd like you to return the favor. This change has no impact 
for QCOM and simplifies the Intel solution, so why would you object?

Seriously, your replies on all Intel contributions make me wonder if 
this is the QCOM/Linaro SoundWire subsystem, or if we are going to find 
common ground to deal with vastly different underlying architectures?
