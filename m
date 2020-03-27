Return-Path: <SRS0=QDkj=5O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270AFC43331
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Mar 2020 08:00:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63FA20714
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Mar 2020 08:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OOChVemK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63FA20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12F8D1679;
	Sun, 29 Mar 2020 09:59:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12F8D1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585468835;
	bh=45UIJbYSpGwTnXTKHRx5gCp5YItIW1Ujy11FSAzW4jo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OOChVemK0OC5p10XliyLnKIhNF/2zQpCKZS39VeXREsXlJEU+1Ry1eSmNs9mdXO0h
	 9gnGR6FyTa19myXLRTM32SSvR2IQlrTDlXslt5xaWQ121bcLet9mQMtjl/BWo+0d5d
	 6Wct0hi87WY2phLVwPnTt9rpW+H4kl+EfFIvEboY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02570F802DF;
	Sun, 29 Mar 2020 09:54:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4BEA3F80291; Fri, 27 Mar 2020 13:54:56 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 519DFF8011B
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 13:54:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 519DFF8011B
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N4Q8u-1jPoeQ1try-011QP1 for <alsa-devel@alsa-project.org>; Fri, 27 Mar
 2020 13:54:52 +0100
Received: by mail-qk1-f172.google.com with SMTP id q188so10579415qke.8
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 05:54:52 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0YnFq7124T43tTrgao+/j5lJRdFiWXzc86HUPDR3IHBncSx9o/
 KqI5ac2XKtawCfTouEjJzkdUySggg9RDPzUtCOw=
X-Google-Smtp-Source: ADFU+vueKMRRVnX6uqbtv+2n6jxNH6u3YPxdn23XTrFSuAqIloIPBnaq1uinFAYZzt7R/58hOnRiuYU6bptE3XgXqoc=
X-Received: by 2002:ac8:d8e:: with SMTP id s14mr13725256qti.204.1585313689290; 
 Fri, 27 Mar 2020 05:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585311091.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1585311091.git.michal.simek@xilinx.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Mar 2020 13:54:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2mKPRFbRE3MWScr9GSiL4cpLg0wqv1Q28XDCZVPWgHfg@mail.gmail.com>
Message-ID: <CAK8P3a2mKPRFbRE3MWScr9GSiL4cpLg0wqv1Q28XDCZVPWgHfg@mail.gmail.com>
Subject: Re: [PATCH 0/2] powerpc: Remove support for ppc405/440 Xilinx
 platforms
To: Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LXK2W6tv2XeqGedXXLUyTB7zdEta2Tel31DFeAKl1TyQMkwE35H
 z7hORj0hnKB3hZ3NJXkqPowiufjfhqvzwMIOYf06V9m+BjhPWRZUuEcaHyTEGTaN6zyUb6S
 tQNZqU5TKHdPGW91BFFmJyvFw5fd5sCzjCiuVXEQKvKhwnPwWEawqeV5FTVzY6+6PzOF3bo
 UHTt17JCl17G7HMJ9u5lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SVsDpnfDdqg=:I9BfY18dBecAPM27yu6Dhr
 ahhPcllgyLuzLuyZPb7e4g6KdSGel+7GaNJngzmSJojDL3nd+TYwGEnojzA3VcFrsDvTGhh2j
 Zz/Z5Q9s34FMR3mKH7/AV4CpsjqP3lxAbCBMnYPfYrHCwkB/5tNNUQt0Ro3tQ2ySwTFxNKN+Y
 JqhePzkb5X+Dc6Q5IP3/30xPi3HUXd16Io0fNS52CxE3aKF9CYjCnzfZD9fhEe7zSFpel/RFz
 0d5pWw4AHFUvoySOEzrKof6R+Oa4xhXdXoSXx+0MK1Nf+3ok1mZN/9DdaNTBJn48F1WqMYAi2
 LUGC0J/WEzjV8VUAj9TYlOjSBnSK4l4A7cIPDd4vR2edT2QzPrWWVQTCuFl++l6x9j3r0bmRY
 MmiZPIuPLNb2gpRBzQFkORxcP93sYIfNmZ3vnKikmTB/NEthPg6kkqHvyyIjr+SVssWlRNdXY
 5AgeWlxF4F3Si00+mqK/QL0FjBPI+Sk53tA6b2T2d7hz+L4PpHCh7uOWDFJ8NUNc0tX+FbXLQ
 +E2pgsGy9ZeLtubti+7MjsW6ny7kfOrA/MbL2anEVTMyXOzqx1gtN9/4B53KOtCps40lx/BS/
 E0gKkIvMXJ34IUktpcdPNmSmZT1GQJTKXNcrIQuLrqAUJnsXEGvyS3MJJP/+jgzJAMEYEfRIt
 nQ2RTttsmBzwp9YtO7TDIrMCWa6BuaFpseXC1i0wg6uE75IQXVc+E/OZ7ECyeMpIRif++PphJ
 bNpFgTh7NQakMYQ6WsodZDW4RUK53RA4jZmLOpJV5akX6t5PyeAizuacAZ56wIh24e2pV8h9y
 +Izt2POKaZYSXINW/hvqRDRyXEBPvQX+PXqSP7GribIQN5d51A=
