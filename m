Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08BBECAAA1
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Sep 2022 08:28:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B99401679;
	Fri,  9 Sep 2022 10:27:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B99401679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662712125;
	bh=zgqLl2m4X/5jKL4rNZyMc0PVC2fCbDDnmcwsC6CQVbw=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GDx5tP56Lnj/0fNaR4yASzJ7+NE2VwqMGUAveu6LSj8QIteM54ykh75434DmP+WU9
	 T+58XszN3R/1wyg1f9s8FCmt4vPl0YNBqu9E+4bvjoJ5hhzOm8kWDJYFm6h7iFPX2p
	 yAabBxC0hqsdLCjuV26CAgiSWhtKWBhSl9gv85cw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6202DF8016D;
	Fri,  9 Sep 2022 10:27:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 845B6F8023A; Fri,  9 Sep 2022 10:27:53 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58177F8011C
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2022 10:27:47 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 8D209A0040;
 Fri,  9 Sep 2022 10:27:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 8D209A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1662712066; bh=0UQJrQpH2Mlkq6DQrMCLxzGnZrU58TEuB2F7n/22HTs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ObOMKoDWKY2px50yZF92t7kqde1W5DmtM6dyssurzfOIjnP8xzk1HqxLsKAQpg0my
 Kdt68olwtnqxqTvmKEglffZnmkcoa7LTW2FwFnZ9Q/LtyHSAG5wxSpyTCi5HkIMVOp
 PccpQozeGJmt6bZVkbMX3s22gV/hLfLrgXju/J+0=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri,  9 Sep 2022 10:27:36 +0200 (CEST)
Message-ID: <11545c65-cd49-9556-13c6-67d0ce5816c3@perex.cz>
Date: Fri, 9 Sep 2022 10:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: fsl_spdif: add ALSA event on dpll locked
Content-Language: en-US
To: robert.rosengren@axis.com, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
References: <20220908133319.2149486-1-robert.rosengren@axis.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220908133319.2149486-1-robert.rosengren@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, kernel@axis.com,
 alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>
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

On 08. 09. 22 15:33, robert.rosengren@axis.com wrote:
> From: Robert Rosengren <robert.rosengren@axis.com>
> 
> Add an ALSA event on the RX Sample Rate controller upon the dpll locked
> interrupt, making it possible for audio applications to monitor changes
> in the hardware.
> 
> Signed-off-by: Robert Rosengren <robert.rosengren@axis.com>
> ---
>   sound/soc/fsl/fsl_spdif.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 7fc1c96929bb..1679a21ffdca 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -44,6 +44,8 @@ static u8 srpc_dpll_locked[] = { 0x0, 0x1, 0x2, 0x3, 0x4, 0xa, 0xb };
>   
>   #define DEFAULT_RXCLK_SRC	1
>   
> +#define RX_SAMPLE_RATE_KCONTROL "RX Sample Rate"
> +
>   /**
>    * struct fsl_spdif_soc_data: soc specific data
>    *
> @@ -122,6 +124,7 @@ struct fsl_spdif_priv {
>   	const struct fsl_spdif_soc_data *soc;
>   	struct spdif_mixer_control fsl_spdif_control;
>   	struct snd_soc_dai_driver cpu_dai_drv;
> +	struct snd_soc_dai *dai;
>   	struct platform_device *pdev;
>   	struct regmap *regmap;
>   	bool dpll_locked;
> @@ -223,9 +226,19 @@ static void spdif_irq_dpll_lock(struct fsl_spdif_priv *spdif_priv)
>   	locked &= SRPC_DPLL_LOCKED;
>   
>   	dev_dbg(&pdev->dev, "isr: Rx dpll %s \n",
> -			locked ? "locked" : "loss lock");
> +		locked ? "locked" : "loss lock");
>   
>   	spdif_priv->dpll_locked = locked ? true : false;
> +
> +	if (spdif_priv->dai) {
> +		struct snd_soc_component *component = spdif_priv->dai->component;
> +		struct snd_kcontrol *kctl = snd_soc_card_get_kcontrol(component->card,
> +						RX_SAMPLE_RATE_KCONTROL);

I would cache the pointer to snd_kcontrol structure in spdif_priv. This lookup 
is expensive for the interrupt routine in my eyes.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
