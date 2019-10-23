Return-Path: <SRS0=bexm=YQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25757CA9EB7
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 13:18:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AA22173B
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 13:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="a0meGu0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AA22173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D76B515E0;
	Wed, 23 Oct 2019 15:17:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D76B515E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571836728;
	bh=Aue7LnRjOINpvZtlr6mPipz2DAMz4pkO4mBIMEuQMwY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a0meGu0C6XmFEJFo/5rAOwLjNWMPUsVwkSuknMD9c2Po90SwAZleRBRoAuoMTiTDx
	 byDtSmbgMAp0lEUNNAswQClXz76C2/rsElQVHVQ/a70jsv+iiwSr9mWL+qZUq1MEot
	 wj+gzAbIUud0Q06EdIhGxfIQSA25ZistyY3j012Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 639ADF802DF;
	Wed, 23 Oct 2019 15:17:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BAA3DF80368; Wed, 23 Oct 2019 15:17:56 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 968F0F802DF
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 15:17:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 968F0F802DF
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Macf4-1hqxi63NYA-00cByi for <alsa-devel@alsa-project.org>; Wed, 23 Oct
 2019 15:17:53 +0200
Received: by mail-qk1-f177.google.com with SMTP id u22so19658428qkk.11
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 06:17:52 -0700 (PDT)
X-Gm-Message-State: APjAAAVAQVksdrLSxLAT72O6nCZKjPx2ZUky26MTjtkQLG+QVzHbNWp5
 r/s9aeNwE9ICjVe1K0R3MNhnOyO5fvRxfMC1T8w=
X-Google-Smtp-Source: APXvYqwuwF999+RxRIbSV5NNX+xHenNtGFCAqCA+7Cahtx0tw1C0BafJPH8NNbUYS7dpsAsfv3lWqVq7b2MktsSH9qA=
X-Received: by 2002:a37:9442:: with SMTP id w63mr7981201qkd.138.1571836671589; 
 Wed, 23 Oct 2019 06:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de> <20191023121458.GB11048@pi3>
In-Reply-To: <20191023121458.GB11048@pi3>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 23 Oct 2019 15:17:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ktdA12vpi6zrTXs7-03efk2Ke_0_mQ9X40MLNcZnEqA@mail.gmail.com>
Message-ID: <CAK8P3a3ktdA12vpi6zrTXs7-03efk2Ke_0_mQ9X40MLNcZnEqA@mail.gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Provags-ID: V03:K1:esgP1am+15Wq7dis1xv+FKaIktg+t/ugaSH2D4kTuYXMK3PZwXR
 l74xTgPE2aITln/6dzN95RI250n+XnPbHyqtiDX3G4rsWctNASkC1cCneccQk6nA/D5E1dD
 4SiZD9DUsXKp6taC9jWQrkPpCgX+kX+tTwRx2y+ok3+TWKsuZWa8WE62fwRDJROm44Y6GFs
 O6T4J85yNqrroPiw2KZIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V0+FzBVafRE=:Hm6qfhf8MJBgq1YsPKRVw/
 spX0PD/rsny5Inr4rPF3jWWusaVWAmqrDsi7CBtJhn4vdyuslTBuGiWdnQkvhSERakJHGzyIZ
 oqe3ZrrCN8iKwXrQJ+30dHYKCXbOqDvcWB8W7yNefeNblFWhjIOKjLaF5jxiC/s3zMBU3VHmQ
 jEFEHJcec3hnImzZYYdJoXcIuvb4OGLX+GflSLa1+tVzIeQavwTDW2/Clpae7Gc5von9loGd3
 oEtlq3VRmg3T+p25TigErgI/iP7b5mW/3c+H1jjfyZ6Brq0Ts2wX6+AS2KfnsR5JSYxLlR9mf
 AIrTa5JWqXEqfOGo/rFgjdIcLN3fge+4XJF+9bgM4FZHVc97u3+hPtwjiLy034GHJ4UiJIsq9
 iPGLoebEmkDxOOIecBKTGBKDDLKuHlKHkR+sImV6nXvyM8qImZ7P0ChV/TUhzTSRoF0Y9mG+E
 MJbUy6juwW4axWhMGsPysQ4dGCr01DKP91m5ZQMuceKXK0GTL5wkb4zeF+dPaHO0M1JINtbvX
 mB3Ne6zrcLWrVZq+y8YMHBXMjVIjtngJP6TQOOyoSirvUi/VCBDDVhGbxXVWMF8H+jgrh3t2T
 nTLQoHQwZitScpQCTdlxYt8JbKRKO+EqId+2xBGl5bHKY7KhhhQJFy8RUVUmYNJnLx5iARnDf
 pVLeZlo/kYFI91D6fAx1asF9dpuDlRLdys1qggDdGVouKWexUw0cnLLeNYcYtkVZs6k+AZBzu
 BgviFWVlFkF0m7urAcCNB/okss0GgwKdLHkqW7PiTxTmcpVhoPUY2c0mAbOJrlndFKiM5SdaY
 OA2lUc/Jc0411vTBRCKFdtfraLje9SWNKQgmtC917KPM6EdNK66B0skfinGxG/chsdj/gmz3R
 1Sd9u+tZpu5bWPC5s45Q==
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-samsung-soc@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Kukjin Kim <kgene@kernel.org>,
 =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
 linux-serial@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Linux PWM List <linux-pwm@vger.kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Jiri Slaby <jslaby@suse.com>,
 Mark Brown <broonie@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sangbeom Kim <sbkim73@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-spi <linux-spi@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>,
 Olof Johansson <olof@lixom.net>
Subject: Re: [alsa-devel] [PATCH 11/36] ARM: s5pv210: split from plat-samsung
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

On Wed, Oct 23, 2019 at 2:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:29:55PM +0200, Arnd Bergmann wrote:
> > These can be build completely independently, so split
> > the two Kconfig symbols.
> >       config DEBUG_S3C_UART0
> > -             depends on PLAT_SAMSUNG || ARCH_EXYNOS
> > +             depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>
> How are you going to select DEBUG_S5PV210_UART now?

I don't see a problem here, the patch should not change the behavior at all.

The whole entry now looks like:

        config DEBUG_S3C_UART0
                depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
                select DEBUG_EXYNOS_UART if ARCH_EXYNOS
                select DEBUG_S3C24XX_UART if ARCH_S3C24XX
                select DEBUG_S3C64XX_UART if ARCH_S3C64XX
                select DEBUG_S5PV210_UART if ARCH_S5PV210
                bool "Use Samsung S3C UART 0 for low-level debug"

so this will work as before with any of ARCH_EXYNOS, ARCH_S3C24XX,
ARCH_S3C64XX and ARCH_S5PV210.

What am I missing?

     Arnd
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
