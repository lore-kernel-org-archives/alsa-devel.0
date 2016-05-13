From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: Add support for HifiBerry DAC
Date: Fri, 13 May 2016 11:54:09 +0100
Message-ID: <20160513105409.GB22038@sirena.org.uk>
References: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org>
 <1463130853-25096-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463130853-25096-3-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 13, 2016 at 09:14:13AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:

> +static int snd_rpi_hifiberry_dac_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	return 0;
> +}

Remove empty functions.  Either they are redundant or you really need to
do something in them.

> +static struct snd_soc_dai_link snd_rpi_hifiberry_dac_dai[] = {
> +{
> +	.name		= "HifiBerry DAC",
> +	.stream_name	= "HifiBerry DAC HiFi",
> +	.cpu_dai_name	= "bcm2708-i2s.0",
> +	.codec_dai_name	= "pcm5102a-hifi",
> +	.platform_name	= "bcm2708-i2s.0",
> +	.codec_name	= "pcm5102a-codec",

I would expect all this to be done with DT references in a DT driver
rather than hard coding static names - look at how simple-card does this.
You could almost use simple-card here but the BCLK ratio requirement is
probably a bit much, I'm not immediately seeing a nice way to specify
the ratio there since it depends on the sample width.

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNbJQAAoJECTWi3JdVIfQhDoH/RpCW7sj6R/+V0JWdsDGc/Da
K6AqQFCfmIxNXeAxzGme96oD2PMY1GcwsQICPtW+OpIx+2basIlMvwLucfJyE4Nr
u3p/3mhyLJsrSsAD6Kz2h9DsOaG3JDZYlN22SrI0hWrFCYTesjyoKDx3jdwEmOCj
4QooioiEEUPLsAtX+3jlKHRdRzc68cs7h294gJRIfCct7G2B7ra7kpBWmKgwevlR
JtM2w8jw9tcJDplU0QGDMMxsiTsHaEqbQPQNphOhTPHLKIfhS9ZRN9z7SothDewG
9wEeRv9g8OOOJjPf5fk1viXBWzgmBnqYIoSVQBI0j1pkwT8lL4IvZrhzMRq3MvI=
=Vx1F
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
