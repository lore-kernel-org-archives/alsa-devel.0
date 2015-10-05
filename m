From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: da7213: Add DT support to codec driver
Date: Mon, 5 Oct 2015 16:55:43 +0100
Message-ID: <20151005155543.GY12635@sirena.org.uk>
References: <cover.1444042230.git.Adam.Thomson.Opensource@diasemi.com>
 <8b10191f4e14b32f831d32c66c7edebd861b70ac.1444042230.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TrSyUYpaPvvX07X2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8b10191f4e14b32f831d32c66c7edebd861b70ac.1444042230.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--TrSyUYpaPvvX07X2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2015 at 04:40:18PM +0100, Adam Thomson wrote:

> This patch adds support for DT bindings in the codec driver.
> As part of this support, the mclk data can now be provided and
> used to control the mclk during codec operation.

Please split out the new MCLK configuration into a separate patch which
describes what that configuration is, it's much easier to review that
way.  Otherwise there's a couple of minor issues here but nothing too
critical.

>  	case SND_SOC_BIAS_STANDBY:
>  		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
> +			/* MCLK */
> +			clk_prepare_enable(da7213->mclk);
> +

This doesn't check the return value.

>  	.driver = {
>  		.name = "da7213",
> +		.of_match_table = da7213_of_match,

Please use of_match_ptr() here.

--TrSyUYpaPvvX07X2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEp17AAoJECTWi3JdVIfQzekH/RfMew2zcn2SOlEXmB6NFgDH
5DXcdrGPttjG92cTWzS2czA9Q523Vyqq+GKR0WG/x720w832fF17y8b6jCyhsoN9
mg3Run+44NwNvhD6RRI9O4OlB9p0KIK4l71wVIbxoijjESXOLck5tFPwjSs6BV4G
UKWmtCIz94s3qzhR1M4F0gU8MTSMDVQ0oK/EDNiBuhaiQL6ZXXDR2Mg3fnoxJu0v
XJ8An7F3/HTGrmpdXfcfmz10RIumS/WomZK8ubQGEThHu1NFxhD0x0ebYaDA7MTr
n9skQFzWatRRH7rOQpiIXllYRld2xLPGy08KWWD6G7tsymUt6ycjfaVS9EE9OSw=
=WuPO
-----END PGP SIGNATURE-----

--TrSyUYpaPvvX07X2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
