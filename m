Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB67BC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:26:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B4B20853
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TXJxmmqI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQiJm1Kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B4B20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8F5086E;
	Wed, 17 Jun 2020 08:25:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8F5086E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592375176;
	bh=M1zHoq06+eEi7s7gHku1LqcXm7cCCg1LanqY9qCgjNk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TXJxmmqIvDBpVF/YtxBWKz0lJPIL2Oe8FE/J4R7IJQjYfWGVg/vHEZ2q2h+4GhvLV
	 1mJoc6ahiCw4f5BCdlnPwD+HSIf0kOrW7+Vel12p+SmfxCFg6KHU2t1iF66b703YMk
	 SvFoWxaSV6oIpfc01SuK8yozAy11cNoYFtg4V8U4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D41BCF80116;
	Wed, 17 Jun 2020 08:25:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD640F800EF; Wed, 17 Jun 2020 08:25:24 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 202DDF800EF
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 08:25:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 202DDF800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="uQiJm1Kv"
Received: by mail-pg1-x544.google.com with SMTP id s10so780465pgm.0
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 23:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=g3cuqw1MSyXPgpwfSctF0q4VjJu4I8Z3M0GkPzhFPXI=;
 b=uQiJm1KvSqhA+U+Rmq7T3vkBhQwaFWZe2j+ocuj3Vyq/u5pzs6ioJ5ccCn8x/fmbEk
 D+mupFc9PdPKhEnu1tBz8N1ZZRdzgRAEzCjKOiA97ngMztK5FiGeVm4aRe75tjg0YbGp
 beCEtKsmaET3KAIu2Hhw5+9wPy8altJfh0fqp+zladWB7rbFOuJgZu/BoqesFJSj9yPO
 wS3XiFM3c2jEVKpX3kaEDLiFyLTovbRh7asyxqnc+wiPfm/W6LdLkaHS+6KTKCpVYBx9
 +NzUfWKIgMxbggZA7xXMfMp1PDcG7A/ZMLCuz5MZ2NHbTeEPgcU8cJUvsmuASmXRA+X8
 HHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=g3cuqw1MSyXPgpwfSctF0q4VjJu4I8Z3M0GkPzhFPXI=;
 b=Tq/6eU873ezM+4s5wnCGA1YMlDdsf73GPVRK0h6+ZJ6C1bAlL3+II+gSC3RBKXYeCo
 xpR03eGr2P6gNemxxQ+o2Qy0rKdz0BfgivHfeC/yr3dnTx3cBRHFCPRhXjem9SKRC2K1
 TbLiHdB/+FLYVbFkiEp6sdLdTCAZfZrtlJl4QcYn+LDSPyTw7nCgY589L29AE53c+zut
 Hy5m15OWOcy/ZboDEF8TrkEGOLRZD/2GAxvd2NJRGrK+0vwOo42uGsolFTDrK3VZXY3D
 wJU8Fo6wQR3qNrgkThW/nScUjh8VZZSfDN6PKn7trszggjGm4WzcMg7g6qRpcyiJ082F
 MYnw==
X-Gm-Message-State: AOAM531nbLV2+kqXF5fgXBsHixZ8TYkHzsLsORQJEBGUOx6wqIgOe3KT
 /9uVqUoYi/+TmcPQwc3b9IU=
X-Google-Smtp-Source: ABdhPJw1gU2G4M0g+SAUSO6VDblRQx1jBiF2PJ3y6iajq5no77C2746qSL/0k/jfXmN6z06pyK6esA==
X-Received: by 2002:aa7:9aee:: with SMTP id y14mr5269735pfp.105.1592375116437; 
 Tue, 16 Jun 2020 23:25:16 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id j36sm3305919pgj.39.2020.06.16.23.25.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 23:25:16 -0700 (PDT)
Date: Tue, 16 Jun 2020 23:24:58 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl_spdif: Add support for imx6sx platform
Message-ID: <20200617062457.GA6411@Asurada-Nvidia>
References: <feda3bb02296455d43aeebb7575918d9b28e1a3f.1592368322.git.shengjiu.wang@nxp.com>
 <53a969a83999de91f3ff2809d78335c3f0cc1ee3.1592368322.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a969a83999de91f3ff2809d78335c3f0cc1ee3.1592368322.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 Xiubo.Lee@gmail.com, lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org,
 tiwai@suse.com, robh+dt@kernel.org, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
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

On Wed, Jun 17, 2020 at 12:30:17PM +0800, Shengjiu Wang wrote:
> The one difference on imx6sx platform is that the root clock
> is shared with ASRC module, so we add a new flags
> "shared_root_clock" which means the root clock is independent,

"shared" means "not independent", against "independent" ;)

> then we will not do the clk_set_rate and clk_round_rate to avoid
> impact ASRC module usage.
> 
> As add a new flags, we include the soc specific data struct.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Can add this once fixing the remaining comments:

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>

> +static inline bool fsl_spdif_can_set_clk_rate(struct fsl_spdif_priv *spdif,
> +					      int clk)

Can actually merge into single line as kernel has 100-character
limit now, though 80-char is still preferable for a good coding
style. But I think this one wouldn't be too bad at all.

> @@ -421,7 +456,7 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
>  	sysclk_df = spdif_priv->sysclk_df[rate];
>  
>  	/* Don't mess up the clocks from other modules */

We can drop this comments now as it's out-of-date and the name of
the new helper function is straightforward enough.

> -	if (clk != STC_TXCLK_SPDIF_ROOT)
> +	if (!fsl_spdif_can_set_clk_rate(spdif_priv, clk))
>  		goto clk_set_bypass;
>  
>  	/* The S/PDIF block needs a clock of 64 * fs * txclk_df */
