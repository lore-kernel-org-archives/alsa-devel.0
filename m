Return-Path: <SRS0=LzfN=Z3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C40C43603
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 02:24:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0F5206DB
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 02:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nVDyMqy0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aglRMlJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0F5206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9442166A;
	Thu,  5 Dec 2019 03:23:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9442166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575512659;
	bh=/ZOFECJWHXfMQyacuYceUGgpBSTvDYJ4Z5oCDWjlYzA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nVDyMqy0eoMVkZBXXmVKVKCDibdpoba+p9yuWMntwmcC36ypDr8MQ5T/PbeVUvcsh
	 stoIzzcZJtla9kMIr3wedARDpicjs3saZnpTzi2MAwhmyOI88qXhy8elVjEqZapa/D
	 M5Ib6Cl/sDS3ZQREeBIUJkJ7gT/Re9bpuBC7xwNo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3763FF800F0;
	Thu,  5 Dec 2019 03:23:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0EF0F801EC; Thu,  5 Dec 2019 03:23:27 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2297AF800F0
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2019 03:23:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2297AF800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="aglRMlJM"
Received: by mail-pg1-x544.google.com with SMTP id l24so827502pgk.2
 for <alsa-devel@alsa-project.org>; Wed, 04 Dec 2019 18:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=H1VUU4rUNg7kFJO0xACp+i6rdKuZ6Hw04Q1UCWcIN1I=;
 b=aglRMlJMdAULGfV+4x2klYHp9oyyrIwz3f1q0hoDKQJotHgJodNQPgDvNbiZevppxo
 BQM6xM/mqyzPvkKf7kt4NMp59Sm9OQCTMpy1gDhVWEH3tfO079d/zDI3qGeovh98hDKE
 VeVC5xtkNdnKAnjJCHBbaMTazkMa/jsA+8xUcqSrA0mq3oOo2NENR4XY1WexeTw+VyxJ
 /vTvSm5xCYVi9dBv/k7miIdxyLqSwKBpelvVPgcYzA3n2FFo597Z3mh++tJtZJKzroYC
 95t1Ad8Ibr0gUrZmOJDiJhST1NjFBqLSKMa48T55xBKnfKKH5fJOKUNcIotF/8F3p1If
 TwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=H1VUU4rUNg7kFJO0xACp+i6rdKuZ6Hw04Q1UCWcIN1I=;
 b=H+wCrHZHpzobLN6YOStD0eaydfxFwa7DuLtsILssqasI5ORDH0AqWv27MWz4kpX+a4
 /kv8y4vna79G1+XFfJjTeOurIsMtG1GVU7pvWHBcFcA8cE8ogG/IRXfhh+O1HR7K9dTL
 3HwWQ0rJYiLNxqaBsbKljsFmPi96/rfkSHyzILxmR170yPTyyLeZZqBWU59cVz3F2DcP
 OWZMEHGej9ahpAJymG+mpNlj6xzCCwXAtjtbU82mX10oiaZp+QBp3m7fOwHJ2i8w1/JT
 bumZE91WXHoJQajIwNcrAm8cs9GRC//mWEAWY7ZWNxpWOa2BFaYLDMvM5FPZFuGh1bWz
 jSOw==
X-Gm-Message-State: APjAAAXyDLl2ufgVrAKaVeRn1fFovhhjERJ3b9pIa0f4dEKVqGYEytsn
 nCbvNCr+HReevMhB2PI/Pj0=
X-Google-Smtp-Source: APXvYqzkjBxfnQeluO+tqp7YsVDUANm1utWoTgwzql0A8Bkxp/7Um+nIn79aONqUfWZ+c2qIO6OiWQ==
X-Received: by 2002:a65:4381:: with SMTP id m1mr6893645pgp.43.1575512596508;
 Wed, 04 Dec 2019 18:23:16 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d26sm8722858pgv.66.2019.12.04.18.23.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 04 Dec 2019 18:23:16 -0800 (PST)
Date: Wed, 4 Dec 2019 18:19:56 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Chuhong Yuan <hslester96@gmail.com>
Message-ID: <20191205021955.GB1122@Asurada-Nvidia.nvidia.com>
References: <20191203111303.12933-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191203111303.12933-1-hslester96@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH resend] ASoC: fsl_audmix: add missed
	pm_runtime_disable
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

On Tue, Dec 03, 2019 at 07:13:03PM +0800, Chuhong Yuan wrote:
> The driver forgets to call pm_runtime_disable in probe failure
> and remove.
> Add the missed calls to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_audmix.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
> index a1db1bce330f..5faecbeb5497 100644
> --- a/sound/soc/fsl/fsl_audmix.c
> +++ b/sound/soc/fsl/fsl_audmix.c
> @@ -505,15 +505,20 @@ static int fsl_audmix_probe(struct platform_device *pdev)
>  					      ARRAY_SIZE(fsl_audmix_dai));
>  	if (ret) {
>  		dev_err(dev, "failed to register ASoC DAI\n");
> -		return ret;
> +		goto err_disable_pm;
>  	}
>  
>  	priv->pdev = platform_device_register_data(dev, mdrv, 0, NULL, 0);
>  	if (IS_ERR(priv->pdev)) {
>  		ret = PTR_ERR(priv->pdev);
>  		dev_err(dev, "failed to register platform %s: %d\n", mdrv, ret);
> +		goto err_disable_pm;
>  	}
>  
> +	return 0;
> +
> +err_disable_pm:
> +	pm_runtime_disable(dev);
>  	return ret;
>  }
>  
> @@ -521,6 +526,8 @@ static int fsl_audmix_remove(struct platform_device *pdev)
>  {
>  	struct fsl_audmix *priv = dev_get_drvdata(&pdev->dev);
>  
> +	pm_runtime_disable(&pdev->dev);
> +
>  	if (priv->pdev)
>  		platform_device_unregister(priv->pdev);
>  
> -- 
> 2.24.0
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
