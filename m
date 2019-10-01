Return-Path: <SRS0=w4sP=X2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB750C352AA
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:42:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA962086A
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TuZmXHCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA962086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A1F71674;
	Tue,  1 Oct 2019 17:41:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A1F71674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569944552;
	bh=C0yW+KcYp/Tr7PPskYZQiGLAgikEKbA7S6S2qp+t1Bg=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TuZmXHCsfIxnGkg/BegTMUqun42sqvHEm7C+Wsknx3BRbOxN9Vx3I4qpuR309ubbM
	 UQi6bN+1+vmexap1MfTFndH8M/X8XPJFnFR7ChqNSK62oAqqvUbYO3Ht6kxGBg85Db
	 y58mluMqs0KMZCHYxfKGkFNhoEmiGJxneiCdOkGc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87445F800D0;
	Tue,  1 Oct 2019 17:41:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0EC5F80506; Tue,  1 Oct 2019 17:41:39 +0200 (CEST)
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3072BF800D0
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2019 17:41:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3072BF800D0
Received: by mail-qk1-f194.google.com with SMTP id u22so11646631qkk.11
 for <alsa-devel@alsa-project.org>; Tue, 01 Oct 2019 08:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PYNED/gHAQZWO+3A/3UN+zfY12A/7ApPwVWXSrVnRe4=;
 b=KRqRCanHux1XacdbFV1s4glqX9MVCp77cEf5yo3J/ye4tXu6lsVb/+oiYyX9mqJv07
 Z3JdWXYg83BbVIY3ZA2jJ2R+Zys3xbeE8SuuKMvMilCJVwDq6HspkqEfJkhKpwksQach
 2KcnWFYlzdZsxyIdT1BBuhLfwBTTV2SfNxqSyDrHh/SOei8m1kUFxz3p9e3Pt6pDqvhA
 iAOIs8fmviDUnn1riN3Jgp/IGjb+YMV1LYPXlgdite2jKJH01bY0O3qXKAwoY/jfNfsK
 T7ZYX5zF2vUn3ma2fdIddqqb/sKqUM7ab8myABhQAzC/HpOb9zjagRiG5Bv+W0eVgQgB
 bojw==
X-Gm-Message-State: APjAAAV32Eye2cHze03A6qScpmpN/gs5WgXJmaJgH2qRhEPSt+j4T+gY
 Ipe1kWZ5m5/d044KUiF18VJ6ko92qINEvyxchyI=
X-Google-Smtp-Source: APXvYqzYVsIwghV1g7M189GjA1p2gl/d+MucD1KvbEioKPUwygJiOOw9tiSuacOJf+g/Fbf9+E9jGyNtKXcZR+sjTxc=
X-Received: by 2002:a37:a858:: with SMTP id r85mr6681072qke.394.1569944495423; 
 Tue, 01 Oct 2019 08:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191001142026.1124917-1-arnd@arndb.de>
 <bb58c7cc-209d-7a2f-0e5b-95a9605ffe7b@linux.intel.com>
In-Reply-To: <bb58c7cc-209d-7a2f-0e5b-95a9605ffe7b@linux.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 1 Oct 2019 17:41:19 +0200
Message-ID: <CAK8P3a3Js2dNhnRhP7PLadWZ69DZr1mz6DowN9HDJL4CFDAAFw@mail.gmail.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Hulk Robot <hulkci@huawei.com>,
 Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: imx: fix reverse
 CONFIG_SND_SOC_SOF_OF dependency
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

On Tue, Oct 1, 2019 at 5:32 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 10/1/19 9:20 AM, Arnd Bergmann wrote:
> > CONFIG_SND_SOC_SOF_IMX depends on CONFIG_SND_SOC_SOF, but is in
> > turn referenced by the sof-of-dev driver. This creates a reverse
> > dependency that manifests in a link error when CONFIG_SND_SOC_SOF_OF
> > is built-in but CONFIG_SND_SOC_SOF_IMX=m:
> >
> > sound/soc/sof/sof-of-dev.o:(.data+0x118): undefined reference to `sof_imx8_ops'
> >
> > Make the latter a 'bool' symbol and change the Makefile so the imx8
> > driver is compiled the same way as the driver using it.
> >
> > A nicer way would be to reverse the layering and move all
> > the imx specific bits of sof-of-dev.c into the imx driver
> > itself, which can then call into the common code. Doing this
> > would need more testing and can be done if we add another
> > driver like the first one.
>
> Or use something like
>
> config SND_SOC_SOF_IMX8_SUPPORT
>         bool "SOF support for i.MX8"
>         depends on IMX_SCU
>         depends on IMX_DSP
>
> config SND_SOC_SOF_IMX8
>         tristate
>         <i.mx selects>
>
> config SND_SOC_SOF_OF
>         depends on OF
>         select SND_SOC_SOF_IMX8 if SND_SOC_SOF_IMX8_SUPPORT
>
> That way you propagate the module/built-in information. That's how we
> fixed those issues for the Intel parts.

Yes, I think that would work here as well, but it keeps even more
information about the specific drivers in the generic code. It also
requires adding more 'select' statements that tend to cause more
problems.

The same could be done with a Kconfig-only solution avoiding
'select' such as:

config SND_SOC_SOF_IMX8_SUPPORT
         bool "SOF support for i.MX8"
         depends on IMX_SCU
         depends on IMX_DSP

 config SND_SOC_SOF_IMX8
         def_tristate SND_SOC_SOF_OF
         depends on SND_SOC_SOF_IMX8_SUPPORT

      Arnd
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
