From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] ASoC: bcm2835-i2s: Fix module autoload for OF platform drivers
Date: Wed, 14 Oct 2015 17:44:46 -0700
Message-ID: <8737xdgdtt.fsf@eliezer.anholt.net>
References: <20150827150401.GA32653@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150827150401.GA32653@goodgumbo.baconseed.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Luis de Bethencourt <luis@debethencourt.com> writes:

> These platform drivers have a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
>
> Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
> ---
>  sound/soc/bcm/bcm2835-i2s.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
> index 03fa1cb..8c435be 100644
> --- a/sound/soc/bcm/bcm2835-i2s.c
> +++ b/sound/soc/bcm/bcm2835-i2s.c
> @@ -862,6 +862,8 @@ static const struct of_device_id bcm2835_i2s_of_match=
[] =3D {
>  	{},
>  };
>=20=20
> +MODULE_DEVICE_TABLE(of, bcm2835_i2s_of_match);
> +
>  static struct platform_driver bcm2835_i2s_driver =3D {
>  	.probe		=3D bcm2835_i2s_probe,
>  	.driver		=3D {
> --=20

It looks like this should go through the asoc tree, but I don't see it
in there.

FWIW, it is also:

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWHvb+AAoJELXWKTbR/J7oiE8QAJw5wc/PvI5gfaLtbA0R0u92
WPecbYXN6gL/JxE3R9JwYnjxIfJx4vS76oYPV0zuZ9MALZBFiZJGTZqBjBRI8gco
T/nDHq+eJGgkgMdgGbNB7FO+V6vAFuSWK0MmDBoCZ/feK30uZrvQ/l07pHKcu5AY
p8rFOBoDTfAR13IyAPAY4YdERgbMvuzCQX8S9qr/1eOZDNtPBiLHlQC2+5YHw2Ae
LfvumM/KVbewAySt2SL5kK/sJuicizEV81+Ufw7Q6P4HwjlfeJss9PQqghXkgn0x
FP7PuqVMKcNsV8JZBSKZ1Qh27giZf0OWtdJFm0JEjYJfKQvUFIcQ99Xc2ZggCvwz
+Y3402U5Ppc3gJKduDk+b5y/Ki1YV6ONUoqj8+UlxTFfcaaENNc1UMiTeQ9BT/PK
znL3vUtsqB4vItMWZELq0OvNUsWGiEJunq/G3aKXFIw4JTPDP2XP6v52GiKu+KFs
9TSmz+O/oiXZBeoZMaxj8sx9nLi458Pxn9EssE9yXqfWAuSSOXZ2IqBpXzuTmYRa
RnOH5maNHrMeSp0SjjSbZRaL8PGoCK792NOQrc6sACKFT6e+DyrMjXpgsMgRXEMA
Z2FXkxRgOsX3s9Sbp5f+VtysjRnQQhSwX3hOdcKrW6wazQG9NuND6NEQBPX8G4T+
o7IEx1GV7XohcCyYRDjT
=4gNE
-----END PGP SIGNATURE-----
--=-=-=--
