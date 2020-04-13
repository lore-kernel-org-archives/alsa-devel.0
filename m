Return-Path: <SRS0=SID+=55=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3C0C2BB86
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 10:49:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD48620692
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 10:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VjLJYW29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD48620692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E80316F3;
	Mon, 13 Apr 2020 12:48:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E80316F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586774968;
	bh=pwHXmNdTrdD5im5ZdqooE890HFVV5Zh0aQOgenrQ3qM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VjLJYW29EKFJr+jBxv6+MVKl6Lgojod1OKzR4RR77TpGzRjPF8cP+wfDK96h8fiBm
	 v0NbBdf6PrIA1mFT3c3x4PMQVEMA4YoSXZe1Maus+Zwxb1U8ivcjvDDIj/7rPMiGGc
	 76EfV1z874FZFTyKY6fG4EV5DLv1DokKQx4UwEH0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F0F3F8027C;
	Mon, 13 Apr 2020 12:47:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99E32F8028A; Mon, 13 Apr 2020 12:47:09 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B63DEF800B9
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2020 12:47:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B63DEF800B9
IronPort-SDR: NqmTR+3KfmpJe6DNvxLgpI2Q2HBRunguQlnJVDkgPdAi/un+OvIqU0EqDJXtqjFFq5/Iv1QJfB
 ZL6LbLQ4uPFw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2020 03:47:02 -0700
IronPort-SDR: ayMz8icoKuu1Cou9MhiqAeFL4MrjUzbHqplQK9F8EJo6KijVa0uvvgu/BoL+PHlCTnE7p2iB+x
 OduldT/7UWAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; d="scan'208";a="243507850"
Received: from ftehrig-mobl.amr.corp.intel.com (HELO [10.209.82.92])
 ([10.209.82.92])
 by fmsmga007.fm.intel.com with ESMTP; 13 Apr 2020 03:47:00 -0700
Subject: Re: [PATCH v2] ASoC: bdw-rt5650: remove 3-channel capture support
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
References: <1586766533-18557-1-git-send-email-brent.lu@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9a484795-ea4a-e559-4ea9-3de24417ec9b@linux.intel.com>
Date: Mon, 13 Apr 2020 05:18:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1586766533-18557-1-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jie Yang <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
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



On 4/13/20 3:28 AM, Brent Lu wrote:
> Implement a constrain to exclude 3-channel capture since only 2 and 4
> channel capture are supported on the platform.

That looks like an error caught by the ALSA conformance tool?

What are the odds that we have a similar issue with the other broadwell 
drivers which don't have a constraint on the number of channels either 
on their 'System PCM' dailink?

Thanks
-Pierre

> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>   sound/soc/intel/boards/bdw-rt5650.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
> index af2f502..eedbdad 100644
> --- a/sound/soc/intel/boards/bdw-rt5650.c
> +++ b/sound/soc/intel/boards/bdw-rt5650.c
> @@ -83,6 +83,36 @@ static struct snd_soc_jack_pin mic_jack_pin = {
>   	.mask	= SND_JACK_MICROPHONE,
>   };
>   
> +static const unsigned int channels[] = {
> +	2, 4,
> +};
> +
> +static const struct snd_pcm_hw_constraint_list constraints_channels = {
> +	.count = ARRAY_SIZE(channels),
> +	.list = channels,
> +	.mask = 0,
> +};
> +
> +static int bdw_fe_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	/*
> +	 * On this platform for PCM device we support,
> +	 * 2 or 4 channel capture
> +	 */
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		snd_pcm_hw_constraint_list(runtime, 0,
> +					   SNDRV_PCM_HW_PARAM_CHANNELS,
> +					   &constraints_channels);
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_ops bdw_rt5650_fe_ops = {
> +	.startup = bdw_fe_startup,
> +};
> +
>   static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
>   			struct snd_pcm_hw_params *params)
>   {
> @@ -234,6 +264,7 @@ static struct snd_soc_dai_link bdw_rt5650_dais[] = {
>   		.name = "System PCM",
>   		.stream_name = "System Playback",
>   		.dynamic = 1,
> +		.ops = &bdw_rt5650_fe_ops,
>   #if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
>   		.init = bdw_rt5650_rtd_init,
>   #endif
> 
