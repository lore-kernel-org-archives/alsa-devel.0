From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: Add support for BCM2835
Date: Sat, 9 Nov 2013 18:48:47 +0000
Message-ID: <20131109184847.GV2493@sirena.org.uk>
References: <527D5013.7080508@koalo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0978958482435882997=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F887261A5E
 for <alsa-devel@alsa-project.org>; Sat,  9 Nov 2013 19:49:00 +0100 (CET)
In-Reply-To: <527D5013.7080508@koalo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Florian Meier <florian.meier@koalo.de>
Cc: devicetree <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, dmaengine <dmaengine@vger.kernel.org>, martin@sperl.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0978958482435882997==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3e0+L7380OK+0MAI"
Content-Disposition: inline


--3e0+L7380OK+0MAI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2013 at 09:56:51PM +0100, Florian Meier wrote:

This all looks pretty good, a few comments belown but nothing terribly
substantial.

>  source "sound/soc/atmel/Kconfig"
>  source "sound/soc/au1x/Kconfig"
> +source "sound/soc/bcm2835/Kconfig"

Is this really only used on this one SoC - I'd expect a more generic
name for the directory?

> +	/*
> +	 * Clear both FIFOs if the one that should be started
> +	 * is not empty at the moment. This should only happen
> +	 * after overrun. Otherwise, hw_params would have cleared
> +	 * the FIFO.
> +	 */
> +	regmap_read(dev->i2s_regmap, BCM2835_I2S_CS_A_REG, &cs_reg);
> +
> +	switch (substream->stream) {
> +	case SNDRV_PCM_STREAM_PLAYBACK:
> +		if (cs_reg & BCM2835_I2S_TXE)
> +			break;
> +	case SNDRV_PCM_STREAM_CAPTURE:
> +		if (!(cs_reg & BCM2835_I2S_RXD))
> +			break;
> +
> +		bcm2835_i2s_clear_fifos(dev);
> +	}

This is a bit confusing to me - the switch statement with fallthroughs
is a fairly unusual idiom and the placement of the clear is a bit
peculiar.  Writing it out with ifs would probably make it clearer what
the intent is.  It's also not clear why we're doing this or that it's
safe, won't this have a destructive effect on the other stream?

> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
> +				BCM2835_I2S_RXON, 0);
> +	} else {
> +		regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
> +				BCM2835_I2S_TXON, 0);
> +	}
> +

No { } for single statement if conditions.

> +static int bcm2835_i2s_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct bcm2835_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
> +
> +	/* Set the appropriate DMA parameters */
> +	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].addr =
> +		(dma_addr_t)BCM2835_I2S_FIFO_PHYSICAL_ADDR;
> +	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].addr =
> +		(dma_addr_t)BCM2835_I2S_FIFO_PHYSICAL_ADDR;

DT?

> +static bool bcm2835_clk_precious_reg(struct device *dev, unsigned int reg)
> +{
> +	return false;
> +}

Just omit this, it's the default.

> +static const struct regmap_config bcm2835_i2s_regmap_config = {
> +};

There should be something in here.

> +		ioarea = devm_request_mem_region(&pdev->dev, mem->start,
> +					   resource_size(mem),
> +					   pdev->name);
> +		if (!ioarea) {
> +			dev_err(&pdev->dev, "I2S probe: Memory region already claimed.\n");
> +			return -EBUSY;
> +		}
> +
> +		base = devm_ioremap(&pdev->dev, mem->start,
> +				resource_size(mem));

devm_ioremap_resource().  Thinking about this we should probably have a
regmap MMIO constructor that takes a resource...

> +static const struct snd_pcm_hardware bcm2835_pcm_hardware = {
> +	.info			= SNDRV_PCM_INFO_MMAP |
> +				  SNDRV_PCM_INFO_MMAP_VALID |
> +				  SNDRV_PCM_INFO_INTERLEAVED |
> +				  SNDRV_PCM_INFO_JOINT_DUPLEX,
> +	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
> +				  SNDRV_PCM_FMTBIT_S32_LE,
> +	.period_bytes_min	= 32,
> +	.period_bytes_max	= 64 * PAGE_SIZE,
> +	.periods_min		= 2,
> +	.periods_max		= 255,
> +	.buffer_bytes_max	= 128 * PAGE_SIZE,

The dmaengine code recently acquired the ability to work out most of
this automatically by querying the DMA controller, you should use that
as much as possible.

--3e0+L7380OK+0MAI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSfoOMAAoJELSic+t+oim9iGEP/0s3B8FE9lrFkKk1GXVIIaxy
WtNyLSgTHNkUAj5qHDkw1qXHY8RZUjCrxDipVY6myH2QUX8SNajo2BswzbIAz1fP
gy4ZRDGJSie2+2sT2GOKqutKsENc3f4xsIyKe92W6XpJJacFOVcgwPEQLaWMztmw
z4+A8CjSo4OCnkmB5uP2mpoIu7u24DbXIWLdt6CPSWcHr7Nut1ybzF63WRtDQaOE
1Ub3b53e7It/ZH2H0agWkXquyfFux0aHGDGfunF0X6XVR7V9B6Ag1j4Y5J/qOhY8
YJTxSU9x4drOGuuCdy4fLBeuijwZgqagDayEINCIR36NAta7Eg/zdacpHp6TvKZg
aJMU9EyMhqzRFZMmlwDPkpnMxj3P87XPw7mK20Wj9aTXoUVd3h3Jx+TBrZ9E3RqQ
gbyTRuxPRZ2afWtQ1YwZDP3kICEvfsdDtLldORAjhrfqNjzt9OOD4OMkt0qbJ04R
GdsWKNTLw+VvZW0aiUxRU1oJkDmTlNYVlXyqfqXCg+omrGzl/xH+k63JEVccHkOv
YKcWn6wp6Bn7+RTOk/HvLiA7PLjuSBEKF7LPv7C9SxeAyXqRuDjLqYFm9PlSQ3cf
QSHEEl9y2u5n1ETZmwF4Z6wYOejIiVNGDQuR5pEQ6QgWZV63kDPqQihVaQegFMaa
adgnv+RkJtjVQgXWTOYj
=UIno
-----END PGP SIGNATURE-----

--3e0+L7380OK+0MAI--

--===============0978958482435882997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0978958482435882997==--
