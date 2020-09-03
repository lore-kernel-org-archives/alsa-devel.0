Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA39CC433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:49:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4178920775
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RfMlgIRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4178920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFD321906;
	Thu,  3 Sep 2020 17:48:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFD321906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599148174;
	bh=q4m0WxT6JL/O9hWKjisShAd2s4GwKY/mouWtArn7qnU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RfMlgIRrZuzJWgrAlBqEAe/4k7qCaRRHMTi2iX9M4G1hQj/JWVpjd/REKAtaHC7tX
	 eCkQxog+CDp6dSydhnJ8uQA+lMi4NnbysmNX8tIDRyxy99JfM4zJmeLm1T+GbkZjl2
	 xLNm8hOaXcqWllJJlHTN5q2mZ0XZXft5p8muiAxM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58095F800BA;
	Thu,  3 Sep 2020 17:48:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 711A5F80217; Thu,  3 Sep 2020 17:47:52 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA99BF800BA
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 17:47:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA99BF800BA
IronPort-SDR: /L8e6kn++cr91Jg2s1bFf2ekPFMAGNsXaPJtjhkgu1RUebS4P93tRfE+iUZw+hx1UfD63PgdAq
 8Nb/RwUZ+OpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="219153264"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; d="scan'208";a="219153264"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 08:47:35 -0700
IronPort-SDR: 02HMsGSDHA7JkyN8IszHHtFc4klZm85DZSDSX9WHjgZoJ1VS100XpYBUxC/3Q7xZFw6VGRyU2X
 VZ5UnQUMCsXQ==
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; d="scan'208";a="446952734"
Received: from kdkrake-mobl.amr.corp.intel.com (HELO [10.212.29.67])
 ([10.212.29.67])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 08:47:33 -0700
Subject: Re: [PATCH 0/7] ASoC: soundwire: Move sdw stream operations to
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
 <20200903104248.GQ2639@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <033ea005-e948-c2c6-9bd4-e074d3effde0@linux.intel.com>
Date: Thu, 3 Sep 2020 09:05:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903104248.GQ2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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



On 9/3/20 5:42 AM, Vinod Koul wrote:
> On 01-09-20, 23:02, Bard Liao wrote:
>> sdw stream operation APIs can be called once per stream. dailink
>> callbacks are good places to call these APIs.
> 
> Again, please mention here if this is to be merged thru sdw tree or ASoC
> tree

Good point, I thought it wouldn't matter but it does. I just gave it a 
try and there seems to be a conflict on Mark's tree w/ 
drivers/soundwire/intel.c (likely due to missing patches already added 
to Vinod's tree).

So this should go to Vinod's tree with Mark's Acked-by tag on the ASoC 
changes.

Alternatively we can also split this in two, with ASoC-only and 
SoundWire-only patches in separate series if it's easier for 
maintainers. We would lose the rationale for the changes but that's not 
essential.

>> Pierre-Louis Bossart (7):
>>    ASoC: soc-dai: clarify return value for get_sdw_stream()
>>    soundwire: stream: fix NULL/IS_ERR confusion
>>    soundwire: intel: fix NULL/ERR_PTR confusion
>>    ASOC: Intel: sof_sdw: add dailink .trigger callback
>>    ASOC: Intel: sof_sdw: add dailink .prepare and .hw_free callback
> 
> These should be ASoC

Right. if you are fine with the content and this goes in your tree, can 
this be modified while applying? Or do want a v2?

>>    soundwire: intel: remove .trigger operation
>>    soundwire: intel: remove stream handling from .prepare and .hw_free
>>
>>   drivers/soundwire/intel.c        | 60 ++++-------------------
>>   drivers/soundwire/stream.c       |  2 +-
>>   include/sound/soc-dai.h          |  3 +-
>>   sound/soc/intel/boards/sof_sdw.c | 81 ++++++++++++++++++++++++++++++++
>>   4 files changed, 92 insertions(+), 54 deletions(-)
>>
>> -- 
>> 2.17.1
> 
