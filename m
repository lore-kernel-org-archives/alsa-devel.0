Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76483C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 03:44:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1062082E
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 03:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kt++4pwB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLXf0FXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1062082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62B571615;
	Wed, 17 Jun 2020 05:43:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62B571615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592365461;
	bh=pv36RWZ8VIuqdzSvHrqAGawGpvr41YYIsrENp1/P5y8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kt++4pwBoL8bmui6qulgkvGADZPpqcjyLI7YrGQQ9Kd1JU+63CL4x73Mmsif2q1EH
	 pUD6e957bMKbPD6cO0NLAU2+j5JLMjVkWMsa0lwzlPFFEVc5zT2neGx0Vc8gOB+enq
	 WKagiTZ78ninw7bNmbZT0V0R3brHuXKqLY2nR9vM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A38E3F80162;
	Wed, 17 Jun 2020 05:43:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5EDB2F80171; Wed, 17 Jun 2020 05:43:28 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69A99F800EF
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 05:43:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69A99F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="rLXf0FXm"
Received: by mail-qk1-x741.google.com with SMTP id c12so752590qkk.13
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 20:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0vu+NO376NKYI1jWLgdkbjWwFJw4rHiE2cx4A9CRwj8=;
 b=rLXf0FXmhfaJqwRhe7pzmFH+I+5Jzl+4mGdC8v2m0Lm3iaDGlAH3hqj8lfuKZH8obQ
 SRV1JMUu0z5+zc2o19KWm6yO8G1kgZ50kIc+3naYW/anOSrAwoEac5sA2keGAK/W102h
 qxCUwKnNcV5tfpStRlLLA2V49N18kqd6rPVDQ4T7Q6EY7W3p3TqRfdV6NEbeRxb9ROZd
 x7Xw3OyEQ4JiY/LGYSbJ7jRR/86tBZWNItSDIX1v2cnl0fF5hqwrE0zA6Xt9R7jQEbZX
 yaLVuBpMHhd5R9p0xoVsMyZ7+EXwMdJgxtLXQ/FjnTbvPBmyqY12rwTJNOWZaP/UWf9d
 5+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0vu+NO376NKYI1jWLgdkbjWwFJw4rHiE2cx4A9CRwj8=;
 b=LAPTqL+UzPyKVkBUgTu0fg9+mO0x8hRrnL5sZPHFQxZDW2UHA/CVzRMgpDMZyrJX9/
 xf9jQ7gAogACxTFD0PqIyu4PfMpAmWLnegSlpRrB5uTgEs2nwBWii+XE8VM+fi6gnvWe
 SKvJ7/8E99+7/pImyfTQRuxeZIZUnc9rTorPqzWHCRNJBpV33lVDC7yyMPHRLO4N86I+
 o3BQLQsKCsDvgDeGBo5NTPuwH9xfpil3C3/6pQgsaekZmOoKxVIWeb+Dlztz0R16VloG
 PD/MahHLidiKMjP0bpZYLOm94Y74n6JH21Dv6ezjRvTQqKY6v/8pJkBihQ1QFohDBOMx
 xfTA==
X-Gm-Message-State: AOAM5339zYpP6iB3SFhSXrTnt1sg6/W/XftQMYPIRmH0encyFZrm6kuZ
 POpeBsvSVzmuJeBSdkCjoVsFh69eqgZVNgkXe9I=
X-Google-Smtp-Source: ABdhPJzTnuBuNJC6PfYb8KsQOFkrB783WazcWiNJ7FUK4rjhj/lk+ZuGwVKuHA9gkQzAAjPETCxduLPoj1SRbaYHNHc=
X-Received: by 2002:a37:b50:: with SMTP id 77mr23894892qkl.152.1592365402625; 
 Tue, 16 Jun 2020 20:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <1592289761-29118-1-git-send-email-shengjiu.wang@nxp.com>
 <1592289761-29118-2-git-send-email-shengjiu.wang@nxp.com>
 <20200616232810.GA19896@Asurada-Nvidia>
In-Reply-To: <20200616232810.GA19896@Asurada-Nvidia>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 17 Jun 2020 11:43:11 +0800
Message-ID: <CAA+D8AMv0EW+zUbT8bA7H+hWB8t_DQdWR=cWuYhFZA2z3F-twg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_spdif: Add support for imx6sx platform
To: Nicolin Chen <nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
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

On Wed, Jun 17, 2020 at 7:30 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Tue, Jun 16, 2020 at 02:42:41PM +0800, Shengjiu Wang wrote:
> > The one difference on imx6sx platform is that the root clock
> > is shared with ASRC module, so we add a new flags "ind_root_clk"
> > which means the root clock is independent, then we will not
> > do the clk_set_rate and clk_round_rate to avoid impact ASRC
> > module usage.
> >
> > As add a new flags, we include the soc specific data struct.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_spdif.c | 43 +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 39 insertions(+), 4 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> > index 1b2e516f9162..00e06803d32f 100644
> > --- a/sound/soc/fsl/fsl_spdif.c
> > +++ b/sound/soc/fsl/fsl_spdif.c
> > @@ -42,6 +42,17 @@ static u8 srpc_dpll_locked[] = { 0x0, 0x1, 0x2, 0x3, 0x4, 0xa, 0xb };
> >
> >  #define DEFAULT_RXCLK_SRC    1
> >
> > +/**
> > + * struct fsl_spdif_soc_data: soc specific data
> > + *
> > + * @imx: for imx platform
> > + * @ind_root_clk: flag for round clk rate
> > + */
> > +struct fsl_spdif_soc_data {
> > +     bool imx;
> > +     bool ind_root_clk;
>
> "ind" doesn't look very straightforward; maybe "shared_root_clock"?
>
> And for its comments:
>         * @shared_root_clock: flag of sharing a clock source with others;
>         *                     so the driver shouldn't set root clock rate
>
> > +};
> > +
> >  /*
> >   * SPDIF control structure
> >   * Defines channel status, subcode and Q sub
> > @@ -93,6 +104,7 @@ struct fsl_spdif_priv {
> >       struct snd_soc_dai_driver cpu_dai_drv;
> >       struct platform_device *pdev;
> >       struct regmap *regmap;
> > +     const struct fsl_spdif_soc_data *soc;
>
> Looks better if we move it to the top of the list :)
>
> > @@ -421,7 +448,7 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
> >       sysclk_df = spdif_priv->sysclk_df[rate];
> >
> >       /* Don't mess up the clocks from other modules */
> > -     if (clk != STC_TXCLK_SPDIF_ROOT)
> > +     if (clk != STC_TXCLK_SPDIF_ROOT || !spdif_priv->soc->ind_root_clk)
> >               goto clk_set_bypass;
> >
> >       /* The S/PDIF block needs a clock of 64 * fs * txclk_df */
> > @@ -1186,7 +1213,8 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
> >                       continue;
> >
> >               ret = fsl_spdif_txclk_caldiv(spdif_priv, clk, savesub, index,
> > -                                          i == STC_TXCLK_SPDIF_ROOT);
> > +                                          i == STC_TXCLK_SPDIF_ROOT &&
> > +                                          spdif_priv->soc->ind_root_clk);
>
> Having more than one place that checks the condition, we can add:
>
> /* Check if clk is a root clock that does not share clock source with others */
> static inline bool fsl_spdif_can_set_clk_rate(struct fsl_spdif_priv *spdif, int clk)
> {
>         return (clk == STC_TXCLK_SPDIF_ROOT) && !spdif->soc->shared_root_clock;
> }

will update them in v2

best regards
wang shengjiu
