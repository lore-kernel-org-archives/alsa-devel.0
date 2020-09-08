Return-Path: <SRS0=EqiG=CR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A490C43461
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:00:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBD020732
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jdsGDltF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBD020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B928883E;
	Tue,  8 Sep 2020 22:59:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B928883E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599598842;
	bh=MMv22+8LyKFQH/GdAoYxO5omZAeLiWgLcE7EprHmXGQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jdsGDltF6BzdX0s3DNrqMruuRWPMf65Y0PmlYPHtuSG9GZYJ8ig+gV9kQ4cfKhB+Z
	 DoY+FVbPnJ6joB/K9+E2R+WyJaNihantpQ1Le/Q0MOqDh8tPsXHFO1EQEuwVyK0roa
	 TQyWkSVDHDMF/ussKwJUEWorckEnWF9LFO2b9m+U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DC4EF8015F;
	Tue,  8 Sep 2020 22:59:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 118FEF80264; Tue,  8 Sep 2020 22:59:51 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E41BF8010B
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2020 22:59:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E41BF8010B
IronPort-SDR: 6gFk/Ae0bVnl9X29qIJJQOvpkpJ+hFDEdQSLp6KvHK5BONQTHfX/9zBIbpImU8fMtu/lSLb08m
 3D17ZN+GoEYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="157501701"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; d="scan'208";a="157501701"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 13:59:43 -0700
IronPort-SDR: y6hZDRdeztSDI9qEbOW7puJWdEwvMxonv1KDJltNB5uCftszS+MGKmKHSNxRlJQ8kXrPsfdSYF
 rHqN8Ota+BTQ==
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; d="scan'208";a="504506013"
Received: from mschen-mobl2.amr.corp.intel.com (HELO [10.213.174.122])
 ([10.213.174.122])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 13:59:42 -0700
Subject: Re: [PATCH V3] ASoC: Intel: boards: Use FS as nau8825 sysclk in
 nau88125_* machine
To: Radoslaw Biernacki <rad@semihalf.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20200908200314.22771-1-rad@semihalf.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <50db252a-1274-f681-d5e7-e7fba839c0ee@linux.intel.com>
Date: Tue, 8 Sep 2020 15:59:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908200314.22771-1-rad@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Lech Betlej <Lech.Betlej@intel.com>, alsa-devel@alsa-project.org,
 Todd Broch <tbroch@google.com>, Harshapriya <harshapriya.n@intel.com>,
 Alex Levin <levinale@google.com>, John Hsu <KCHSU0@nuvoton.com>,
 linux-kernel@vger.kernel.org, michal.sienkiewicz@intel.com,
 Ben Zhang <benzh@chromium.org>, Mac Chiang <mac.chiang@intel.com>,
 Marcin Wojtas <mw@semihalf.com>,
 Vamshi Krishna <vamshi.krishna.gopal@intel.com>, Yong Zhi <yong.zhi@intel.com>
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

Sorry, I couldn't resist adding three more comments to improve further:

> -static int skylake_nau8825_hw_params(struct snd_pcm_substream *substream,
> -	struct snd_pcm_hw_params *params)
> +static int skylake_nau8825_trigger(struct snd_pcm_substream *substream, int cmd)
>   {
>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
>   	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> -	int ret;
> -
> -	ret = snd_soc_dai_set_sysclk(codec_dai,
> -			NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK_IN);
> +	int ret = 0;
>   
> -	if (ret < 0)
> -		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +		ret = snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS, 0,
> +					     SND_SOC_CLOCK_IN);

Maybe a simple comment to explain what this does?

> +		if (ret < 0) {
> +			dev_err(codec_dai->dev, "can't set FS clock %d\n", ret);
> +			break;
> +		}
> +		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
> +					  runtime->rate * 256);
> +		if (ret < 0)
> +			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
> +		break;

You could replace this by a /* fallthrough */ statement?

> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
> +					  runtime->rate * 256);
> +		if (ret < 0)
> +			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
> +		break;
> +	}

> +static int __maybe_unused skylake_nau8825_resume_post(struct snd_soc_card *card)
> +{
> +	struct snd_soc_dai *codec_dai;
> +
> +	codec_dai = snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_DAI);
> +	if (!codec_dai) {
> +		dev_err(card->dev, "Codec dai not found\n");
> +		return -EIO;
> +	}
> +
> +	dev_dbg(codec_dai->dev, "playback_active:%d playback_widget->active:%d codec_dai->rate:%d\n",
> +		codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK],
> +		codec_dai->playback_widget->active,
> +		codec_dai->rate);
> +
> +	if (codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK] &&
> +	    codec_dai->playback_widget->active)
> +		snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS, 0,
> +				       SND_SOC_CLOCK_IN);

And that part is also worthy of a comment, e.g. why not do this as part 
of the TRIGGER_RESUME and why only for playback?


> --- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
> +++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c

same comments for this other machine driver.

