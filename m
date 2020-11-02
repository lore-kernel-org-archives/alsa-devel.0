Return-Path: <SRS0=b8gG=EI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA089C388F2
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:04:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C982072C
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oCorphK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C982072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DF56172D;
	Mon,  2 Nov 2020 16:03:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DF56172D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604329466;
	bh=Bc5iCFwnbeNvhAelCO8tnoCSf4c/7ZQB6BjNFjjzmjY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oCorphK+KIPLPMcfvni7tf/4OqBtNfQdH+ferBQ17jIP2IdH1Ua/ys555UfCP9F89
	 C28dcidAHwTQfVlr6GhGdJbCmBru+gShOlfzoL3vL55s6FLUdNOFb+Io28tqos0piQ
	 AfMNHNAF/hRnCF9i1O/T/iKOSk+TdhZgTMo1Toeo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93029F80256;
	Mon,  2 Nov 2020 16:02:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1BF6EF80234; Mon,  2 Nov 2020 16:02:44 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D495F8012B
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2020 16:02:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D495F8012B
IronPort-SDR: 5a+v/WPVkL7iQTNnhasQ6A1zfiT7XZ9lHByd5xXF6F02vHZivuB+kUkzGq6zrAMJKrUACgcR/g
 ENrF0tpCZQ5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="155883708"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; d="scan'208";a="155883708"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2020 07:02:36 -0800
IronPort-SDR: RQcvOWNLCJtR/oOdiMiBSKS/dGnwXf0DogXdN4YFxPIdyszroHB22aQcKUVfUrUrUlhxQUhUxf
 hL/IpbZgfmVw==
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; d="scan'208";a="528043515"
Received: from pvrott-mobl1.amr.corp.intel.com (HELO [10.212.253.243])
 ([10.212.253.243])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2020 07:02:34 -0800
Subject: Re: [PATCH] ASoC: nau8315: add codec driver
To: David Lin <CTLIN0@nuvoton.com>, broonie@kernel.org
References: <20201102023212.594137-1-CTLIN0@nuvoton.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0adb99c2-d0d9-5052-c163-4d9a341239fc@linux.intel.com>
Date: Mon, 2 Nov 2020 08:42:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102023212.594137-1-CTLIN0@nuvoton.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org,
 KCHSU0@nuvoton.com, lgirdwood@gmail.com
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


> +struct nau8315_priv {
> +	struct gpio_desc *enable;
> +	int enpin_switch;
> +};
> +
> +static int nau8315_daiops_trigger(struct snd_pcm_substream *substream,
> +		int cmd, struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct nau8315_priv *nau8315 =
> +		snd_soc_component_get_drvdata(component);
> +
> +	if (!nau8315->enable)
> +		return 0;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		if (nau8315->enpin_switch) {
> +			gpiod_set_value(nau8315->enable, 1);
> +			dev_dbg(component->dev, "set enable to 1");
> +		}

I know the code is modeled after max98357a.c but I keep wondering if 
this enpin_switch state is actually useful for anything.

Is there actually a case where the trigger happens before the 
DAPM_POST_PMU event handled below [1]?

> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		gpiod_set_value(nau8315->enable, 0);
> +		dev_dbg(component->dev, "set enable to 0");
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nau8315_enpin_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component =
> +		snd_soc_dapm_to_component(w->dapm);
> +	struct nau8315_priv *nau8315 =
> +		snd_soc_component_get_drvdata(component);
> +

[1]

> +	if (event & SND_SOC_DAPM_POST_PMU)
> +		nau8315->enpin_switch = 1;
> +	else if (event & SND_SOC_DAPM_POST_PMD)
> +		nau8315->enpin_switch = 0;

And even if this variable was useful, for symmetry should it be 
PRE_PMU/POST_PMD?

> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_dapm_widget nau8315_dapm_widgets[] = {
> +	SND_SOC_DAPM_OUTPUT("Speaker"),
> +	SND_SOC_DAPM_OUT_DRV_E("EN_Pin", SND_SOC_NOPM, 0, 0, NULL, 0,
> +			nau8315_enpin_event,
> +			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
> +};
> +
> +static const struct snd_soc_dapm_route nau8315_dapm_routes[] = {
> +	{"EN_Pin", NULL, "HiFi Playback"},
> +	{"Speaker", NULL, "EN_Pin"},
> +};
> +
> +static const struct snd_soc_component_driver nau8315_component_driver = {
> +	.dapm_widgets		= nau8315_dapm_widgets,
> +	.num_dapm_widgets	= ARRAY_SIZE(nau8315_dapm_widgets),
> +	.dapm_routes		= nau8315_dapm_routes,
> +	.num_dapm_routes	= ARRAY_SIZE(nau8315_dapm_routes),
> +	.idle_bias_on		= 1,
> +	.use_pmdown_time	= 1,

is this necessary? This has the side effect of powering-down immediately 
instead of after a delay.

> +	.endianness		= 1,
> +	.non_legacy_dai_naming	= 1,
> +};
