Return-Path: <SRS0=cpFx=IC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D591EC433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 20:06:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5794C64F78
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 20:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5794C64F78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E921717DD;
	Thu,  4 Mar 2021 21:05:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E921717DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614888363;
	bh=RUOa+jhAmK+h73T8EOU9DsvhCI2E8Dn8FH/Ia3vJc3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cm4ELpYcEuUzc8xyGfrLQpKwzbeqUsS+eL8E223ZnV8u+qvINMsR8RPXZjOGZ1c3x
	 Cs6cIqlcCUVA/oLXg3Qaq0UEjF70WPfIsGDg6ayxAQupuwouYSZcNfaCbPDyR1hN5F
	 oxfglYEfKSK5HOLStBvaN8UP5XUyKqqVQohPD8HA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F887F8025B;
	Thu,  4 Mar 2021 21:05:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10FEDF80269; Thu,  4 Mar 2021 21:05:11 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CEE9F80227
 for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2021 21:05:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CEE9F80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Z/ZCNH1i"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AFFC64F6F
 for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2021 20:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614888300;
 bh=RUOa+jhAmK+h73T8EOU9DsvhCI2E8Dn8FH/Ia3vJc3g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Z/ZCNH1ifsYXMOqxSS+vwP879iLQBcDXyn1H/7QusIM5zsOkA7artXq5whqVPK460
 7A8gdRsO3HwpoqhfpDCn9iGRqzvTMilw5fXHzT0b3HmP24fJAfw30dabM/sqJQvBs1
 fFLMfhAu/Y34199XaYjzJcW8aJAwpR2Br+UMtU0KVQC0ZEQFbZXvMaUivSNKE0uO2p
 VjkgHAjNRqucjOwH4H1+d5MljrZ1OLodWXPUpx7JFxjcmivEpct/YbbN5rw83bDZPQ
 gJSXGku2c6Yn+AWwWafPqIIrHgnsrKILLqyJIqjZShQRaHDng7AjPyJpHk7RJOku0+
 WT8qKoRn+iwKg==
Received: by mail-ed1-f54.google.com with SMTP id w9so20425240edt.13
 for <alsa-devel@alsa-project.org>; Thu, 04 Mar 2021 12:05:00 -0800 (PST)
X-Gm-Message-State: AOAM530CCnR4mMc0HicMUiKTgDbvNt2hxBebxefHPK0iUlsNiKS8K2mO
 PQttr8AqzkJl3Ghmga7RP9keQQOJg2DQD1vW2w==
X-Google-Smtp-Source: ABdhPJyT+WJus7T3jwrxrdTRd/Zm7drWY1Nq415cI9il3xyb1hXROafInBX/zusYrRdtrHQ0uWkFNttElXzFgzzJpBM=
X-Received: by 2002:aa7:d3d8:: with SMTP id o24mr6306044edr.165.1614888299086; 
 Thu, 04 Mar 2021 12:04:59 -0800 (PST)
MIME-Version: 1.0
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-8-git-send-email-shengjiu.wang@nxp.com>
 <20210210221704.GA2894134@robh.at.kernel.org>
 <CAA+D8ANOv91jr4381Acz1B2mZ6=Mx2J_2CMTGXmPKztv7bMjPA@mail.gmail.com>
In-Reply-To: <CAA+D8ANOv91jr4381Acz1B2mZ6=Mx2J_2CMTGXmPKztv7bMjPA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 4 Mar 2021 14:04:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK1uc82hfdE4yj0ye-D6vygiqWkDVW96NOb-8kEFVqHMg@mail.gmail.com>
Message-ID: <CAL_JsqK1uc82hfdE4yj0ye-D6vygiqWkDVW96NOb-8kEFVqHMg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: imx-rpmsg: Add binding doc for
 rpmsg machine driver
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Thu, Feb 18, 2021 at 1:23 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
>
> On Thu, Feb 11, 2021 at 6:18 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Feb 07, 2021 at 06:23:55PM +0800, Shengjiu Wang wrote:
> > > Imx-rpmsg is a new added machine driver for supporting audio on Cortex-M
> > > core. The Cortex-M core will control the audio interface, DMA and audio
> > > codec, setup the pipeline, the audio driver on Cortex-A core side is just
> > > to communitcate with M core, it is a virtual sound card and don't touch
> > > the hardware.
> >
> > I don't understand why there are 2 nodes for this other than you happen
> > to want to split this into 2 Linux drivers. It's 1 h/w thing.
>
> This one is for the sound card machine driver.  Another one is
> for the sound card cpu dai driver. so there are 2 nodes.

You are explaining this to me in terms of drivers. Explain it in terms
of h/w blocks.

Rob
