Return-Path: <SRS0=hypa=BU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13862C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 08:54:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A80F20729
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 08:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EDIb7yU+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7Aa9uvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A80F20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17F0915F9;
	Mon, 10 Aug 2020 10:53:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17F0915F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597049687;
	bh=P5205B7DSBVpJ83irqAkSCzMf3U7XJUMwrsQq4Zoy0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EDIb7yU+1QdzdwzxWq5NgH4BaCsxvwPFmmc1yNZws9kJSWZLxdGR/HTOJUCsd5NI6
	 GeDdxFzPjGsKMxSZHfdVbw6J4PkduB3M4GMAiwQ+6DUf6MxBYZkswvvde9ojOD1bjn
	 4/hTtaYwz7VtaitPjcRxRF81CAx0A/d23p8BYV4g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97281F801DB;
	Mon, 10 Aug 2020 10:53:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7DDC3F800BC; Mon, 10 Aug 2020 10:53:55 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6926BF800BC
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2020 10:53:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6926BF800BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="d7Aa9uvk"
Received: by mail-qk1-x744.google.com with SMTP id n129so1975618qkd.6
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2020 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hn/uvI5guaY3D0G4/sdlh6Gx/KpGc+PN8jIJlWv4gfw=;
 b=d7Aa9uvkgM7oBz+js2KgV6ryeTcBKg1+nuyabNAVpCSEqUIVRt494wY2baViHTGqKZ
 aF8nGJPx0RtjOgE/N1sdXrZ5LC0r/EHlwHUFetfeuk2Shc5Vgs2rX7/rFOfAJ9fOSvZX
 c03EyDruLop4NtSphCrDRGpVngIJMJJhzgRS8dseZLs8U/scj0te95vbIW8mYJqoro1t
 cIgFamiIKdggQQ8iXVxxwWkmWuXVpJkxyQRerU5lir3AWhL1OVYlRUkI5PFHFweMQssu
 f5lmFSUmVMWE08JFuNHHPBbwf+uMCMnNuki5SkOm8ov4A5AFAwy2zcaornwwpbm+zdOD
 5hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hn/uvI5guaY3D0G4/sdlh6Gx/KpGc+PN8jIJlWv4gfw=;
 b=Z9tnzXooq4Use3bM8+JNkqnrPiikmmDz48/4GWxTJpGlF+qORuNDDCfhMDRvqPosVX
 7D4bTLb8zhkDbO8Emn2BuJDJ5zlMLE7w9UjWBHAIn/oF0MqZtTILqpIg4Ze16MVIZi5y
 qb4Xu6HkL8H36VbomigMXgo1CpF/2mHYkq8GcZqVG2Jrx1JOR/7X3d9gshgQZNJarBQk
 JPIbn4aVCXobktYe8np77JWxl8W8PmFa4faH2oOzbX1jKnJbBNTb8CvYWKMuFGoCNBKb
 w/SmEmzxqXB/ivR9xYb3LtPK6CmdR3nYfrA+doUct9Cdw3UVPgCGTrQ59+2bkf6TERm/
 Bq6g==
X-Gm-Message-State: AOAM531AGTkNfilI4Nu77f+JVxaqNtUtEfLGmUqQgjATQ4pB8LUbtxuS
 8Y766lE3m4QbJY8QMtBlna9Wx34hxS4TWrJLK7Q=
X-Google-Smtp-Source: ABdhPJw4PLTjbhjwDy6EiKaJ7HTrl8YRVLWi1NAyqs9jnrxv1KPWBcnGXX4x7q7HcmegO6cIZyeDvkpZWdqQjLRd+WU=
X-Received: by 2002:a37:e92:: with SMTP id 140mr24720492qko.121.1597049622701; 
 Mon, 10 Aug 2020 01:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <1596791682-4311-1-git-send-email-shengjiu.wang@nxp.com>
 <20200810080018.GA13408@Asurada-Nvidia>
In-Reply-To: <20200810080018.GA13408@Asurada-Nvidia>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 10 Aug 2020 16:53:31 +0800
Message-ID: <CAA+D8AP6thymUXN_OTGMxz6Xun0c8Ep0s1-LKj6b0odoBQ0K=g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add -EPROBE_DEFER check for regmap init
To: Nicolin Chen <nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
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

On Mon, Aug 10, 2020 at 4:02 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Fri, Aug 07, 2020 at 05:14:42PM +0800, Shengjiu Wang wrote:
> > Regmap initialization may return -EPROBE_DEFER for clock
> > may not be ready, so check -EPROBE_DEFER error type before
> > start another Regmap initialization.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index a22562f2df47..eb933fe9b6d1 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -927,7 +927,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
> >                       "bus", base, &fsl_sai_regmap_config);
> >
> >       /* Compatible with old DTB cases */
> > -     if (IS_ERR(sai->regmap))
> > +     if (IS_ERR(sai->regmap) && PTR_ERR(sai->regmap) != -EPROBE_DEFER)
> >               sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
> >                               "sai", base, &fsl_sai_regmap_config);
> >       if (IS_ERR(sai->regmap)) {
>
> In that case, might need a !EPROBE_DEFER check for this
> fallback devm_regmap_init_mmio_clk at "sai" clock too?

No, I think it is ok for this fallback to return directly with
EPROBE_DEFER.

best regards
wang shengjiu
