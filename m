From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ASoC: cs43130: Add support for CS43130 codec
Date: Fri, 1 Sep 2017 11:43:45 +0100
Message-ID: <20170901104345.4syoutjbskq75v55@sirena.org.uk>
References: <a71e2771-fec4-4d15-af95-ec15e010fd0c@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jibxpyh5rz3x7loz"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a71e2771-fec4-4d15-af95-ec15e010fd0c-XU/xxMRwCJnfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--jibxpyh5rz3x7loz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2017 at 11:00:19AM -0500, Li Xu wrote:

This is mostly good, there's a couple of stylistic issues - please send
incremental patches fixing them:

> +	case SND_SOC_DAPM_POST_PMU:
> +		regmap_update_bits(cs43130->regmap, CS43130_DSD_PATH_CTL_1,
> +				   CS43130_MUTE_MASK, 0);
> +		switch (cs43130->dev_id) {
> +		case CS43130_CHIP_ID:
> +		case CS4399_CHIP_ID:
> +			regmap_multi_reg_write(cs43130->regmap, unmute_seq,
> +					       ARRAY_SIZE(unmute_seq));
> +		}

I'd expect to see break statements at the end of each case in a switch -
this is an issue throughout the driver.

> +	if (cs43130->reset_gpio)
> +		gpiod_set_value_cansleep(cs43130->reset_gpio, 0);

The check here isn't needed and isn't done elsewhere in the driver, best
to remove it for consistency.

--jibxpyh5rz3x7loz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmpOeEACgkQJNaLcl1U
h9B+egf+MzL0oEUO+GwsATN8NSrPhEsmNVZ8dkeEe/PcQh7pBU76e4GhXD5f2mSs
u+Db2uEcMZC9L6nbVq4jyqGYgiUVIx8jLFKTMQfRrWBIp6lcrdjIKkLoB809wkwe
oVYCq44jY4baCCNASyEU276l3+oEA2fACl94PHI1RVkfguhsvPCDv8msP4j0E5i6
x1ExnHQBYSP6KB+4X1i/gTNEQjrGGPGpKmLRQ07cBuaNmguXTpHokjt1s2V5qxia
tiRvqNWQ8IKpAfeymcNwDIsCOzu58W1+pJ/TUYnqNzu4hNO9GQKw4Gi02GW5HxsS
0LcUz/xZVnELL86vvaaEIeo6KxNYPQ==
=lEL9
-----END PGP SIGNATURE-----

--jibxpyh5rz3x7loz--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
