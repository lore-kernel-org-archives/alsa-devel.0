From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v5 07/10] ASoC: fsl-ssi: imx ac97 support
Date: Thu, 25 Apr 2013 11:50:30 +0800
Message-ID: <20130425035029.GB1276@S2101-09.ap.freescale.net>
References: <1366814199-14827-1-git-send-email-mpa@pengutronix.de>
 <1366814199-14827-8-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 by alsa0.perex.cz (Postfix) with ESMTP id A705B265D13
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 05:50:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1366814199-14827-8-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 24, 2013 at 04:36:36PM +0200, Markus Pargmann wrote:
> +/*
> + * Pointer to AC97 reset functions for specific boards
> + */
> +#if IS_ENABLED(CONFIG_MACH_PCA100)
> +extern void pca100_ac97_cold_reset(struct snd_ac97 *ac97);
> +extern void pca100_ac97_warm_reset(struct snd_ac97 *ac97);
> +#else
> +void pca100_ac97_cold_reset(struct snd_ac97 *ac97) { }
> +void pca100_ac97_warm_reset(struct snd_ac97 *ac97) { }
> +#endif
> +
> +#if IS_ENABLED(CONFIG_MACH_PCM043)
> +extern void pcm043_ac97_cold_reset(struct snd_ac97 *ac97);
> +extern void pcm043_ac97_warm_reset(struct snd_ac97 *ac97);
> +#else
> +void pcm043_ac97_cold_reset(struct snd_ac97 *ac97) { }
> +void pcm043_ac97_warm_reset(struct snd_ac97 *ac97) { }
> +#endif
...
> @@ -717,13 +956,39 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>  
>  	strcpy(ssi_private->name, p);
>  
> -	/* Initialize this copy of the CPU DAI driver structure */
> -	memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
> -	       sizeof(fsl_ssi_dai_template));
> -	ssi_private->cpu_dai_drv.name = ssi_private->name;
> -
>  	ssi_private->use_dma = !of_property_read_bool(np, "fsl,imx-fiq");
>  
> +	if (ac97) {
> +		sprop = of_get_property(of_find_node_by_path("/"), "compatible",
> +				NULL);
> +		p = strrchr(sprop, ',');
> +		if (p)
> +			sprop = p + 1;
> +
> +		if (!strcmp(sprop, "imx27-pca100")) {
> +			ssi_private->ac97_reset = pca100_ac97_cold_reset;
> +			ssi_private->ac97_warm_reset = pca100_ac97_warm_reset;
> +		} else if (!strcmp(sprop, "imx27-pcm043")) {
> +			ssi_private->ac97_reset = pcm043_ac97_cold_reset;
> +			ssi_private->ac97_warm_reset = pcm043_ac97_warm_reset;
> +		} else {
> +			dev_err(&pdev->dev, "Failed to enable ssi AC97 mode, unknown board.\n");
> +			ret = -EINVAL;
> +			goto error_kmalloc;
> +		}

I do not like these board specific hooks show up in an IP driver
in such way.  Can we work it out in other ways, notification or even
platform_data with auxdata?

Shawn
