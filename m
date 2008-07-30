From: Russ Dill <Russ.Dill@gmail.com>
Subject: Re: [PATCH] pxa2xx-lib: support building for several
	pxa's
Date: Wed, 30 Jul 2008 17:08:19 +0000 (UTC)
Message-ID: <loom.20080730T165541-413@post.gmane.org>
References: <1217022714-2521-1-git-send-email-dbaryshkov@gmail.com>
	<1217022714-2521-2-git-send-email-dbaryshkov@gmail.com>
	<1217022714-2521-3-git-send-email-dbaryshkov@gmail.com>
	<1217022714-2521-4-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id E547024375
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jul 2008 19:10:04 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KOFBb-0000E3-6L
	for alsa-devel@alsa-project.org; Wed, 30 Jul 2008 17:10:04 +0000
Received: from ip70-190-167-62.ph.ph.cox.net ([70.190.167.62])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2008 17:10:03 +0000
Received: from Russ.Dill by ip70-190-167-62.ph.ph.cox.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2008 17:10:03 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


[...]

(in pxa2xx_ac97_hw_resume)
> +		pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
>  #ifdef CONFIG_PXA27x
> -	/* Use GPIO 113 as AC97 Reset on Bulverde */
> -	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
> +		/* Use GPIO 113 as AC97 Reset on Bulverde */
> +		pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
>  #endif

forgot a cpu_is_pxa27x()

[...]

(in pxa2xx_ac97_hw_probe
> -		goto err_irq;
> +		/* Use GPIO 113 as AC97 Reset on Bulverde */
> +		pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
> +#endif

another one
