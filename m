Return-Path: <SRS0=Rgv7=ZF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADC8C432C3
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:20:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB69E206EC
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YedVFPYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB69E206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BA88167B;
	Wed, 13 Nov 2019 18:20:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BA88167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573665651;
	bh=0btuUKuT6uhlZWHXfyN+xfCTJzKuc3qT6Q4CtSlg0OI=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YedVFPYtR+e0cas5C7g62JqYNCK2T9K8srCRm5x0S1Kso/lCoa15b2VOHy5iOYlDB
	 A0xNn8qM3XM1cL75j6WC4HaCWXsqsE1xpK2sKaLwSVwaASg2PCzi3iSrABGo7VQnBx
	 w/bgYG4BrN8P49WqV6HjiJbUzT4W5igYOVSusDnM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8653AF800BA;
	Wed, 13 Nov 2019 18:18:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CAE62F800B8; Wed, 13 Nov 2019 18:18:32 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF33EF80084
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2019 18:18:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF33EF80084
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Nov 2019 09:18:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,301,1569308400"; d="scan'208";a="229813233"
Received: from dmsnyder-mobl1.amr.corp.intel.com (HELO [10.252.193.15])
 ([10.252.193.15])
 by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2019 09:18:07 -0800
To: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
References: <1573629249-13272-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1573629249-13272-4-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5ca55e4b-51e5-7d1e-31a6-73f923a10078@linux.intel.com>
Date: Wed, 13 Nov 2019 10:29:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1573629249-13272-4-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Language: en-US
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, YueHaibing <yuehaibing@huawei.com>,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Sanju R Mehta <sanju.mehta@amd.com>, Mark Brown <broonie@kernel.org>,
 djkurtz@google.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Alexander.Deucher@amd.com, Colin Ian King <colin.king@canonical.com>,
 Akshu.Agrawal@amd.com
Subject: Re: [alsa-devel] [RESEND PATCH v5 3/6] ASoC: amd: Enabling I2S
 instance in DMA and DAI
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


> @@ -83,9 +83,20 @@ static int acp3x_i2s_hwparams(struct snd_pcm_substream *substream,
>   		struct snd_pcm_hw_params *params,
>   		struct snd_soc_dai *dai)
>   {
> -	u32 val = 0;
> +	u32 val;
> +	u32 reg_val;

nit-pick: xmas-tree style, move the declarations below


> @@ -104,24 +115,46 @@ static int acp3x_i2s_hwparams(struct snd_pcm_substream *substream,
>   		return -EINVAL;
>   	}
>   	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -		val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
> -		val = val | (rtd->xfer_resolution  << 3);
> -		rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
> +		switch (rtd->i2s_instance) {
> +		case I2S_BT_INSTANCE:
> +			reg_val = mmACP_BTTDM_ITER;
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			reg_val = mmACP_I2STDM_ITER;
> +		}
>   	} else {
> -		val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_IRER);
> -		val = val | (rtd->xfer_resolution  << 3);
> -		rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_IRER);
> +		switch (rtd->i2s_instance) {
> +		case I2S_BT_INSTANCE:
> +			reg_val = mmACP_BTTDM_IRER;
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			reg_val = mmACP_I2STDM_IRER;
> +		}
>   	}
> +	val = rv_readl(rtd->acp3x_base + reg_val);
> +	val = val | (rtd->xfer_resolution  << 3);
> +	rv_writel(val, rtd->acp3x_base + reg_val);
>   	return 0;
>   }

nice cleanup, much better than previous versions!

>   
>   static int acp3x_i2s_trigger(struct snd_pcm_substream *substream,
>   		int cmd, struct snd_soc_dai *dai)
>   {
> -	int ret = 0;
> +	int ret;

move 2 lines below.

>   	struct i2s_stream_instance *rtd = substream->runtime->private_data;
> -	u32 val, period_bytes;
> -
> +	u32 val, period_bytes, reg_val, ier_val, water_val;
> +	struct snd_soc_pcm_runtime *prtd = substream->private_data;
> +	struct snd_soc_card *card = prtd->card;
> +	struct acp3x_platform_info *pinfo = snd_soc_card_get_drvdata(card);


>   static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
>   {
>   	u16 page_idx;
> -	u32 low, high, val, acp_fifo_addr;
> -	dma_addr_t addr = rtd->dma_addr;
> +	uint64_t low, high, val, acp_fifo_addr;
> +	uint64_t reg_ringbuf_size, reg_dma_size, reg_fifo_size, reg_fifo_addr;
> +	dma_addr_t addr;

nit-pick: xmas-tree style

> @@ -303,13 +346,24 @@ static int acp3x_dma_hw_params(struct snd_soc_component *component,
>   			       struct snd_pcm_hw_params *params)
>   {
>   	int status;
> -	u64 size;
> -	struct snd_pcm_runtime *runtime = substream->runtime;
> -	struct i2s_stream_instance *rtd = runtime->private_data;
> +	uint64_t size;
> +	struct snd_soc_pcm_runtime *prtd = substream->private_data;
> +	struct snd_soc_card *card = prtd->card;
> +	struct acp3x_platform_info *pinfo = snd_soc_card_get_drvdata(card);
>   
> +	struct i2s_stream_instance *rtd = substream->runtime->private_data;

nit pick: xmas-tree style and newlines


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
