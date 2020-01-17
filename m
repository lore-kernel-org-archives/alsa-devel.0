Return-Path: <SRS0=jvLf=3G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EE7C33CB1
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:12:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4C82073A
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uAUyqn63";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK/A5QUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4C82073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D8DB17CB;
	Fri, 17 Jan 2020 08:11:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D8DB17CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579245137;
	bh=2mleZjr8G/S5mrcNX+Z0Tb9A6FuZ079qqzdqXAIwVQ8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uAUyqn63WdZsfk+YFwLOQiKiC6VlFBaErAkSwWWRVTFdG16WDaFIETGnZKzUvw01S
	 IhJ49vLO1RJB+QBevBbWrNETz9gwhYz3tsDowAhEwfXTobF+FDZzOCbzpw5JD7iG+s
	 G7PsI3kFnEyT6zMT7Bsvm+XIES4ulZ2yhBXOM0hs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8E2DF8014B;
	Fri, 17 Jan 2020 08:11:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25136F801EB; Fri, 17 Jan 2020 08:11:24 +0100 (CET)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2F80F800AA
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2020 08:11:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2F80F800AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="lK/A5QUc"
Received: by mail-qk1-x742.google.com with SMTP id a203so21805785qkc.3
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 23:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dD+bqe0OboIvDe7Tfhggx1v6hI7fKblqWVn9MXd+wok=;
 b=lK/A5QUcLvbmKiyXEH4Kgl3BRQ0Bkz311hk3/Hmc5ukQy/WYQLXsiyxcpola18hAcv
 tWWhk96wVTGiHmv7M8lX2JVfMkU72C9/VsKywzEfMgtIXPixPNRB5tYrwmJNd/m9PKx2
 t3sC3KkpG4fU79UK3gnN+BJ3miybwpjHv0mbl2Yt8rWbLcxOocN8RqumOk9xx5NPYW/n
 vSumxTygoymB2HvT6vaA11GglQlXbKc4WLF5LxpkxUeUk6tyjM50Wa5S1bORS2kknIsm
 1zwitC4hg7oRXqvj9fao+OsaExHr9o78IDI+hEl90ND2xDWUbFC+2lBpQdRjvWOpPxyh
 X9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dD+bqe0OboIvDe7Tfhggx1v6hI7fKblqWVn9MXd+wok=;
 b=dwFmZhR5jqiqVW4pMrQ502raQrSehePFmLZI1Amc8S0kLJTOgscgpMSOGG1E2UPpUB
 u4BSyd1OH4p9u+4heDYmTl8J1lcM5bQL0LT3QII72RwH0X+hn9YJaA1HM0yfOGNOMc1J
 pY+WPkp2Vh0lmD+NYGVYZTMb/v6JBC8Gri9uClFsBrfT68Nga2wocJ3r5o9JASfy5PEw
 /EOWjynkGG5qNVci1/V8qGIuvhP9V42/uInmDx/uTQW5u0MNZVFTbglJz7jhyRhfyt//
 Vv9lxCsiuGbbMaelGREXARR379IWOSfr8SxmVWKvuWq0HR7iaEAFP/jIz6I99FDY9uPU
 hi/Q==
X-Gm-Message-State: APjAAAU9hVc3I1YsrFUd6r8kBiutjJfp9btiiU6WiEeDGOtjbYgE8Qcq
 hKhHjq/cvu2iPGQ9Qs9tSmL/i0wAaarjpjl2DyY=
X-Google-Smtp-Source: APXvYqyjRZTGLo6wmcBob/iiFfwd3I+O6iRUPciXoph4+LN6FFWL7ri4y46ZvGr8nD5GWauJEepPSlWLvsegq97lPm4=
X-Received: by 2002:a05:620a:166a:: with SMTP id
 d10mr36014901qko.37.1579245075683; 
 Thu, 16 Jan 2020 23:11:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1569493933.git.shengjiu.wang@nxp.com>
 <d728f65194e9978cbec4132b522d4fed420d704a.1569493933.git.shengjiu.wang@nxp.com>
 <CANcMJZBy=yH+4YgZWwphiE-PO6d4hzhFK3XFtpN677ZAv_N4WQ@mail.gmail.com>
 <CANcMJZCuU_-Xii=YT5Rp5DAyxboptJCrpp51jForuYUpeMuhmQ@mail.gmail.com>
In-Reply-To: <CANcMJZCuU_-Xii=YT5Rp5DAyxboptJCrpp51jForuYUpeMuhmQ@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 17 Jan 2020 15:11:04 +0800
Message-ID: <CAA+D8AP39bo6EsHvWhVXvAYAho_xMnWmePPAK6dBsOh5wsz48Q@mail.gmail.com>
To: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 lars@metafoo.de, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH V6 3/4] ASoC: pcm_dmaengine: Extract
	snd_dmaengine_pcm_refine_runtime_hwparams
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

Hi

