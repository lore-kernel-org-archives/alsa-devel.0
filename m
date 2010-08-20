From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/1] ASoC: clean dead file pxa2xx-pcm.h
Date: Fri, 20 Aug 2010 11:52:09 +0100
Message-ID: <1282301529.3084.166.camel@odin>
References: <AANLkTimwZUqjROy0POvEgS_XE3V953bzh_+hV8z8=ewz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 12FE51037FB
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 12:52:14 +0200 (CEST)
Received: by wyb42 with SMTP id 42so3378199wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 03:52:13 -0700 (PDT)
In-Reply-To: <AANLkTimwZUqjROy0POvEgS_XE3V953bzh_+hV8z8=ewz@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-08-20 at 18:37 +0800, Haojian Zhuang wrote:
> From a3d2309c28d502e89997e0cc1ab98f3cacc684df Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Fri, 20 Aug 2010 18:27:41 +0800
> Subject: [PATCH 1/1] ASoC: clean dead file pxa2xx-pcm.h
> 
> Since pxa2xx-pcm.h is removed from sound/soc/pxa directory, clean it
> for passing compilation.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  sound/soc/pxa/pxa2xx-ac97.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
> index 9c2bafa..ac51c6d 100644
> --- a/sound/soc/pxa/pxa2xx-ac97.c
> +++ b/sound/soc/pxa/pxa2xx-ac97.c
> @@ -24,7 +24,6 @@
>  #include <mach/dma.h>
>  #include <mach/audio.h>
> 
> -#include "pxa2xx-pcm.h"
>  #include "pxa2xx-ac97.h"
> 
>  static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
