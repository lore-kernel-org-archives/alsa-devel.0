From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98926 codec driver
Date: Tue, 8 Dec 2015 19:10:31 +0000
Message-ID: <20151208191031.GZ5727@sirena.org.uk>
References: <1448994679-7387-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7683189181080837547=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FCFC2604D1
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:10:36 +0100 (CET)
In-Reply-To: <1448994679-7387-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7683189181080837547==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fzZAfzrt3Jhvp+ma"
Content-Disposition: inline


--fzZAfzrt3Jhvp+ma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 01, 2015 at 10:31:19AM -0800, anish kumar wrote:

> Changes since v1:
> Made some widgets as supply widgets
> Changed the names a bit
> Moved some registers to volatile struct
> Some coding style changes
> added the print for diagnostics
>=20
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---

Please use the patch submission format covered in SubmittingPatches -
the inter-version changelog should be after the --- so it doesn't end up
in the final changelog.

>  	select SND_SOC_AK4641 if I2C
>  	select SND_SOC_AK4642 if I2C
> +	select SND_SOC_MAX98926 if I2C
>  	select SND_SOC_AK4671 if I2C
>  	select SND_SOC_AK5386
>  	select SND_SOC_ALC5623 if I2C

Please keep the Kconfig and Makefile sorted.

> +static const struct snd_kcontrol_new max98926_mixer_controls[] =3D {
> +	SOC_DAPM_SINGLE("PCM", MAX98926_SPK_AMP,
> +		MAX98926_INSELECT_MODE_SHIFT, 0, 0),
> +	SOC_DAPM_SINGLE("PDM", MAX98926_SPK_AMP,
> +		MAX98926_INSELECT_MODE_SHIFT, 1, 0),
> +};

On/off switches should have names ending in " Single".

> +	SOC_DAPM_SINGLE("LeftRightDiv2", MAX98926_GAIN,
> +		MAX98926_DAC_IN_SEL_SHIFT, 3, 0),

Please give this a more human readable name, something like "(Left +
Right) / 2 Switch".

> +static int max98926_probe(struct snd_soc_codec *codec)
> +{
> +	struct max98926_priv *max98926 =3D snd_soc_codec_get_drvdata(codec);
> +
> +	max98926->codec =3D codec;
> +	codec->control_data =3D max98926->regmap;
> +	regmap_write(max98926->regmap, MAX98926_GLOBAL_ENABLE, 0x00);
> +	regmap_write(max98926->regmap, MAX98926_TDM_SLOT_SELECT, 0xC8);
> +	regmap_write(max98926->regmap, MAX98926_DOUT_HIZ_CFG1, 0xFF);
> +	regmap_write(max98926->regmap, MAX98926_DOUT_HIZ_CFG2, 0xFF);
> +	regmap_write(max98926->regmap, MAX98926_DOUT_HIZ_CFG3, 0xFF);
> +	regmap_write(max98926->regmap, MAX98926_DOUT_HIZ_CFG4, 0xF0);
> +	regmap_write(max98926->regmap, MAX98926_FILTERS, 0xD8);
> +	regmap_write(max98926->regmap, MAX98926_ALC_CONFIGURATION, 0xF8);
> +	regmap_write(max98926->regmap, MAX98926_CONFIGURATION, 0xF0);

Lots of random magic numbers - what's going on here?

> +	/* Disable ALC muting */
> +	regmap_write(max98926->regmap, MAX98926_BOOST_LIMITER, 0xF8);

Shouldn't this be a control?

> +	ret =3D snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98926,
> +			max98926_dai, ARRAY_SIZE(max98926_dai));
> +	if (ret < 0)
> +		dev_err(&i2c->dev,
> +				"Failed to register codec: %d\n", ret);
> +	ret =3D regmap_read(max98926->regmap,
> +			MAX98926_VERSION, &reg);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to read: %x\n", reg);
> +		return -EINVAL;
> +	}
> +	dev_info(&i2c->dev, "device version: %x\n", reg);

It's more normal to read the device ID information before doing anything
else - part of what we're doing is working out if we've got working
register access to the device, if that fails then there's no point in
registering.  Please also pass back error codes rather than substituting
new codes unless there's a strong reason.

--fzZAfzrt3Jhvp+ma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWZysnAAoJECTWi3JdVIfQUA4H/1oFtt1wxjcKH67WPE8DcbnJ
EqkBgJPAusye6gf4laSMdnDOfS1BJLRsnKtpD95TDNN6Xl6I0NKKSAC6dAVkUsMy
zX1qXzrneVKXGc2F6L6rS6LQp2QluC9Decsh0lfAvJMOhzvF6xGDOZ0PTBACCWCx
Y0T/kMVhmMbz/YZfuvOi8nDh/l4vJnBHToYA9JD4hlioO942c5G3FQ6WHyy9E5kT
uQYeDDcl0qs6StvpixGkaQ2YuKfyrLKab1xTzxO3iROmtmc6T4VUGZzKewmGya3W
N9dYUZIMUDBJaVh7y39qb12B2VJO+0uNjcufYdBaDn3HOCHoIwZlz2k1vzDPHI4=
=0tEg
-----END PGP SIGNATURE-----

--fzZAfzrt3Jhvp+ma--

--===============7683189181080837547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7683189181080837547==--
