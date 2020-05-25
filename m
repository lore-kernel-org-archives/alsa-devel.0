Return-Path: <SRS0=YV0t=7H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AD3C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2020 05:11:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A2BC2075F
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2020 05:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mDcdhXRe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn3TRd1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2BC2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D343C16AC;
	Mon, 25 May 2020 07:10:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D343C16AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590383488;
	bh=ST1MIZLGXWJ93v79JeJKBELQXpqKNUoxRD+6BXlhzFI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mDcdhXReLtayxRGH9YtodRniGZy1JMaZPYy+pPB3CoAIa7CrdaQRtcYN4RpXQ7MtL
	 4wgrevpcjipw88tvmck0mqhSJCeprKZGWnfEwomHDGqL2ufGhlK5BGgVhsjlgYbQ/y
	 sg5sD+EslnHTUT9N6S30SIncYd1YfU4zPPqTICjc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AA71F8014E;
	Mon, 25 May 2020 07:10:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B2DBF8016F; Mon, 25 May 2020 07:10:29 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A6AAF80149
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2020 07:10:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A6AAF80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kn3TRd1F"
Received: by mail-pg1-x541.google.com with SMTP id f4so8206896pgi.10
 for <alsa-devel@alsa-project.org>; Sun, 24 May 2020 22:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YRJ/uOHwZy2ewPR+X9jA1rwhfgU5ND1HSwCyer+uJtE=;
 b=kn3TRd1Ful72W4WI09lPbmOCFr0cc8jgn/UQsM8xyEHuv8XRoTCZ59qmXXiaJBYdoa
 dF8Tv4JnSYd5PhsKJTrKoICFXCjSlY+YIKoDpi2QAOLNDCqzDQEtS1UZX8GztwRd2dbL
 g6heL6VZWCf46y76J1lh8DWJYvCsWLZMV2AeLcr4UVpkTHgncjJbjnXezE67plJYDmJM
 oBCaj405nHTpfZIa/Wnd8188OR8SSLVyQTWoNjr3xX4v5nqTUQC60PyDpgC/33A5yg3P
 6sZxeN6t3t2rsso7zauGnonIyue2jEA2Yp0zYhZNMYU53O4gGdSqdnKcZOe71a1ICc1T
 WNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YRJ/uOHwZy2ewPR+X9jA1rwhfgU5ND1HSwCyer+uJtE=;
 b=HGws3eRUfcMes6npVdef6iVpoS327PTRmNc3YinFbGcgdCj5e9a1ofRayNe8ckljoe
 iX2Ssw+Rce9hPszzNoCayxhMHlZzU007sxMFalkdGQtzybIY5KlW1w210snPONa6Xoka
 XyhReRb1RmA27E6B1qeXYqkze9/OV2dRf/7stcpRlSRHxPnQYMZHTuihL/q/EgYgTe09
 MIosymK0yyA2ycrcpl0duWx5hbu3Qi2zQs+y0FGzhAAI0kgFO8959psOGtKN/azyX4Vq
 IugYjRJdap0hnW65/m0Z0d9PLOV0CWGMvfReUid6L/1Spd/vWGdJH5VgX3aWlYPkQbhK
 ukrA==
X-Gm-Message-State: AOAM531aTj0J5FWj1L23efnIGsS0pXMPdsR+Uu5W2ZR6kGJArhVJeEL4
 tvsL1JmdiX/HeTYmQP/gOI4=
X-Google-Smtp-Source: ABdhPJzQCUPRj8DgbPosLYa7RFU4MdgVjnRbidmCGmop2YwNzGzhcWemC1QhhiQMgnYiykuu8Rio6A==
X-Received: by 2002:a62:be18:: with SMTP id l24mr3743697pff.12.1590383398285; 
 Sun, 24 May 2020 22:09:58 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
 by smtp.gmail.com with ESMTPSA id
 7sm12153013pfc.203.2020.05.24.22.09.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 24 May 2020 22:09:58 -0700 (PDT)
Date: Sun, 24 May 2020 22:09:51 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: Merge suspend/resume function to
 runtime_suspend/resume
Message-ID: <20200525050950.GA1244@Asurada>
References: <1590141444-28668-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590141444-28668-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 broonie@kernel.org, festevam@gmail.com, linux-kernel@vger.kernel.org
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

