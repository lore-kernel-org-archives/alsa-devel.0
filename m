From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4] ASoC: tas2552: Support TI TAS2552 Amplifier
Date: Thu, 3 Jul 2014 09:52:50 -0500
Message-ID: <20140703145250.GO5814@saruman.home>
References: <1404398393-21497-1-git-send-email-dmurphy@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IYV9cRr2u6rjcP4B"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404398393-21497-1-git-send-email-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--IYV9cRr2u6rjcP4B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 03, 2014 at 09:39:53AM -0500, Dan Murphy wrote:
> +static int tas2552_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	u8 serial_format;
> +	struct snd_soc_codec *codec =3D dai->codec;
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		serial_format =3D 0x00;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFM:
> +		serial_format =3D TAS2552_WORD_CLK_MASK;
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +		serial_format =3D TAS2552_BIT_CLK_MASK;
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		serial_format =3D (TAS2552_BIT_CLK_MASK | TAS2552_WORD_CLK_MASK);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	pm_runtime_get_sync(codec->dev);
> +
> +	snd_soc_update_bits(codec, TAS2552_SER_CTRL_1,
> +			    (TAS2552_BIT_CLK_MASK | TAS2552_WORD_CLK_MASK),
> +			    serial_format);
> +
> +	pm_runtime_put(codec->dev);

I have a feeling it's better to just put at the end of the function.
Remember your pm_runtime_put() will issue i2c transfers which can take a
looooooong time ;-)

other than that, looks ok to me:

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--IYV9cRr2u6rjcP4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTtW5CAAoJEIaOsuA1yqREyXkQAKh8Dz7Zh8OzSSeVcc2qC0yU
NoIlVsT9SIIJfw0xdepXhF6l0fmVSHCk1zJb1DYj/gd+cvBh0yMbXljlWCDpfNYX
jhWcJEYr1gceiltp9+OOnuoiBwtWQNoU6hsHZYLz91WkQwZLR7nhpJZJPe04kxyz
PkMx6ffB/X/MU0IwRqAzc01qYy77NYX1TQgGcICQEk5XFySmF5zdkGVCnRX/ZZVN
/AYIDOxld9NKYpnMk+TIyufujuXuBih+WZKcZ+KFySfezaGpV8zIU3QErKvD3pKP
uL5ZC+s1mlSyFT9BRBOkSkTCwCxlrP3yiHvnQy1AanaGhQnVlzuIrVIl/azv6CoJ
/R60+ZYIy55lf3ap/KYgNZ4kmNyOtRkOZak5uNahpVTwJ7GTZJsG3j/4TgAJx3zF
EECNtmnTD7k1uywyYHAFU7nyYzL0s9ax5ePv374neP1j4vbUH/fHZWtro8KvVKRs
jY/Bkgd1OfyOACoF5YG/qICQlectiA4L3X7jk9vyKL8vttoNRiB3K6K7CuauEXFc
zuI/iCZLxJXivl1tvJuz7537PjYGLbW2ORNgjW2SMsUvWVqr37c6yYBYHip5JlSg
vH4AeEV5SrHbPqSj2Ba7RB4TgfK4aRE6o4Y5LVSepAXEDUXCOUn2D6YGKzeoqG0r
TgZxMiC1LD9t+NxgIXZS
=BpwA
-----END PGP SIGNATURE-----

--IYV9cRr2u6rjcP4B--
