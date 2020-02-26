Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B96C4BA06
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 01:52:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D8D20732
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 01:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oosenGZ+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tb0I8cSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D8D20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76CC9843;
	Wed, 26 Feb 2020 02:51:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76CC9843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582681968;
	bh=0RkgcIdkgW9xcYseWfFI6b5iHUW176WUY9TbhwFhtgE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oosenGZ+5RwtKfSzEaddf66WRGqtdflYWCxk7/+Csltmw+ZBRXRllY+wLLEn/RGJU
	 Y/eVy2B165SAugS7lw2wgmmCCPba3KMh+kZuo0EEZqZmAGiDfNJHW7nVRE4prMrj92
	 0N8v+dXE/UH9qStzOI8xJVHo9LymlU3uN49YxTzU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6E03F8013E;
	Wed, 26 Feb 2020 02:51:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3536F800AD; Wed, 26 Feb 2020 02:51:55 +0100 (CET)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 011D6F800AD
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 02:51:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 011D6F800AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="tb0I8cSF"
Received: by mail-qk1-x744.google.com with SMTP id b7so1182426qkl.7
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2020 17:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ExNh/gghsj1ImBILJ0ozb3ysT/hRkbhT4G0voLUZVgI=;
 b=tb0I8cSFTYgT7uR05Z3XcyQJudBEyylDCJtGYxlyf+qKYaSVvQWf55BjyB0khyCpLk
 URIaKz8zV1v01cmlqTYofRQsyBn8Q5Xt2rQEalI+Bp/hZVGA+FiZ+yRld1QP6kbZoWGJ
 7Gj0IK6HUXHNGltU2GzHzrFP3clFdNNN+0OktaNn9k/nST5HQ3mzbSEIY+czvohawaQD
 MAhSbkhjjugNTm+rbJ245lRRzWZKczZJpSiFeufw6NQb6WrEVegjDueb6bBFi4UeBGyu
 c6Jc6g0+n6samzd3DBCYRm9UKYyRa0j4nQ79StvG/C232fibx7lajHhp71iMwm8podbN
 axzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ExNh/gghsj1ImBILJ0ozb3ysT/hRkbhT4G0voLUZVgI=;
 b=RWglALVFJgrJbsA9z9rwqBXf/Ymfj5SVYaotsf8uGPVYiRKev5aTXWzA7BXfU9WT5O
 HKHknsiDOa8wtsJbJvqyI1nyROyDXVmZ+TpIQCWbgwrXWREZKr0bxTN+zmv1H0WFUq+p
 OCR1HZq0A+RJ8W06k+XeAV6ixAven9iK/qnPyqbKUCm3m43dDejZ15pO+qzKU+ipJ1It
 23syyhtA3Jb5I0go7w2bzWiZ7v7UhMaIUBbvZOQcdAehlJOfFl/8ecbAF79Lgn1tWEqE
 BkUKUNNT2ZuvSo/Dx8p7H74FLIBQ71fTouXbW0LZSUCwuAJdOf2jTcgMevlioV4ABiQJ
 PS4A==
X-Gm-Message-State: APjAAAXWQhtALPdFmXQjfgc9rK2mdlZUKCunbYk70+ZZWOJCuhmYDNz1
 NIai8kA9AMPcMZNl5l7b829TBJO0K6np/miiny8=
X-Google-Smtp-Source: APXvYqyynmPK9+Rdbdj6+s+AmVwrzFwMwUtQnyhXObjLlWE28j9mHJIWKxFk9yjPuy5ceKsGuAuF/TUUtksL5KcdvEY=
X-Received: by 2002:a37:5c9:: with SMTP id 192mr2480838qkf.103.1582681910840; 
 Tue, 25 Feb 2020 17:51:50 -0800 (PST)
MIME-Version: 1.0
References: <VE1PR04MB6479BCA376502F6F1251602BE3EC0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20200225080350.GA11332@Asurada>
In-Reply-To: <20200225080350.GA11332@Asurada>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 26 Feb 2020 09:51:39 +0800
Message-ID: <CAA+D8AMFzDs8uXiR-N8harRVmhC+3i8p9HdO2CgxOCX8WVfXAw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and
 platform drivers
To: Nicolin Chen <nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Feb 25, 2020 at 4:05 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Feb 24, 2020 at 08:53:25AM +0000, S.j. Wang wrote:
> > Hi
> >
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > ---
> > > >  sound/soc/fsl/Kconfig           |   10 +
> > > >  sound/soc/fsl/Makefile          |    2 +
> > > >  sound/soc/fsl/fsl_asrc_common.h |    1 +
> > > >  sound/soc/fsl/fsl_easrc.c       | 2265 +++++++++++++++++++++++++++++++
> > > >  sound/soc/fsl/fsl_easrc.h       |  668 +++++++++
> > > >  sound/soc/fsl/fsl_easrc_dma.c   |  440 ++++++
> > >
> > > I see a 90% similarity between fsl_asrc_dma and fsl_easrc_dma files.
> > > Would it be possible reuse the existing code? Could share structures from
> > > my point of view, just like it reuses "enum asrc_pair_index", I know
> > > differentiating "pair" and "context" is a big point here though.
> > >
> > > A possible quick solution for that, off the top of my head, could be:
> > >
> > > 1) in fsl_asrc_common.h
> > >
> > >         struct fsl_asrc {
> > >                 ....
> > >         };
> > >
> > >         struct fsl_asrc_pair {
> > >                 ....
> > >         };
> > >
> > > 2) in fsl_easrc.h
> > >
> > >         /* Renaming shared structures */
> > >         #define fsl_easrc fsl_asrc
> > >         #define fsl_easrc_context fsl_asrc_pair
> > >
> > > May be a good idea to see if others have some opinion too.
> > >
> >
> > We need to modify the fsl_asrc and fsl_asrc_pair, let them
> > To be used by both driver,  also we need to put the specific
> > Definition for each module to same struct, right?
>
> Yea. A merged structure if that doesn't look that bad. I see most
> of the fields in struct fsl_asrc are being reused by in fsl_easrc.
>
> > >
> > > > +static const struct regmap_config fsl_easrc_regmap_config = {
> > > > +     .readable_reg = fsl_easrc_readable_reg,
> > > > +     .volatile_reg = fsl_easrc_volatile_reg,
> > > > +     .writeable_reg = fsl_easrc_writeable_reg,
> > >
> > > Can we use regmap_range and regmap_access_table?
> > >
> >
> > Can the regmap_range support discontinuous registers?  The
> > reg_stride = 4.
>
> I think it does. Giving an example here:
> https://github.com/torvalds/linux/blob/master/drivers/mfd/da9063-i2c.c

The register in this i2c driver are continuous,  from 0x00, 0x01, 0x02...

But our case is 0x00, 0x04, 0x08, does it work?

best regards
wang shengjiu
