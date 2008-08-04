From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] ALSA: wss_lib: opti92x-ad1848
 WSS_HW_DETECT fix
Date: Mon, 4 Aug 2008 06:36:04 +0200
Message-ID: <20080804063604.506c8656.krzysztof.h1@poczta.fm>
References: <489678D7.8030104@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 831282440D
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Aug 2008 06:30:39 +0200 (CEST)
In-Reply-To: <489678D7.8030104@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 04 Aug 2008 05:34:47 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> [0001-ALSA-wss_lib-opti92x-ad1848-WSS_HW_DETECT-fix.patch  text/plain (1.3KB)]
> From 3e75fdd69c577bf29ee5a6583d479646a12c9d52 Mon Sep 17 00:00:00 2001
> From: Rene Herman <rene.herman@gmail.com>
> Date: Mon, 4 Aug 2008 05:26:26 +0200
> Subject: [PATCH] ALSA: wss_lib: opti92x-ad1848 WSS_HW_DETECT fix
> 
> snd-opti92x-ad1848 mistakingly passes WSS_HW_OPTI93X currently. This
> fixes it as tested with a OPTi 82C929A/AD1848 card.
> 
> Signed-off-by: Rene Herman <rene.herman@gmail.com>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


>  sound/isa/opti9xx/opti92x-ad1848.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
> index cb5f66b..19706b0 100644
> --- a/sound/isa/opti9xx/opti92x-ad1848.c
> +++ b/sound/isa/opti9xx/opti92x-ad1848.c
> @@ -719,6 +719,8 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
>  	chip->dma1 = dma1;
>  #if defined(CS4231) || defined(OPTi93X)
>  	chip->dma2 = dma2;
> +#else
> +	chip->dma2 = -1;
>  #endif
>  
>  	if (chip->wss_base == SNDRV_AUTO_PORT) {
> @@ -734,10 +736,10 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
>  
>  	error = snd_wss_create(card, chip->wss_base + 4, -1,
>  			       chip->irq, chip->dma1, chip->dma2,
> -#ifdef CS4231
> -			       WSS_HW_DETECT, 0,
> -#else /* OPTi93x */
> +#ifdef OPTi93X
>  			       WSS_HW_OPTI93X, WSS_HWSHARE_IRQ,
> +#else
> +			       WSS_HW_DETECT, 0,
>  #endif
>  			       &codec);
>  	if (error < 0)
> -- 
> 1.5.5
> 
> 
> 
> [text/plain (161B)]
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

----------------------------------------------------------------------
Te newsy nakreca Cie na caly dzien!
Sprawdz >>> http://link.interia.pl/f1e94
