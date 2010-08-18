From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/3] ASoC: add tavorevb3 machine driver for
	88pm860x
Date: Wed, 18 Aug 2010 15:06:59 +0100
Message-ID: <1282140419.3117.465.camel@odin>
References: <AANLkTi=o7+GtXz1ZxuLJiYkREpMB=RPckig95FQrSqLd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F3ED8103815
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 16:07:11 +0200 (CEST)
Received: by wyb42 with SMTP id 42so799792wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2010 07:07:08 -0700 (PDT)
In-Reply-To: <AANLkTi=o7+GtXz1ZxuLJiYkREpMB=RPckig95FQrSqLd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <Mark.Brown@wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-08-18 at 21:49 +0800, Haojian Zhuang wrote:
> >From 114a6f2d4629b0bbff4c4ce9b4a633ddf7e25498 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Tue, 17 Aug 2010 13:24:35 +0800
> Subject: [PATCH 2/3] ASoC: add tavorevb3 machine driver for 88pm860x
> 
> 88PM860x codec is used in Marvell tavorevb3 development board. 88PM860x
> codec is used as master mode of SSP communication. Only I2S format is
> supported.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  sound/soc/pxa/Kconfig      |    9 +
>  sound/soc/pxa/Makefile     |    2 +
>  sound/soc/pxa/pxa2xx-ssp.c |  532 ++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/pxa/pxa2xx-ssp.h |   59 +++++
>  sound/soc/pxa/ssp.c        |  298 +++++++++++++++++++++++++

I dont think you meant to include the SSP driver.

Thanks

Liam
