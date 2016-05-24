From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4 v7] ASoC: dwc: Add PIO PCM extension
Date: Tue, 24 May 2016 17:41:51 +0100
Message-ID: <20160524164151.GM8206@sirena.org.uk>
References: <cover.1463996627.git.joabreu@synopsys.com>
 <d81055d826825874c9d76922d2275688b2586fa6.1463996627.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/hP/389S7qb5BOej"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d81055d826825874c9d76922d2275688b2586fa6.1463996627.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: alsa-devel@alsa-project.org, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--/hP/389S7qb5BOej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 23, 2016 at 11:02:24AM +0100, Jose Abreu wrote:

> +config SND_DESIGNWARE_PCM
> +	bool "PCM PIO extension for I2S driver"

Why can't this be built as a module?

> +
> +	return irq_valid ? IRQ_HANDLED : IRQ_NONE;

Please write a normal if statement, the ternery operator doesn't help
legibility.

>  static void i2s_start(struct dw_i2s_dev *dev,
>  		      struct snd_pcm_substream *substream)
>  {
>  	struct i2s_clk_config_data *config =3D &dev->config;
> =20
>  	i2s_write_reg(dev->i2s_base, IER, 1);
> -	i2s_enable_irqs(dev, substream->stream, config->chan_nr);
> +
> +	if (dev->use_pio)
> +		i2s_enable_irqs(dev, substream->stream, config->chan_nr);
> =20
>  	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
>  		i2s_write_reg(dev->i2s_base, ITER, 1);

That seems wrong, or at least something that should be separate?
Previously we needed interrupts for DMA operation but now we enable
interrupts only if we don't use DMA.  It feels like we want to make the
change for DMA separately if only to make it clear for bisection, are we
100% sure that masking the interrupt won't also mask the DMA request
signals?

> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq >=3D 0) {
> +		dev_dbg(&pdev->dev, "using PIO mode\n");
> +		dev->use_pio =3D true;
> +
> +		ret =3D devm_request_irq(&pdev->dev, irq, i2s_irq_handler, 0,
> +				pdev->name, dev);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to request irq\n");
> +			return ret;
> +		}
> +	}

This also seems wrong.  We're forcing PIO if an interrupt is provided
rather than based on DMA being configured which means that if the
interrupt is wired up and happens to be described in DT we'll get worse
performance.  People should be able to just describe the system without
worrying about this, and we might find some other use for the interrupts
in future.  Indeed right now it would probably be reasonable to use the
error interrupts all the time if they're available.

--/hP/389S7qb5BOej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRIRNAAoJECTWi3JdVIfQp+0H/1Wr/vK4+Uwilx565kjhIovT
WvXSdWXfIPGK3sqR4K8Ow7iATN+HWO8kbFm+s03DjNBL9jb+FsrXz8F/iFAeHUo1
9mSXlSbWtqQBDMfy92Qax7oARunolSBJBlemAFzH6J2A5JZNFskMGejmQlbwWtyR
TAWT6MwpnXPva/ndOpQQCGHikd7hes4tJqEjdTmhrbtLghka2dLnGCypeMylyB3t
yE4bLRKtvdYkbxjsXVZk3EHIs1cKlHRG9b2Oz2hxgGT2OCCCPEPDXNH34JPwAUdv
meQvHDnHjGkfuUdgoqK9+hJRB2yhGaolJXV6Y8xlQL35GDwYOkuttG/FpO0snko=
=RtIu
-----END PGP SIGNATURE-----

--/hP/389S7qb5BOej--
