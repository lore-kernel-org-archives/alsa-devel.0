Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49896C4167D
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Nov 2023 17:17:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 028EE850;
	Thu,  2 Nov 2023 18:16:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 028EE850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698945458;
	bh=aSupGtKsp0VBACa4qaUgDGY2fD+gSj4vYyST1r2Nv0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ReyE2OoN7NvvT36Ahf6KzE3wk/wkiq/Nk1x83NifDFJWz93FW1ky5Txitkzj0XOhi
	 Ds0PExhTp6/cDgss8I366sqj3w8fjO5QvWgiHQ98GfzTqlkXt632Q9cOwGUc3RfDn0
	 P3tefzVKQpFbY51hq2BdmgDfSF3Qm44NIQtYTIgA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E9637F80425; Thu,  2 Nov 2023 18:16:19 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 98F1CF80290;
	Thu,  2 Nov 2023 18:16:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 360B6F80290; Thu,  2 Nov 2023 18:16:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5A461F8003C
	for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2023 18:16:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A461F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UM/j9zq8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698945373; x=1730481373;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aSupGtKsp0VBACa4qaUgDGY2fD+gSj4vYyST1r2Nv0w=;
  b=UM/j9zq8hKpEcPQnkyVyjwPP5BgZqPJtoCRh9nKf+OhoXoM71W0jqEH8
   gxkvKQRnQR/8ri2CgLUlPg6PtXxVg3iVtnNGoI0Zj+/aS9m1v4WJ7wPw8
   KK0SXcK1JvdL0AbGoZpN9fa242zWVE6du4dC2eP5T6H8AY2h1WlBkHb5o
   M+P8UxJen5Mgou8E1qPdPHNpPqwK2aPzr5ndyXTpqDVI4CSSEHXAqhXAH
   FvYv52YP2dB6vpjvcvaeb+vDSF4O1APVxjD2CpwNhJ8S9wD6nRYu4/fzH
   efHiOzuthCSymgSoJVbpe9dbLwlmBW1XR2+qjYAgOgbaVhPsl5lSxFB7D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="379160220"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200";
   d="scan'208";a="379160220"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 10:16:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="754862965"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200";
   d="scan'208";a="754862965"
Received: from hmfaraby-mobl1.amr.corp.intel.com (HELO [10.209.35.236])
 ([10.209.35.236])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 10:16:08 -0700
Message-ID: <4ed6c0dc-f1f4-41ba-99da-71145885e9ca@linux.intel.com>
Date: Thu, 2 Nov 2023 12:16:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: Intel: sof_rt5682: add mtl_rt5650 support
Content-Language: en-US
To: Mac Chiang <mac.chiang@intel.com>, alsa-devel@alsa-project.org
Cc: cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
References: <20231102164844.6930-1-mac.chiang@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231102164844.6930-1-mac.chiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: VYG3CYG2S7XRRUYT2O7TSSGQTT6F3R2A
X-Message-ID-Hash: VYG3CYG2S7XRRUYT2O7TSSGQTT6F3R2A
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VYG3CYG2S7XRRUYT2O7TSSGQTT6F3R2A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The code is fine but this patch is problematic on three counts:

a) you didn't Cc: maintainers
b) by sending this directly, you lost Bard and my Reviewed-by tags
c) the timing is bad, we don't send patches during the merge window
(unless they are critical fixes)

On 11/2/23 11:48, Mac Chiang wrote:
> RT5650 is I2S codec integrated with HP and SPK.
> The HW board connects SoC I2S to RT5650 codec as below:
> 
> I2S0: ALC5650 aif1 for Speaker
> I2S2: ALC5650 aif2 for Headphone
> 
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>
> ---
> pick up from Link: https://github.com/thesofproject/linux/pull/4661
> for Chrome MTL projects.
> 
> Changes v2:
>   - regen format patch due to v1 from github remote
> ---
>  sound/soc/intel/boards/sof_rt5682.c               |  9 +++++++++
>  sound/soc/intel/common/soc-acpi-intel-mtl-match.c | 12 ++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 06ad15af46de..9723479f43da 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -1147,6 +1147,15 @@ static const struct platform_device_id board_ids[] = {
>  					SOF_RT5682_SSP_AMP(0) |
>  					SOF_RT5682_NUM_HDMIDEV(3)),
>  	},
> +	{
> +		.name = "mtl_rt5650",
> +		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
> +					SOF_RT5682_SSP_CODEC(2) |
> +					SOF_RT5682_SSP_AMP(0) |
> +					SOF_RT5682_NUM_HDMIDEV(3) |
> +					SOF_BT_OFFLOAD_SSP(1) |
> +					SOF_SSP_BT_OFFLOAD_PRESENT),
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, board_ids);
> diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
> index 301b8142d554..af4224bff718 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
> @@ -40,6 +40,11 @@ static const struct snd_soc_acpi_codecs mtl_lt6911_hdmi = {
>  	.codecs = {"INTC10B0"}
>  };
>  
> +static const struct snd_soc_acpi_codecs mtl_rt5650_amp = {
> +	.num_codecs = 1,
> +	.codecs = {"10EC5650"}
> +};
> +
>  struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_machines[] = {
>  	{
>  		.comp_ids = &mtl_rt5682_rt5682s_hp,
> @@ -77,6 +82,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_machines[] = {
>  					SND_SOC_ACPI_TPLG_INTEL_SSP_MSB |
>  					SND_SOC_ACPI_TPLG_INTEL_DMIC_NUMBER,
>  	},
> +	{
> +		.id = "10EC5650",
> +		.drv_name = "mtl_rt5650",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &mtl_rt5650_amp,
> +		.sof_tplg_filename = "sof-mtl-rt5650.tplg",
> +	},
>  	/* place amp-only boards in the end of table */
>  	{
>  		.id = "INTC10B0",
