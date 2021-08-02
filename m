Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD28CC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 21:06:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712FF60F4B
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 21:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 712FF60F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3661F1713;
	Mon,  2 Aug 2021 23:05:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3661F1713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627938381;
	bh=kOJP9YcQCknQSgvOxHhwRxgy88i1CQupJ0pwITjsdZg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gohQEdiijsHSumUy8flB/P55OjfICmlvT/7SSBHn7HkE3tXbFATw2+qzv2r72FlFl
	 2uiDNdDpYKhJteXbcfGySGW2X1dr+XCBWEzrMVcK65KevIi3FoKsOnIQqgGODUuq/y
	 kKpMJYNZZD07UuAH9fxSFocV5LaPp8krj8zFG8p0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B884CF801F7;
	Mon,  2 Aug 2021 23:05:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2147F8025F; Mon,  2 Aug 2021 23:05:28 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76E36F8014D
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 23:05:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76E36F8014D
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="213261199"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; d="scan'208";a="213261199"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 14:05:19 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; d="scan'208";a="501960736"
Received: from skarumur-mobl.amr.corp.intel.com (HELO [10.212.72.192])
 ([10.212.72.192])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 14:05:18 -0700
Subject: Re: [PATCH] ASoC: Intel: boards: Fix CONFIG_SND_SOC_SDW_MOCKUP select
To: Nathan Chancellor <nathan@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
References: <20210802190351.3201677-1-nathan@kernel.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3929126b-b4f0-bdf5-56f5-28662c7b7b44@linux.intel.com>
Date: Mon, 2 Aug 2021 16:05:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802190351.3201677-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>
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



On 8/2/21 2:03 PM, Nathan Chancellor wrote:
> When CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH is enabled without
> CONFIG_EXPERT, there is a Kconfig warning about unmet dependencies:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_SDW_MOCKUP
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
> EXPERT [=n] && SOUNDWIRE [=y]
>   Selected by [y]:
>   - SND_SOC_INTEL_SOUNDWIRE_SOF_MACH [=y] && ...
> 
> Selecting a symbol does not account for dependencies so if symbol A
> selects symbol B which depends on symbol C, symbol B or its select of
> symbol A should depend on symbol C as well.
> 
> Make the CONFIG_SND_SOC_SDW_MOCKUP select in
> CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH depend on CONFIG_EXPERT as the
> help text for CONFIG_SND_SOC_SDW_MOCKUP indicates it is intended to be a
> development option.
> 
> Fixes: 0ccac3bcf356 ("ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> An alternative here is if CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH wants
> to unconditionally select CONFIG_SND_SOC_SDW_MOCKUP, the "depends on
> EXPERT" can be moved to the prompt (tristate "..." if EXPERT). I am
> happy to send a new patch if that is what is desired.

Thanks for the patch Nathan, I added this depends on EXPERT and forgot
about it when I updated the machine driver.

Maybe a better alternate would be

imply SND_SOC_SDW_MOCKUP

We don't necessarily want the EXPERT part to be shown in the machine
driver lists.


> 
>  sound/soc/intel/boards/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index 046955bf717c..8284c46d7435 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -602,7 +602,7 @@ config SND_SOC_INTEL_SOUNDWIRE_SOF_MACH
>  	select SND_SOC_DMIC
>  	select SND_SOC_INTEL_HDA_DSP_COMMON
>  	select SND_SOC_INTEL_SOF_MAXIM_COMMON
> -	select SND_SOC_SDW_MOCKUP
> +	select SND_SOC_SDW_MOCKUP if EXPERT
>  	help
>  	  Add support for Intel SoundWire-based platforms connected to
>  	  MAX98373, RT700, RT711, RT1308 and RT715
> 
> base-commit: 170c0d7460fc4aa522995ae4096b5a442f50a1fc
> 
