Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7408EC19F2A
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Aug 2022 03:08:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4957B84B;
	Fri,  5 Aug 2022 05:07:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4957B84B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659668919;
	bh=5U7wsXNGPWQFKNVejEIViG+M5IhPF3zX7RqOJvuJcUI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RQx9egL3YIsOhkYEMcmBBEcT1mXWOSn3AV0vKJulRdk9OOIT/zOjqdP5t3uQipxgN
	 5ChwS3xsh+UkQ/Svy2DqaW0aCQlYBOEfKVQ3UylYGAJgnx4FRblYpaTHFLDSq7iwDu
	 /uOEOIWkwj6Xw1qA+RnaaoCpP2kRi8+JBl/1bukQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3070F80238;
	Fri,  5 Aug 2022 05:07:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62C02F8025A; Fri,  5 Aug 2022 05:07:47 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA961F8013D
 for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2022 05:07:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA961F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="BfyWZLNA"
Received: by mail-lf1-x12b.google.com with SMTP id a9so1620646lfm.12
 for <alsa-devel@alsa-project.org>; Thu, 04 Aug 2022 20:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=zRLrhdcOQ99bka6D1fOqnb8SZpDSCBPIHHf+1lVBXSM=;
 b=BfyWZLNA0WA0wwe8aQmwrq46RWQdKrrLB7XyPlQeQqyFVErsZG1WvpkTCT31caCh8p
 eS4iXl4wK2kGOigufJo9S6qacJG7Eeaa2Plgda6L4JEOntGA7+Ntl3onJjaYf3A0B9SW
 1BkPF8lXNS0d2d+JZNp6gcv8k9AdMoBbj3pS2STf6GJMN4s43va/D1TBDg0KF1iK66d1
 9TXiq1kkHRqa3CXqhTaWqGclcKM/BN3YWYEmrJvyYrqGjKy7yaUTA+Y0fJJE1QKzWi6s
 tG5YslrcsH+AjecGEMiuFGWZW2nnqVBBdvqGW97jmSsm9rS5RsFQ8M+GSSlV1hgj4iNr
 wNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=zRLrhdcOQ99bka6D1fOqnb8SZpDSCBPIHHf+1lVBXSM=;
 b=lTZlG83Sp6HsyygKsPKOXJKhcapVeDLmqD98ss7x+6qp6H4YrW1j4fgWwsbJhB8/bn
 qHZjbrAfl3sy1hgObIarYOFyXwVtgA8oyZiptZGLT+Pv8yyLQlicSe0teWF3moJ0Z+bT
 PrmWPz57eVaNCMFJ2ugtVlZU/YSzMjzCur1E3m9k8ZtrrNlGRR2elQBhcL/YCcDf7RqV
 jWvRK2MKYHeKY2awYzxfiZtIergTFJ3YbgzPI3Y2lmjM/D2GiuO/4ADWbsysjTCGwOTc
 17WbKTepvCaHAsZHVmX77SpAfSKNVI/3OzPoWuEI0xS0KgI6TCNfQ1eIAKY7s7rdVCA6
 4PiQ==
X-Gm-Message-State: ACgBeo1w0f8M8zuVlNcn5zNB32KrReEpHTLToKmDAZ/ODLTEUi1TJENP
 vVEpqDMGz1sMSmA48RWCHFlMsRin7VXRPpM1YFw=
X-Google-Smtp-Source: AA6agR7Qfp8bF/c/dF8zcpgjC+nUpj98cRP4PLX8RQikDQJwywgbYhLTmF+vMFugwMjtJr0FnROMW2IDC92kB8tr+ec=
X-Received: by 2002:a05:6512:31ca:b0:48a:2e3:db41 with SMTP id
 j10-20020a05651231ca00b0048a02e3db41mr1573570lfe.285.1659668862329; Thu, 04
 Aug 2022 20:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220507123101.10938-1-pieterjan.camerlynck@gmail.com>
In-Reply-To: <20220507123101.10938-1-pieterjan.camerlynck@gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 5 Aug 2022 11:07:31 +0800
Message-ID: <CAA+D8ANzaCGEAZUdZsCmKhuw+gXSXdHP7S0RW__xu7FYp+Rdcw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: fix incorrect mclk number in error message
To: Pieterjan Camerlynck <pieterjan.camerlynck@gmail.com>,
 Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>
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

On Sat, May 7, 2022 at 8:31 PM Pieterjan Camerlynck <
pieterjan.camerlynck@gmail.com> wrote:

> In commit <c3ecef21c3f26> ("ASoC: fsl_sai: add sai master mode support")
> the loop was changed to start iterating from 1 instead of 0. The error
> message however was not updated, reporting the wrong clock to the user.
>
> Signed-off-by: Pieterjan Camerlynck <pieterjan.camerlynck@gmail.com>
>

Please resend it and cc Mark

Best regards
Wang shengjiu

> ---
>  sound/soc/fsl/fsl_sai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index ffc24afb5a7a..f0602077b385 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -1054,7 +1054,7 @@ static int fsl_sai_probe(struct platform_device
> *pdev)
>                 sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
>                 if (IS_ERR(sai->mclk_clk[i])) {
>                         dev_err(&pdev->dev, "failed to get mclk%d clock:
> %ld\n",
> -                                       i + 1, PTR_ERR(sai->mclk_clk[i]));
> +                                       i, PTR_ERR(sai->mclk_clk[i]));
>                         sai->mclk_clk[i] = NULL;
>                 }
>         }
> --
> 2.25.1
>
>
