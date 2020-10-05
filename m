Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF89C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:16:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CB320848
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lDBKxs8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CB320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98D0A17B1;
	Mon,  5 Oct 2020 15:15:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98D0A17B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601903785;
	bh=ZauFq9zhckSK3LJ4PEUSLzJCiuuL0d2fGgX0LCp1uBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lDBKxs8Jn51ZmOOkep81hVa9/2Wct5XiH/RDgsDvnmf8cwFt5EUyu88pbHzgQTZMb
	 hwsYeDhhwo4/P09i73nrejIdodCHdL0Q87ogQHBlVPi1kJZovFzJcmiUcxpU3Mbxg5
	 g64+AuMmEf52t6QUm4siTqlOb90eYzTwnEp9Lek4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2BE3FF80245;
	Mon,  5 Oct 2020 15:15:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFBC9F8025A; Mon,  5 Oct 2020 15:15:33 +0200 (CEST)
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34E08F800C9
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 15:15:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34E08F800C9
Received: by mail-lj1-f196.google.com with SMTP id n25so7369824ljj.4
 for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2020 06:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7cBoMJtsS2QIM7l/tvd/09+d4HrK6HDbi11UZa2qXqw=;
 b=J5NkhP+t7JXqWThCKb6CNiWEj47IdPhxHySIzaHuJyVBXT0LakZxsvLSYvERNwjyBk
 QixU9cNWon5i3EsLxOUiY9gS8XhzFMADG3DV151iVGOOJekuQ68Jso2/RE2JNMNGJS6j
 gxDKYWe/Sg3nC8G1VhzMVoG+HI8sTITBMYG3TfRX6qU0oXBnwBjyHRD0ArzmmezlcWsK
 1BBhu9zpT1ewwIyrrfHvsXrG+DVZEdZmQ9tj7V0D0tj1IxFfsEw3dsxpE/AkrB7cCcd3
 /G4ih9qxG1CVkKSdHICfaoq1uH+2UIvu/7mR9qI7mjbdB/4rHWzJgrlQMApgNY0wz3Ih
 ec7Q==
X-Gm-Message-State: AOAM5331v5Nm8N2FYlQAmfRJtVmkyT//l62jcZConqAv02NRmwSa2BAF
 4YvSlMSlVB4CdcvPg/qWrCBk6zXiFFZZTw==
X-Google-Smtp-Source: ABdhPJwbxMc7erzlQgquiPJDlfkL9Mq6b6F14D9HQUKgaLL7Ll2h3WBEPj6F+BzT7UYXU0VwAusTYA==
X-Received: by 2002:a2e:b4da:: with SMTP id r26mr4825385ljm.68.1601903721884; 
 Mon, 05 Oct 2020 06:15:21 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com.
 [209.85.167.51])
 by smtp.gmail.com with ESMTPSA id z12sm2584098ljc.17.2020.10.05.06.15.21
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 06:15:21 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id u8so10821461lff.1
 for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2020 06:15:21 -0700 (PDT)
X-Received: by 2002:a05:6512:370b:: with SMTP id
 z11mr5248254lfr.571.1601903720884; 
 Mon, 05 Oct 2020 06:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-21-samuel@sholland.org>
 <20201005120101.igzzwosnq6bzbua6@gilmour.lan>
In-Reply-To: <20201005120101.igzzwosnq6bzbua6@gilmour.lan>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 5 Oct 2020 21:15:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v67hsAfBJVjuhCQ-_ihnP3XRPeMEVik5j1ViCTmgt_JDWg@mail.gmail.com>
Message-ID: <CAGb2v67hsAfBJVjuhCQ-_ihnP3XRPeMEVik5j1ViCTmgt_JDWg@mail.gmail.com>
Subject: Re: [PATCH 20/25] ASoC: sun8i-codec: Protect the clock rate while
 streams are open
To: Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Cc: Ondrej Jirman <megous@megous.com>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Samuel Holland <samuel@sholland.org>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Mon, Oct 5, 2020 at 8:01 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Wed, Sep 30, 2020 at 09:11:43PM -0500, Samuel Holland wrote:
> > The codec's clock input is shared among all AIFs, and shared with other
> > audio-related hardware in the SoC, including I2S and SPDIF controllers.
> > To ensure sample rates selected by userspace or by codec2codec DAI links
> > are maintained, the clock rate must be protected while it is in use.
> >
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> >  sound/soc/sunxi/sun8i-codec.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> > index 501af64d43a0..86065bee7cd3 100644
> > --- a/sound/soc/sunxi/sun8i-codec.c
> > +++ b/sound/soc/sunxi/sun8i-codec.c
> > @@ -416,27 +416,32 @@ static int sun8i_codec_get_lrck_div_order(unsigned int slots,
> >       unsigned int div = slots * slot_width;
> >
> >       if (div < 16 || div > 256)
> >               return -EINVAL;
> >
> >       return order_base_2(div);
> >  }
> >
> > +static unsigned int sun8i_codec_get_sysclk_rate(unsigned int sample_rate)
> > +{
> > +     return sample_rate % 4000 ? 22579200 : 24576000;
> > +}
> > +
> >  static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
> >                                struct snd_pcm_hw_params *params,
> >                                struct snd_soc_dai *dai)
> >  {
> >       struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
> >       struct sun8i_codec_aif *aif = &scodec->aifs[dai->id];
> >       unsigned int sample_rate = params_rate(params);
> >       unsigned int slots = aif->slots ?: params_channels(params);
> >       unsigned int slot_width = aif->slot_width ?: params_width(params);
> > -     unsigned int sysclk_rate = clk_get_rate(scodec->clk_module);
> > -     int lrck_div_order, word_size;
> > +     unsigned int sysclk_rate = sun8i_codec_get_sysclk_rate(sample_rate);
> > +     int lrck_div_order, ret, word_size;
> >       u8 bclk_div;
> >
> >       /* word size */
> >       switch (params_width(params)) {
> >       case 8:
> >               word_size = 0x0;
> >               break;
> >       case 16:
> > @@ -466,17 +471,30 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
> >                          (lrck_div_order - 4) << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
> >
> >       /* BCLK divider (SYSCLK/BCLK ratio) */
> >       bclk_div = sun8i_codec_get_bclk_div(sysclk_rate, lrck_div_order, sample_rate);
> >       regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> >                          SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
> >                          bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
> >
> > -     if (!aif->open_streams) {
> > +     /* SYSCLK rate */
> > +     if (aif->open_streams) {
> > +             ret = clk_set_rate(scodec->clk_module, sysclk_rate);
> > +             if (ret < 0)
> > +                     return ret;
> > +     } else {
> > +             ret = clk_set_rate_exclusive(scodec->clk_module, sysclk_rate);
>
> It's not really clear to me why we wouldn't want to always protect the
> clock rate here?

I believe the intention is to allow a window, i.e. when no audio
blocks are running,
when it is possible to switch between sample rate families?

ChenYu

> > +             if (ret == -EBUSY)
> > +                     dev_err(dai->dev, "%s: clock is busy! Sample rate %u Hz "
> > +                             "conflicts with other audio streams.\n",
>
> This string creates a checkpatch warning.
>
> Maxime
