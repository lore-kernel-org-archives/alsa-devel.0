Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CB2C433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Nov 2022 05:45:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AF791681;
	Tue,  1 Nov 2022 06:45:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AF791681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667281557;
	bh=tEQ8UqAnofX6No+fvFCnf28bw3Cuy9QS3LK2mn21Gk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ncAQOyPzsVOS7eFRO+/MUMaopP0m8IDOR4WS2KmD2pU1gWjRdnGW+3bZXPvKzYoON
	 gMd7VPFrUfCWnUXLQyRbNN9jQ5xPXKGMcN1E0ITNPLU+YGAmdk7ZZHbU5dIlR4HsFK
	 0HbaZ9LK+nXaT/tO1oNWQyw7KROGLetiooGlVkEE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFE61F8028D;
	Tue,  1 Nov 2022 06:45:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7DD0F80423; Tue,  1 Nov 2022 06:45:04 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5416BF800F3
 for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2022 06:44:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5416BF800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="HAIa9cwc"
Received: by mail-lj1-x233.google.com with SMTP id b8so19511706ljf.0
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2022 22:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f1fAuCRQsLNGwK/8BajgP7KDtZDIWOaW2Geb1akrfaI=;
 b=HAIa9cwcM+T3W3gWmie5gOU2sMid3j3+I3RlHixnP+cZDe+E6MkgOsffZQrWcICz7T
 cMadMi6jF7IMyMK+nUy1L9Te4WubSP/qg7nf7pgkR44HxiIxOx/sAiQcQG7MjJfRj5FO
 LejXCyMyfTsGL38BV+3HTJGBX5qt62XIQ3+rxDsDnrvNg/vB95o1x7+Zfy2P8M5Aor/Q
 qDX2L19FNoC55fTAsKlrsWaq4luZr4MkD/TSDPnKFQx6VgoTYOqEVP+Bemc3ZchZq3aQ
 SnSHP52OakvdV9R6N97jIpelILc4GpUZjD1jaAL/tF6VjAcBGxw30+RnHy/JB64o6srk
 C/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f1fAuCRQsLNGwK/8BajgP7KDtZDIWOaW2Geb1akrfaI=;
 b=sBKJP6S/XCo+CTJU8RGaPUlLsRT1aYwtTwpscOUBrcklinaO44PoFEvaycmWi+nNo9
 NhueRbOSjLfxLuuLN0bOIe04UBH2UPVdpi7YeZeHLSM6YMhL+ZJvyKGnhD1+FttnUsK5
 dePHiv6QbrcB7ON1WkwnvGHQl5l4yoz3EpfMba1gy1jR/RRYfapF2y0vOHS4bBLlvbCK
 JzmBRdRCojqiLFDqIeiLcJvsv1S54CMkoX4b3Yekfnp1wyQsAa+ndAEgnStXnjrIgoTL
 DYV5Bh+ykmXhxNGNJPGk9N91J4SlzidAhHQ+ut90tHPQQ312BEydcurFGuolR3HrvZGg
 +HPg==
X-Gm-Message-State: ACrzQf3I/CsRScPQpBK23eoKRyBNvDcTInWxJZbr8/gmkzXF9QmldNUX
 gP8CR9DBgNqBXFVabogrXHs5NG2iMYgvo5hUNjg=
X-Google-Smtp-Source: AMsMyM4AgJhVCDcxwCMn6l+76L77o81zW5OKs/V3dJ59vZ8cHH/ZsqraJ5ZcNEMAmIyWAuyO3wujs1/qBeRN3K6/90k=
X-Received: by 2002:a05:651c:c8a:b0:26f:a90a:fd82 with SMTP id
 bz10-20020a05651c0c8a00b0026fa90afd82mr419435ljb.248.1667281496096; Mon, 31
 Oct 2022 22:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221028082750.991822-1-chancel.liu@nxp.com>
 <20221028082750.991822-3-chancel.liu@nxp.com>
In-Reply-To: <20221028082750.991822-3-chancel.liu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 1 Nov 2022 13:44:44 +0800
Message-ID: <CAA+D8AMt0VB4j8wYHyZfk3dnBhwwBvQeHe7bGh1FPPDP6ug8Wg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: fsl_micfil: Add support for i.MX93 platform
To: Chancel Liu <chancel.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, tiwai@suse.com,
 nicoleotsuka@gmail.com, broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 festevam@gmail.com
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

On Fri, Oct 28, 2022 at 4:28 PM Chancel Liu <chancel.liu@nxp.com> wrote:

> Add compatible string and specific soc data to support MICFIL on i.MX93
> platform.
>
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
wang shengjiu

> ---
>  sound/soc/fsl/fsl_micfil.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> index eeaa75fb9196..b8a9504441df 100644
> --- a/sound/soc/fsl/fsl_micfil.c
> +++ b/sound/soc/fsl/fsl_micfil.c
> @@ -82,9 +82,18 @@ static struct fsl_micfil_soc_data fsl_micfil_imx8mp = {
>         .formats = SNDRV_PCM_FMTBIT_S32_LE,
>  };
>
> +static struct fsl_micfil_soc_data fsl_micfil_imx93 = {
> +       .imx = true,
> +       .fifos = 8,
> +       .fifo_depth = 32,
> +       .dataline =  0xf,
> +       .formats = SNDRV_PCM_FMTBIT_S32_LE,
> +};
> +
>  static const struct of_device_id fsl_micfil_dt_ids[] = {
>         { .compatible = "fsl,imx8mm-micfil", .data = &fsl_micfil_imx8mm },
>         { .compatible = "fsl,imx8mp-micfil", .data = &fsl_micfil_imx8mp },
> +       { .compatible = "fsl,imx93-micfil", .data = &fsl_micfil_imx93 },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_micfil_dt_ids);
> --
> 2.25.1
>
>
