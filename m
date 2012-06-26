From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: add AGC, MIC_BIAS
Date: Tue, 26 Jun 2012 14:17:13 +0100
Message-ID: <20120626131712.GT30406@opensource.wolfsonmicro.com>
References: <4FE9B35B.9020002@aksignal.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1586133090845220973=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E6FC2435D
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 15:17:14 +0200 (CEST)
In-Reply-To: <4FE9B35B.9020002@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Prchal =?utf-8?B?SmnFmcOt?= <jiri.prchal@aksignal.cz>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, nsekhar@ti.com, peter.ujfalusi@ti.com, mr.swami.reddy@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1586133090845220973==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qwbT0JTInWqknst"
Content-Disposition: inline


--2qwbT0JTInWqknst
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 03:04:27PM +0200, Prchal Ji=C5=99=C3=AD wrote:

>  	SOC_DOUBLE_R("AGC Switch", LAGC_CTRL_A, RAGC_CTRL_A, 7, 0x01, 0),
> +	SOC_ENUM("Left AGC Target level", aic3x_enum[LAGC_LEV_ENUM]),
> +	SOC_ENUM("Right AGC Target level", aic3x_enum[RAGC_LEV_ENUM]),
> +	SOC_ENUM("Left AGC Attack time", aic3x_enum[LAGC_ATT_ENUM]),
> +	SOC_ENUM("Right AGC Attack time", aic3x_enum[RAGC_ATT_ENUM]),
> +	SOC_ENUM("Left AGC Decay time", aic3x_enum[LAGC_DEC_ENUM]),
> +	SOC_ENUM("Right AGC Decay time", aic3x_enum[RAGC_DEC_ENUM]),

Please move everything out of the big array or if you insist on having
the array then use the indexes in the assignments.  Otherwise the code
is just error prone and hard to read.

> +
> +	SOC_ENUM("Mic Bias", aic3x_enum[MIC_BIAS_ENUM]),

No, this should be platform data or done with a callback from the
machine driver.  It's very unlikely that it's sensible to vary at
runtime without coordination with other driver code.

> +	/* set to avoid artifacts on the audio output during power-on/off */
> +	snd_soc_write(codec, AIC3X_HEADSET_DETECT_CTRL_B, 0x80); /*ac-coupled*/
> +	snd_soc_write(codec, HPOUT_POP_REDUCTION, 0x4e); /* 10 + 4 ms, referenc=
e*/
> +
> +	/* short circuit protection */
> +	snd_soc_write(codec, HPRCOM_CFG, 0x04);
> +

This appears to be unrelated to the change.  What is it for?

>  	/* DAC to Mono Line Out default volume and route to Output mixer */
> -	snd_soc_write(codec, DACL1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
> -	snd_soc_write(codec, DACR1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
> +	/* mix both channels with -6dB level */
> +	snd_soc_write(codec, DACL1_2_MONOLOPM_VOL, (DEFAULT_VOL + 12) | ROUTE_O=
N);
> +	snd_soc_write(codec, DACR1_2_MONOLOPM_VOL, (DEFAULT_VOL + 12) | ROUTE_O=
N);

This is also an unrelated change to the chip defaults (which we were
overriding anyway when we shouldn't be...).  Code like this should just
be removed completely.

> +	/* AGC to -10dB, 20 / 500ms, no clip stepping, noise gate -90dB, hyster=
esis 3dB*/
> +	snd_soc_write(codec, LAGC_CTRL_A, 0x2f);
> +	snd_soc_write(codec, RAGC_CTRL_A, 0x2f);
> +	snd_soc_write(codec, LAGC_CTRL_C, 0xbe);
> +	snd_soc_write(codec, RAGC_CTRL_C, 0xbe);

Again, just use the chip defaults and let the user override.

--2qwbT0JTInWqknst
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6bZSAAoJEBus8iNuMP3dPZAP/RIcWPZ2CY57dBKR9iB2kd7Q
kThYGy3pcYodBY8B1mt+qv2xv3HELBEWn9dvTYHUEymdys5l15BcdOA2sIqzClD3
Yul7TfaSXHh+Ef7oZLqaBQnhHJM2daPPf9qf/bcvVRiRTGd0o1MGnWEX/c7DnYcz
x6PvmAUt32AxN2hAWy0C5tL6+5x/ndX1p2zmyckh5+RqulwtcY6oOXrHfywgaFw4
2oXjQkrto4hTU1pL2/kxfC1STOcKKFGYUZlb7ufa6imv8osMk/UkVlPAi35J4Qv6
58rDDgUfhr+XYYlZO+zqgtVcWkzTWY6dQm9sXINtPhtUJoIEePI9sTF7L100D/S4
oxpnKdJS8sRCiMMZjUZqB90YsKK9mF8bzoPRHNVNbfjzgkEFvhTYUiEOyd19O4qQ
ehZIr9getHrHWazntNqXtxAAgzhmPv6AwzkCSB0juQGOuZwtnOsJxaR/UK9aG02d
xiU7fUsA3c+NHDMNSNWsK/bFQJSozb0CLItrCI41Z18ZpFwaFHXlUJ05+EJx2cWp
Q3/yaG5Y3r3HZYM61dK6A7Ai41XZF3+y/4zHFbyTMOSda0ifDSOpjKQ8BrGv7062
nVUF+N/5itnjqnYYjq0lEP1LydA9OhX7S1ILnVybiLSr7L9UtSzhYu/tfVMeg5YT
5Pg9cck+m+NqzuqP00nd
=PVfb
-----END PGP SIGNATURE-----

--2qwbT0JTInWqknst--

--===============1586133090845220973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1586133090845220973==--
