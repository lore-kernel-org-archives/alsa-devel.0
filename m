From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 v2] ALSA: ASoC: Add reset-gpio DT
 property to cs4270 driver
Date: Wed, 25 Jul 2012 14:18:16 +0100
Message-ID: <20120725131816.GN3099@opensource.wolfsonmicro.com>
References: <500F8E48.9000007@gmail.com>
 <1343199809-11936-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7544374241276641852=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59BBF26532C
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 15:18:15 +0200 (CEST)
In-Reply-To: <1343199809-11936-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============7544374241276641852==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qi3SIpffvxS/TM8d"
Content-Disposition: inline


--qi3SIpffvxS/TM8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2012 at 09:03:29AM +0200, Daniel Mack wrote:
> In the process of moving over from static board files to the device
> tree, reset pins of peripheral reset pins should be handled by their
> corresponding drivers.
>=20
> Add a reset-gpio DT property to the cs4270 driver, and de-assert it
> before probing the chip. The logic could be augmented some day to
> re-assert it when codec is put to suspend.

I'm missing 1/2...  Please also don't bury patches in the middle of
previous threads.

> +		enum of_gpio_flags flags;
> +		int gpio =3D of_get_named_gpio_flags(np, "reset-gpio", 0, &flags);
> +
> +		if (gpio_is_valid(gpio))
> +			devm_gpio_request_one(&i2c_client->dev, gpio,
> +				     flags & OF_GPIO_ACTIVE_LOW ?
> +					GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
> +				     "cs4270 reset");

This ignores the return code and won't work well with probe deferral, if
we manage to get a GPIO from the DT then we should fail if we're unable
request it.  Passing back the return code should get you deferral
support for free in 3.6 and onwards.

--qi3SIpffvxS/TM8d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQD/IRAAoJEBus8iNuMP3dE9QP/1cym0gZ6xycGekQS2ZVQQI5
1IgZmABMCefqecyNUtOtU1Iv8g4Oiq5Idz8gjL7pQL4Br/vySIAVsdCIcgrO3SdG
l46jkWj2zGUFjE5YG+MU9esBGx5ClO1Xdku2jfcuMYsMUsaMcSluZcko8iJPOJA/
ROXzTvU0HntRRH3w42L6wgvpPI8zuaG69bF70r8zq0vF3bcPs+aa71rCmNbGVdYE
+xyXBVbnpIcXw0QUGxvqMhh8D4qKEYjvWApmIxLdJpIdH34ST4IcmsQRiOUOO464
9iLgSawEOFP4Nyv8G9XtWO+YvKKz4KNXDSakkPRGMIHwT8JYsZBGtjKYF/HQBMlT
JW7dgjxT5xBlrFyLF0ugO2bbPH+SPXWPHfpbAGMf03Ja5S/a6n9+wFHd7mJCCdVe
33un0Bd2vYfvcxA0727HylCjRnmcJoNxwK65MERwzpm2mWPct1tYOnBfZv2U/knp
z77tc+ENj2TRHyZyB1jA6x9wG6WKyMlJyiOfu7fXKx1P9jbQi7GvraNyF0s7XTJJ
Gj0hsDTulUyFEl0a7/F6JSSk/FaO6Ru9WloIVRylotUw7Bxj9oU8HUXsU18RWRsE
Aga9qPmkqpYr9z1GxeSifPnElD0yPfUSjuCb1sFCj+jtgu+WpvkQAx4bAOY0YukI
0f17ENJe4/HkbFq3EZfI
=qGy3
-----END PGP SIGNATURE-----

--qi3SIpffvxS/TM8d--

--===============7544374241276641852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7544374241276641852==--
