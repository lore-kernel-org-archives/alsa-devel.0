Return-Path: <SRS0=gYtK=EM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEC4C4742C
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 02:52:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F5A20786
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 02:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OU+mrqHR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/JG8EDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F5A20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C972E84A;
	Fri,  6 Nov 2020 03:51:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C972E84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604631136;
	bh=cRg0gHvIE46jg1WWvVfKiIv9tVJOcGXreaP7UNxvnzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OU+mrqHRIXJuWT/L7zlzdmEXf4ALi4YVd8DeqyPjv7fiMbcNfTVRQO8j/RMLETy5i
	 cR0XgB7xocTUTaSDGPm3+MagEp1B3GxqD+3MtymlY3GRTBHjyL+s3nzJrv0bkHALsL
	 Hx/kZrgTrM2z+aSRbZ9Rnc7CQ8d2tG/osDNJ+MPc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43A42F80232;
	Fri,  6 Nov 2020 03:51:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7DE2F80234; Fri,  6 Nov 2020 03:51:24 +0100 (CET)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6622F80150
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2020 03:51:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6622F80150
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="p/JG8EDr"
Received: by mail-qt1-x841.google.com with SMTP id n63so2738560qte.4
 for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2020 18:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WTOpuxQqUTD7Fs5ED8d6WE6HwICjQ/RXvxFgPZw8ydY=;
 b=p/JG8EDrUjsel8y++UnIKylNNB7pdtkG84acG4fowir5XwgMGq/dJP/aJWrh0XctbL
 ad+bYvmnzOOpMPsliLfFb9w0yxcfyKBiZd9sJOrOuniq56S3j5a3y5sYVEnZ5FO7/Q36
 omn87/g+QkVSEEycolY5jlF6rcNa9thuBFYqBKPPlFXQ/E8nDDqgvvRU97nxZ+1guG7p
 9OetQ7bZNAYVtwv9mHGIHzurr02g9ja+Hw36FbwjvLxyTERVcFRIsiw0a6ueba3flpt8
 nAy9mWVR0o7N/d2XsbQVm9ncI/AmWajjppaC7uve7TaNqJSCsYc2VTGEyLRrTKSjACH9
 z0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WTOpuxQqUTD7Fs5ED8d6WE6HwICjQ/RXvxFgPZw8ydY=;
 b=ljRtRjci4xR5zbR7gwgWyhfgnXA88X2LSO0fl6W1SIkX1sl3DPzwvoiKAWzPSuH5uo
 fH9WjqqGyPeyrGTKcYrhd+9FfP0+bbd8tu28s9jJzAkUiQoMQeClkmoXa7wa8tR+e+u4
 SCHsmtsXXMFEAIbAMmvVzdKDwXfS8h7rZ8PM2K64LqivoVfBLo8gyNQVXEdEPfIDJEZQ
 8LEfacTeKwv8xj+uKAn/E9zQICAqIfGnaYGaSBtm52whvLdUdz/nNYe6WGXF9EWmCKvq
 VMrc/M77FMl5KjuRdO6uXyDl2eZ9f4XvajGZ0oQuOiOI+ldFnxMLugIF/xkLXWWhS1Z5
 6QBg==
X-Gm-Message-State: AOAM531U9DjbyBhBrRkqyw8zi2GpyGqc1c/XK1ayAEk2hw/uY0KsukEP
 3vH4iwOvb7i8SWw0TNt64rOYIk0RUVyn20M9CTs=
X-Google-Smtp-Source: ABdhPJzmaVLfpBM4DF4coroQarUHDYYbWmF3o5VQGr7jzQ39SDG3tzILiBVeORimIM8T60VCYrXH/xjW6RHzzC5xsMs=
X-Received: by 2002:ac8:71c3:: with SMTP id i3mr340558qtp.204.1604631074809;
 Thu, 05 Nov 2020 18:51:14 -0800 (PST)
MIME-Version: 1.0
References: <1604281947-26874-1-git-send-email-shengjiu.wang@nxp.com>
 <1604281947-26874-2-git-send-email-shengjiu.wang@nxp.com>
 <20201105013539.GA16459@Asurada-Nvidia>
