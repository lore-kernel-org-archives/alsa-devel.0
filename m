From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [patch] ASoC: sun4i-i2s: remove some dead code
Date: Tue, 7 Feb 2017 14:42:15 +0100
Message-ID: <20170207134215.f47cufvs7tngrabk@lukather>
References: <20170207131934.GD28207@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="suhne6lu3x5odlec"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170207131934.GD28207@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--suhne6lu3x5odlec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Tue, Feb 07, 2017 at 04:19:34PM +0300, Dan Carpenter wrote:
> "i2s->rst" is either NULL or a valid pointer.  We won't probe
> successfully if it's an error pointer.  That means these checks can be
> removed.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 3635bbc72cbc..d79be3e4361b 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -723,13 +723,11 @@ static int sun4i_i2s_probe(struct platform_device *=
pdev)
>  		}
>  	}
> =20
> -	if (!IS_ERR(i2s->rst)) {
> -		ret =3D reset_control_deassert(i2s->rst);
> -		if (ret) {
> -			dev_err(&pdev->dev,
> -				"Failed to deassert the reset control\n");
> -			return -EINVAL;
> -		}
> +	ret =3D reset_control_deassert(i2s->rst);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to deassert the reset control\n");
> +		return -EINVAL;

In the case where has_reset is false, rst is NULL and will trigger a
WARN_ON in reset_control_deassert.

The proper fix would be to move it in the previous if block, or to
change the IS_ERR check for a NULL check.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--suhne6lu3x5odlec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYmc6zAAoJEBx+YmzsjxAg2Y4P/0WRUn7PvpNY+c2emXKKdjk7
egFA11FirlpEKwjSDBTOeTGLaNxWPRlefgaQ7NvhBJtTcDrpveoQBMXxYO9sokGp
rSd/rNUDHdC9mVnuEpOSfmy5wqORy3wMm6hbrCHiOzE2RtdezTloG23XIOCmdONq
NP+WQYUPj9SOt1IGf78GeqabVK1Cmz75YMhNKIocgvBjlcTILjKpPs76ylD0pP0T
REMJcf9bXNioxviympEC5nnxSHjvAZ8znys2nKN6xGFO8vVhAZNAenVCyKANca5x
rpC9cnQXHpTc26fZ8N62bEywLx9ic1nUY3EkFXABEmhbS2XxJaGOthshcmLWgnS4
fTg31nsSY5socsv20KaakNrzJESrpnusikpwn9fqyqjY8gqP8L228Zl8aLmSPRdB
N7eXOk7wu206vKquq5XrmBQT/aHcBBzvBhVAnrkQwuLXRWj6EJbMMfSAh1HFvsBu
E/vFm/Lmc9j4pheTILDtfe7bP8/xzzxbvzEqCWT8DDv67L8Hcd6Ml+BNewYCjjLm
KJvf9JE/L9bniRmiegkP5e0pkZiS+eRRIqRadj2afDLKLwjD4kaySRuxwiN18goP
wNkwPbj/Wvwov5GT8y/550iLe44fQrFTAbYWHygf2Z2gqO9m6Ddtvx46nOekXDF3
qOdy0o94NeNR8dbHmEH4
=upaR
-----END PGP SIGNATURE-----

--suhne6lu3x5odlec--
