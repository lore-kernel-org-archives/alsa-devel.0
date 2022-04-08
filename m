Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDC9C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Apr 2022 05:18:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4EA0189C;
	Fri,  8 Apr 2022 07:18:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4EA0189C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649395135;
	bh=ZjpqT49N0fU3X1xZh5KWv/7LHNSjm5xMFS+JUWYnPd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z+Fr6La++27IaZgkljot2lCIFpregfyRDQqOUw3WGkLwc0uXrtSVk0TitGCEuPiD3
	 DjGSrHiLvY5OX/5oO2W3bfB5U0v2ZVi2c8aRJpWDh6jwW989Iu+DH+SRLLDvk1QOG2
	 ULMTobwp0MIYF4c22Q9lULXcexAOJZ9NYxxQW7cM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D143F8012A;
	Fri,  8 Apr 2022 07:18:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA7FEF8014E; Fri,  8 Apr 2022 07:18:02 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A877F80116
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2022 07:17:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A877F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ceQsFQeY"
Received: by mail-qk1-x729.google.com with SMTP id b189so3991090qkf.11
 for <alsa-devel@alsa-project.org>; Thu, 07 Apr 2022 22:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CE3JazpFKuLiIWaBknPLagEB0/QW8KqlA/RdOmMR33U=;
 b=ceQsFQeYXScHm/wenFKx30TOZ9i2GwEkR8Ixr4pIlFl7pHnIMZsBMM5oRXO0OusPb0
 4fZJuV/nQeFb7Tuh0Yz76gyJrpShLD5P2ZV3BIevrpLIqBFMYvctSaWKg/aKaQTpIP3c
 cAZikTwEk1IpejCOcOdeIAveKxUqhiqHnamfQQFzQeqgCI2XeFBWacq1xvWgap6hl9GU
 XhAuJsNut56DBNothlnXlupq+o8f6uIr19vgb9JBhQxSpAm1zIhC1rgqwcWC+rGLWVAi
 B6qQXKK5pokFZK8dmsSzVHGGHOCIZfhef0+24MlJj/sn+odzAL2Q+AENO14ss7olXgW3
 hEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CE3JazpFKuLiIWaBknPLagEB0/QW8KqlA/RdOmMR33U=;
 b=OAerRGEC7jmxTMbp8mnmwsECmZk9qHIq3r/619IX8PDquNlJgT/s29JaOas1iiKAj/
 i6UC0boh1PidWu0MEtmF7szIlrocxAYCE2H8jVMe6V8iJYzzySvDVD2QTefbpLymOxIg
 QoT6UZEpDwwo6eJsSmbkP5vmRRvveaaJGSCrpwf52LAjwqdOGHML+KYLRh2WqauHbt7F
 mAgUKzcQ1z4HH//zq/WpadsNXStd1CwhCfrrmZPLtgsmuqorQChbJ05DOcqIkxPDoCgB
 5c+7IEdNAORI6hbludLyneyOae9WuTUvTZvUyKjNkkkMqvXS944IqSSUXxJsiuNYNWRY
 FfxQ==
X-Gm-Message-State: AOAM530s5Jw4/pL1tlJA11WdMBCVga32p+l+TisH6/B63IM7coSW6Zl2
 m5jjRuOc2s01+h36qbv/hGGDRDtOpczVIB5RxDo=
X-Google-Smtp-Source: ABdhPJyxy3CCkkGUImPWu0WPp//stW91NFyfgAr9wRhfLoxyKKRisEShNvm9mipHQzEdswXKhy00VJt3JmthFiQn5wM=
X-Received: by 2002:a05:620a:4592:b0:67d:8ed9:8c37 with SMTP id
 bp18-20020a05620a459200b0067d8ed98c37mr11848318qkb.150.1649395072683; Thu, 07
 Apr 2022 22:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220407084936.223075-1-s.hauer@pengutronix.de>
 <20220407084936.223075-15-s.hauer@pengutronix.de>
In-Reply-To: <20220407084936.223075-15-s.hauer@pengutronix.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 8 Apr 2022 13:17:41 +0800
Message-ID: <CAA+D8AOk3zEMaG0oHNmWZNzd33yao0SkZVnNx1qw2TbqTAQRKQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/21] ASoC: fsl_micfil: Drop get_pdm_clk()
To: Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
 Vinod Koul <vkoul@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>
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

On Thu, Apr 7, 2022 at 4:49 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:

> get_pdm_clk() calculates the PDM clock based on the quality setting,
> but really the PDM clock is independent of the quality, it's always
> rate * 4 * micfil->osr. Just drop the function and do the calculation
> in the caller.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
wang shengjiu

> ---
>
> Notes:
>     Changes since v3:
>     - Don't use uninitialized and no longer present struct fsl_micfil::osr
>
>  sound/soc/fsl/fsl_micfil.c | 38 +-------------------------------------
>  1 file changed, 1 insertion(+), 37 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> index a35c1c580dbc1..3ddc988b4fe65 100644
> --- a/sound/soc/fsl/fsl_micfil.c
> +++ b/sound/soc/fsl/fsl_micfil.c
> @@ -110,42 +110,6 @@ static const struct snd_kcontrol_new
> fsl_micfil_snd_controls[] = {
>                      snd_soc_get_enum_double, snd_soc_put_enum_double),
>  };
>
> -static inline int get_pdm_clk(struct fsl_micfil *micfil,
> -                             unsigned int rate)
> -{
> -       u32 ctrl2_reg;
> -       int qsel;
> -       int bclk;
> -       int osr = MICFIL_OSR_DEFAULT;
> -
> -       regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);
> -       qsel = FIELD_GET(MICFIL_CTRL2_QSEL, ctrl2_reg);
> -
> -       switch (qsel) {
> -       case MICFIL_QSEL_HIGH_QUALITY:
> -               bclk = rate * 8 * osr / 2; /* kfactor = 0.5 */
> -               break;
> -       case MICFIL_QSEL_MEDIUM_QUALITY:
> -       case MICFIL_QSEL_VLOW0_QUALITY:
> -               bclk = rate * 4 * osr * 1; /* kfactor = 1 */
> -               break;
> -       case MICFIL_QSEL_LOW_QUALITY:
> -       case MICFIL_QSEL_VLOW1_QUALITY:
> -               bclk = rate * 2 * osr * 2; /* kfactor = 2 */
> -               break;
> -       case MICFIL_QSEL_VLOW2_QUALITY:
> -               bclk = rate * osr * 4; /* kfactor = 4 */
> -               break;
> -       default:
> -               dev_err(&micfil->pdev->dev,
> -                       "Please make sure you select a valid quality.\n");
> -               bclk = -1;
> -               break;
> -       }
> -
> -       return bclk;
> -}
> -
>  static inline int get_clk_div(struct fsl_micfil *micfil,
>                               unsigned int rate)
>  {
> @@ -154,7 +118,7 @@ static inline int get_clk_div(struct fsl_micfil
> *micfil,
>
>         mclk_rate = clk_get_rate(micfil->mclk);
>
> -       clk_div = mclk_rate / (get_pdm_clk(micfil, rate) * 2);
> +       clk_div = mclk_rate / (rate * MICFIL_OSR_DEFAULT * 8);
>
>         return clk_div;
>  }
> --
> 2.30.2
>
>
