From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sun4i-codec: Distinguish sun4i from sun7i
Date: Tue, 6 Sep 2016 11:28:14 +0100
Message-ID: <20160906102814.GG3950@sirena.org.uk>
References: <20160905192404.13871-1-dannym@scratchpost.org>
 <20160905192404.13871-2-dannym@scratchpost.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A1+ljxmNgwU2bK8G"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160905192404.13871-2-dannym@scratchpost.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Danny Milosavljevic <dannym@scratchpost.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-sunxi@googlegroups.com
List-Id: alsa-devel@alsa-project.org


--A1+ljxmNgwU2bK8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 05, 2016 at 09:24:04PM +0200, Danny Milosavljevic wrote:

> -static const struct snd_kcontrol_new sun4i_codec_widgets[] = {
> -	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
> -		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
> -		       sun4i_codec_pa_volume_scale),
> +#define SUN4I_COMMON_CODEC_CONTROLS \
> +	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,\
> +		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,\
> +		       sun4i_codec_pa_volume_scale)
> +
> +static const struct snd_kcontrol_new sun4i_codec_controls[] = {
> +	SUN4I_COMMON_CODEC_CONTROLS,
> +};

No, please don't do this - macros like this just make the code harder to
work with.  Do what everything else that handles multiple devices in one
driver does and have several different tables of controls, registering
the ones that are appropriate for the current device at runtime.

--A1+ljxmNgwU2bK8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXzpo9AAoJECTWi3JdVIfQ8Y4H/1eJac+deW70yGXvlRnXR47T
hrzSJZEKdAWzgb9YCJ5FD27cR9XGrbZZTo4iE+cvy73vko3JdDbEznz/48Q9InrS
zErePk5dLSSmZg8Ibg7LfljXkG1TJ5DCOu21oYf1g3Yir86p98i7vRl15MZwJwh8
1fJs60cnYn/G2yttxeg8FHhFWTPWYLYqh1WPdTT2EoG9WEskSwBif1hSoT4j31s6
tENaNVJ3Jsi7AnvECFEbmC0jRSPlNpf0tsnukpG5UDlTHPj+KIpCYbt5Vb+cvCZj
YkeCKbPuJ/0r/e7/orf/E6UXDaN9JieuYcAS9vpuaYa+ir0Kk9G7GyB5PqFFWkc=
=U/KG
-----END PGP SIGNATURE-----

--A1+ljxmNgwU2bK8G--
