Return-Path: <SRS0=hypa=BU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F2EC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 08:38:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F0E2065C
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 08:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FmAFHJgP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLBGxBmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F0E2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 024EC15F9;
	Mon, 10 Aug 2020 10:37:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 024EC15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597048720;
	bh=sm7fx9RGpCSrrLqNvW6haazGts6HZ2PTYiyZZg0tf+M=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FmAFHJgPtQYTA/2aeoz+QWGu4eeYYU7uqIJmiStBp7j7BBmZdzw54nB8xrGea7QND
	 7647vZwsL1YYliVVRSQi4fPQ/hjAJxAK0dh9MLydBad5vcnuNDyXspOSU8c1prNU22
	 P7UwvvLlaxdKdYyBKMJ/X88H227dMVW9rQFoTr5c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A973F800BC;
	Mon, 10 Aug 2020 10:37:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3BD4AF8022B; Mon, 10 Aug 2020 10:37:48 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF4A1F800CE
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2020 10:37:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF4A1F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="pLBGxBmA"
Received: by mail-pj1-x1044.google.com with SMTP id e4so4430985pjd.0
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2020 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Scg7QrQFHhZ2Uk5vL9dJtfSBTf93pMWkHX0hTYM3Wac=;
 b=pLBGxBmA28+kasChedisfkm5yQ00pLLat8cogyaXTpLiExGsBIVYBEBCu2hz/OBRjq
 JEnJ8UbRvkBLpVgWe9F5OiPBNu9NN1vD5FcFk390ldPJaV9NbI3L8f1/o6dj2SD8uDG8
 X8HCnYYdZ3mdBTreaxYiqxn/AEPh962sa6zkhkddCa28cl6ei0EUjktXDaKZ9mZmleMu
 nqxvzdp70e+sqykKT3MdZqiju2Xs3elZPFUcEiKx0QWPDUgZjzniVgfUlThWTWdT/teq
 vMOIcg2BEPu5qgUkPzOaHU7y3Q68EobH75g7jKMfAkHKVMdl3PONxv3/GLP39z2Lr56w
 5CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Scg7QrQFHhZ2Uk5vL9dJtfSBTf93pMWkHX0hTYM3Wac=;
 b=n+HR6E89GA71ESHFyip6ovSdThucQ6SqjTq+tEABQCeeQ2WqkZqmi3UvTgq65sCQ+Q
 VhcceGVrlBP/Wam/4BMmTE1E4mvX3hwJguKPdYQLF30Go0Od2DF4jnmjkxPHzc2QCCYT
 n8ZBf0qTQPITErtkswtUjErJsLDpOB1srTXBbWvRixqCZ32m+BxDyApE39K9mv5VTm6H
 XNCASLjw6JEgs7OIiWm37xYnJkPRGwQqVGdy41p/p54akZHkbCDNMh01m0JJDKlQ7EC0
 bFCCwMvL61XYJSndPJ77rznYbTD6wx8TFrJnrk1WiODMccqJDD4zQChF5lQ7Cl1pU1cD
 Dx1g==
X-Gm-Message-State: AOAM530AHetttlByfQ25M434cN7HbnFU3J88POWDl0MFmK8Lb6srji6B
 ByKVlKhT+uTFytqpGb0zWiQ=
X-Google-Smtp-Source: ABdhPJzjuMOIL1DAbcFHuOnCIOgipzZg0qAzo4rznqU2sir2vCh9nY2ksofTJnj2XfUNc1XE1vk4bw==
X-Received: by 2002:a17:90a:b386:: with SMTP id
 e6mr26337780pjr.57.1597048654505; 
 Mon, 10 Aug 2020 01:37:34 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id 13sm22135713pfp.3.2020.08.10.01.37.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Aug 2020 01:37:34 -0700 (PDT)
Date: Mon, 10 Aug 2020 01:37:29 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: Get "extal" clock rate by
 clk_get_rate
Message-ID: <20200810083728.GA7560@Asurada-Nvidia>
References: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

On Mon, Aug 10, 2020 at 04:11:43PM +0800, Shengjiu Wang wrote:
> On some platform(.e.g. i.MX8QM MEK), the "extal" clock is different
> with the mclk of codec, then the clock rate is also different.
> So it is better to get clock rate of "extal" rate by clk_get_rate,
> don't reuse the clock rate of mclk.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2
> - add defer probe handler
> 
>  sound/soc/fsl/fsl-asoc-card.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 52adedc03245..32f8f756e6bb 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -696,6 +696,17 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  			goto asrc_fail;
>  		}
>  	} else if (of_node_name_eq(cpu_np, "esai")) {
> +		struct clk *esai_clk = clk_get(&cpu_pdev->dev, "extal");
> +
> +		if (!IS_ERR(esai_clk)) {
> +			priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(esai_clk);
> +			priv->cpu_priv.sysclk_freq[RX] = clk_get_rate(esai_clk);

Will it break existing imx-audio-cs42888 on older i.MX platforms?
'cause it overwrites cpu_priv.sysclk_freq[] that are set in "card
configurations" section.
