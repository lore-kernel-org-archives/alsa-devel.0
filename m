Return-Path: <SRS0=yD/C=LC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195D2C47082
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 07:51:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3263960FEE
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 07:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3263960FEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3B641678;
	Tue,  8 Jun 2021 09:51:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3B641678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623138712;
	bh=GLbOM7U8+6TScsO2Mih7/7org/zfaujumI6jLSQj4WY=;
	h=References:From:To:Subject:In-reply-to:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oVJOpiyeVlLcsPv8D31ib2I6wcWOR3h0TybVId3WnzOmT3iiPiFwWeUnis9JnC3Vb
	 w9yLKz3h3z5Efl7up2D61g6jK6781sdTSIKRlB1U5eMPQEiMl57TFraK8iQvaSA/rE
	 NFuxV0WNa9kr96aOJ4qDTYaxVzBdvttthRaIbTi4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63807F801EC;
	Tue,  8 Jun 2021 09:51:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 644E0F80218; Tue,  8 Jun 2021 09:51:01 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A0B3F800FD
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 09:50:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A0B3F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="h8R948xY"
Received: by mail-ej1-x632.google.com with SMTP id k7so30999402ejv.12
 for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2021 00:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
 :date:mime-version;
 bh=hUTnTMFR+eXzNs4SZR8VOAFJ6n46mGzGxpZIZUF2qwI=;
 b=h8R948xYukDImjVCNQjIkn2QMJ0kyY2Zw5L4tB1WJjC54fm6ZlFkJQGSeQLQqyprWB
 p0PBhLhmznCEm1/wLchHL67fv/Ec+oL4XOvJwighDPMCx01hqEoloZJTfa2iX/i5WGoe
 2ezLKQI3wtgIuFT/wo4/XWVtZZ52uxeVFJja7RGCWwCdUeJs2GJLyMqbREA9mMpavJ6M
 ptSEV/tbGMmxZ9jQrkNbEFbu/hQnk4pxEWvNNkjihFaXi1p/z0yh6UamqDfLzsajdIEL
 AI7JMAGtrCMgQsWetO/5oANUTSJXkeUIdT4FDp668IxtIdZxtCYzcnDbQy1MjzqzHmKE
 xzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:message-id:date:mime-version;
 bh=hUTnTMFR+eXzNs4SZR8VOAFJ6n46mGzGxpZIZUF2qwI=;
 b=mqyNEeeFfZkTkTZKM/ZoEy/1rh2aOgRRhcIkRDrgRMijkA1WAJpfVCl72iXqXnvnFs
 wLM6DboRY1xoo5woaFPU1qFnCnwVGhUM+5zbAbZIrDPlaJeH6aIrAJTT4WzIoGJ3ZfUd
 5btcC8voSU/wb+7kKCPnszT+LoCpiB/2iZsLtd6Wyt2m4yKTIFkX5kfdCGxJKnY2l8ms
 64vlbZw7KHGwYEmzlZpjsXtGnB5eutd4gxgtf8Lgu94wvWTyatsrxybOzwzm3eZDJx3I
 zoXU8GJt6YHZGfATWOdPUfNyRKuZCP5ereL70c3oLfypBUyUeBH+0T9R3fezznE2TnjM
 3CGg==
X-Gm-Message-State: AOAM530kqgg8niHh90/6dMAs+nCi8+1tSHZ1EXfrUcHeJZw8xWeJWvG5
 hI3GHfNd5TzvhMcHL8bB4spVVw==
X-Google-Smtp-Source: ABdhPJzO4IqpgdWj0mESgUKaR/WzdAuvWXJApHNBZRr8jb0fSgIxMJbyLC2d60j45YM5i6D87wDiZw==
X-Received: by 2002:a17:906:b84f:: with SMTP id
 ga15mr21673366ejb.372.1623138653177; 
 Tue, 08 Jun 2021 00:50:53 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
 by smtp.gmail.com with ESMTPSA id bh3sm7438687ejb.19.2021.06.08.00.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 00:50:52 -0700 (PDT)
References: <875yypdxlm.wl-kuninori.morimoto.gx@renesas.com>
 <87wnr5ciyz.wl-kuninori.morimoto.gx@renesas.com>
User-agent: mu4e 1.4.15; emacs 27.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/9] ASoC: fsl: switch to use
 snd_soc_daifmt_parse_format/clock_provider()
In-reply-to: <87wnr5ciyz.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <1jo8cgre03.fsf@starbuckisacylon.baylibre.com>
Date: Tue, 08 Jun 2021 09:50:52 +0200
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Sameer Pujar <spujar@nvidia.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
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


On Tue 08 Jun 2021 at 02:12, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> This patch switch to use snd_soc_daifmt_parse_format/clock_provider() from
> snd_soc_of_parse_daifmt().
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/fsl/fsl-asoc-card.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index c62bfd1c3ac7..6a6f098da0dc 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -540,7 +540,6 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  	struct device *codec_dev = NULL;
>  	const char *codec_dai_name;
>  	const char *codec_dev_name;
> -	unsigned int daifmt;
>  	u32 width;
>  	int ret;
>  
> @@ -684,19 +683,12 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Format info from DT is optional. */
> -	daifmt = snd_soc_of_parse_daifmt(np, NULL,
> -					 &bitclkmaster, &framemaster);
> -	daifmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
> +	snd_soc_daifmt_parse_clock_provider(np, NULL, &bitclkmaster, &framemaster);
>  	if (bitclkmaster || framemaster) {
> -		if (codec_np == bitclkmaster)
> -			daifmt |= (codec_np == framemaster) ?
> -				SND_SOC_DAIFMT_CBM_CFM : SND_SOC_DAIFMT_CBM_CFS;
> -		else
> -			daifmt |= (codec_np == framemaster) ?
> -				SND_SOC_DAIFMT_CBS_CFM : SND_SOC_DAIFMT_CBS_CFS;
> -
>  		/* Override dai_fmt with value from DT */
> -		priv->dai_fmt = daifmt;
> +		priv->dai_fmt = snd_soc_daifmt_parse_format(np, NULL) |
> +			snd_soc_daifmt_clock_provider_pickup(((codec_np == bitclkmaster) << 4) +
> +							      (codec_np == framemaster));

Hi,

I understand you are trying to fold some code but I'm not sure about this
snd_soc_daifmt_clock_provider_pickup().

Instead of repeating the if clause around DAIFMT (which is a bit verbose
but fairly easy to understand and maintain) there is now the calculation
of a made up constant (which is rather opaque as it is), which later
translate to the same type of test around DAIFMT. 

I'd be in favor of dropping the snd_soc_daifmt_clock_provider_pickup()
part for the sake or readability. This apply to the rest of the series,
not just fsl.

The rest looks good, Thx Kuninori.

>  	}
>  
>  	/* Change direction according to format */