On Thu, Jan 16, 2020 at 1:56 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Jan 8, 2020 at 8:58 PM John Stultz <john.stultz@linaro.org> wrote:
> > On Thu, Sep 26, 2019 at 6:50 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> > >
> > > When set the runtime hardware parameters, we may need to query
> > > the capability of DMA to complete the parameters.
> > >
> > > This patch is to Extract this operation from
> > > dmaengine_pcm_set_runtime_hwparams function to a separate function
> > > snd_dmaengine_pcm_refine_runtime_hwparams, that other components
> > > which need this feature can call this function.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
> >
> > As a heads up, this patch seems to be causing a regression on the HiKey board.
> >
> > On boot up I'm seeing:
> > [   17.721424] hi6210_i2s f7118000.i2s: ASoC: can't open component
> > f7118000.i2s: -6
> >
> > And HDMI audio isn't working. With this patch reverted, audio works again.
> >
> >
> > > diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> > > index 89a05926ac73..5749a8a49784 100644
> > > --- a/sound/core/pcm_dmaengine.c
> > > +++ b/sound/core/pcm_dmaengine.c
> > > @@ -369,4 +369,87 @@ int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream)
> > ...
> > > +       ret = dma_get_slave_caps(chan, &dma_caps);
> > > +       if (ret == 0) {
> > > +               if (dma_caps.cmd_pause && dma_caps.cmd_resume)
> > > +                       hw->info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
> > > +               if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
> > > +                       hw->info |= SNDRV_PCM_INFO_BATCH;
> > > +
> > > +               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > > +                       addr_widths = dma_caps.dst_addr_widths;
> > > +               else
> > > +                       addr_widths = dma_caps.src_addr_widths;
> > > +       }
> >
> > It seems a failing ret from dma_get_slave_caps() here is being returned...
> >
> > > +
> > > +       /*
> > > +        * If SND_DMAENGINE_PCM_DAI_FLAG_PACK is set keep
> > > +        * hw.formats set to 0, meaning no restrictions are in place.
> > > +        * In this case it's the responsibility of the DAI driver to
> > > +        * provide the supported format information.
> > > +        */
> > > +       if (!(dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK))
> > > +               /*
> > > +                * Prepare formats mask for valid/allowed sample types. If the
> > > +                * dma does not have support for the given physical word size,
> > > +                * it needs to be masked out so user space can not use the
> > > +                * format which produces corrupted audio.
> > > +                * In case the dma driver does not implement the slave_caps the
> > > +                * default assumption is that it supports 1, 2 and 4 bytes
> > > +                * widths.
> > > +                */
> > > +               for (i = SNDRV_PCM_FORMAT_FIRST; i <= SNDRV_PCM_FORMAT_LAST; i++) {
> > > +                       int bits = snd_pcm_format_physical_width(i);
> > > +
> > > +                       /*
> > > +                        * Enable only samples with DMA supported physical
> > > +                        * widths
> > > +                        */
> > > +                       switch (bits) {
> > > +                       case 8:
> > > +                       case 16:
> > > +                       case 24:
> > > +                       case 32:
> > > +                       case 64:
> > > +                               if (addr_widths & (1 << (bits / 8)))
> > > +                                       hw->formats |= pcm_format_to_bits(i);
> > > +                               break;
> > > +                       default:
> > > +                               /* Unsupported types */
> > > +                               break;
> > > +                       }
> > > +               }
> > > +
> > > +       return ret;
> >
> > ... down here.
> >
> > Where as in the old code...
> >
> > > diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> > > index 748f5f641002..b9f147eaf7c4 100644
> > > --- a/sound/soc/soc-generic-dmaengine-pcm.c
> > > +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> >
> > > @@ -145,56 +140,12 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
> > >         if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
> > >                 hw.info |= SNDRV_PCM_INFO_BATCH;
> > >
> > > -       ret = dma_get_slave_caps(chan, &dma_caps);
> > > -       if (ret == 0) {
> > > -               if (dma_caps.cmd_pause && dma_caps.cmd_resume)
> > > -                       hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
> > > -               if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
> > > -                       hw.info |= SNDRV_PCM_INFO_BATCH;
> > > -
> > > -               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > > -                       addr_widths = dma_caps.dst_addr_widths;
> > > -               else
> > > -                       addr_widths = dma_caps.src_addr_widths;
> > > -       }
> >
> > ...the ret from dma_get_slave_caps()  checked above, but is not
> > actually returned.
> >
> > Suggestions on how to sort this out?
>
> Just wanted to check in on this, as I'm still seeing this regression with -rc6.
>
Compare with the old code. it seems that we shouldn't check the return value.

Could you help to test below changes?

--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -138,12 +138,10 @@ dmaengine_pcm_set_runtime_hwparams(struct
snd_soc_component *component,
        if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
                hw.info |= SNDRV_PCM_INFO_BATCH;

-       ret = snd_dmaengine_pcm_refine_runtime_hwparams(substream,
+       snd_dmaengine_pcm_refine_runtime_hwparams(substream,
                                                        dma_data,
                                                        &hw,
                                                        chan);
-       if (ret)
-               return ret;

        return snd_soc_set_runtime_hwparams(substream, &hw);
 }

Best regards
Shengjiu Wang
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
