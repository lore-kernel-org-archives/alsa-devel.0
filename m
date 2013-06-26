From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: sgtl5000: Defer probe in case of
	I2C error
Date: Wed, 26 Jun 2013 09:33:08 +0100
Message-ID: <20130626083308.GL27646@sirena.org.uk>
References: <1372168801-4221-1-git-send-email-fabio.estevam@freescale.com>
 <1372168801-4221-3-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8644199936163829847=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E9742650A4
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 11:32:23 +0200 (CEST)
In-Reply-To: <1372168801-4221-3-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: marex@denx.de, alsa-devel@alsa-project.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8644199936163829847==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GmIAiBEz2jSsbeLA"
Content-Disposition: inline


--GmIAiBEz2jSsbeLA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2013 at 11:00:01AM -0300, Fabio Estevam wrote:
> In case of I2C error, let's defer the probe.
>=20
> On mx28, for example, the first read of the codec revision register fails=
=20
> because there is no codec clock provided at this point. The codec clock w=
ill be=20
> enabled later in the mxs-saif driver, so return -EPROBE_DEFER in case of =
I2C=20
> read error, so that the codec driver can do another attempt at a later st=
age=20
> when the codec clock is available.

This doesn't seem to match up with the code:

>  	ret =3D regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
> -	if (ret)
> +	if (ret) {
> +		ret =3D -EPROBE_DEFER; /* If I2C read failed, try again later */
>  		goto disable_clk;
> =20
> +	}

Looking at the label we jump to here it seems like the clock really
should be enabled at the point where the register read is attempted...

--GmIAiBEz2jSsbeLA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyqdBAAoJELSic+t+oim9hOMQAJ19uSOzkksVPUGymz9TpS/u
R4Boal8Cp0SI3HDSJ0SLPLHbBOi3KHdF0LnSb4hriMrlezv8qBTdJiIev7v5yROw
m4Ah6RyWZ4EBqPK3URn3flfgWxMXPbQ+PPoh3fbsH0p7OcZpAjuoePiTrqo8zEoP
iVvbfMLItl45NHdlw7aUjFsfT1DKxZS/Ay0lTC2rhU9CIYye/wpR5oePkggGHi0h
vgS3AC0/fHgfe0FUlC3BeliHrDH092Vydn0Sq2joMsXdOlyyh+QB7z2SXBL8pKg9
m4o2A7LSwCM1UgxLaQINrER1H8PATGQYLlWDLX352cuAAUMiBqucZ8piR+E62Al6
+yIWlFl0arl8zOZDzZnIOQmQSuR+jWGtglON7VH/yAu0wv5KkXw07s47LA28eL+W
/1f5WZV7gFy2BVg8LqNpVUdJlX66DT/Bih4oGW/qM1MpiYahC5KlG0NW9OEvQjCC
2VIMTD49kR5ww0xpjcQ+VKVVXyF0nYhUE+jiWfrqrKY4ydbdFjf4v/0Dt59ioXW4
hppAg7nYWXa+LaognxDrblOCuSssH3k7b5ZPCr2XlDzQjbqpYF4yOcDLFVOMFVA9
zZNntutj/2c0d21YwXO8iGCVHlORzfTc07+KkyDtmkKARk/WwhxtRF+b7pfwSovc
BgFxjPzt+HV9+sBrr/e/
=eRIG
-----END PGP SIGNATURE-----

--GmIAiBEz2jSsbeLA--

--===============8644199936163829847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8644199936163829847==--
