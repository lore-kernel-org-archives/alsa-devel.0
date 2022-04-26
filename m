Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2688C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Apr 2022 09:56:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9BEC21891;
	Tue, 26 Apr 2022 11:56:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9BEC21891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650967012;
	bh=yAglgq0oujbj/DUQSIwBMoO+a6DOS3fE0qRiM2wabbc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aoY9S4CbWoCHlDktfMWooi9VDbcINHuTTeogP91ceSj05A/0zHavZmo3Qxkc+PjPq
	 Q8zmKMX/Ki170ndZ0BNCEtQHQlYkZw/OFkczxhzeTFSqt/V+HAGRh1H+wZSx++DBiN
	 ywv8lAETBI7Jj5vLHv1uKsnQYcvXSAt2CPoqKmDM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 071B4F8014B;
	Tue, 26 Apr 2022 11:56:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4766DF80152; Tue, 26 Apr 2022 11:56:00 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BDAA7F800AE
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 11:55:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDAA7F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Zidjjk27"
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-2f7d7e3b5bfso62694187b3.5
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 02:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=weWPZwTpqiHPHgcVzIIdA7nRDKZOshuGpKa1VF6LHgo=;
 b=Zidjjk277gxvzedd4edYCSb6Cn9K1V3dPeUgbbEb5gLCI8VtvCKz20lBep7DWHtcRQ
 64pJZ8eGC6Q6OP3at/hwyq6ZC82wuELOUdPHx3yLbrMLPYWy3gnKv2HM/+O6/dDwIUgp
 GZc2Y1OoyA47jGPhH2xOV+QqvHguE8F8s7D0CSsTHN8J2VzPWFw2dQVF09lEs2/elM+T
 8y2FFNzKmND94cAR5JpEGVj5911tNu77MIztnM07yFoWADZmH8Dv007sz5BA3dY85iG9
 iH2UqWKuoLVdHr4ugmGiaWErZBjTBujwCDGi9XVP75OAvlAbfqlMBG7dQyByGGAsQqRi
 TD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=weWPZwTpqiHPHgcVzIIdA7nRDKZOshuGpKa1VF6LHgo=;
 b=tGv0/LBr85JfDhITk9538v8220QJr1cZAr0IanVWtNwDY5J6YDr/RmUNCGECSuDuhZ
 zji6y12pZBJN286MUDBMCcPLUsBjxPw9mmgnMdAQekOHNF4OSNt6nbLwLOBsTzzOj03x
 AcWopkfIqP0H/uUwMrKepNb8G80ILzxu+Zi+wo/JR10VqYn0GKA4clWfcAOhq+XfiZT9
 LmsC6N8EqklFY8oSUrxQzXTDnFyRt3kQS+TT/NU7EEbkUsWSTTBKb51vUvc6UNH1BHjz
 SxZHUJNiZN14iglC7rt80mSHW7+kTh/UmAKhcKaNAEyIHcaLNBUULHny6zLhJpXliyyK
 Cx8w==
X-Gm-Message-State: AOAM530DjhBNC0i6AWtgok4yqiy7Z0EFOGya0+sUsTZ2egZwmFpjYzly
 xbXhrbaSczDqas+TMMIfXC0Q3WprpDl13L2YGyc=
X-Google-Smtp-Source: ABdhPJwsCSuWCB3O/ko1vmdn3uUKURlpkvVP2MmwfwdioZMUvlxGbUz6V84fLJ5dZFEpB90VPoxTbMU7pwxUCojYksU=
X-Received: by 2002:a0d:dd16:0:b0:2f4:dc1e:e0d8 with SMTP id
 g22-20020a0ddd16000000b002f4dc1ee0d8mr21532262ywe.413.1650966949989; Tue, 26
 Apr 2022 02:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220426074922.13319-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220426074922.13319-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <5bb82736-50bc-eafd-7d68-df1ed966d572@omp.ru>
In-Reply-To: <5bb82736-50bc-eafd-7d68-df1ed966d572@omp.ru>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 26 Apr 2022 10:55:23 +0100
Message-ID: <CA+V-a8s=7nDHEE=kcdqcyM5SurY9KwteNwnc7PZ4xiqGQFvY=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ASoC: sh: rz-ssi: Propagate error codes returned
 from platform_get_irq_byname()
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel <alsa-devel@alsa-project.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Liam Girdwood <lgirdwood@gmail.com>, Pavel Machek <pavel@denx.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Takashi Iwai <tiwai@suse.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 LKML <linux-kernel@vger.kernel.org>
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

Hi Sergey,

Thank you for the review.

On Tue, Apr 26, 2022 at 10:47 AM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> Hello!
>
> On 4/26/22 10:49 AM, Lad Prabhakar wrote:
>
> > Propagate error codes returned from platform_get_irq_byname() instead of
> > returning -ENODEV. platform_get_irq_byname() may return -EPROBE_DEFER, to
> > handle such cases propagate the error codes.
> >
> > While at it drop the dev_err_probe() messages as platform_get_irq_byname()
> > already does this for us in case of error.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * No change
> > ---
> >  sound/soc/sh/rz-ssi.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
> > index cec458b8c507..d9a684e71ec3 100644
> > --- a/sound/soc/sh/rz-ssi.c
> > +++ b/sound/soc/sh/rz-ssi.c
> > @@ -977,8 +977,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
> >       /* Error Interrupt */
> >       ssi->irq_int = platform_get_irq_byname(pdev, "int_req");
> >       if (ssi->irq_int < 0)
> > -             return dev_err_probe(&pdev->dev, -ENODEV,
> > -                                  "Unable to get SSI int_req IRQ\n");
> > +             return ssi->irq_int;
>
>    Why not:
>
>                 return dev_err_probe(&pdev->dev, ssi->irq_int,
>                                      "Unable to get SSI int_req IRQ\n");
>
That is because platform_get_irq_byname() already does this for us [0]
(also mentioned in the commit message). In case I keep the
dev_err_probe() I'll get two prints for each error.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/platform.c?h=v5.18-rc4#n471

Cheers,
Prabhakar

> [...]
> > @@ -990,8 +989,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
> >               /* Tx and Rx interrupts (pio only) */
> >               ssi->irq_tx = platform_get_irq_byname(pdev, "dma_tx");
> >               if (ssi->irq_tx < 0)
> > -                     return dev_err_probe(&pdev->dev, -ENODEV,
> > -                                          "Unable to get SSI dma_tx IRQ\n");
> > +                     return ssi->irq_tx;
>
>    Same here...
>
> >
> >               ret = devm_request_irq(&pdev->dev, ssi->irq_tx,
> >                                      &rz_ssi_interrupt, 0,
> > @@ -1002,8 +1000,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
> >
> >               ssi->irq_rx = platform_get_irq_byname(pdev, "dma_rx");
> >               if (ssi->irq_rx < 0)
> > -                     return dev_err_probe(&pdev->dev, -ENODEV,
> > -                                          "Unable to get SSI dma_rx IRQ\n");
> > +                     return ssi->irq_rx;
>
>    And here...
>
> [...]
>
> MBR, Sergey
