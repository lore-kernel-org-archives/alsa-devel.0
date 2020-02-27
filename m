Return-Path: <SRS0=k5Qg=4P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E7BC11D3D
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:46:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D115A2469F
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tb/udXyc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrLlidHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D115A2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DAE016BE;
	Thu, 27 Feb 2020 18:45:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DAE016BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582825602;
	bh=s8TP1GcplkMmXYezbkYCb651NfhOYfD9KWoXECFLyxQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tb/udXycR4XUKXJ3q5/ydghvlwYGieVmgzYAlXnmGIZbkw4FdsSaR0P2CpRU5KhRs
	 mIHhxF0nx6QCMv68PhZqp/CAqTjUV28hfvp6HGbIyqWYhoOIHBwSgjmG66EDcHUKRD
	 h2e20TPIYCz65DpG/3npKHH/r7cX1+MkdSE4/v+U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAE9AF8013E;
	Thu, 27 Feb 2020 18:45:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CDC63F80142; Thu, 27 Feb 2020 18:45:48 +0100 (CET)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BCB5F80089
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2020 18:45:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BCB5F80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="WrLlidHp"
Received: by mail-pf1-x444.google.com with SMTP id j9so180843pfa.8
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2020 09:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aavjJ+Z/Os0zHnsfY4LhrQa/kjKKVPycfJnfRrQ9Zao=;
 b=WrLlidHpJQHENIo9YAPAEQekykxM5HD2YXi3IVdH2pDlg6yOsqQeAnBHuInus8IGYC
 T+Llicheka6t83Av1G7fnGQK8N8t/+ARqHcr7lEyinMjtYM47yBrjkl2uEcRsEZ4vjUz
 pAjZPbsFEKwx29NM8eVxoOKBbOhAa5Ss0rhJpdsluzAbqfyGiQnGG/Zp0NAiBrgbAbt0
 jfF0riqJcV8+RHgdQPpeLHStGSeazOIOy4Dlp0oY3js8i23wr6q2uHDBiIWHOaJsg9t8
 1ZOC6VPeEyYaQraK7qW+s5OLWdodWJnu6yrWH8xyJEc1DQGF4Yy9unxmzfeJW8N2YDjq
 /lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aavjJ+Z/Os0zHnsfY4LhrQa/kjKKVPycfJnfRrQ9Zao=;
 b=ZYqal7i4WcANrUV08ZTthlaoCTpgATU2RnAVlJsU0ARQD+sAqVExFaeEfhN0l+xDGe
 BTVjNq4/CLwzuY6nzEhfsZBodNsRPJ7M/+kxAVzGQENyQKXxYQpza3sBkEJGprP/BSxl
 oRp/fQvlwfFSyPJZiXGXLpfzjHlCg5GHyfUaoxBAtZSc6larQYWo41xoMoCitYpCjuuT
 Lr6V7HcjN8KwZ+WwEMU6VUtQBOQG9tvoDk4MWyr3L1c/UTdBO3Unqw4B9b2Y75+6lcfx
 BmlDiP+uVFKowuBeD0IKJY8J2jlcUDfvggT5CsBL6fgB2HjEsLTa/WnPpc/+SOc1HzUl
 J2Pw==
X-Gm-Message-State: APjAAAXSgh40z9Sqbxyj+lEetCUgcgvUEEKuFAi6woIT235lhv/b/Hom
 HTq/fs7vMGEsKw5lfUr23wo=
X-Google-Smtp-Source: APXvYqxLesXxb5FW6sTnMiGiGe5CN/UVKj1bBr36Rl2QBzPtHaPhoQYlUWdpilUa7ohjuvvcuvc2jw==
X-Received: by 2002:a62:7c96:: with SMTP id x144mr114879pfc.7.1582825543344;
 Thu, 27 Feb 2020 09:45:43 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id m16sm7712623pfh.60.2020.02.27.09.45.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 27 Feb 2020 09:45:43 -0800 (PST)
Date: Thu, 27 Feb 2020 09:45:41 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH v3 1/4] ASoC: fsl_asrc: Change asrc_width to asrc_format
Message-ID: <20200227174540.GA17040@Asurada-Nvidia.nvidia.com>
References: <cover.1582770784.git.shengjiu.wang@nxp.com>
 <ffd5ff2fd0e8ad03a97f6a640630cff767d73fa7.1582770784.git.shengjiu.wang@nxp.com>
 <20200227034121.GA20540@Asurada-Nvidia.nvidia.com>
 <CAA+D8AMzqpC35_CR2dCG6a_h4FzvZ6orXkPSYh_1o1d8hv+BMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AMzqpC35_CR2dCG6a_h4FzvZ6orXkPSYh_1o1d8hv+BMg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
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

On Thu, Feb 27, 2020 at 01:10:19PM +0800, Shengjiu Wang wrote:
> On Thu, Feb 27, 2020 at 11:43 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 10:41:55AM +0800, Shengjiu Wang wrote:
> > > asrc_format is more inteligent variable, which is align
> > > with the alsa definition snd_pcm_format_t.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  sound/soc/fsl/fsl_asrc.c     | 23 +++++++++++------------
> > >  sound/soc/fsl/fsl_asrc.h     |  4 ++--
> > >  sound/soc/fsl/fsl_asrc_dma.c |  2 +-
> > >  3 files changed, 14 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> > > index 0dcebc24c312..2b6a1643573c 100644
> > > --- a/sound/soc/fsl/fsl_asrc.c
> > > +++ b/sound/soc/fsl/fsl_asrc.c
> >
> > > @@ -600,11 +599,6 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
> > >
> > >       pair->config = &config;
> > >
> > > -     if (asrc_priv->asrc_width == 16)
> > > -             format = SNDRV_PCM_FORMAT_S16_LE;
> > > -     else
> > > -             format = SNDRV_PCM_FORMAT_S24_LE;
> >
> > It feels better to me that we have format settings in hw_params().
> >
> > Why not let fsl_easrc align with this? Any reason that I'm missing?
> 
> because the asrc_width is not formal,  in the future we can direct

Hmm..that's our DT binding. And I don't feel it is a problem
to be ASoC irrelative.

> input the format from the dts. format involve the info about width.

Is there such any formal ASoC binding? I don't see those PCM
formats under include/dt-bindings/ folder. How are we going
to involve those formats in DT?
