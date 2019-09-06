Return-Path: <SRS0=qBPI=XB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A6EC43331
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:47:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B418F206BB
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ETcy4dDc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeUe7NOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B418F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64EE874C;
	Fri,  6 Sep 2019 08:46:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64EE874C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567752441;
	bh=WE/PTtY2UHbZ5M4v9P8yr0E/984PXC7RNU1rnb80R9A=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ETcy4dDcbmnSCj/LX8rOSm6HsI4/tGx9xLR4GjTHvb24IXefyOQZu65gC/gk6nC0v
	 DfSsfo1+bg5dtcww0gCx4wqzoj7WbmBtKr0N8pBud4SFcL8ErEPs47q9QOI4SqEcd6
	 XENkj1ZQaHo7AMRGBiOQS/qSCXlXy51o3sUP/L8E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D20BCF80390;
	Fri,  6 Sep 2019 08:46:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27A0FF80394; Fri,  6 Sep 2019 08:46:29 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07957F80171
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2019 08:46:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07957F80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="SeUe7NOO"
Received: by mail-wr1-x441.google.com with SMTP id 30so5265775wrk.11
 for <alsa-devel@alsa-project.org>; Thu, 05 Sep 2019 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f1veQAzAhBh/8QLIcBHhhy6Oq2ECmt8ium3T+Z509bU=;
 b=SeUe7NOO3XyJdM9wgMxo3VlFHkTcgKkIklKcVLAVhSnoFSbqswSZa06jkCJ0y6W7cO
 ERIUfV/TXKkO2e9cAoNoE8cUQq8ZzrgdGiyhBZR6vg+qCb1dRjn/tpsvrtcOat1iFwxP
 c/xJ8tPPdNnOAE4LHJKpWOa0Gd4AQsJrXM1KsdRpQvtuDsTL4f9DVemQuNIrqtruyMoH
 EfqmdGfe+vPx6+ymXuI1GJ4iEcD5vnfCzzhqaCnBL+xGgRQMzlr9sZ0k3MHXNR/B89Ct
 RqRdjvbZF0JoqjHYOucLg981x1R5RdgkIL3VOUBo6p/fHMDw2ywAoAi1dC6nevH5oDvC
 E5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f1veQAzAhBh/8QLIcBHhhy6Oq2ECmt8ium3T+Z509bU=;
 b=Dkx4ib+0XRE6egbBSN/EI0U7Ss7NXbRytwoKfOBm4CYcqNYDCQgTWFXqi6/eiROIPU
 A1hqHTWiOPjg62KCGO43x0JQ9gpJyr6ZjaZD3uWH1HSzgpEF+fkaRyBtNHXVQ1a0lKer
 QKBOb4ojDCV5K+Pbdk9MTmSU1pb68mHWrMUdXkz2g+K0YGkQKyERvjNfQDSouQk+WcyT
 o2tdD3rZ1ZnY5vBs8Y3ajNMWy7tDK4YeQ8UJHituNgIbWzDcotAHwToDTh/s9UvmxgL3
 210U4jh6coOa1qOxRpSXTSmlGRqNQDcG51hOTRRfLeDncpJVb1fabEOXZqFYvSjJ8GM6
 9hBg==
X-Gm-Message-State: APjAAAX09QrnFB9zZBpQePF3eKriYOwF1+AeewD88QAPbu7Y4SQ1iTrC
 4QLhXS8E+9+rCqqYy6PdH5JoNFlGlm083McNDw4=
X-Google-Smtp-Source: APXvYqzLJ9EmC5C5FvIEJ1CyAUI4KLcua0kk3t5HRvkuQYnAEihajdKHH9lVT8HGznM+fO771PFTOy3b3Gd/R3vurrs=
X-Received: by 2002:a5d:6703:: with SMTP id o3mr5533975wru.335.1567752384937; 
 Thu, 05 Sep 2019 23:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190830200900.19668-1-daniel.baluta@nxp.com>
 <20190906012438.GA17926@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190906012438.GA17926@Asurada-Nvidia.nvidia.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 6 Sep 2019 09:46:12 +0300
Message-ID: <CAEnQRZBTc=beU7CX747RsM7KEsJethfZ0fPv=CkLQ1e3ofHMkA@mail.gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Mihai Serban <mihai.serban@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 Mihai Serban <mihai.serban@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_sai: Fix noise when using EDMA
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

On Fri, Sep 6, 2019 at 4:25 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Fri, Aug 30, 2019 at 11:09:00PM +0300, Daniel Baluta wrote:
> > From: Mihai Serban <mihai.serban@nxp.com>
> >
> > EDMA requires the period size to be multiple of maxburst. Otherwise the
> > remaining bytes are not transferred and thus noise is produced.
> >
> > We can handle this issue by adding a constraint on
> > SNDRV_PCM_HW_PARAM_PERIOD_SIZE to be multiple of tx/rx maxburst value.
> >
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 15 +++++++++++++++
> >  sound/soc/fsl/fsl_sai.h |  1 +
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 728307acab90..fe126029f4e3 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -612,6 +612,16 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
> >                          FSL_SAI_CR3_TRCE_MASK,
> >                          FSL_SAI_CR3_TRCE);
> >
> > +     /*
> > +      * some DMA controllers need period size to be a multiple of
> > +      * tx/rx maxburst
> > +      */
> > +     if (sai->soc_data->use_constraint_period_size)
> > +             snd_pcm_hw_constraint_step(substream->runtime, 0,
> > +                                        SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
> > +                                        tx ? sai->dma_params_tx.maxburst :
> > +                                        sai->dma_params_rx.maxburst);
>
> I feel that PERIOD_SIZE could be used for some other cases than
> being related to maxburst....
>
> >  static const struct of_device_id fsl_sai_ids[] = {
> > diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> > index b89b0ca26053..3a3f6f8e5595 100644
> > --- a/sound/soc/fsl/fsl_sai.h
> > +++ b/sound/soc/fsl/fsl_sai.h
> > @@ -157,6 +157,7 @@
> >
> >  struct fsl_sai_soc_data {
> >       bool use_imx_pcm;
> > +     bool use_constraint_period_size;
>
> ....so maybe the soc specific flag here could be something like
>         bool use_edma;
>
> What do you think?

I think your suggestion is a little bit better than what we have. But what if
in the future another DMA controler (not eDMA) will need the same constraint.

Wouldn't it be confusing?
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
