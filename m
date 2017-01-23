From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/4] ASoC: es8328: Add support for slave mode
Date: Mon, 23 Jan 2017 17:59:17 +0000
Message-ID: <20170123175917.3fpceelozd57emz3@sirena.org.uk>
References: <20170123104149.2508-1-romain.perier@collabora.com>
 <20170123104149.2508-3-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="etwh2oo4py7wpyd5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170123104149.2508-3-romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--etwh2oo4py7wpyd5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 23, 2017 at 11:41:47AM +0100, Romain Perier wrote:

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +		case SND_SOC_DAIFMT_CBM_CFM:
> +			master = true;
> +			break;
> +		case SND_SOC_DAIFMT_CBS_CFS:
> +			master = false;
> +			break;
> +		default:
> +			return -EINVAL;
> +	}

Please use the normal kernel coding style.  People read in part by
pattern matching so this is important to ease review and coding style
problems are a big warning sign that the code also has problems with
other, more substantial, understanding of how the kernel is expected to
work.

> -	/* Master serial port mode, with BCLK generated automatically */
> -	snd_soc_update_bits(codec, ES8328_MASTERMODE,
> -			ES8328_MASTERMODE_MSC, ES8328_MASTERMODE_MSC);
> +	if (master) {
> +		/* Master serial port mode, with BCLK generated automatically */
> +		snd_soc_update_bits(codec, ES8328_MASTERMODE,
> +				    ES8328_MASTERMODE_MSC,
> +				    ES8328_MASTERMODE_MSC);
> +	} else {
> +		/* Slave serial port mode */
> +		snd_soc_update_bits(codec, ES8328_MASTERMODE,
> +				    ES8328_MASTERMODE_MSC,
> +				    0);
> +	}

Why not just directly do this in the switch statement?  This appears to
be the only place where we change behaviour so setting a variable at the
top of the function then using it at the bottom doesn't seem to add
anything.

--etwh2oo4py7wpyd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliGRHQACgkQJNaLcl1U
h9DFhwf/eFY7jOX8H6f2i5mlcdoDuL9SibVCS48ft35fs+IBjbVanncDBhL8WHpW
/5mIcZbiXASRewcT8QAfLtokV3ttLznBG3Yb1TuHwcVWRh5TKhiNUENKr55MBql7
b7VKj6s4vDpBpB5pnSit1CFzdeCa4422I+XdB0gdIF8t/o7U8lh9H0m1awryd4ea
8xTGNY5r5vGjpOB5YKKE2nU/0PB0SnbFLWb9qaoUHyvFnsTxow7dfeRkohETWVUH
kLvpFLK6hua4ELc4qNeNvhowjNtQdpy9jMXoRiI5h0TR0naOuuAcQCo6T4+rwthm
jpPU0HMk4JctW+IvxVRjyTn42R1JbQ==
=Fcfm
-----END PGP SIGNATURE-----

--etwh2oo4py7wpyd5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
