Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7303FC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:31:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC31206D7
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h52Tk6y8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrnP4M4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC31206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EDE61664;
	Fri, 12 Jun 2020 21:30:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EDE61664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591990259;
	bh=tp5IWUyotW+T5shk3CQSPIWwuz8oGz8bxMaBulbtFfQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h52Tk6y81Be1L5XfP4znPJb56YIfxOcpb3g0ukB+WpcPpixPW2Kq3NwRGFQ1u4Hnj
	 fbVdXQbukz610VIRraOeQVeLaoyqXTuYDPmklC7zuqaokJiVHZWrxmNlvfArEp+xFL
	 FAZmgMHx6wax9pXg2+GYAYmerlQwy2+wFT3WtyIA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7932F801F7;
	Fri, 12 Jun 2020 21:30:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5558F8021C; Fri, 12 Jun 2020 21:30:04 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDA91F800C7
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 21:29:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDA91F800C7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="MrnP4M4K"
Received: by mail-pf1-x444.google.com with SMTP id j1so4773490pfe.4
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=a4a2Pl1CFSq1GWe8QgYdCA4ph+xymGtgDfDZzT+4IG4=;
 b=MrnP4M4KchL7FJOLTbUbPeOpodea9cEMKXenI/A9XfvsliD4gdI1bSGbPo1HCq+PeH
 oUhU47XbIwNvM0D9ph7ctwVBwr6W40VlCNZqs43FVd5nzcvHLD8M3/uHBHRYkXCtQEHA
 cxH82FsGLEeN7WqHFmUaIBmBaCyCejKE+QWjR20w+l2Bu/ILF2kFdtUMYtYx8UjGpkZN
 wUnCINgTl53WsnF/rjdzmuwWp7QCP+QFIaJdK85+DncHWScwDNghqbdUEfYwLtmHe+XC
 MiRMHphwN+URaJvMgL+HNSAasFx3k3VYwsdevmtFcSaot4+UFugcdAPD0ynpq9es6vxi
 WVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=a4a2Pl1CFSq1GWe8QgYdCA4ph+xymGtgDfDZzT+4IG4=;
 b=lsWjuLd74blRv/1BZHVx213KAJKCGNtNsxHknKrNM1ajM+qZThMBzgNuweXSzRst8P
 m8pIRa9onQrZQh+0zewJp/NNwo+Q9d7o+TTVBNdyc4HGRK0PszhNkDiQL8K93mFevirW
 k/NNn0GNuoUzDNen6epj/TO6Pv9UnEl/hx7JX3AQgIh97MIRg257RBi92/pC+WjJFyD+
 SpjJguionZBQMJ44JOxOKW8as3Ub6JvV4yL5LtWe+mj1NBqdV9HbaEo9S/Fz8y2UYSg9
 mgWRUdihi+vTJEJGpOAGLHfBVURIvcmGg2r+SBVVkztHhH1pwGzEcfhZtfOyX5DLCyao
 nYEg==
X-Gm-Message-State: AOAM533acAdhFfu/0CprE5yE3I4mL43nGPJw1T4YaHUYPTrRIAS8F5BI
 XtBwRzbplFHn1YqcXC+DPtc=
X-Google-Smtp-Source: ABdhPJwseWqOvjBDHGRP7yoAe1UiXi1K4/GCKgBeAGhWekH7P5Vblc/Zm0oGbIJRoz6jgvwLhh+5gA==
X-Received: by 2002:a65:5349:: with SMTP id w9mr12392157pgr.281.1591990194780; 
 Fri, 12 Jun 2020 12:29:54 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id c1sm6977123pfo.197.2020.06.12.12.29.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Jun 2020 12:29:54 -0700 (PDT)
Date: Fri, 12 Jun 2020 12:29:43 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix bclk calculation for mono channel
Message-ID: <20200612192942.GA26587@Asurada-Nvidia>
References: <1591690768-1691-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591690768-1691-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
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

On Tue, Jun 09, 2020 at 04:19:28PM +0800, Shengjiu Wang wrote:
> For mono channel, ssi will switch to normal mode. In normal
> mode, the Word Length Control bits control the word length
> divider in clock generator, which is different with I2S master
> mode, the word length is fixed to 32bit.
> 
> So we refine the famula for mono channel, otherwise there
> will be sound issue for S24_LE.
> 
> Fixes: b0a7043d5c2c ("ASoC: fsl_ssi: Caculate bit clock rate using slot number and width")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index bad89b0d129e..e347776590f7 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -695,6 +695,11 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
>  	/* Generate bit clock based on the slot number and slot width */
>  	freq = slots * slot_width * params_rate(hw_params);
>  
> +	/* The slot_width is not fixed to 32 for normal mode */
> +	if (params_channels(hw_params) == 1)

This function has a local variable that you can reuse here:
	unsigned int slots = params_channels(hw_params);

> +		freq = (slots <= 1 ? 2 : slots) * params_width(hw_params) *
> +		       params_rate(hw_params);

We have a small section of slots and slot_width calculation
at the top of this function where we can squash these in.
