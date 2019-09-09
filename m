Return-Path: <SRS0=MTqT=XE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC664C4740A
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Sep 2019 19:34:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663F021A4A
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Sep 2019 19:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="buV/XAh3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNgoAJZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663F021A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A54FD165E;
	Mon,  9 Sep 2019 21:33:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A54FD165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568057643;
	bh=21PSJr8Kk1kaege01Y04Mnu1S+l64yL+GdOelpds+fg=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=buV/XAh3fBZFmYhsMIvBnqWFMNVJMQeh0aad1u9YbjkRQ6VTIXZWtz8NWg/dopgpm
	 6rGXmyz2+B8YAwy0CVJtEkQytNRFIpGRSwBXwojvtfUifFCQZp9D6lkp7mzzvtAeGz
	 vSeFxaGPLC4wDYCJeyffeNFe9fG2MkCohw42IRV4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C343F80323;
	Mon,  9 Sep 2019 21:33:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE203F804CF; Mon,  9 Sep 2019 21:33:10 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DE5DF800A9
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2019 21:33:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DE5DF800A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="SNgoAJZV"
Received: by mail-pf1-x444.google.com with SMTP id q5so9822556pfg.13
 for <alsa-devel@alsa-project.org>; Mon, 09 Sep 2019 12:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RaRE1Iu5KUHw2kF5I9xN2ziSWnzUpRlWSz3BZK7PqtY=;
 b=SNgoAJZV+5ID24jcq/ogL56EPLG4XLHTtbcwvdtCs9cUwEwB2vLUrcHV4GJlssFvXQ
 Md/WdrXDCljdGL5we81h69jFBMqoPNiL8xqYd0364AOhk8+o+QbJWMEx5hbwlU84qjFg
 Se/5NSBh8EzJau8pPX4eQCSWUrg2iGs2/Dz0I0v6WCqFN1MT0i2DwRay31CUK4cRQeW7
 WaDsUaXSWQBsJGlzFuoSOEa978uMLZtLAfv0aP2IlV4mANsWdhVHMaXESBnmAoEINP/T
 Z10c1D1HtdFkDYDvEy/N0cqnZrWc+ENOwCwUtbqIUNO7/DZP5nD+2/aqg5+kDjUtlgnJ
 wJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RaRE1Iu5KUHw2kF5I9xN2ziSWnzUpRlWSz3BZK7PqtY=;
 b=jhwP4v8Vmi5vwWovAdDcO1w6Xdb1/42uvHeLCcgdbIs/MsnFbVjMOCTc4TMD0f945h
 GkbS9TCyuOHRuo6FEhcOjMEK6A/FdtX04TsEP6aPb5OXRFCsvAFAgPFLhpsJlrTm+W91
 LeMdhiEvl/WYpijxTF046EM7QcsxB4ZhPilWSQoBnWzcMgfvLoTzBSfbzSZ/N4G9QVLU
 P4lCFUJxc/KdlnOx53nAo0PnA8FEC7/r6MQ7ow3FwQIUNL9DnbFLv952F6EG6/KbKt78
 5bJdMpotSGNSVjgvIrokFoLdNA8ipujdf0aDQZ7vICYJ83bu4VtfL/pfIzNfCdydKyrS
 jpuA==
X-Gm-Message-State: APjAAAVdv1uu9ECm/Y7qQvZ2EnU4FKaO0LzTlDb3ZYMev4R4CsLDVEv2
 o2BL54mo/cyzl7pXZ+ldPaA=
X-Google-Smtp-Source: APXvYqzuJVmL1KvgW96Px+WaNpFc/h8svQlg6lkb9PFH4vxlAq1B2IJsKu8U1pC/pdAjqH18ms2EnA==
X-Received: by 2002:a65:63c4:: with SMTP id n4mr7060143pgv.44.1568057585214;
 Mon, 09 Sep 2019 12:33:05 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id w11sm19308266pfd.116.2019.09.09.12.33.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 09 Sep 2019 12:33:05 -0700 (PDT)
Date: Mon, 9 Sep 2019 12:32:38 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Message-ID: <20190909193238.GA10344@Asurada-Nvidia.nvidia.com>
References: <20190830200900.19668-1-daniel.baluta@nxp.com>
 <20190906012438.GA17926@Asurada-Nvidia.nvidia.com>
 <CAEnQRZBTc=beU7CX747RsM7KEsJethfZ0fPv=CkLQ1e3ofHMkA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEnQRZBTc=beU7CX747RsM7KEsJethfZ0fPv=CkLQ1e3ofHMkA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

On Fri, Sep 06, 2019 at 09:46:12AM +0300, Daniel Baluta wrote:
> On Fri, Sep 6, 2019 at 4:25 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Fri, Aug 30, 2019 at 11:09:00PM +0300, Daniel Baluta wrote:
> > > From: Mihai Serban <mihai.serban@nxp.com>
> > >
> > > EDMA requires the period size to be multiple of maxburst. Otherwise the
> > > remaining bytes are not transferred and thus noise is produced.
> > >
> > > We can handle this issue by adding a constraint on
> > > SNDRV_PCM_HW_PARAM_PERIOD_SIZE to be multiple of tx/rx maxburst value.
> > >
> > > Cc: NXP Linux Team <linux-imx@nxp.com>
> > > Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > ---
> > >  sound/soc/fsl/fsl_sai.c | 15 +++++++++++++++
> > >  sound/soc/fsl/fsl_sai.h |  1 +
> > >  2 files changed, 16 insertions(+)
> > >
> > > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > > index 728307acab90..fe126029f4e3 100644
> > > --- a/sound/soc/fsl/fsl_sai.c
> > > +++ b/sound/soc/fsl/fsl_sai.c
> > > @@ -612,6 +612,16 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
> > >                          FSL_SAI_CR3_TRCE_MASK,
> > >                          FSL_SAI_CR3_TRCE);
> > >
> > > +     /*
> > > +      * some DMA controllers need period size to be a multiple of
> > > +      * tx/rx maxburst
> > > +      */
> > > +     if (sai->soc_data->use_constraint_period_size)
> > > +             snd_pcm_hw_constraint_step(substream->runtime, 0,:
> > > +                                        SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
> > > +                                        tx ? sai->dma_params_tx.maxburst :
> > > +                                        sai->dma_params_rx.maxburst);
> >
> > I feel that PERIOD_SIZE could be used for some other cases than
> > being related to maxburst....
> >
> > >  static const struct of_device_id fsl_sai_ids[] = {
> > > diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> > > index b89b0ca26053..3a3f6f8e5595 100644
> > > --- a/sound/soc/fsl/fsl_sai.h
> > > +++ b/sound/soc/fsl/fsl_sai.h
> > > @@ -157,6 +157,7 @@
> > >
> > >  struct fsl_sai_soc_data {
> > >       bool use_imx_pcm;
> > > +     bool use_constraint_period_size;
> >
> > ....so maybe the soc specific flag here could be something like
> >         bool use_edma;
> >
> > What do you think?
> 
> I think your suggestion is a little bit better than what we have. But what if

The better part of using "edma" word, I felt, is to match this
"soc" word in the structure name.

> in the future another DMA controler (not eDMA) will need the same constraint.

That sounds like a valid point to me, I don't feel it'd happen
that often though. I'd be okay if you insist to keep yours :)
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
