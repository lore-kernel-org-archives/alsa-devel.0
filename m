From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch V3 04/10] ASoC: codec: Add MAX98357A codec driver
Date: Fri, 26 Dec 2014 16:44:33 +0000
Message-ID: <20141226164433.GF17800@sirena.org.uk>
References: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
 <1419439330-2303-5-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yl/hcSr02N//2x3j"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419439330-2303-5-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--Yl/hcSr02N//2x3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 24, 2014 at 08:42:04AM -0800, Kenneth Westfield wrote:

> +++ b/sound/soc/codecs/Kconfig
> @@ -69,6 +69,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_MAX98088 if I2C
>  	select SND_SOC_MAX98090 if I2C
>  	select SND_SOC_MAX98095 if I2C
> +	select SND_SOC_MAX98357A if SND_SOC_QCOM

What does this have to do with SND_SOC_QCOM?

>  # Amp
> +snd-soc-max98357a-objs := max98357a.o

Why is this CODEC driver being sorted with the amplifier drivers?

> +static struct platform_driver max98357a_platform_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +		.of_match_table = max98357a_dt_match,

of_match_ptr().

--Yl/hcSr02N//2x3j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUnZBwAAoJECTWi3JdVIfQvIMH/RvrwcFYBrTWu+sGGK7NBJdk
54LKZuKruvdleP3miVaZ0SVjLCnMFioj+C4F9wf4qe5gFCM5bEJPkTv/9kv1bh7n
ZMYwHtkVj0hbt47XaQJ21beUbDHxoMG2t8Uo7zyj+0qZ+hEYRCKl6OwLaqpzDtHg
oNUAuCO4yYYgmE36J5PcuUgFwrqwwlNPQ7F32GC1l0RARwgNdoRlIPKyqbso2y4I
gh8DcRUJFJp+AeuYcYLLRjyRk+tYhjDS9pFckDMlfYZ/q1NNqnSYygrLZ54m5fnT
INa/ncxbAQnuB6VbuyYXKU/U7B6Fbk+4jIH9D1ZUzEMoBtBdODTpFXc6yHbDeHc=
=5nHu
-----END PGP SIGNATURE-----

--Yl/hcSr02N//2x3j--
