Return-Path: <SRS0=EWQz=PB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D840DC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 08:41:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99BD60F23
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 08:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B99BD60F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D8301686;
	Wed, 13 Oct 2021 10:40:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D8301686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634114509;
	bh=wG687bVeX4Nt6Aguzga1NFsQ6MUIl2Ah3hJie9SPCB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EDIrDxqxllgyOY2cyfbO7BHgHqlvdmFNwKYIfNWK7gsqDIPWJLK3qlxjxu2HmjDxA
	 +/5dpQQC2rOim2xlh1l2QQty3EQXhxkVWjOOHq9nkhIVD9XTUCAtEdFC9BtIr3wPiM
	 ecH1FhT82MByO+yfQFO2g20D9X7CL/A8iKIWlbyU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC2AEF80085;
	Wed, 13 Oct 2021 10:40:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B55E2F80269; Wed, 13 Oct 2021 10:40:56 +0200 (CEST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF328F80085
 for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2021 10:40:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF328F80085
Received: by mail-ua1-f54.google.com with SMTP id e7so2914667ual.11
 for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2021 01:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o21Xh9J32kqeXX2sLP/uoO24jfsRO3XxpHv3HTju++o=;
 b=cqz2oLB0kl3Qb15LSxMvy0tcNhbTzlpxtiLKSq4LyaD7P5mdG8yxmExmflRIIb0IOZ
 XIvy+4sSnXZnsWT7KhJ/xr5+98ISpnIygYQOxGb031t+95HrfZBaUPMqjonwTetd7JsI
 BRmVLqH52QVagZhuI99/RD9+xS+dPQs3jGWl6DhRpbVmi/U3TuTJ3OhouXVKwJVPvnEe
 O8AP245NO/tVTBSBl/jZkKcpfKJxBmlr5MW17uO2jTfef6pGiNErKqQqmM1/E3BaluVV
 7E2ARBil30mzUZAfd29huKxTU7nc6jUshGXlzGyOEcGmbiS1z3wDBVTcOyyNFdpp5L3e
 pnVQ==
X-Gm-Message-State: AOAM530iC474PTbs4DxpfCUKZGlcnCN7c4qg5DhJg6rHVHZzlAC/cdKV
 KlSktGXs9fE8A2xgIDZgpgo7b3SaNaLvPpmTYcE=
X-Google-Smtp-Source: ABdhPJxdOrt/NeqKBbobPgR/QYlFFRT0/HBYQPl2x39gYkEt6ihDnKgmOShnK7VIgbiDKv3BhBEH9IjpXBj5pvbVWW0=
X-Received: by 2002:ab0:58c1:: with SMTP id r1mr27617670uac.89.1634114449054; 
 Wed, 13 Oct 2021 01:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211003030357.32456-1-rdunlap@infradead.org>
 <96c810cb-f7e3-d9ff-9713-7ec007ebb599@microchip.com>
In-Reply-To: <96c810cb-f7e3-d9ff-9713-7ec007ebb599@microchip.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Oct 2021 10:40:37 +0200
Message-ID: <CAMuHMdUyo-sFzo3CA9WwycZFp=pVYLJeJfEWRT48EVhSZGL3rw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: atmel: add COMPILE_TEST for SND_ATMEL_SOC_PDC
To: Codrin Ciubotariu <Codrin.Ciubotariu@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>
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

Hi Codrin,

On Wed, Oct 13, 2021 at 10:15 AM <Codrin.Ciubotariu@microchip.com> wrote:
> On 03.10.2021 06:03, Randy Dunlap wrote:
> > Geert pointed out that since sound/soc has the soc_dummy_driver for
> > NO_DMA platforms, it is possible (desirable) to have drivers that
> > depend on HAS_DMA to alternately depend on COMPILE_TEST.
> >
> > This means that SND_ATMEL_SOC_PDC can depend on HAS_DMA || COMPIE_TEST.
> >
> > Fixes: 6c5c659dfe3f ("ASoC: atmel: ATMEL drivers don't need HAS_DMA")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: alsa-devel@alsa-project.org
> > Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> > ---
> >   sound/soc/atmel/Kconfig |    1 +
> >   1 file changed, 1 insertion(+)
> >
> > --- linux-next-20211001.orig/sound/soc/atmel/Kconfig
> > +++ linux-next-20211001/sound/soc/atmel/Kconfig
> > @@ -11,6 +11,7 @@ if SND_ATMEL_SOC
> >
> >   config SND_ATMEL_SOC_PDC
> >          bool
> > +       depends on HAS_DMA || COMPILE_TEST
>
> SND_ATMEL_SOC_PDC compiles fine without HAS_DMA, so I don't understand
> the need for this...

Does it work without DMA support?
If not, it doesn't make much sense to offer this option to the user, unless
the user is compile-testing.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
