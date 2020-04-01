Return-Path: <SRS0=1DJj=5R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D07C43331
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2020 05:07:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B8820772
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2020 05:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oBJHFW0G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjEaWA28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B8820772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D542B166E;
	Wed,  1 Apr 2020 07:06:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D542B166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585717627;
	bh=CHwZ7t4T2n+93moxoWET1ChbbS9nLUQ4W/xKqHQDHhE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oBJHFW0GO4vu2xT2ycAWTvFqV71rja6S+mXdv0aTUxVTcYwciQ6OfKR2NyuZ0aWOL
	 T4HigH2QbJFSeENLBmQozD/owqR1G/BGzv35z6Vgzr+nwyZPGZRe7Qsrz2OMrVLMSy
	 3ETVhRnTHO0JMByBZVcPYI7ApSBP5mwc8JwnA4wY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45382F8014A;
	Wed,  1 Apr 2020 07:06:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DE8AF8014B; Wed,  1 Apr 2020 07:06:14 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25F99F80110
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2020 07:06:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25F99F80110
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KjEaWA28"
Received: from localhost (unknown [122.167.76.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C9B182074D;
 Wed,  1 Apr 2020 05:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585717566;
 bh=CHwZ7t4T2n+93moxoWET1ChbbS9nLUQ4W/xKqHQDHhE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KjEaWA28I4dRrDFwkprzyYnJc/KjzARW+1KsGpPskpPpMB7mM44lbENGnu3KEjFRA
 4pTEGFojFEfp6npQ24PP+QxW3/eoO8Uu78rsFC5QGDdeP5vFxvj9jXZw07Y0hAqzQp
 t8PGfXfL7SdnCLCTk21fzEq75IBVdFmvurB29sH4=
Date: Wed, 1 Apr 2020 10:36:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?B?77+9zLDvv73vv73vv70=?= <gt82.lee@samsung.com>
Subject: Re: [PATCH] ASoC: dpcm: allow start or stop during pause for backend
Message-ID: <20200401050601.GB72691@vkoul-mobl>
References: <CGME20200401010421epcas2p3d5b16041fa59efa0ac8786f682d4c991@epcas2p3.samsung.com>
 <004d01d607c1$7a3d5250$6eb7f6f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <004d01d607c1$7a3d5250$6eb7f6f0$@samsung.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com,
 broonie@kernel.org, hmseo@samsung.com, tkjung@samsung.com,
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

Hello Gyeongtaek,

On 01-04-20, 10:04, �̰��� wrote:
> soc_compr_trigger_fe() allows start or stop after pause_push.
> In dpcm_be_dai_trigger(), however, only pause_release is allowed
> command after pause_push.
> So, start or stop after pause in compress offload is always
> returned as error if the compress offload is used with dpcm.
> To fix the problem, SND_SOC_DPCM_STATE_PAUSED should be allowed
> for start or stop command.

I think it makes sense to allow START if the stream is paused. Similarly
a STOP should be legal as well for paused stream, so:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
> ---
>  sound/soc/soc-pcm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 2c59b3688ca0..8f6f0ad50288 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2236,7 +2236,8 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
>  		switch (cmd) {
>  		case SNDRV_PCM_TRIGGER_START:
>  			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
> -			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
> +			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
> +			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
>  				continue;
>  
>  			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
> @@ -2266,7 +2267,8 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
>  			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
>  			break;
>  		case SNDRV_PCM_TRIGGER_STOP:
> -			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
> +			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
> +			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
>  				continue;
>  
>  			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
> -- 
> 2.21.0
> 

-- 
~Vinod
