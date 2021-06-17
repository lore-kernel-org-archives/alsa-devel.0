Return-Path: <SRS0=NYZN=LL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2A6C2B9F4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 14:45:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7631613A9
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 14:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7631613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DDCF17A0;
	Thu, 17 Jun 2021 16:44:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DDCF17A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623941141;
	bh=ZzfNRq8VlfTSVxlffgyExpOk1y7AxRbVDBop4Zo+QZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lNQJRYZCSznZLexinB+UlHv9uKfHUCOSCvDWsbXsDvDflBDdcKKu0P3UC9lZ1zYfP
	 8a/G+yCttKOido+DU/miHJtaM9LB17Xrgpe3IAblgM7SnHDDlJEc0dGY1zEdzJNKAI
	 039863X/OjNNeNUDN2VTryfjJtd1rxZq0aKeHXpw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C413F805C1;
	Thu, 17 Jun 2021 16:35:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CE5FF8025A; Thu, 17 Jun 2021 13:51:07 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61146F8016D
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 13:50:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61146F8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="HTT19X0V"
Received: by mail-pg1-x533.google.com with SMTP id e20so4811401pgg.0
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 04:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sKn9UvDVlydbDfhyjcKiR8IQebdYWuPzRo3dE9qFvzU=;
 b=HTT19X0V095oJRTCzBuNJaVN4HZknbDw48KwzexgYxUe8fSxFHwWmx5qCuxOySbqY8
 oIhrj+O7sEtFlIQnJUWc8B3UDDiWZ7L1eX+0I1whFlp2IFctgF1Yqe1T6dpLJVdywUwi
 PnSOnmgj0c1OGJ0xVWQh8sAzW5NzMZoXHcglUWLoaCW+5qtIOnvVlJcA2IUv9VijrNbJ
 +w0wJnCaVH4AG3cNaf10KKxvykGRkz4rzk461fN+Y+f3xL4ZsAqVxFlqDmQ9byYf3XlY
 a3nzvcDFou6GLpDPGfHO9wQEClE2m9vU5ZIbj2FddMNRAanPHC78pShAINAcd0YZzSyG
 BitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sKn9UvDVlydbDfhyjcKiR8IQebdYWuPzRo3dE9qFvzU=;
 b=I1aaxlA1T3tu5SfLf8f4c116yO/rttE3VwyBOPo1mW+7mz0jvamQNbBZQ5UNi/ZLRm
 6AES4mVKnGEzVFuzQ8qg07tm1239VLiA5yB0Bt543s1ZybT/I1HKOILVTv+uBObEIwVc
 QTISsOiHuJjODeqUs51oaC0O29gEz8b56dWZ/CwtIMyXRxKu/PDttiq+Fj5aUnMNG+Cx
 SBkX3EVnToRvJrIw1IioB66qDFRs/x+Br4zjNxvxSckyqEwUW0Dh2VpP7UENeXflAog/
 uJ+BY/neBWtwXlv7l5sH8w1r/owa4t45FRLCTDtjWIGX6uSj9aoTjwBiphdQsLL8XZVm
 lGGg==
X-Gm-Message-State: AOAM531NnprR7hEHAmw4QPtI4X3pDOO9W786CqEK0SoZqJbYon97xGJ/
 t5dh7mvZJtsODxSr81kArekWgYUmd44UkO5Y7g==
X-Google-Smtp-Source: ABdhPJzLsfs3op+S3slb9TqsEE9rDKBjbpT/kYfZDNwghaNqG6qtKFP/8gazWOPOPVAsKMwERdZcGU0aiuCW4mmYCy4=
X-Received: by 2002:a63:f344:: with SMTP id t4mr4676265pgj.314.1623930653336; 
 Thu, 17 Jun 2021 04:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210615130326.2044-1-fengzheng923@gmail.com>
 <20210615132207.GG5149@sirena.org.uk>
 <CAE=m61-kHPeKNvEEc08w8DeUwssGPWNf5UaYojRPNZRJ0v=arw@mail.gmail.com>
 <20210617104828.GA5067@sirena.org.uk>
In-Reply-To: <20210617104828.GA5067@sirena.org.uk>
From: =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Date: Thu, 17 Jun 2021 19:50:42 +0800
Message-ID: <CAE=m618Gtx_RQ4+h=8+TFvbcuSTpNWVcx1bry+8OggL6uDCzfw@mail.gmail.com>
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

Hi=EF=BC=8C

Mark Brown <broonie@kernel.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=8817=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 17, 2021 at 03:42:43PM +0800, =E7=8F=AD=E6=B6=9B wrote:
> > Mark Brown <broonie@kernel.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:22=E5=86=99=E9=81=93=EF=BC=9A
>
> > > > @@ -0,0 +1,408 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * ALSA SoC DMIC Audio Layer
> > > > + *
> > > > + * Copyright 2021 Ban Tao <fengzheng923@gmail.com>
> > > > + *
>
> > > Please make the entire comment a C++ one so things look more
> > > intentional.
>
> > For example;
> > // SPDX-License-Identifier: GPL-2.0-or-later
> > /*
> >  * This driver supports the DMIC in Allwinner's H6 SoCs.
> >  *
> >  * Copyright 2021 Ban Tao <fengzheng923@gmail.com>
> >  *
> >  */
> > is this OK?
>
> No, that's what you have already make the entire thing a C++ comment
> with //s.

I don=E2=80=99t understand. For example, sun4i-codec.c sun4i-i2s.c
sun8i-codec.c and sun4i-spdif.c files are the same as mine.
Which file can I refer to? what should I do......
>
> > > > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > +     base =3D devm_ioremap_resource(&pdev->dev, res);
> > >
> > > devm_platform_ioremap_resource()
> >
> > But I need to get the register base address of DMIC. E.g res->start.
> > host->dma_params_rx.addr =3D res->start + SUN50I_DMIC_DATA;
>
> OK.
