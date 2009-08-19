From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] Add FSI-AK464x sound support for
	ms7724se
Date: Wed, 19 Aug 2009 13:00:58 +0100
Message-ID: <20090819120058.GB20227@rakim.wolfsonmicro.main>
References: <uiqgk59lj.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5671624385
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 14:00:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <uiqgk59lj.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 19, 2009 at 08:25:28PM +0900, Kuninori Morimoto wrote:

>  arch/sh/boards/Kconfig                   |    9 +++
>  arch/sh/boards/mach-se/7724/Makefile     |    3 +-
>  arch/sh/boards/mach-se/7724/fsi-ak464x.c |   90 ++++++++++++++++++++++++++++++

the machine driver itself should be under sound/soc/sh.

> +static int machine_init(struct snd_soc_codec *codec)
> +{
> +	snd_soc_dapm_sync(codec);
> +	return 0;
> +}

This should just be removed - the core will do this for you.

> +	/* enable FSI */
> +	gpio_request(GPIO_FN_FSIMCKB,    NULL);
> +	gpio_request(GPIO_FN_FSIMCKA,    NULL);
> +	gpio_request(GPIO_FN_FSIOASD,    NULL);
> +	gpio_request(GPIO_FN_FSIIABCK,   NULL);
> +	gpio_request(GPIO_FN_FSIIALRCK,  NULL);
> +	gpio_request(GPIO_FN_FSIOABCK,   NULL);
> +	gpio_request(GPIO_FN_FSIOALRCK,  NULL);
> +	gpio_request(GPIO_FN_CLKAUDIOAO, NULL);
> +	gpio_request(GPIO_FN_FSIIBSD,    NULL);
> +	gpio_request(GPIO_FN_FSIOBSD,    NULL);
> +	gpio_request(GPIO_FN_FSIIBBCK,   NULL);
> +	gpio_request(GPIO_FN_FSIIBLRCK,  NULL);
> +	gpio_request(GPIO_FN_FSIOBBCK,   NULL);
> +	gpio_request(GPIO_FN_FSIOBLRCK,  NULL);
> +	gpio_request(GPIO_FN_CLKAUDIOBO, NULL);
> +	gpio_request(GPIO_FN_FSIIASD,    NULL);

Is this something that the FSI driver should do for itself?  It looks
like there's no pin options here, just fixed functions for FSI A or B so
replicating per-board seems redundant.  On the other hand, if it's
idiomatic for SH better keep it this way.
