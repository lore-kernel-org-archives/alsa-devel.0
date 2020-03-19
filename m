Return-Path: <SRS0=4Ztp=5E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7F5C4332B
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 23:18:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524F12076C
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 23:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pJKKxzGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524F12076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A15117B7;
	Fri, 20 Mar 2020 00:17:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A15117B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584659923;
	bh=zD3fF3Keozh3LQhuxVojd1PsStm7DEIMooA5TLlVqq0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pJKKxzGifARHGsEe9RXmUVnUupxcdpO8+jgNgSZLj+KJXHh+5kHlGuwcxuU6i7opI
	 a/cATrJPidg9TFV3GrG4HlOn0j38cY98I+dapH+ZyKFoQourgq91G6o0vC+9CIULN+
	 5+hT7qoTPLe+2FvEOg/HaYz01o2CWGAXem4cPmV8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8DDEF80217;
	Fri, 20 Mar 2020 00:17:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F08BBF8022B; Fri, 20 Mar 2020 00:17:50 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6869CF800DD
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 00:17:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6869CF800DD
IronPort-SDR: uNG3CuAZG+1psY+oBKHbWyr+WyfFuYb9SgAq0LryCiH5QjmUJxrIMuNxid9UxAQk1HOrN3xdv6
 r9Vn0h0EhKNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2020 16:17:40 -0700
IronPort-SDR: /dxDJbBuOLRtLE4QLXYejRMH7H8VHqfIrJUYBaBk0VqS2DT+27RmXx5N7HbDclZPxji7IiLihG
 YcN/xPnhfj5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,573,1574150400"; d="scan'208";a="418524587"
Received: from greenley-mobl2.amr.corp.intel.com (HELO [10.255.33.221])
 ([10.255.33.221])
 by orsmga005.jf.intel.com with ESMTP; 19 Mar 2020 16:17:39 -0700
Subject: Re: [PATCH] ASoC: Intel: broadwell: Revert SSP0 link to use dummy
 components
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20200319211204.21580-1-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <43d75d9e-5dfe-7dee-aa7d-a8a1c0b7876f@linux.intel.com>
Date: Thu, 19 Mar 2020 17:20:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319211204.21580-1-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, lgirdwood@gmail.com, linux@dominikbrodowski.net,
 tiwai@suse.com
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



On 3/19/20 4:12 PM, Cezary Rojewski wrote:
> Commit:
> "ASoC: Intel: broadwell: change cpu_dai and platform components for SOF

checkpatch.pl probably reports the format doesn't follow conventions?

> 
> while enabling bdw on SOF, changed behavior for non-SOF solutions. In
> essence replacing platform 'dummy' with actual 'platform' causes
> redundant stream initialization to occur during audio start. hw_params
> for haswell-pcm destroys initial stream right after its creation - only
> to recreate it again from proceed from there.
> 
> While harmless so far, this flow ain't right and should be corrected.

isn't

> The actual need for dummy components for SSP0 link is questionable but
> that issue is subject for another series.

If we want to be consistent, the same use of a dummy platform component 
needs to be applied to bdw-rt5677.c and bdw-rt5650.c

> 
> Link to first message in conversation:
> https://lkml.org/lkml/2020/3/18/54
> 
> Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Fixes: 64df6afa0dab ("ASoC: Intel: broadwell: change cpu_dai and platform components for SOF")
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>   sound/soc/intel/boards/broadwell.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
> index 0776ea2d4f36..9b639475e99f 100644
> --- a/sound/soc/intel/boards/broadwell.c
> +++ b/sound/soc/intel/boards/broadwell.c
> @@ -167,9 +167,6 @@ SND_SOC_DAILINK_DEF(codec,
>   #if IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
>   SND_SOC_DAILINK_DEF(ssp0_port,
>   	    DAILINK_COMP_ARRAY(COMP_CPU("ssp0-port")));
> -#else
> -SND_SOC_DAILINK_DEF(ssp0_port,
> -	    DAILINK_COMP_ARRAY(COMP_DUMMY()));
>   #endif
>   
>   /* broadwell digital audio interface glue - connects codec <--> CPU */
> @@ -225,7 +222,11 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
>   		.ops = &broadwell_rt286_ops,
>   		.dpcm_playback = 1,
>   		.dpcm_capture = 1,
> +#if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
> +		SND_SOC_DAILINK_REG(dummy, codec, dummy),
> +#else
>   		SND_SOC_DAILINK_REG(ssp0_port, codec, platform),
> +#endif
>   	},
>   };
>   
> 
