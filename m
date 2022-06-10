Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E8FC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jun 2022 20:08:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A187A1AEB;
	Fri, 10 Jun 2022 22:08:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A187A1AEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654891735;
	bh=muc6rFcuvPh1S85VCGvkjQrqwtQ3kIRRNiJtLWyXVfk=;
	h=In-Reply-To:References:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aaxHxhP8LjHerRm8X0XMzO30uFHSXABLYa8VslPeKOgATmS7miPsO/2qew4YXEkwV
	 DbLlS3TI64aqx1QIFRun9p1eTROJ28Evw5v5ryiFaLoHC0j6bomovTfjJ1/528DG5+
	 BP+r8JCooclbUDbI+AJ6NUIuBRsXUxYNzeotRMMQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36C55F800E5;
	Fri, 10 Jun 2022 22:08:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F081DF804D2; Fri, 10 Jun 2022 22:08:03 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA80FF800E5
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2022 22:07:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA80FF800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="lc3Jw2kY"
Received: by mail-ot1-x330.google.com with SMTP id
 q1-20020a056830018100b0060c2bfb668eso10431ota.8
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2022 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:user-agent:date:message-id
 :subject:to; bh=c4MmH10o4nxyvNb+yLQx/gfjamZc60fdBQ6fL0rTVzI=;
 b=lc3Jw2kYMP3blVRs5hUBawz3Z348qfuHGhD4gAfTjY60kprFN86B288vsV0RzUZPx1
 L4vpiCkCaYKglDEWWttA+6QB56lkIvgoEWqjghhhgYk5Dw2nrJHkvcYYzn7Exz22MlEN
 w2i6N0ecijCkk2h7RfYLniM5gpudUcyROSG2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from
 :user-agent:date:message-id:subject:to;
 bh=c4MmH10o4nxyvNb+yLQx/gfjamZc60fdBQ6fL0rTVzI=;
 b=CTT3CwobtU5/mIzsRemLJbecSMgKrf/+ZpHdyFsKy5B/BfXD4BMoAS1FCyqr6CB+ca
 6agrZnuaVjTqWlpxyyGwr3BfDCLXTAYiup9y08UcM4ajamECe/KhPTl3r27cyfAso9y8
 wnhSVQzholWr2SpOiUdOc/oncNPCFP2A1bWyK0EwSHANl/19Igz9h7FhdTAwvhREkJj0
 LgSZZyDoz93m+pur+rOCt+jBCGLjxuMTbB/IGKlCAUIWHedt03mQOZPJVE167fPGJzh2
 teTRHMaBIDfDvkRwsk32O7IXGuAEbUH29HlreXKozYj23RvY3LrZIC9txgWQHncux3b+
 VUHw==
X-Gm-Message-State: AOAM531BH3ZGTxshDX9g8P3hLOkecLbhOuadzZr47GMKscyTBbYfwCMg
 xzbLEoejZfBAZTzm/gI8ONqdhrw98UNcsWb+CHJorg==
X-Google-Smtp-Source: ABdhPJyQAhZjEcGLUr7co7U+cTdLJgv/8YL3LyUOYF93ir9ueFXa+ObQ+C+qbbjUI7BPoKwZJxHDMEdSN2VBIEC2EGs=
X-Received: by 2002:a9d:6484:0:b0:60b:eb0b:4054 with SMTP id
 g4-20020a9d6484000000b0060beb0b4054mr73615otl.159.1654891673442; Fri, 10 Jun
 2022 13:07:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Jun 2022 13:07:53 -0700
MIME-Version: 1.0
In-Reply-To: <1654872335-4993-3-git-send-email-quic_srivasam@quicinc.com>
References: <1654872335-4993-1-git-send-email-quic_srivasam@quicinc.com>
 <1654872335-4993-3-git-send-email-quic_srivasam@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Fri, 10 Jun 2022 13:07:52 -0700
Message-ID: <CAE-0n53TTyQ9FOcYCT-51wJZd2HP-VfAgTkGBk4gV3jawRPi1w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: qcom: sc7280: Add clock optional check
 for ADSP bypass targets
To: Linus Walleij <linus.walleij@linaro.org>, 
 Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, agross@kernel.org,
 alsa-devel@alsa-project.org, 
 bgoswami@quicinc.com, bjorn.andersson@linaro.org, broonie@kernel.org, 
 devicetree@vger.kernel.org, judyhsiao@chromium.org, lgirdwood@gmail.com, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, perex@perex.cz, quic_plai@quicinc.com, 
 quic_rohkumar@quicinc.com, robh+dt@kernel.org, srinivas.kandagatla@linaro.org, 
 tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
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

Quoting Srinivasa Rao Mandadapu (2022-06-10 07:45:35)
> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> index 74810ec..6e03529 100644
> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> @@ -388,6 +388,9 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
>         pctrl->data = data;
>         pctrl->dev = &pdev->dev;
>
> +       if (of_property_read_bool(np, "qcom,adsp-bypass-mode"))
> +               data->is_clk_optional = true;
> +

Or just

	data->is_clk_optional = of_property_read_bool(np, "qcom,adsp-bypass-mode");

>         pctrl->clks[0].id = "core";
>         pctrl->clks[1].id = "audio";
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> index 2add9a4..3fc7de1 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> @@ -141,7 +141,7 @@ static const struct lpi_pinctrl_variant_data sc7280_lpi_data = {
>         .ngroups = ARRAY_SIZE(sc7280_groups),
>         .functions = sc7280_functions,
>         .nfunctions = ARRAY_SIZE(sc7280_functions),
> -       .is_clk_optional = true,
> +       .is_clk_optional = false,

Just drop it as 'false' is the default.

Otherwise

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
