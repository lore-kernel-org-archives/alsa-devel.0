Return-Path: <SRS0=q21C=4W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B27C3F2D1
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:28:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1E220848
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p2NtHyr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1E220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 673611655;
	Thu,  5 Mar 2020 14:27:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 673611655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583414928;
	bh=QlcEZSDM+WXcCcdL0YoCDXBEfnShvkK4YYQ4cGgTR14=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p2NtHyr5M3d0d5+yF3iM5io2QseyHwzAKXIOmtwOcTdUJvePkZnfKQqc5klSFvr14
	 0Swkf5F8d+NEDasz1zHcQs0wKKpRkdHR2lPNs66XaxjvhJo5TXw0CHEWXwo9Lv+fnN
	 PBwQiKS8GjyJQHrEmm6GKJbUZT5a6yyYJgV3xZAA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A59B9F8025F;
	Thu,  5 Mar 2020 14:27:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93F8FF8026A; Thu,  5 Mar 2020 14:27:55 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36F13F80245
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2020 14:27:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36F13F80245
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Mar 2020 05:27:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; d="scan'208";a="439500234"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga005.fm.intel.com with ESMTP; 05 Mar 2020 05:27:41 -0800
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1j9qXP-0076Vx-Ka; Thu, 05 Mar 2020 15:27:43 +0200
Date: Thu, 5 Mar 2020 15:27:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 3/3] ASoC: Intel: kbl-rt5660: use .exit() dailink
 callback to release gpiod
Message-ID: <20200305132743.GK1224808@smile.fi.intel.com>
References: <20200305130616.28658-1-pierre-louis.bossart@linux.intel.com>
 <20200305130616.28658-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305130616.28658-4-pierre-louis.bossart@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

On Thu, Mar 05, 2020 at 07:06:16AM -0600, Pierre-Louis Bossart wrote:
> The gpiod handling is inspired from the bdw-rt5677 code. Apply same

gpiod -> GPIO descriptor

> fix to avoid reference count issue while removing modules for
> consistency.
> 
> The SOF driver does not yet support this machine driver, and module
> load/unload with the SKL driver isn't well supported, so this was not
> tested on a device.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/intel/boards/kbl_rt5660.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5660.c b/sound/soc/intel/boards/kbl_rt5660.c
> index e23dea9ab79a..3ff3afd36536 100644
> --- a/sound/soc/intel/boards/kbl_rt5660.c
> +++ b/sound/soc/intel/boards/kbl_rt5660.c
> @@ -165,8 +165,8 @@ static int kabylake_rt5660_codec_init(struct snd_soc_pcm_runtime *rtd)
>  		dev_warn(component->dev, "Failed to add driver gpios\n");
>  
>  	/* Request rt5660 GPIO for lineout mute control, return if fails */
> -	ctx->gpio_lo_mute = devm_gpiod_get(component->dev, "lineout-mute",
> -					   GPIOD_OUT_HIGH);
> +	ctx->gpio_lo_mute = gpiod_get(component->dev, "lineout-mute",
> +				      GPIOD_OUT_HIGH);
>  	if (IS_ERR(ctx->gpio_lo_mute)) {
>  		dev_err(component->dev, "Can't find GPIO_MUTE# gpio\n");
>  		return PTR_ERR(ctx->gpio_lo_mute);
> @@ -207,6 +207,14 @@ static int kabylake_rt5660_codec_init(struct snd_soc_pcm_runtime *rtd)
>  	return 0;
>  }
>  
> +static void kabylake_rt5660_codec_exit(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(rtd->card);
> +

> +	if (!IS_ERR(ctx->gpio_lo_mute))

Same comment as per previous patch.

> +		gpiod_put(ctx->gpio_lo_mute));
> +}
> +
>  static int kabylake_hdmi_init(struct snd_soc_pcm_runtime *rtd, int device)
>  {
>  	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(rtd->card);
> @@ -421,6 +429,7 @@ static struct snd_soc_dai_link kabylake_rt5660_dais[] = {
>  		.id = 0,
>  		.no_pcm = 1,
>  		.init = kabylake_rt5660_codec_init,
> +		.exit = kabylake_rt5660_codec_exit,
>  		.dai_fmt = SND_SOC_DAIFMT_I2S |
>  		SND_SOC_DAIFMT_NB_NF |
>  		SND_SOC_DAIFMT_CBS_CFS,
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


