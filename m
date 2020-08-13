Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6698C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:57:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FF920774
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oArs9ElU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FF920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA8A21616;
	Thu, 13 Aug 2020 20:56:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA8A21616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597345035;
	bh=9lPVUeCvY1FKCuCU7lNH1oiqQ+cRIF84VuNwfg6H56I=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oArs9ElUqaPdyK49L4ii4nzmnmywbxJBgFnfMewr7X+a3xd1Av6v86noDiqrnXC2b
	 x6TDQb7PPrM+2YMFp0JRcY3jXfPj4ljN2+q11uaCK3s2+jz0lC1LFtHT8gRuMEMg27
	 wpwjxbqbq93OfY7NnfxL91b+rr8E103k110Ca3mY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90DE5F80100;
	Thu, 13 Aug 2020 20:56:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D8C6F8015B; Thu, 13 Aug 2020 20:56:23 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71B0AF80100
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 20:56:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71B0AF80100
IronPort-SDR: X8RLT88VZCbN8TOSSirYCV8P+7b7Yu2MFxQ3GkyKPe+AvdpOGk74TYpD7rWa9TYM/7/4h3d5Lk
 X4ULrAAQBa2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="218639599"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="218639599"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 11:56:12 -0700
IronPort-SDR: aJ5GROhKxCiZoKtPMtse38aqxCVExrtiHdqJlEuxCAcvDFj/d0+Ny60kqWQcIQsp9M3RYG8jqG
 +Y1n4WZxNp9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="325507728"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008.jf.intel.com with ESMTP; 13 Aug 2020 11:56:08 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@intel.com>)
 id 1k6IOT-008Uum-Gu; Thu, 13 Aug 2020 21:56:05 +0300
Date: Thu, 13 Aug 2020 21:56:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v4 11/13] ASoC: Intel: broadwell: Remove haswell-solution
 specific code
Message-ID: <20200813185605.GD1891694@smile.fi.intel.com>
References: <20200812205753.29115-1-cezary.rojewski@intel.com>
 <20200812205753.29115-12-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812205753.29115-12-cezary.rojewski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 filip.kaczmarski@intel.com, harshapriya.n@intel.com, marcin.barlik@intel.com,
 zwisler@google.com, lgirdwood@gmail.com, tiwai@suse.com,
 filip.proborszcz@intel.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com, michal.wasko@intel.com,
 cujomalainey@chromium.org, krzysztof.hejmowski@intel.com,
 ppapierkowski@habana.ai, vamshi.krishna.gopal@intel.com
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

On Wed, Aug 12, 2020 at 10:57:51PM +0200, Cezary Rojewski wrote:
> Remove code specific to sound/soc/intel/haswell. Update BE dai_link
> definition to provide seamless transition to catpt solution.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  sound/soc/intel/boards/broadwell.c | 33 ------------------------------
>  1 file changed, 33 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
> index f6399077d291..ea2818f27105 100644
> --- a/sound/soc/intel/boards/broadwell.c
> +++ b/sound/soc/intel/boards/broadwell.c
> @@ -14,9 +14,6 @@
>  #include <sound/pcm_params.h>
>  #include <sound/soc-acpi.h>
>  
> -#include "../common/sst-dsp.h"
> -#include "../haswell/sst-haswell-ipc.h"
> -
>  #include "../../codecs/rt286.h"
>  
>  static struct snd_soc_jack broadwell_headset;
> @@ -122,27 +119,6 @@ static const struct snd_soc_ops broadwell_rt286_ops = {
>  	.hw_params = broadwell_rt286_hw_params,
>  };
>  
> -#if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
> -static int broadwell_rtd_init(struct snd_soc_pcm_runtime *rtd)
> -{
> -	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
> -	struct sst_pdata *pdata = dev_get_platdata(component->dev);
> -	struct sst_hsw *broadwell = pdata->dsp;
> -	int ret;
> -
> -	/* Set ADSP SSP port settings */
> -	ret = sst_hsw_device_set_config(broadwell, SST_HSW_DEVICE_SSP_0,
> -		SST_HSW_DEVICE_MCLK_FREQ_24_MHZ,
> -		SST_HSW_DEVICE_CLOCK_MASTER, 9);
> -	if (ret < 0) {
> -		dev_err(rtd->dev, "error: failed to set device config\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -#endif
> -
>  static const unsigned int channels[] = {
>  	2,
>  };
> @@ -189,10 +165,8 @@ SND_SOC_DAILINK_DEF(platform,
>  SND_SOC_DAILINK_DEF(codec,
>  	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-INT343A:00", "rt286-aif1")));
>  
> -#if IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
>  SND_SOC_DAILINK_DEF(ssp0_port,
>  	    DAILINK_COMP_ARRAY(COMP_CPU("ssp0-port")));
> -#endif
>  
>  /* broadwell digital audio interface glue - connects codec <--> CPU */
>  static struct snd_soc_dai_link broadwell_rt286_dais[] = {
> @@ -201,9 +175,6 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
>  		.name = "System PCM",
>  		.stream_name = "System Playback/Capture",
>  		.dynamic = 1,
> -#if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
> -		.init = broadwell_rtd_init,
> -#endif
>  		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
>  		.ops = &broadwell_fe_ops,
>  		.dpcm_playback = 1,
> @@ -248,11 +219,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
>  		.ops = &broadwell_rt286_ops,
>  		.dpcm_playback = 1,
>  		.dpcm_capture = 1,
> -#if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
> -		SND_SOC_DAILINK_REG(dummy, codec, dummy),
> -#else
>  		SND_SOC_DAILINK_REG(ssp0_port, codec, platform),
> -#endif
>  	},
>  };
>  
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


