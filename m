Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11120C07CA9
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Nov 2023 17:54:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A063DF1;
	Tue, 28 Nov 2023 18:54:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A063DF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701194078;
	bh=X/vuCuKhjCfbCD+yDhFxIgQrez9Yi+j96FEy1rjFZSg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EtJAPG/nyytfZWnV3MXZUrL+T3lCQITvNQ63fMXqC90Y7M8XV3Fu0bW39S29JKCK8
	 8L3akSDpaY/5jIMX7WFEitjqgIhdZqH78ruzYaGVZh5XK/aGEEUp8kMvRyJh5kbs+A
	 wW/8bQForHU4NYpGzqCOKox2K6xdojJyMIi092VI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 64996F80589; Tue, 28 Nov 2023 18:54:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 46D49F8059F;
	Tue, 28 Nov 2023 18:54:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C08FFF801D5; Tue, 28 Nov 2023 18:54:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 798EDF80104
	for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2023 18:53:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 798EDF80104
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XeRmTdpZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701194038; x=1732730038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X/vuCuKhjCfbCD+yDhFxIgQrez9Yi+j96FEy1rjFZSg=;
  b=XeRmTdpZ1Wm+Hl1Rya0j+NBDeh83nAF59YahXckDFbT4OCF5Cvaatp71
   kWTfBSDT/MPXTJcbmkTXlmbtHNra0jZ25C7Vr9slo2hbuLETd8J7dGkQS
   Aby3QPSygw30sMI+YsIHTYMFM1tq6MZV1+BYqT9bvwZW6sbT0kOPHiYEg
   QuBDahG7FSxYxvGWGobet1LLXfAC/6Hh5eC0/cIJNT8nsrBCbAyrVHI1I
   ioK2PKPAb1J+6nUGSFWxCiz43F5ZqpvPVuVJkaIGLSGueUdH73SirjpD9
   k4txeX4jPtq4pP+mc23OGeCEKTau+EgcZ/unEebPVOguJyx4nRXxrCvNL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="424127071"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600";
   d="scan'208";a="424127071"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2023 09:53:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="834715293"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600";
   d="scan'208";a="834715293"
Received: from skumarso-mobl33.amr.corp.intel.com (HELO [10.255.231.208])
 ([10.255.231.208])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2023 09:53:53 -0800
Message-ID: <1ca6f822-355a-4eb0-8e3c-f9a408074144@linux.intel.com>
Date: Tue, 28 Nov 2023 08:58:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: hdac_hda: Conditionally register dais for HDMI
 and Analog
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, lgirdwood@gmail.com,
 broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com
References: <20231128123914.3986-1-peter.ujfalusi@linux.intel.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231128123914.3986-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: PP2IRSLOGQMEUW5XQZUCIK77LLIGOEKW
X-Message-ID-Hash: PP2IRSLOGQMEUW5XQZUCIK77LLIGOEKW
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PP2IRSLOGQMEUW5XQZUCIK77LLIGOEKW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 11/28/23 06:39, Peter Ujfalusi wrote:
> The current driver is registering the same dais for each hdev found in the
> system which results duplicated widgets to be registered and the kernel
> log contains similar prints:
> snd_hda_codec_realtek ehdaudio0D0: ASoC: sink widget AIF1TX overwritten
> snd_hda_codec_realtek ehdaudio0D0: ASoC: source widget AIF1RX overwritten
> skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget hifi3 overwritten
> skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget hifi2 overwritten
> skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget hifi1 overwritten
> skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget Codec Output Pin1 overwritten
> skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget Codec Input Pin1 overwritten
> skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget Analog Codec Playback overwritten
> skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget Digital Codec Playback overwritten
> skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget Alt Analog Codec Playback overwritten
> skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget Analog Codec Capture overwritten
> skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget Digital Codec Capture overwritten
> skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget Alt Analog Codec Capture overwritten
> 
> To avoid such issue, split the dai array into HDMI and non HDMI array and
> register them conditionally:
> for HDMI hdev only register the dais needed for HDMI
> for non HDMI hdev do not  register the HDMI dais.
> 
> Depends-on: 3d1dc8b1030d ("ASoC: Intel: skl_hda_dsp_generic: Drop HDMI routes when HDMI is not available")
> Link: https://github.com/thesofproject/linux/issues/4509
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
> Hi,
> 
> Changes since v1:
> - Drop the patch for patch_hdmi to export a funtion to match the device
> - Use the struct hdac_hda_priv.need_display_power boolean as indication that the
>   device is a HDMI/DP audio codec

LGTM.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> Regards,
> Peter
> 
>  sound/soc/codecs/hdac_hda.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
> index 355f30779a34..b075689db2dc 100644
> --- a/sound/soc/codecs/hdac_hda.c
> +++ b/sound/soc/codecs/hdac_hda.c
> @@ -132,6 +132,9 @@ static struct snd_soc_dai_driver hdac_hda_dais[] = {
>  		.sig_bits = 24,
>  	},
>  },
> +};
> +
> +static struct snd_soc_dai_driver hdac_hda_hdmi_dais[] = {
>  {
>  	.id = HDAC_HDMI_0_DAI_ID,
>  	.name = "intel-hdmi-hifi1",
> @@ -607,8 +610,16 @@ static const struct snd_soc_component_driver hdac_hda_codec = {
>  	.endianness		= 1,
>  };
>  
> +static const struct snd_soc_component_driver hdac_hda_hdmi_codec = {
> +	.probe			= hdac_hda_codec_probe,
> +	.remove			= hdac_hda_codec_remove,
> +	.idle_bias_on		= false,
> +	.endianness		= 1,
> +};
> +
>  static int hdac_hda_dev_probe(struct hdac_device *hdev)
>  {
> +	struct hdac_hda_priv *hda_pvt = dev_get_drvdata(&hdev->dev);
>  	struct hdac_ext_link *hlink;
>  	int ret;
>  
> @@ -621,9 +632,15 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
>  	snd_hdac_ext_bus_link_get(hdev->bus, hlink);
>  
>  	/* ASoC specific initialization */
> -	ret = devm_snd_soc_register_component(&hdev->dev,
> -					 &hdac_hda_codec, hdac_hda_dais,
> -					 ARRAY_SIZE(hdac_hda_dais));
> +	if (hda_pvt->need_display_power)
> +		ret = devm_snd_soc_register_component(&hdev->dev,
> +						&hdac_hda_hdmi_codec, hdac_hda_hdmi_dais,
> +						ARRAY_SIZE(hdac_hda_hdmi_dais));
> +	else
> +		ret = devm_snd_soc_register_component(&hdev->dev,
> +						&hdac_hda_codec, hdac_hda_dais,
> +						ARRAY_SIZE(hdac_hda_dais));
> +
>  	if (ret < 0) {
>  		dev_err(&hdev->dev, "failed to register HDA codec %d\n", ret);
>  		return ret;
