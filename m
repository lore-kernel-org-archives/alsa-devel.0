Return-Path: <SRS0=lXbg=XL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63FEC49ED7
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2019 23:03:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FD5216C8
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2019 23:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rG64xznP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4Caqvmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FD5216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 924F115F8;
	Tue, 17 Sep 2019 01:02:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 924F115F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568675001;
	bh=89wfmwYMQU+xTKdwfq4b/u0r1G4KH8opzpYfAZdQy7A=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rG64xznPUEQSGz4dlb+KIy0fwLwynq4K3insp6KWDHVVstAEYLciytZdXSpuU2tXw
	 J8FmosL9K0G1fRNMdrFsjSSfG/6lsSWu3OeIg5mFh+gWb97QdTHjnnd8HbqTJi6Vd7
	 vqvl8XTsgPSaj81nvQshLCN9kwovsVZm8qU/qnAY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D116F80137;
	Tue, 17 Sep 2019 01:02:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C114BF80506; Tue, 17 Sep 2019 01:02:29 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F255F80148
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2019 01:02:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F255F80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="P4Caqvmf"
Received: by mail-pg1-x544.google.com with SMTP id x15so834832pgg.8
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2019 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zVZMG9z5pOOWsp+4vryQ3AVq4ZgEgRNgNwh9Yk2ZT+4=;
 b=P4CaqvmfTJiHNJO9wvGMONhYF8QCRruZiUbvOv7eD+OsZAkrSPW3Wj95W2ejCOZ17Z
 DeJmyZCx3s8319SlQznas6nij08GI5050re9gEXIX2B5/ceNAcKTWUIUTrDOE9MvPyGK
 6LB1K/SF6KvdufDR8JzZb2mVWHZPk5tZmR6/p7Y2dsQsnueP1644ZKP7q4MYTGP6pnyY
 zTnF3zxBKoFiMf6Kw+muoffaix9BJfc0H8OAUiHT4HPgzg8TZkelODeMIEQwI3a0z+X5
 41BjnYXj73Xx5Z50fdIf8ygkFEskWPvHmzFKpE6Mm/IfrjOmQ2VoLCPcQFuzl2crFtl2
 HJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zVZMG9z5pOOWsp+4vryQ3AVq4ZgEgRNgNwh9Yk2ZT+4=;
 b=ZsbUMb2K4k8Pwu8ae8j03Rx+0zW9FMtNNmu+WX8tWvS5gtDy8E/yc6KXyqBFKw7Xox
 7jaoxsON62ND6XDjxshlnB4hC9rbNQxTY7V+eoRljLSAt6myPhPmuqG/l9RulwkPwGGL
 htHdkCX7bjkkvQ/CoASP3FFJvE8kkY+kb9idHDq2k2BCOOniVpHhME6n5a1LWkSBSXkD
 0i68FOLl/Frz6SSVMaBQLzIc03EHTIIiKVarqxjpP6GXWyt+QGklO8eWhHqwWKzffNly
 AMaUAWuFedoQf+CEAOitgcj6DbZzTXYUx6OzYl3yT0CaGKZSeDw3PvZ9ZGBccm9UOn3y
 HLag==
X-Gm-Message-State: APjAAAWf30Qz5jZ2nEUcFRFQkxM5kblteFUBpW8j9WJAqRK/bW1Rj2sr
 O6yhkFYSJhTxgIJFEm6j1QY=
X-Google-Smtp-Source: APXvYqyI+GrdW76zWGlfFpAovO27klH6xywoh8iOMh5248anIQ+h5SBGw7socHr707LnWWs6a1Cz5A==
X-Received: by 2002:a17:90a:154f:: with SMTP id
 y15mr1707964pja.73.1568674944944; 
 Mon, 16 Sep 2019 16:02:24 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id r187sm173925pfc.105.2019.09.16.16.02.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Sep 2019 16:02:24 -0700 (PDT)
Date: Mon, 16 Sep 2019 16:02:06 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Message-ID: <20190916230205.GC12789@Asurada-Nvidia.nvidia.com>
References: <20190913192807.8423-1-daniel.baluta@nxp.com>
 <20190913192807.8423-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190913192807.8423-3-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, festevam@gmail.com
Subject: Re: [alsa-devel] [PATCH v2 2/3] ASoC: fsl_sai: Fix xMR setting in
	synchronous mode
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Sep 13, 2019 at 10:28:06PM +0300, Daniel Baluta wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> When Tx is synchronous with receiver the RMR should not be changed.
> When Rx is synchronous with transmitter the TMR should not be changed.

Would you please explain why and what bug this patch fixes?
We might want to Cc stable kernel too if it's a useful fix.

Thank you.
 
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> Changes since v1:
> * new patch
> 
>  sound/soc/fsl/fsl_sai.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index b517e4bc1b87..6598a1ae0a2d 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -482,8 +482,6 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  			regmap_update_bits(sai->regmap, FSL_SAI_TCR5(ofs),
>  				FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
>  				FSL_SAI_CR5_FBT_MASK, val_cr5);
> -			regmap_write(sai->regmap, FSL_SAI_TMR,
> -				~0UL - ((1 << channels) - 1));
>  		} else if (!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
>  			regmap_update_bits(sai->regmap, FSL_SAI_RCR4(ofs),
>  				FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
> @@ -491,8 +489,6 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  			regmap_update_bits(sai->regmap, FSL_SAI_RCR5(ofs),
>  				FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
>  				FSL_SAI_CR5_FBT_MASK, val_cr5);
> -			regmap_write(sai->regmap, FSL_SAI_RMR,
> -				~0UL - ((1 << channels) - 1));
>  		}
>  	}
>  
> -- 
> 2.17.1
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
