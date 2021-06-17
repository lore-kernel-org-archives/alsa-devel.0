Return-Path: <SRS0=NYZN=LL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF80AC2B9F4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 14:45:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3064461040
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 14:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3064461040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CABDE179C;
	Thu, 17 Jun 2021 16:44:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CABDE179C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623941120;
	bh=+KBOOJCYkxsfJaXdlHh6bjt88qM404LSq3eTyZgU48A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SwRQyJAvO9IGsNtRuYttmIO4U9VA30QnNth44uCRrnjKbxXVCGGNfLCbnRuPtEBZf
	 uYxYRZ4oUZ6V8BpQvcUdFkc3LfX87J7qIMt9tEv6z/qjXsciwrpyc97M4AYAozkBpK
	 CozCUR07YHo+PtfWxR2QRXiqVtgQnkDLrdC2Xf7Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF0C9F805B4;
	Thu, 17 Jun 2021 16:35:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21377F8025A; Thu, 17 Jun 2021 09:43:02 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6E48F8016D
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 09:42:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6E48F8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="DJulBmuY"
Received: by mail-pg1-x52a.google.com with SMTP id w31so4264108pga.6
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dlhQI9LBeuWWY/YA418crEQCoirxo4ehIW0nOzSjBfg=;
 b=DJulBmuYSBO4muKdi/8Vu2KF3vGVxZhvjkz55/4WjZHKA29UUH/SnFs1qfTuoS6Uwz
 vH2+PxKJCLFFFIdmU1z2SV/hlmCdNyhSbogDeVK9badYGnI9ZaMJB1HawmbSEp2n/8Ry
 G5NaXyhPWe1Ngso956j8A7KeVG0zSoeAdLQwAGG4m/0egx5f2SBjzLjrpX8G7WxLdaqC
 3J+TZxXbO+41tuQDFFuEfikFYL2HJl3hOpQa4QqBCbyDyQWsuAcZbyPvs3ExaH4fEfMM
 8N1FWDkTjISZ7ZZXP4v+XzvIUCpY/5Ie/9y99xfD7x5rBb8cAIX1+b4NKIUGCg0DW1kw
 h+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dlhQI9LBeuWWY/YA418crEQCoirxo4ehIW0nOzSjBfg=;
 b=cTBJoeO4kR8Z5YqxKU+/jPejv6ceWkApyEPTZlGE160gtnBofPVAwc/z7gEyrsdC6d
 dbS2LxqhEzjxfe7bgEGyVbBSMWjgVd1BunWKAnlr2p8M6Pka6leBYhVW/9EyWM5wMqgg
 rsRRqi8CYTFJKvpgEPFZw0k0pV0GYGKtwMi+jjZ+WfkEWJd/7fxSnEW1nLZnJUj9e8Dw
 J+4qG+/u6a+cIl3YAgLklEhP6LCrK48K+P3+ee+ELmimy4fJkdJ8NGPpxN+85ZcUtkMz
 P9P8Jj+j2EjYZZvzEL+apMc8pzBL4WtpyJTiEn6V0YmhoVuVgVvdikqHJKw4ihBtJ7Ae
 Q9/w==
X-Gm-Message-State: AOAM531iPC6B8ygI/OFPLUP2jbFPORasO/EeDM5glMHlOdpXsMWQv2C5
 ZlXb0S05OUDbD7tIVvJRD3fIFvjZMkCoQE+kiw==
X-Google-Smtp-Source: ABdhPJzFltPZJW+CLlqPO3ZDNVm8FYuMgndfCGkTH+NIbNsyzO3D2zxHKHJ6V972BF7TsmpoZxJ49mG+/NuxsZWcpdU=
X-Received: by 2002:a63:dc4e:: with SMTP id f14mr3735400pgj.378.1623915775013; 
 Thu, 17 Jun 2021 00:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210615130326.2044-1-fengzheng923@gmail.com>
 <20210615132207.GG5149@sirena.org.uk>
In-Reply-To: <20210615132207.GG5149@sirena.org.uk>
From: =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Date: Thu, 17 Jun 2021 15:42:43 +0800
Message-ID: <CAE=m61-kHPeKNvEEc08w8DeUwssGPWNf5UaYojRPNZRJ0v=arw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 17 Jun 2021 16:34:45 +0200
Cc: alsa-devel@alsa-project.org, krzk@kernel.org,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 tiwai@suse.com, jernej.skrabec@gmail.com, lgirdwood@gmail.com, wens@csie.org,
 mripard@kernel.org, p.zabel@pengutronix.de, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
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

Hi,

Mark Brown <broonie@kernel.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 15, 2021 at 09:03:26PM +0800, Ban Tao wrote:
>
> Other than a few small things this looks good:
>
> > +M:   Ban Tao <fengzheng923@gmail.com>
> > +L:   alsa-devel@alsa-project.org (moderated for non-subscribers)
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.=
yaml
> > +F:   sound/soc/sunxi/sun50i-dmic.c
>
> Not the binding document?
>
> > @@ -0,0 +1,408 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * ALSA SoC DMIC Audio Layer
> > + *
> > + * Copyright 2021 Ban Tao <fengzheng923@gmail.com>
> > + *
>
> Please make the entire comment a C++ one so things look more
> intentional.
>
For example;
// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * This driver supports the DMIC in Allwinner's H6 SoCs.
 *
 * Copyright 2021 Ban Tao <fengzheng923@gmail.com>
 *
 */
is this OK?


> > +static void sun50i_snd_rxctrl_enable(struct snd_pcm_substream *substre=
am,
> > +                                 struct sun50i_dmic_dev *host, bool en=
able)
> > +{
> > +     if (enable) {
>
> > +     } else {
>
> > +static int sun50i_dmic_trigger(struct snd_pcm_substream *substream, in=
t cmd,
> > +                            struct snd_soc_dai *dai)
> > +{
> > +     int ret =3D 0;
> > +     struct sun50i_dmic_dev *host =3D snd_soc_dai_get_drvdata(dai);
> > +
> > +     if (substream->stream !=3D SNDRV_PCM_STREAM_CAPTURE)
> > +             return -EINVAL;
> > +
> > +     switch (cmd) {
> > +     case SNDRV_PCM_TRIGGER_START:
> > +     case SNDRV_PCM_TRIGGER_RESUME:
> > +     case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +             sun50i_snd_rxctrl_enable(substream, host, true);
> > +             break;
> > +
> > +     case SNDRV_PCM_TRIGGER_STOP:
> > +     case SNDRV_PCM_TRIGGER_SUSPEND:
> > +     case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> > +             sun50i_snd_rxctrl_enable(substream, host, false);
> > +             break;
>
> This is the only caller of _rxctrl_enable() and _rxctrl_enable() shares
> no code between the two cases - just inline _rxctrl_enable() here, it's
> clearer what's going on.
>
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     base =3D devm_ioremap_resource(&pdev->dev, res);
>
> devm_platform_ioremap_resource()

But I need to get the register base address of DMIC. E.g res->start.
host->dma_params_rx.addr =3D res->start + SUN50I_DMIC_DATA;