On Fri, May 22, 2020 at 05:57:24PM +0800, Shengjiu Wang wrote:
> With dedicated power domain for asrc, power can be disabled after
> probe and pm runtime suspend, then the value of all registers need to
> be restored in pm runtime resume. So we can merge suspend/resume function
> to runtime_suspend/resume function and enable regcache only in end of
> probe.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 70 ++++++++++++++++------------------------
>  1 file changed, 27 insertions(+), 43 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 432936039de4..3ebbe15ac378 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -1100,6 +1100,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, asrc);
>  	pm_runtime_enable(&pdev->dev);
>  	spin_lock_init(&asrc->lock);
> +	regcache_cache_only(asrc->regmap, true);
>  
>  	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_asrc_component,
>  					      &fsl_asrc_dai, 1);
> @@ -1117,6 +1118,7 @@ static int fsl_asrc_runtime_resume(struct device *dev)
>  	struct fsl_asrc *asrc = dev_get_drvdata(dev);
>  	struct fsl_asrc_priv *asrc_priv = asrc->private;
>  	int i, ret;
> +	u32 asrctr;
>  
>  	ret = clk_prepare_enable(asrc->mem_clk);
>  	if (ret)
> @@ -1135,6 +1137,24 @@ static int fsl_asrc_runtime_resume(struct device *dev)
>  			goto disable_asrck_clk;
>  	}
>  
> +	/* Stop all pairs provisionally */
> +	regmap_read(asrc->regmap, REG_ASRCTR, &asrctr);
> +	regmap_update_bits(asrc->regmap, REG_ASRCTR,
> +			   ASRCTR_ASRCEi_ALL_MASK, 0);
> +
> +	/* Restore all registers */
> +	regcache_cache_only(asrc->regmap, false);
> +	regcache_mark_dirty(asrc->regmap);


I see you doing regcache_mark_dirty() in the resume() now,
being different from previously doing in suspend()?

Thanks
Nic


> +	regcache_sync(asrc->regmap);
> +
> +	regmap_update_bits(asrc->regmap, REG_ASRCFG,
> +			   ASRCFG_NDPRi_ALL_MASK | ASRCFG_POSTMODi_ALL_MASK |
> +			   ASRCFG_PREMODi_ALL_MASK, asrc_priv->regcache_cfg);
> +
> +	/* Restart enabled pairs */
> +	regmap_update_bits(asrc->regmap, REG_ASRCTR,
> +			   ASRCTR_ASRCEi_ALL_MASK, asrctr);
> +
>  	return 0;
>  
>  disable_asrck_clk:
> @@ -1155,6 +1175,11 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
>  	struct fsl_asrc_priv *asrc_priv = asrc->private;
>  	int i;
>  
> +	regmap_read(asrc->regmap, REG_ASRCFG,
> +		    &asrc_priv->regcache_cfg);
> +
> +	regcache_cache_only(asrc->regmap, true);
> +
>  	for (i = 0; i < ASRC_CLK_MAX_NUM; i++)
>  		clk_disable_unprepare(asrc_priv->asrck_clk[i]);
>  	if (!IS_ERR(asrc->spba_clk))
> @@ -1166,51 +1191,10 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
>  }
>  #endif /* CONFIG_PM */
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int fsl_asrc_suspend(struct device *dev)
> -{
> -	struct fsl_asrc *asrc = dev_get_drvdata(dev);
> -	struct fsl_asrc_priv *asrc_priv = asrc->private;
> -
> -	regmap_read(asrc->regmap, REG_ASRCFG,
> -		    &asrc_priv->regcache_cfg);
> -
> -	regcache_cache_only(asrc->regmap, true);
> -	regcache_mark_dirty(asrc->regmap);
> -
> -	return 0;
> -}
> -
> -static int fsl_asrc_resume(struct device *dev)
> -{
> -	struct fsl_asrc *asrc = dev_get_drvdata(dev);
> -	struct fsl_asrc_priv *asrc_priv = asrc->private;
> -	u32 asrctr;
> -
> -	/* Stop all pairs provisionally */
> -	regmap_read(asrc->regmap, REG_ASRCTR, &asrctr);
> -	regmap_update_bits(asrc->regmap, REG_ASRCTR,
> -			   ASRCTR_ASRCEi_ALL_MASK, 0);
> -
> -	/* Restore all registers */
> -	regcache_cache_only(asrc->regmap, false);
> -	regcache_sync(asrc->regmap);
> -
> -	regmap_update_bits(asrc->regmap, REG_ASRCFG,
> -			   ASRCFG_NDPRi_ALL_MASK | ASRCFG_POSTMODi_ALL_MASK |
> -			   ASRCFG_PREMODi_ALL_MASK, asrc_priv->regcache_cfg);
> -
> -	/* Restart enabled pairs */
> -	regmap_update_bits(asrc->regmap, REG_ASRCTR,
> -			   ASRCTR_ASRCEi_ALL_MASK, asrctr);
> -
> -	return 0;
> -}
> -#endif /* CONFIG_PM_SLEEP */
> -
>  static const struct dev_pm_ops fsl_asrc_pm = {
>  	SET_RUNTIME_PM_OPS(fsl_asrc_runtime_suspend, fsl_asrc_runtime_resume, NULL)
> -	SET_SYSTEM_SLEEP_PM_OPS(fsl_asrc_suspend, fsl_asrc_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
>  };
>  
>  static const struct fsl_asrc_soc_data fsl_asrc_imx35_data = {
> -- 
> 2.21.0
> 
