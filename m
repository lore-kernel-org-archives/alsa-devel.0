From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v2 5/7] ASoC: stm32: add DFSDM DAI support
Date: Tue, 14 Feb 2017 17:45:34 +0000
Message-ID: <20170214174534.35ytbpax75mxcayg@sirena.org.uk>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-6-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xpdpdov767mccfpp"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1487003909-11710-6-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--xpdpdov767mccfpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 05:38:27PM +0100, Arnaud Pouliquen wrote:

This looks basically fine as a system specific driver but as some of the
comments in here say there's bits of it could perhaps be genericised but
I'm not sure we need to do that right now.  I'm not sure the abstraction
is exactly comfortable but having another bit of hardware doing a bridge
to IIO might be the best way to figure out something better.

> +	.period_bytes_min =3D 40, /* 8 khz 5 ms */
> +	.period_bytes_max =3D 4 * PAGE_SIZE,
> +	.buffer_bytes_max =3D 16 * PAGE_SIZE

What's the physical minimum period limit?  The comment makes this sound
like it's just made up.

> +	unsigned int shift =3D 24 -priv->max_scaling;
> +=09

Missing space after -.

> +	dev_dbg(dai->dev, "%s: enter\n", __func__);
> +	return 0;
> +	return snd_pcm_hw_constraint_list(substream->runtime, 0,
> +					  SNDRV_PCM_HW_PARAM_RATE,
> +					  &priv->rates_const);

Looks like debug changes got left in?

> +static int stm32_adfsdm_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> +				   unsigned int freq, int dir)
> +{
> +	struct stm32_adfsdm_priv *priv =3D snd_soc_dai_get_drvdata(dai);
> +	struct stm32_adfsdm_pdata *pdata =3D priv->pdata;
> +
> +	dev_dbg(dai->dev, "%s: enter for dai %d\n", __func__, dai->id);
> +	if (dir =3D=3D SND_SOC_CLOCK_IN) {
> +		pdata->ops->set_sysclk(pdata->adc, freq);
> +		priv->dmic_clk =3D freq;
> +	}
> +
> +	/* Determine supported rate which depends on SPI/manchester clock */
> +	return stm32_adfsdm_get_supported_rates(dai, &priv->rates_const.mask);

Since the DAI is unidirectional it doesn't matter but obviously if it
weren't then the fact that getting the supported rates involves setting
the hwparams means this could become disruptive.  If we're going to
genericise this to be a more general IIO/ASoC bridge that could matter.

> +static int stm32_adfsdm_dai_remove(struct snd_soc_dai *dai)
> +{
> +	dev_dbg(dai->dev, "%s: enter for dai %d\n", __func__, dai->id);
> +
> +	return 0;
> +}

Remove empty functions, though in this case I think you want to add
something to disconnect the XRUN callback just in order to be sure it
can't be mistakenly called.

--xpdpdov767mccfpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlijQj4ACgkQJNaLcl1U
h9BceAf+IvJatEdQ7QRh76mi+W8+GmO6mh2PfrVZkp85nnwYhtrGUefHTceCm0Ro
0n5QebpVR2vC2E/8NkCoCFrl3LWiZ32dQ4CE60JsQg/BTrLGYTmhUhfUTE74ydaL
GRvBj7+nfhdkJOoc11pu+GhrCL4JjBU3H4XrRXXnA6u4E8c0mh970lEsC484UyIn
Baac1qM8ezLQc5k/pMNcjMdTcF8HbovyFm7Ih/jdDS8wzh2BGBU7MukrJwfeSCHy
4GtPf/BaQnnYzlWc/Ncj82Kk28lt8ndZ8uAASpfkNEv2Be6gARtxB0fQoQSX0dhK
fwhp0sOulo5MObScqlDiVwFkLGKinA==
=FHM7
-----END PGP SIGNATURE-----

--xpdpdov767mccfpp--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
