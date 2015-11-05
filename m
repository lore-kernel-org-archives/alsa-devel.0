From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add da7218 codec driver
Date: Thu, 5 Nov 2015 15:27:36 +0000
Message-ID: <20151105152736.GO18409@sirena.org.uk>
References: <cover.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <01a9b6e96b66327cf9a27781c13aa50545380acb.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2/+Vq7w28QOSGzSM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <01a9b6e96b66327cf9a27781c13aa50545380acb.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--2/+Vq7w28QOSGzSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2015 at 10:43:19AM +0000, Adam Thomson wrote:

> +/* ALC */
> +static void da7218_alc_calib(struct snd_soc_codec *codec)
> +{
> +	struct da7218_priv *da7218 =3D snd_soc_codec_get_drvdata(codec);
> +	u8 calib_ctrl;
> +	int i =3D 0;
> +	bool calibrated =3D false;
> +
> +	/* Bypass cache so it saves current settings */
> +	regcache_cache_bypass(da7218->regmap, true);

What ensures that nothing else is running at the same time this is? =20

> +static int da7218_mic_lvl_det_sw_put(struct snd_kcontrol *kcontrol,
> +				     struct snd_ctl_elem_value *ucontrol)
> +{

Why is this a user visible control?

> +	/* Default all mixers off */
> +	snd_soc_write(codec, DA7218_DROUTING_OUTDAI_1L, 0);
> +	snd_soc_write(codec, DA7218_DROUTING_OUTDAI_1R, 0);
> +	snd_soc_write(codec, DA7218_DROUTING_OUTDAI_2L, 0);
> +	snd_soc_write(codec, DA7218_DROUTING_OUTDAI_2R, 0);
> +	snd_soc_write(codec, DA7218_DROUTING_OUTFILT_1L, 0);
> +	snd_soc_write(codec, DA7218_DROUTING_OUTFILT_1R, 0);
> +	snd_soc_write(codec, DA7218_DROUTING_ST_OUTFILT_1L, 0);
> +	snd_soc_write(codec, DA7218_DROUTING_ST_OUTFILT_1R, 0);

We generally just use the device defaults, why change them?

--2/+Vq7w28QOSGzSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO3VnAAoJECTWi3JdVIfQOoIH/3WmoI/XdUvAlul5oKTGsLf1
kE2Ms8ZIDfm3SgVXqi35qdMWfn16wXNE1tBGpbwqBdI53LtKVMwaTUc+upuhXOm7
tuJCndsPIdBREvSMgpmplELfpB3ffUA3uIMHCJS+/u8Yzogy3wN0tGGF8eGajN/t
9TeVWVedW1i0x8w4kCt2UBjpNzcMP/87Gb20hjL8IdG9bJ/IDlNgE4vUhDU28utI
XkdpZp++WaJAvsvx2HbGsXbWX+pwSvXI74srMxKFRfVBVDAnP5JKErtkWceZ/n0R
FIsd2LJJ4chk6RXbfT5VTsPH5RmL9SBVWT9FdeXyvo2OZKTOYFzCV7LSmeW1aAw=
=FMP8
-----END PGP SIGNATURE-----

--2/+Vq7w28QOSGzSM--
