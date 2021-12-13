Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547B8C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Dec 2021 20:38:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98EFC18F3;
	Mon, 13 Dec 2021 21:37:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98EFC18F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639427902;
	bh=X9TmUKjYBH8szUHeMICJIybfvaAyMQBZM5LPaTeKFOo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=amXgK8eR40PLlxkOGW6lsC7wFZ9GUti0LKbjdh42sX18nt+fWEs0TyBckcmxwOp2X
	 eaLbpdWk3udm7qAIOP++oapNnl0mJ8ZbwnZwfYSX2NqchL/bL7MC9CjwgZW/UZ9IHy
	 veYOfo/bT6f+9vxzH6sZkc1QUZT2zu+wpmZ5unYk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4609BF80229;
	Mon, 13 Dec 2021 21:37:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9010DF8025D; Mon, 13 Dec 2021 21:37:30 +0100 (CET)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D4FBF80161
 for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2021 21:37:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D4FBF80161
Received: by mail-oi1-f172.google.com with SMTP id t19so24788183oij.1
 for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2021 12:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZgfptJ9Nc5V7IoyX3trjYNyQOy+R5xm/7NE8jjO7OEA=;
 b=gna0TsTWGHBHqh6HszM943c8zoo8FTezc4t1Gtf8dX1V9uDkeEB310pZXaQ+APHaOq
 DTdiNgb0f5ka/wzAd3y2GNAX+MRmOkAT9vnQ2IBMRntegJEVu7RsAVuFlmisu14Ax27h
 As7NMCJYNw4TRmOc8A3OY58KyLuTjotbaq6dWsk5/V8ey79QjzOcHcNv2vySaZOcgXMW
 GSbJFGwIhYyDqvZehyPmQsuWAVyJXjOsHx0qjZXi3ub59FFyqc2kBjq85wRLvqYCXgWJ
 wErnxxEJ3bpYOevlwx9ukexLx3oX/FC48vnlpQI+iWg4Ww+DqryGONtXW4/Rvu+btO++
 BDYA==
X-Gm-Message-State: AOAM532nRCk/zJoIduyzoXteBLvjQ6w77zZTmk5yuA9i3119hcQVxfOi
 YuTrKnc0bhO2sYPAONSMxA==
X-Google-Smtp-Source: ABdhPJxRGFl7/TuYODUdC0OyJhloj38Cvr/IgqWq5bUIDnUkSaz8Q/Vd7zdWNvdsGQ+H/NDCpJzSSA==
X-Received: by 2002:a05:6808:20a5:: with SMTP id
 s37mr28661250oiw.127.1639427841508; 
 Mon, 13 Dec 2021 12:37:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id d8sm2915081oiw.24.2021.12.13.12.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Dec 2021 12:37:20 -0800 (PST)
Received: (nullmailer pid 1529335 invoked by uid 1000);
 Mon, 13 Dec 2021 20:37:19 -0000
Date: Mon, 13 Dec 2021 14:37:19 -0600
From: Rob Herring <robh@kernel.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: Re: [PATCH 3/4] ASoC: fsl-asoc-card: Add optional dt property for
 setting mclk-id
Message-ID: <Ybeu/1vsUzvAg2Ya@robh.at.kernel.org>
References: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
 <20211203134930.128703-4-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203134930.128703-4-ariel.dalessandro@collabora.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 michael@amarulasolutions.com, kuninori.morimoto.gx@renesas.com,
 Xiubo.Lee@gmail.com, tony@atomide.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, tiwai@suse.com, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, nicoleotsuka@gmail.com, broonie@kernel.org,
 bcousson@baylibre.com, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

On Fri, Dec 03, 2021 at 10:49:29AM -0300, Ariel D'Alessandro wrote:
> Sound cards may allow using different main clock inputs. In the generic
> fsl-asoc-card driver, these values are hardcoded for each specific card
> configuration.
> 
> Let's make it more flexible, allowing setting mclk-id from the
> device-tree node. Otherwise, the default value for each card
> configuration is used.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 1 +
>  sound/soc/fsl/fsl-asoc-card.c                             | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> index 23d83fa7609f..b219626a5403 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> @@ -82,6 +82,7 @@ Optional properties:
>    - dai-format		: audio format, for details see simple-card.yaml.
>    - frame-inversion	: dai-link uses frame clock inversion, for details see simple-card.yaml.
>    - bitclock-inversion	: dai-link uses bit clock inversion, for details see simple-card.yaml.
> +  - mclk-id		: main clock id, specific for each card configuration.

Ahh, there it is. This change and the header defines should be 1 patch 
and driver changes another.

>  
>  Optional unless SSI is selected as a CPU DAI:
>  
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 90cbed496f98..bb962e04d40b 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -693,6 +693,12 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  		goto asrc_fail;
>  	}
>  
> +	/*
> +	 * Allow setting mclk-id from the device-tree node. Otherwise, the
> +	 * default value for each card configuration is used.
> +	 */
> +	of_property_read_u32(np, "mclk-id", &priv->codec_priv.mclk_id);
> +
>  	/* Format info from DT is optional. */
>  	snd_soc_daifmt_parse_clock_provider_as_phandle(np, NULL, &bitclkprovider, &frameprovider);
>  	if (bitclkprovider || frameprovider) {
> -- 
> 2.30.2
> 
> 
