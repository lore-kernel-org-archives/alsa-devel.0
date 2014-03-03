From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv3 1/3] ASoC: codec: Simplify ASoC probe code.
Date: Mon, 3 Mar 2014 12:59:52 +0800
Message-ID: <20140303045952.GO2411@sirena.org.uk>
References: <1393814545-15002-1-git-send-email-Li.Xiubo@freescale.com>
 <1393814545-15002-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OoKXXPSaVc/Wpb6N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393814545-15002-2-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: lars@metafoo.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--OoKXXPSaVc/Wpb6N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 03, 2014 at 10:42:22AM +0800, Xiubo Li wrote:

>  static int ak4535_probe(struct snd_soc_codec *codec)
>  {
> -	struct ak4535_priv *ak4535 = snd_soc_codec_get_drvdata(codec);
> -	int ret;
> -
> -	codec->control_data = ak4535->regmap;
> -	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
> -	if (ret < 0) {
> -		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> -		return ret;
> -	}
>  	/* power on device */
>  	ak4535_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

Are you sure that the set_bias_level() call doesn't do anything with
I/O?  Can I suggest sending a patch that just does the drivers that only
do set_cache_io() and nothing else in probe - that would be really quick
and simple to fix.

> -	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
> -	if (ret < 0) {
> -		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> -		return ret;
> -	}
> -
>  	/* Default to using ALC auto offset calibration mode. */
>  	snd_soc_update_bits(codec, DA7213_ALC_CTRL1,
>  			    DA7213_ALC_CALIB_MODE_MAN, 0);

This one will fail.

--OoKXXPSaVc/Wpb6N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFAxFAAoJELSic+t+oim9ShwP/25WVUDYJMeS48C4CJU1/b/+
q86Yd5gDbFqiY7j+bgzH9c87i1UCgbC1BC2dy0fXujEU0/+0Ra5snyHmMQzvjcUM
/T1E0JfFjo6ABKGhNHQU/6AGioZ9AeI9EnvQVpn+BDiSCfAo7S0isDSVcda5K7hh
B/xKvM18/Vy8B8fcGQm3CsZNJrOlvU8Qw9lYuqmD2tNKHZtGdSYDkc+G5HQO4WhW
GzFixRsVsmnq/o3AsbvTPQRhjmPCaPKy8glrMvnmmplmRtdwEOIlKW37sWinKOkt
LZ0qu5dNyG+xjeC7Oq+3cfXL/vF0mEgU6NDf6S5E8wmQDGxBTZMLN0ZDKw3r/bHv
guiZZhwsP1B6eNFKo6XA5A29ihoO47GJ4hJ5c1FZv68b5K4l4/yjub4Nxlo9wFnP
7hsld3LQMaVN4w8YrCD+qnGqJOfjlMdog66Dyd/eqOeOJ2GgxxUk0MyQXRvjmzZE
OsY8U5HmO5hWNEsTsFs9l1uaMRlz4ecowKMdjR2KSxkdv/G10EBrLeOXtKILKDRi
rmEG9QtvGfzOltPb37vpZkqGKepOby5WI+kbZdHApccTQS1eTJXKBSr2moquaQKX
37J0vlf6T3AF8fGKsadyMtWXoU1BDaIiRt/+9WizibjTmeXfsV+tM/ZK0tPJTXWP
NCtq7DctUB2T2sH1qAu7
=Vd71
-----END PGP SIGNATURE-----

--OoKXXPSaVc/Wpb6N--
