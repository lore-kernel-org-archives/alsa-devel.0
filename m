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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE43C43603
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 02:22:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4159221823
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 02:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Q/Zyt6Dk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NELtG8K2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4159221823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0BCB1662;
	Thu,  5 Dec 2019 03:21:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0BCB1662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575512538;
	bh=6wSXZdVnyc1sElY1+qx/ia+nWywuWy0Tdv9poYmDaPA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q/Zyt6DkC5JZM6f7UROh4BhtvlETi6q2A090+Tp7TOkpRZUDlN9QlZd90MbLv3U7d
	 8EeUYNPQM6zownznkqC3QWmdJtC4FuFLgPtTu71B4MEL+SSNdvxNY9nEK1QN2cTJe8
	 U/frMkAlEcgAqbr275SPm6hlmJkW0nKDqeL77Bss=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A26AF801D9;
	Thu,  5 Dec 2019 03:21:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D359F801EC; Thu,  5 Dec 2019 03:21:25 +0100 (CET)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50866F800F0
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2019 03:21:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50866F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="NELtG8K2"
Received: by mail-pj1-x1042.google.com with SMTP id ep17so622748pjb.4
 for <alsa-devel@alsa-project.org>; Wed, 04 Dec 2019 18:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JumaJpJPhmNfSvvvkz61jNW5BTSsDPkTym99dI21cw8=;
 b=NELtG8K2dfx3apc8E7BMQrUJfvTeRmPJjo/179dWN+u9bqC92MWHpqsHkTkdG9+tHF
 PkWc/QCeImujLtQRnf/3RUcmQEnVe0z/zZelOft28FusJuB78yRG3LRkTYee+U4vXvo0
 NOuCfiPqqDj241vOAHnEz9QUHIUElAqGuk4tPIXgcXhGQsbAcwCMKuyXfO4G9iUzkhvy
 UTtHcjNRw6czLtFkee5AzGgRcgr0EqkDnDvkpAdDOAeVjUChbuY7qAN8a2sBD91Sf5QU
 ZesxB54dEpcVcp16enpBExvDge265f35e/qjqs09wM/u8CM3orqeE+B/i4ZhyxRsnyhH
 CvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JumaJpJPhmNfSvvvkz61jNW5BTSsDPkTym99dI21cw8=;
 b=ckb8puuLL1mvAwgznEILtOI/n34nybhuAkcVcHEdlhTrLZni7SOu40NDh0Rbmz71vE
 PQPNKYhIUUqQcAuM/jetyFRYvq1gZxqMM/hUz04a2Zx1hO00nTnSV8wiI1Whj0soAZ4r
 199UhTqP47xAQ5YMDA0dhiG1jX7N2tGEvoi0Ql4n0dffx1+ZhHo7xsLiWlNO790eTruG
 KvJYg8EOhl46rcv1AKbH2A6Owg8/IRa4fcICRxsuUXQ9Ndq96ZCEC/9mHV1Y0gxq2m9w
 /wKcoLMKtVfzz0J6f5/JBAapUUOMmVw/FifbQf2mlYnTlHZ8a8OuNPO7mjHMsEvYQzaB
 +k1w==
X-Gm-Message-State: APjAAAURDY9TJh5Ae9I+4GRkEpBCrMtjCRJsMi/701LxcB856XJK4XHK
 hgYVbLgFme6Fgiksh3kS4pQ=
X-Google-Smtp-Source: APXvYqwb6wYTzOOyWbUQwbCr44Sh1Uouiz0Kb5BZ0Mc3ApMcrfMMebihBJVtLLPa9b3XOn+09sXF8w==
X-Received: by 2002:a17:90a:6484:: with SMTP id
 h4mr4335560pjj.84.1575512479426; 
 Wed, 04 Dec 2019 18:21:19 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id y38sm9041215pgk.33.2019.12.04.18.21.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 04 Dec 2019 18:21:19 -0800 (PST)
Date: Wed, 4 Dec 2019 18:17:57 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Michael Walle <michael@walle.cc>
Message-ID: <20191205021756.GA1122@Asurada-Nvidia.nvidia.com>
References: <20191128223802.18228-1-michael@walle.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191128223802.18228-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_sai: add IRQF_SHARED
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

On Thu, Nov 28, 2019 at 11:38:02PM +0100, Michael Walle wrote:
> The LS1028A SoC uses the same interrupt line for adjacent SAIs. Use
> IRQF_SHARED to be able to use these SAIs simultaneously.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_sai.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index b517e4bc1b87..8c3ea7300972 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -958,7 +958,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	ret = devm_request_irq(&pdev->dev, irq, fsl_sai_isr, 0, np->name, sai);
> +	ret = devm_request_irq(&pdev->dev, irq, fsl_sai_isr, IRQF_SHARED,
> +			       np->name, sai);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to claim irq %u\n", irq);
>  		return ret;
> -- 
> 2.20.1
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
