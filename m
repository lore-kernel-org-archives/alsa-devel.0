From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v5 07/10] ASoC: fsl-ssi: imx ac97 support
Date: Thu, 25 Apr 2013 13:37:16 +0200
Message-ID: <20130425113716.GB27763@pengutronix.de>
References: <1366814199-14827-1-git-send-email-mpa@pengutronix.de>
 <1366814199-14827-8-git-send-email-mpa@pengutronix.de>
 <20130425035029.GB1276@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130425035029.GB1276-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 25, 2013 at 11:50:30AM +0800, Shawn Guo wrote:
> On Wed, Apr 24, 2013 at 04:36:36PM +0200, Markus Pargmann wrote:
> > +/*
> > + * Pointer to AC97 reset functions for specific boards
> > + */
> > +#if IS_ENABLED(CONFIG_MACH_PCA100)
> > +extern void pca100_ac97_cold_reset(struct snd_ac97 *ac97);
> > +extern void pca100_ac97_warm_reset(struct snd_ac97 *ac97);
> > +#else
> > +void pca100_ac97_cold_reset(struct snd_ac97 *ac97) { }
> > +void pca100_ac97_warm_reset(struct snd_ac97 *ac97) { }
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_MACH_PCM043)
> > +extern void pcm043_ac97_cold_reset(struct snd_ac97 *ac97);
> > +extern void pcm043_ac97_warm_reset(struct snd_ac97 *ac97);
> > +#else
> > +void pcm043_ac97_cold_reset(struct snd_ac97 *ac97) { }
> > +void pcm043_ac97_warm_reset(struct snd_ac97 *ac97) { }
> > +#endif
> ...
> > @@ -717,13 +956,39 @@ static int fsl_ssi_probe(struct platform_device *pdev)
> >  
> >  	strcpy(ssi_private->name, p);
> >  
> > -	/* Initialize this copy of the CPU DAI driver structure */
> > -	memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
> > -	       sizeof(fsl_ssi_dai_template));
> > -	ssi_private->cpu_dai_drv.name = ssi_private->name;
> > -
> >  	ssi_private->use_dma = !of_property_read_bool(np, "fsl,imx-fiq");
> >  
> > +	if (ac97) {
> > +		sprop = of_get_property(of_find_node_by_path("/"), "compatible",
> > +				NULL);
> > +		p = strrchr(sprop, ',');
> > +		if (p)
> > +			sprop = p + 1;
> > +
> > +		if (!strcmp(sprop, "imx27-pca100")) {
> > +			ssi_private->ac97_reset = pca100_ac97_cold_reset;
> > +			ssi_private->ac97_warm_reset = pca100_ac97_warm_reset;
> > +		} else if (!strcmp(sprop, "imx27-pcm043")) {
> > +			ssi_private->ac97_reset = pcm043_ac97_cold_reset;
> > +			ssi_private->ac97_warm_reset = pcm043_ac97_warm_reset;
> > +		} else {
> > +			dev_err(&pdev->dev, "Failed to enable ssi AC97 mode, unknown board.\n");
> > +			ret = -EINVAL;
> > +			goto error_kmalloc;
> > +		}
> 
> I do not like these board specific hooks show up in an IP driver
> in such way.  Can we work it out in other ways, notification or even
> platform_data with auxdata?

soc_ac97_ops is a global symbol, so we could setup soc_ac97_ops.reset
and warm_reset in board specific ac97 drivers. For this patch I would
move the assignment of reset functions to phycore-ac97.c which already
is specifically for this codec-ssi combination on the two boards.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
