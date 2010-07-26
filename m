From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: multi-component: SAMSUNG: Modify the
 name of I2S driver
Date: Mon, 26 Jul 2010 11:44:48 +0100
Message-ID: <1280141088.3072.33.camel@odin>
References: <4C4CEDE1.5010605@samsung.com>
	<B9F57799-417E-4006-80D4-7768EE347BF5@opensource.wolfsonmicro.com>
	<AANLkTi=20B0K+87HeRjdKAONVjwEhar09QRmj-SB2zbO@mail.gmail.com>
	<AANLkTimV+mJF_Qz2JvDcAUc+pApVApFQMHkLK32w+MWp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D45A24702
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 12:44:45 +0200 (CEST)
Received: by wwb22 with SMTP id 22so4789023wwb.20
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 03:44:45 -0700 (PDT)
In-Reply-To: <AANLkTimV+mJF_Qz2JvDcAUc+pApVApFQMHkLK32w+MWp@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>, "jassi.brar@samsung.com" <jassi.brar@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, ben-linux <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-07-26 at 16:37 +0900, Kyungmin Park wrote:
> On Mon, Jul 26, 2010 at 4:22 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> > On Mon, Jul 26, 2010 at 3:57 PM, Mark Brown
> > <broonie@opensource.wolfsonmicro.com> wrote:
> >> On 25 Jul 2010, at 19:07, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> >>
> >>> This patch modify the name of I2S driver(S3C64XX/S3C24xx
> >>> /S3C2412) from "*-iis-*" to "*-i2s-*". The mismatch of I2S name
> >>> exist in the following sound driver. These files write the
> >>> "cpu_dai_name" of I2S as "*-i2s-*".
> >>>
> >>> - sound/soc/s3c24xx/aquila_wm8994.c : "s3c64xx-i2s-v4-dai"
> >>> - sound/soc/s3c24xx/goni_wm8994.c : "s3c64xx-i2s-v4-dai"
> >>> - sound/soc/s3c24xx/smdk64xx_wm8580.c "s3c64xx-i2s-v4-dai"
> >>> - sound/soc/s3c24xx/jive_wm8750.c : "s3c2412-i2s-dai"
> >>> - sound/soc/s3c24xx/neo1973_wm8753.c : "s3c24xx-i2s-dai"
> >>> - sound/soc/s3c24xx/neo1973_gta02_wm8753.c : "s3c24xx-i2s-dai"
> >>> - sound/soc/s3c24xx/s3c24xx_simtec_hermes.c : "s3c24xx-i2s-dai"
> >>> - sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c : "s3c24xx-i2s-dai"
> >>> - sound/soc/s3c24xx/s3c24xx_uda134x.c : "s3c24xx-i2s-dai"
> >>> - sound/soc/s3c24xx/smartq_wm8987.c : "s3c64xx-i2s-dai.0"
> >>>
> >>> or, It is should modify "cpu_dai_name" of sound drvier files
> >>> instead of modifying the name of I2S driver.
> >>
> >> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> >>
> >> but Jassi really should also comment here.
> > I already talked to Ben about renaming drivers but he doesn't like the idea
> > of breaking loadable drivers in distributions and I buy his opinion.
> > So, Ben really has the say on the matter.
> 

I'll explain the reasoning behind the "-dai" suffix.

The "-dai" suffix name change is all about preventing naming collisions.
I'm not sure if this may affect the Samsung platforms atm, but it does
affect other platforms like OMAP, PXA, DaVinci, I.MX, FSL and Blackfin
atm. (Now that _all_ ASoC components are devices)

The problem is that digital audio interfaces are typically now being
implemented in silicon as part of platform general purpose serial buses.
So on OMAP, we can use the McBSP interface for audio and any other
general purpose serial type data. So this leads to the problem where you
want to use McBSP2 for audio and McBSP1 for some non audio serial device
and have to name the McBSP client bus drivers for probing().

Btw shouldn't correct MODULE_ALIAS() information allow the distributions
to load the renamed module drivers ?  

> Plus how to change the directory name to "samsung'?
> 

I guess the s3c24xx directory name is actually quite misleading now.
Although this should probably be looked at after the multi-component
merge.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
