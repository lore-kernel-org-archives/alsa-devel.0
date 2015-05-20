From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] SoC: max98357a: use flags argument of
 devm_gpiod_get to set direction
Date: Wed, 20 May 2015 19:08:57 +0100
Message-ID: <20150520180857.GM21577@sirena.org.uk>
References: <1432018689-7124-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0047179041756481735=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C51C5265474
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2015 20:09:05 +0200 (CEST)
In-Reply-To: <1432018689-7124-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============0047179041756481735==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oiL9LJXJsdjS5rzq"
Content-Disposition: inline


--oiL9LJXJsdjS5rzq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2015 at 08:58:09AM +0200, Uwe Kleine-K=F6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> parameter that allows to specify direction and initial value for output.

Applied, thanks.  Please use subject lines reflecting the style for the
subsystem.

--oiL9LJXJsdjS5rzq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXM24AAoJECTWi3JdVIfQXa8H/2IzIii63nw/q9pizYz67cfH
iMhTjc8zGGcZMtYPo+9bI0Rsfbfope5Rw1nx0qUkjRwD1j/hoLPk5Frj27F+1nbX
AC5MhiNGFJyJDu4tCS5uGw27sAm/3sjYQyg9n0wmqhQmvKe0TGUmjy5Y9jrls2ZZ
WwVksiBIil0hBmJydNgKfY//tD5luXU5xE8FnWz0hN2KPxHkdjYzzwboEGBXlANf
BV8irdDf9+X3+VH3rW2amYwqR2K5gEGosiiUw98n0uWWGzSMf9uZMTPt2rveEGoR
JVFofHolf3Nq/mtxj5kh/Yo0VWo9xo8LWqhI4rr3mZ0F1OMsOX8X/zxIsQgaeGE=
=RBoY
-----END PGP SIGNATURE-----

--oiL9LJXJsdjS5rzq--

--===============0047179041756481735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0047179041756481735==--
