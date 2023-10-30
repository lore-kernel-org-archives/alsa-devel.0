Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88B1C4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Oct 2023 16:58:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DC34A4D;
	Mon, 30 Oct 2023 17:57:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DC34A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698685106;
	bh=dEjCXDT0zPEo0nS7+2ecfgvoIT2oYjrfZSHG4lH9szk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QheYq1wmgButVylCgcEzwLKRYuRE4V58RYvfNK4JNx+ot1w0F1sZfdLOvySlXdzTu
	 7+MYMSI2fZbwqSPT9WVWAPSOeh0x4bPnSURUScBeGATaKaqd+UwYqMeC0jghx9a9qZ
	 O5iV7nhhN0uE+4twOI9Jk1CtU4Brcr2BJl5aOhEo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B9E6F8020D; Mon, 30 Oct 2023 17:57:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A0534F8020D;
	Mon, 30 Oct 2023 17:57:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57F47F8020D; Mon, 30 Oct 2023 17:56:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 78E78F8014B
	for <alsa-devel@alsa-project.org>; Mon, 30 Oct 2023 17:56:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78E78F8014B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RQSmS3P4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698685005; x=1730221005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dEjCXDT0zPEo0nS7+2ecfgvoIT2oYjrfZSHG4lH9szk=;
  b=RQSmS3P4zs7tmtsYuLXbeISes/PfzRygJp7J18pBUfixVXJ4to/DKtNK
   xrEzrBpogvZ302JigsqoJSnscQNl6yzLsgS/B1CdIq40SeYIcjXzvTd+Q
   9uuvBYeeO5obHST2j9MjOxmvrD0TMM+x8xXCSwclMUsJwVP4GcY2c2T1G
   5uQhyNvJ5jOnUS3HrLkJ/Bmu5+vP5Grxvgt0T76zQjckhU2OYFot/j3vZ
   5UmeNrYnaFX8bcomHwMBCLRy0ZV4e+9+BLX/hXzP1MoTPpQAR9mxHgyG7
   O/j/s4h14ExFVuZ9iHiykJI1eWUp+W3eMIs7uQDXm76NFd9ZftdaZ/a+Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="957309"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200";
   d="scan'208";a="957309"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2023 09:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="830736415"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200";
   d="scan'208";a="830736415"
Received: from wezedi-mobl1.amr.corp.intel.com (HELO [10.212.223.192])
 ([10.212.223.192])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2023 09:56:37 -0700
Message-ID: <257609dc-8fa9-40e0-8730-29e45af93878@linux.intel.com>
Date: Mon, 30 Oct 2023 11:08:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: intel-dsp-cfg: Use AVS driver on SKL/KBL/APL
 Chromebooks
Content-Language: en-US
To: Brady Norander <bradynorander@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
References: <ZTz9orCylVwn3Pye@arch>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZTz9orCylVwn3Pye@arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 6R4ZW7HGN7KQHFUF3V6EIII57ZILNHLF
X-Message-ID-Hash: 6R4ZW7HGN7KQHFUF3V6EIII57ZILNHLF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6R4ZW7HGN7KQHFUF3V6EIII57ZILNHLF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 10/28/23 07:25, Brady Norander wrote:
> The legacy SKL driver no longer works properly on these Chromebook
> platforms. Use the new AVS driver by default instead.

shouldn't this be used only if AVS is compiled in?

> 
> Signed-off-by: Brady Norander <bradynorander@gmail.com>
> ---
>  sound/hda/intel-dsp-config.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
> index 756fa0aa69bb..1045be1fd441 100644
> --- a/sound/hda/intel-dsp-config.c
> +++ b/sound/hda/intel-dsp-config.c
> @@ -16,10 +16,11 @@
>  static int dsp_driver;
>  
>  module_param(dsp_driver, int, 0444);
> -MODULE_PARM_DESC(dsp_driver, "Force the DSP driver for Intel DSP (0=auto, 1=legacy, 2=SST, 3=SOF)");
> +MODULE_PARM_DESC(dsp_driver, "Force the DSP driver for Intel DSP (0=auto, 1=legacy, 2=SST, 3=SOF, 4=AVS)");
>  
>  #define FLAG_SST			BIT(0)
>  #define FLAG_SOF			BIT(1)
> +#define FLAG_AVS			BIT(2)
>  #define FLAG_SST_ONLY_IF_DMIC		BIT(15)
>  #define FLAG_SOF_ONLY_IF_DMIC		BIT(16)
>  #define FLAG_SOF_ONLY_IF_SOUNDWIRE	BIT(17)
> @@ -56,7 +57,7 @@ static const struct config_entry config_table[] = {
>  /*
>   * Apollolake (Broxton-P)
>   * the legacy HDAudio driver is used except on Up Squared (SOF) and
> - * Chromebooks (SST), as well as devices based on the ES8336 codec
> + * Chromebooks (AVS), as well as devices based on the ES8336 codec
>   */
>  #if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
>  	{
> @@ -81,7 +82,7 @@ static const struct config_entry config_table[] = {
>  #endif
>  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_APL)
>  	{
> -		.flags = FLAG_SST,
> +		.flags = FLAG_AVS,
>  		.device = PCI_DEVICE_ID_INTEL_HDA_APL,
>  		.dmi_table = (const struct dmi_system_id []) {
>  			{
> @@ -96,13 +97,13 @@ static const struct config_entry config_table[] = {
>  #endif
>  /*
>   * Skylake and Kabylake use legacy HDAudio driver except for Google
> - * Chromebooks (SST)
> + * Chromebooks (AVS)
>   */
>  
>  /* Sunrise Point-LP */
>  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
>  	{
> -		.flags = FLAG_SST,
> +		.flags = FLAG_AVS,
>  		.device = PCI_DEVICE_ID_INTEL_HDA_SKL_LP,
>  		.dmi_table = (const struct dmi_system_id []) {
>  			{
> @@ -122,7 +123,7 @@ static const struct config_entry config_table[] = {
>  /* Kabylake-LP */
>  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_KBL)
>  	{
> -		.flags = FLAG_SST,
> +		.flags = FLAG_AVS,
>  		.device = PCI_DEVICE_ID_INTEL_HDA_KBL_LP,
>  		.dmi_table = (const struct dmi_system_id []) {
>  			{
> @@ -667,6 +668,9 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
>  		}
>  	}
>  
> +	if (cfg->flags & FLAG_AVS)
> +		return SND_INTEL_DSP_DRIVER_AVS;
> +
>  	return SND_INTEL_DSP_DRIVER_LEGACY;
>  }
>  EXPORT_SYMBOL_GPL(snd_intel_dsp_driver_probe);
