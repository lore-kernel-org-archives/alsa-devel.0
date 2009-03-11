From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/3][RFC] ASoC: Add Magician machine
 support.
Date: Wed, 11 Mar 2009 19:02:08 +0000
Message-ID: <1236798128.6781.187.camel@vega.slimlogic.co.uk>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
	<1236795420-12175-2-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 511C41038A8
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 20:02:10 +0100 (CET)
In-Reply-To: <1236795420-12175-2-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Overall looks good. One very minor issue :-

On Wed, 2009-03-11 at 19:16 +0100, Philipp Zabel wrote:
> HTC Magician has a Philips UDA1380 codec connected via
> SSP1 (playback) and I2S (capture).
> There is a flip-flop between the SSP frame clock output
> and the codec's word select input pin. To make the codec
> see proper I2S input, the SSP has to send two frames per
> sample.
> 
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
> ---
>  sound/soc/pxa/Kconfig    |   10 +
>  sound/soc/pxa/Makefile   |    2 +
>  sound/soc/pxa/magician.c |  563 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 575 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/pxa/magician.c
> 

snip

> --- /dev/null
> +++ b/sound/soc/pxa/magician.c
> @@ -0,0 +1,563 @@
> +/*
> + * SoC audio for HTC Magician
> + *
> + * Copyright (c) 2006-2009 Philipp Zabel <philipp.zabel@gmail.com>
> + *
> + * based on spitz.c,
> + * Authors: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

This address is no longer valid. Could you change to the address I'm
sending with.

Thanks

Liam
