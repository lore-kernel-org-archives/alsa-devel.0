Return-Path: <SRS0=FWLr=6Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBC8C47255
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 19:28:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6FA20736
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 19:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dyfdoes2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6FA20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A814115F9;
	Mon, 11 May 2020 21:27:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A814115F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589225304;
	bh=MpA7sYZGQxc6JqA8dj5kA5zgio6LEAPMjcIY7YNXdmk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dyfdoes2kGtHrj84kIgTAR2yMh8XyR64bUwSfJQfRBVqirNljaBsijO6QOohimM98
	 Ss+6ScKhy05iI3g15osIV+Pw02jOnm15zlrvSRzs/fH2T3VczLJCp4u3JOQ8ATyXEX
	 eBhvitvxPS7r4LbpL71kk2cl/tzaIk1yfRSYR4Pc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7024AF8022D;
	Mon, 11 May 2020 21:26:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8D4BF801F2; Mon, 11 May 2020 21:26:40 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6930F80107
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 21:26:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6930F80107
IronPort-SDR: co9g/OBACI3Gcu+3wNQR1qvA/sXJA+h26bYrxsQvAOzl+QBgkkeIieCEgzO4IdOseOdIjRKVqy
 1u+XgGIn0csA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2020 12:26:30 -0700
IronPort-SDR: ZFouxsGejBPWwL4qNSbr+qi0qkbM35Z0xBcLBx9i5l+aDYI9cva00gKuWNaLg1eLKu/bZBenID
 ay2LQItJSKwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; d="scan'208";a="297786523"
Received: from mlamm-mobl1.amr.corp.intel.com (HELO [10.255.230.116])
 ([10.255.230.116])
 by orsmga008.jf.intel.com with ESMTP; 11 May 2020 12:26:29 -0700
Subject: Re: [PATCH] ASoC: soc-dai: pull out be_hw_params_fixup from
 snd_soc_dai_hw_params
To: Gyeongtaek Lee <gt82.lee@samsung.com>, broonie@kernel.org
References: <CGME20200511033107epcas2p2465bc53295b38d2723c4bc351da77c5e@epcas2p2.samsung.com>
 <000001d62744$9b631670$d2294350$@samsung.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1fd436c2-373e-a332-02e6-c7b919a8fd0c@linux.intel.com>
Date: Mon, 11 May 2020 13:47:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <000001d62744$9b631670$d2294350$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, khw0178.kim@samsung.com, kimty@samsung.com,
 lgirdwood@gmail.com, tiwai@suse.com, hmseo@samsung.com, tkjung@samsung.com,
 pilsun.jang@samsung.com
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



On 5/10/20 10:31 PM, Gyeongtaek Lee wrote:
> When dpcm_be_dai_hw_params() called, be_hw_params_fixup() callback is
> called with same arguments 3times.
> It is called in be_hw_params_fixup() itself and in soc_pcm_hw_params()
> for cpu dai and codec dai.
> Tested in 5.4.
> 
> Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
> Cc: stable@vger.kernel.org
> ---
>   sound/soc/soc-dai.c  | 12 ------------
>   sound/soc/soc-dapm.c | 11 +++++++++++
>   2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
> index 31c41559034b..4785cb6b336f 100644
> --- a/sound/soc/soc-dai.c
> +++ b/sound/soc/soc-dai.c
> @@ -257,20 +257,8 @@ int snd_soc_dai_hw_params(struct snd_soc_dai *dai,
>   			  struct snd_pcm_substream *substream,
>   			  struct snd_pcm_hw_params *params)
>   {
> -	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>   	int ret;
>   
> -	/* perform any topology hw_params fixups before DAI  */
> -	if (rtd->dai_link->be_hw_params_fixup) {
> -		ret = rtd->dai_link->be_hw_params_fixup(rtd, params);
> -		if (ret < 0) {
> -			dev_err(rtd->dev,
> -				"ASoC: hw_params topology fixup failed %d\n",
> -				ret);
> -			return ret;
> -		}
> -	}
> -

Sorry I don't get this change.

If the be_hw_params_fixup() callback is called three times, it's because 
the soc_soc_dai_hw_params() routine is called three times, so what is 
the problem here?

Also the comment is explicit about doing fixups before calling the dai 
hw_params() callback, so that is not longer the case with this change? 
Even if the change was legit, the comment is no longer relevant and 
should be updated.

>   	if (dai->driver->ops->hw_params) {
>   		ret = dai->driver->ops->hw_params(substream, params, dai);
>   		if (ret < 0) {
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index e2632841b321..d86c1cd4e8fa 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -3886,6 +3886,17 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
>   	hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS)->max
>   		= config->channels_max;
>   
> +	/* perform any topology hw_params fixups before DAI  */
> +	if (rtd->dai_link->be_hw_params_fixup) {
> +		ret = rtd->dai_link->be_hw_params_fixup(rtd, params);
> +		if (ret < 0) {
> +			dev_err(rtd->dev,
> +				"ASoC: hw_params topology fixup failed %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
>   	substream->stream = SNDRV_PCM_STREAM_CAPTURE;
>   	snd_soc_dapm_widget_for_each_source_path(w, path) {
>   		source = path->source->priv;
> 
> base-commit: f3643491bd079c973ac6c693da7966cd17506ca3
> 