X-Mailman-Approved-At: Sun, 29 Mar 2020 09:54:17 +0200
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Richard Fontana <rfontana@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Sasha Levin <sashal@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet <corbet@lwn.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Masahiro Yamada <masahiroy@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Leonardo Bras <leonardo@linux.ibm.com>,
 Matt Porter <mporter@kernel.crashing.org>, DTML <devicetree@vger.kernel.org>,
 Andrew Donnellan <ajd@linux.ibm.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>,
 Mark Brown <broonie@kernel.org>, git@xilinx.com,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Allison Randal <allison@lohutok.net>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Michal Simek <monstr@monstr.eu>,
 Wei Hu <weh@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Armijn Hemel <armijn@tjaldur.nl>, Rob Herring <robh+dt@kernel.org>,
 Enrico Weigelt <info@metux.net>, "David S. Miller" <davem@davemloft.net>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
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

On Fri, Mar 27, 2020 at 1:12 PM Michal Simek <michal.simek@xilinx.com> wrote:
>
> recently we wanted to update xilinx intc driver and we found that function
> which we wanted to remove is still wired by ancient Xilinx PowerPC
> platforms. Here is the thread about it.
> https://lore.kernel.org/linux-next/48d3232d-0f1d-42ea-3109-f44bbabfa2e8@xilinx.com/
>
> I have been talking about it internally and there is no interest in these
> platforms and it is also orphan for quite a long time. None is really
> running/testing these platforms regularly that's why I think it makes sense
> to remove them also with drivers which are specific to this platform.
>
> U-Boot support was removed in 2017 without anybody complain about it
> https://github.com/Xilinx/u-boot-xlnx/commit/98f705c9cefdfdba62c069821bbba10273a0a8ed
>
> Based on current ppc/next.
>
> If anyone has any objection about it, please let me know.

Acked-by: Arnd Bergmann <arnd@arndb.de>

This looks reasonable to me as well, in particular as the code only
supports the two
ppc44x virtex developer boards and no commercial products.

It does raise a follow-up question about ppc40x though: is it time to
retire all of it?
The other ppc405 machines appear to have seen even fewer updates after the
OpenBlockS 600 got added in 2011, so it's possible nobody is using them any more
with modern kernels.

I see that OpenWRT removed both ppc40x and ppc44x exactly a year ago after
they had not been maintained for years.

However, 44x (in its ppc476 incarnation) is clearly still is used
through the fsp2 platform,
and can not be deprecated at least until that is known to have stopped
getting kernel
updates.

        Arnd
