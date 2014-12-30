From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 6/6] ASoC: dwc: Add devicetree support for Designware
 I2S
Date: Tue, 30 Dec 2014 16:53:31 +0000
Message-ID: <20141230165331.GM17800@sirena.org.uk>
References: <cover.1419936132.git.Andrew.Jackson@arm.com>
 <8da45b000fb1f9a029b30fcf5abe50941f45e32e.1419936132.git.Andrew.Jackson@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S/ANZfAJ/3KdLSz0"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8da45b000fb1f9a029b30fcf5abe50941f45e32e.1419936132.git.Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Jackson <andrew.jackson-5wv7dgnIgG8@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rajeev Kumar <rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--S/ANZfAJ/3KdLSz0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2014 at 10:55:48AM +0000, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>
>=20
> Allow the driver to be configured through a device tree rather than platf=
orm
> data.

Applied but...

> +#ifdef CONFIG_OF
> +		.of_match_table =3D of_match_ptr(dw_i2s_of_match),
> +#endif

=2E..the whole point of of_match_ptr() is that it avoids the need for the
ifdef, please send a followup removing them.

--S/ANZfAJ/3KdLSz0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUotiLAAoJECTWi3JdVIfQ7+QH/2gSu/zAAUdqmNww5aTycacq
LGHRMLGL7/ZF+3wqamjy7+QHho80LQN5GddzGuQzRTQ3nj1xI36v0N8u1ttvUhEn
m7rhRm7QDT1AYkRo4qb0EyiriA2OjvAc6OttmX/ycJIvoqfhvY6QikjOKBd577Ak
zpnKGtw/PJoKkJcr9a8Z+N/aeOU8zqntJpfYBsiy07tWGHsmLkqvoOJ60wzNNnuD
pu43luelGqPkMpYOfDuJEr2AH6k60wZt9WPWIFlwtYVKK3MdNKUjx6KF9TaBxGgH
vqLTyFr32jxQJOszcIdaYEnlRPcMSLdMiWlKwITrUa49iOaoPKI7i98Z2H71UEk=
=pilP
-----END PGP SIGNATURE-----

--S/ANZfAJ/3KdLSz0--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
