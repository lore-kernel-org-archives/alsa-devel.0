From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] ASoC: mediatek: Add MT8516 PCM driver
Date: Fri, 3 May 2019 14:58:09 +0900
Message-ID: <20190503055809.GC14916@sirena.org.uk>
References: <20190502121041.8045-1-fparent@baylibre.com>
 <20190502121041.8045-4-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e7WmlSfQJTtHfSol"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190502121041.8045-4-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com, kaichieh.chuang@mediatek.com, shunli.wang@mediatek.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--e7WmlSfQJTtHfSol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 02, 2019 at 02:10:39PM +0200, Fabien Parent wrote:

> +static irqreturn_t mt8516_afe_irq_handler(int irq, void *dev_id)
> +{
> +	struct mtk_base_afe *afe = dev_id;
> +	unsigned int reg_value;
> +	unsigned int memif_status;
> +	int i, ret;
> +
> +	ret = regmap_read(afe->regmap, AFE_IRQ_STATUS, &reg_value);
> +	if (ret) {
> +		reg_value = AFE_IRQ_STATUS_BITS;
> +		goto exit_irq;
> +	}

...

> +exit_irq:
> +	regmap_write(afe->regmap, AFE_IRQ_CLR, reg_value & AFE_IRQ_STATUS_BITS);
> +
> +	return IRQ_HANDLED;
> +}

This unconditionally says it handled an interrupt regardless of what
happened.  This means that the interrupt line can't be shared and that
the error handling code in the generic interrupt subsystem can't tell if
something goes wrong and the interrupt gets stuck.

> +	ret = devm_request_irq(afe->dev, irq_id, mt8516_afe_irq_handler,
> +			       0, "Afe_ISR_Handle", (void *)afe);
> +	if (ret) {
> +		dev_err(afe->dev, "could not request_irq\n");
> +		return ret;
> +	}

Are you sure the interrupt handler can safely use managed resources,
especially given...

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	afe->base_addr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(afe->base_addr))
> +		return PTR_ERR(afe->base_addr);
> +
> +	afe->regmap = devm_regmap_init_mmio(&pdev->dev, afe->base_addr,
> +		&mt8516_afe_regmap_config);
> +	if (IS_ERR(afe->regmap))
> +		return PTR_ERR(afe->regmap);

...that things like the register map and the I/O resources for the chip
are allocated after and therefore freed before before the interrupt is
freed.  Normally the interrupt should be one of the last things to be
allocated.

> +static int mt8516_afe_pcm_dev_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

In general if functions can legitimately be empty they should just be
omitted, if they are required that usually means they have to do
something.

--e7WmlSfQJTtHfSol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzL2HAACgkQJNaLcl1U
h9CyAwf9G6RLyjC0l1jZ7PuvlyUWgPa0meffYGQwZm5IRVLUCEfYjhxodTO5hKh2
fFN64GvyEDq68fgDpF1ILhSFWZFRBLkdFwJ2/e2tknzzQ3QWpWA3mvzrzEzyZlOB
Z0ocR20bgbYxO+OAas//SnwCaY+Hm14Dho0oQooGlWHWGfQtxF7OcKKVTYnf1uij
GHYwqmasG50ldZZ+Lwu8tgueOohnt53QpM5L8wx33IBSYmmAdpCw6C6raql8bQAe
9dyCLUtxkI+dUhvn9cemnDD6VTPhPvj7AGL+L8Xp2/3T8GQQkYTyskjPWt/3nCan
5wADxvamyeOpeEhFqke6O33PxGD2jA==
=0nPV
-----END PGP SIGNATURE-----

--e7WmlSfQJTtHfSol--
