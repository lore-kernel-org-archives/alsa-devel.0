Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B3DC54FD0
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:01:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F032063A
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dndm5lDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F032063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C02D16AA;
	Mon, 27 Apr 2020 13:00:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C02D16AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587985282;
	bh=sR4Ay7ba2G34kARTCgYlDGMzxPKvRjbIQOSiiFY37CY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dndm5lDoJFVGKxPuv4yGCWrCirQePiH2oymwfEOqQrnkDhnzCiSQRx7jsLvd44800
	 Ckv5YYdpTj6jJ6G8p/XIDk0eTp72G1jsVD8yRnq5L69Ay6AVlAhh1eRz+kJsHSCPyQ
	 EszmDktLf304EES0WbKJyZAWNCvOcsYYsl98GhA0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74AFCF8025F;
	Mon, 27 Apr 2020 12:59:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5632FF8027D; Mon, 27 Apr 2020 12:59:03 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8037F80113
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 12:58:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8037F80113
IronPort-SDR: +AOGzdeIqLDMmf2GXVcVZsUOUROVnzlLywMl+FVAdX3vJCXhomtve20/rT1MTlbmi4TJsxHn0s
 nMKy6JW6MVHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 03:58:51 -0700
IronPort-SDR: t2AoJtXKtF6iKW8T6Ypc8cCdIq9cDAiQUXNV6d208AOSMaqN8PO8/JLtN1sqKUod5leSmTxaCm
 jYYAarts2AGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; d="scan'208";a="302340875"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.7.127])
 ([10.213.7.127])
 by FMSMGA003.fm.intel.com with ESMTP; 27 Apr 2020 03:58:48 -0700
Subject: Re: [PATCH 3/3] ASoC: broadwell: channel constraint support
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
References: <1587976638-29806-1-git-send-email-brent.lu@intel.com>
 <1587976638-29806-4-git-send-email-brent.lu@intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <51b8fa84-5835-74e9-703f-30d608ace736@intel.com>
Date: Mon, 27 Apr 2020 12:58:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587976638-29806-4-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ben Zhang <benzh@chromium.org>, Mac Chiang <mac.chiang@intel.com>,
 Mark Brown <broonie@kernel.org>
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

On 2020-04-27 10:37, Brent Lu wrote:
> BDW boards using this machine driver supports only stereo capture and
> playback. Implement a constraint to enforce it.
> 

Title for the overall series fits better than the one chosen for actual 
patches. "channel constraint support" is misleading. Constraints are 
added or removed but certainly not supported.

> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>   sound/soc/intel/boards/broadwell.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
> index f9a8336..09347f2 100644
> --- a/sound/soc/intel/boards/broadwell.c
> +++ b/sound/soc/intel/boards/broadwell.c
> @@ -19,6 +19,8 @@
>   
>   #include "../../codecs/rt286.h"
>   
> +#define DUAL_CHANNEL 2
> +

Remove, we need not additional too-obvious macro. One could argue 
'STEREO' is a better choice too.

>   static struct snd_soc_jack broadwell_headset;
>   /* Headset jack detection DAPM pins */
>   static struct snd_soc_jack_pin broadwell_headset_pins[] = {
> @@ -143,6 +145,36 @@ static int broadwell_rtd_init(struct snd_soc_pcm_runtime *rtd)
>   }
>   #endif
>   
> +static const unsigned int channels[] = {
> +	DUAL_CHANNEL,

Inline as stated above.

> +};
> +
> +static const struct snd_pcm_hw_constraint_list constraints_channels = {
> +	.count = ARRAY_SIZE(channels),
> +	.list = channels,
> +	.mask = 0,
> +};
> +
> +static int broadwell_fe_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	/*
> +	 * On this platform for PCM device we support,
> +	 * stereo audio
> +	 */
> +

Sometimes you add a newline add and before, while other times just one, 
before the comment. Please streamline the format across all patches in 
the series. Comment can be more strict too
	/* Board supports stereo configuration only */

> +	runtime->hw.channels_max = DUAL_CHANNEL;

Inline. If you really want to avoid using 2, make use of 0-entry of 
constrains_channels array.

> +	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
> +					   &constraints_channels);
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_ops broadwell_fe_ops = {
> +	.startup = broadwell_fe_startup,
> +};
> +
>   SND_SOC_DAILINK_DEF(system,
>   	DAILINK_COMP_ARRAY(COMP_CPU("System Pin")));
>   
> @@ -180,6 +212,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
>   		.init = broadwell_rtd_init,
>   #endif
>   		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
> +		.ops = &broadwell_fe_ops,
>   		.dpcm_playback = 1,
>   		.dpcm_capture = 1,
>   		SND_SOC_DAILINK_REG(system, dummy, platform),
> 