In-Reply-To: <20201105013539.GA16459@Asurada-Nvidia>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 6 Nov 2020 10:51:03 +0800
Message-ID: <CAA+D8ANrkgXR+8JGp4fPLvkKJ05EqQyShWTO+xWpPOycPT9Tyw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: fsl_aud2htx: Add aud2htx module driver
To: Nicolin Chen <nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, Nov 5, 2020 at 9:48 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Nov 02, 2020 at 09:52:27AM +0800, Shengjiu Wang wrote:
> > The AUD2HTX is a digital module that provides a bridge between
> > the Audio Subsystem and the HDMI RTX Subsystem. This module
> > includes intermediate storage to queue SDMA transactions prior
> > to being synchronized and passed to the HDMI RTX Subsystem over
> > the Audio Link.
> >
> > The AUD2HTX contains a DMA request routed to the SDMA module.
> > This DMA request is controlled based on the watermark level in
> > the 32-entry sample buffer.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
>
> Despite some small comments inline.
>
> > +static int fsl_aud2htx_dai_probe(struct snd_soc_dai *cpu_dai)
> > +{
> > +     struct fsl_aud2htx *aud2htx = dev_get_drvdata(cpu_dai->dev);
> > +
> > +     /* DMA request when number of entries < WTMK_LOW */
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> > +                        AUD2HTX_CTRE_DT_MASK, 0);
> > +
> > +     /* Disable interrupts*/
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_IRQ_MASK,
> > +                        AUD2HTX_WM_HIGH_IRQ_MASK |
> > +                        AUD2HTX_WM_LOW_IRQ_MASK |
> > +                        AUD2HTX_OVF_MASK,
> > +                        AUD2HTX_WM_HIGH_IRQ_MASK |
> > +                        AUD2HTX_WM_LOW_IRQ_MASK |
> > +                        AUD2HTX_OVF_MASK);
> > +
> > +     /* Configure watermark */
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> > +                        AUD2HTX_CTRE_WL_MASK,
> > +                        AUD2HTX_WTMK_LOW << AUD2HTX_CTRE_WL_SHIFT);
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> > +                        AUD2HTX_CTRE_WH_MASK,
> > +                        AUD2HTX_WTMK_HIGH << AUD2HTX_CTRE_WH_SHIFT);
>
> If there isn't a hard requirement from hardware, feels better to
> combine all the writes to AUD2HTX_CTRL_EXT into one single MMIO.

ok, will update it.

>
> > +static irqreturn_t fsl_aud2htx_isr(int irq, void *dev_id)
> > +{
> > +     return IRQ_HANDLED;
>
> Empty isr? Perhaps can drop the request_irq() at all?

I'd like to keep this for future enhancement, what do you think?

>
> > +static int fsl_aud2htx_probe(struct platform_device *pdev)
> > +{
> > +     struct fsl_aud2htx *aud2htx;
> > +     struct resource *res;
> > +     void __iomem *regs;
> > +     int ret, irq;
> > +
> > +     aud2htx = devm_kzalloc(&pdev->dev, sizeof(*aud2htx), GFP_KERNEL);
> > +     if (!aud2htx)
> > +             return -ENOMEM;
> > +
> > +     aud2htx->pdev = pdev;
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     regs = devm_ioremap_resource(&pdev->dev, res);
> > +     if (IS_ERR(regs)) {
> > +             dev_err(&pdev->dev, "failed ioremap\n");
> > +             return PTR_ERR(regs);
> > +     }
> > +
> > +     aud2htx->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
> > +                                             &fsl_aud2htx_regmap_config);
> > +     if (IS_ERR(aud2htx->regmap)) {
> > +             dev_err(&pdev->dev, "failed to init regmap");
> > +             return PTR_ERR(aud2htx->regmap);
> > +     }
> > +
> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq < 0) {
> > +             dev_err(&pdev->dev, "no irq for node %s\n",
> > +                     dev_name(&pdev->dev));
>
> dev_err() already prints dev_name, so not necessary to print again.

ok, will update it

best regards
wang shengjiu
