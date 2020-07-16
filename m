Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42D3C433E3
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 23:39:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEE6206F4
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 23:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ibQ+IbxR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNT1KJPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEE6206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7F7D886;
	Fri, 17 Jul 2020 01:38:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7F7D886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594942757;
	bh=nEJyaQMXC6jisLT/wHAV5gStAPaUZezw0k4WwDjGAEk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ibQ+IbxRrcdTwoBeBDmyPC2e1lPhc5nA5kF4AF7Qo+1RWco5Sq3sNoL5YUqvpoXPW
	 ifgoqe0/3e+zGiQi7PLeWR/8xwhnbDo8/+uCxgZIeYouKqnzK0o2K45+zmy+dPlGgs
	 Qeg5APd2bX0s0JUDaFnhQg9nbvHmqr3m3Tfqcm5M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16332F8016F;
	Fri, 17 Jul 2020 01:38:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52AAAF801EC; Fri, 17 Jul 2020 01:38:23 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C95FBF8014C
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 01:38:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C95FBF8014C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="HNT1KJPv"
Received: by mail-pg1-x542.google.com with SMTP id d4so5723078pgk.4
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 16:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YI7Vx/uvEtkVHjbnn5enh7Amkd8UUwSoGpt+t0J9E6s=;
 b=HNT1KJPvsw+DsJ8EOVLWmzitrBpr2yo7OeDS/ByQPu3+8YItroTU5tRmB2KmRs4P21
 1XdBvcw8tcZZxmOTswgMDE9PbYsIPXJqexuThr4oua0stDFqoqRnQfWaVLDynSbDgGBP
 +mRMfWfUqqnWFa/3agfFCCVTwGyXE9Uf0XW6eMoUfi0Y7i6+FT+TzKmhujId02r1dSpP
 EoRiQkBwdafl5ekL2/7NLOuVhAxIIsA3G0q6hzrXbZWVczzNTRhwCuaVqWJ5sR6J8rIC
 k6eEdlyYzR+qvFsGOEyzIzVx5a23yduG38u5JOFP5rsy3N26hZFlRa6mxiYAppwLyvYL
 4vGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YI7Vx/uvEtkVHjbnn5enh7Amkd8UUwSoGpt+t0J9E6s=;
 b=inS8V4XcQL7kTthzqQHuYY48N4puGwhlIVWhWy4PlCGNaJwpjXH7wfq3oiKAQYhcLU
 265Vyn8Zc+ZpYyIDtgYrwzSYO7bwfsT9KaWhtI94BtJYaLOEc1R7x5v5V0E5xdichLvi
 H97o5k4b54y8dMzV4VXLdFCoT0JcBxjdiAv3eDWnhxHMT+btHlXIXpRsddyGggiHoukv
 r/t574Nhl6iOfD8xonC3GM1f4iYasRHGHFFq0xG42vOQGFhvZ6EppB6KyPvMUdmp2b+9
 Xb1c5ApxfuTBiLgVQglIR01dUOtGerGZmSkvCrdvbrAI8AkLCQ/YhGvMdcmbEZm7II+u
 pLoQ==
X-Gm-Message-State: AOAM5313+5mMt+k2g4XRdTufDrsd8q9qzRUyjBGfcptqxA2VA8407sFz
 MIoGApTFy8SqQLRnuiHqlDw=
X-Google-Smtp-Source: ABdhPJzQHxH3wEjRwLvQBEJM/Bkm1Yppl+9h/O55FOV43a+W6m9xAk7+6BmVoJgvPO1jc9/gw2Zwfw==
X-Received: by 2002:a63:ac53:: with SMTP id z19mr6120867pgn.181.1594942693154; 
 Thu, 16 Jul 2020 16:38:13 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id y20sm5585405pfo.170.2020.07.16.16.38.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 16 Jul 2020 16:38:12 -0700 (PDT)
Date: Thu, 16 Jul 2020 16:37:46 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl_asrc: always use internal ratio
Message-ID: <20200716233742.GA27376@Asurada-Nvidia>
References: <20200716145201.186270-1-arnaud.ferraris@collabora.com>
 <20200716151352.193451-1-arnaud.ferraris@collabora.com>
 <20200716151352.193451-3-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716151352.193451-3-arnaud.ferraris@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, kernel@collabora.com,
 Shengjiu Wang <shengjiu.wang@gmail.com>
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

On Thu, Jul 16, 2020 at 05:13:54PM +0200, Arnaud Ferraris wrote:
> Even though the current driver calculates the dividers to be used
> depending on the clocks and sample rates, enabling the internal ratio
> can lead to noticeable improvements in the audio quality, based on my
> testing.
> 
> As stated in the documentation, "When USRx=1 and IDRx=0, ASRC internal
> measured ratio will be used", so setting this bit even when not in
> "Ideal Ratio" mode still makes sense.
> 
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 6d43cab6c885..0b79a02d0d76 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -465,7 +465,7 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool use_ideal_rate)
>  	regmap_update_bits(asrc->regmap, REG_ASRCTR,
>  			   ASRCTR_ATSi_MASK(index), ASRCTR_ATS(index));
>  	regmap_update_bits(asrc->regmap, REG_ASRCTR,
> -			   ASRCTR_USRi_MASK(index), 0);
> +			   ASRCTR_USRi_MASK(index), ASRCTR_USR(index));
>  
>  	/* Set the input and output clock sources */
>  	regmap_update_bits(asrc->regmap, REG_ASRCSR,
> @@ -507,8 +507,7 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool use_ideal_rate)
>  
>  	/* Enable Ideal Ratio mode */

The code is against the comments now -- need to update this line.

>  	regmap_update_bits(asrc->regmap, REG_ASRCTR,
> -			   ASRCTR_IDRi_MASK(index) | ASRCTR_USRi_MASK(index),
> -			   ASRCTR_IDR(index) | ASRCTR_USR(index));
> +			   ASRCTR_IDRi_MASK(index), ASRCTR_IDR(index);

The driver falls back to ideal ratio mode if there is no matched
clock source. Your change seems to apply internal ratio mode any
way? Probably would break the fallback routine.
