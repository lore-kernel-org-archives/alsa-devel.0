From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] SoC: sta32x: use devm_gpiod_get_optional
 for optional reset gpio
Date: Wed, 20 May 2015 19:08:36 +0100
Message-ID: <20150520180836.GL21577@sirena.org.uk>
References: <1432018467-5497-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1165960914131284312=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3508F265474
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2015 20:08:53 +0200 (CEST)
In-Reply-To: <1432018467-5497-1-git-send-email-u.kleine-koenig@pengutronix.de>
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
Cc: kernel@pengutronix.de, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
List-Id: alsa-devel@alsa-project.org


--===============1165960914131284312==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5VuzLDXibKSJvVYD"
Content-Disposition: inline


--5VuzLDXibKSJvVYD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2015 at 08:54:27AM +0200, Uwe Kleine-K=F6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> parameter that allows to specify direction and initial value for output.

Applied, thanks.  Please use subject liens reflecting the style for the
subsystem.

--5VuzLDXibKSJvVYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXM2jAAoJECTWi3JdVIfQvuoH/j0854EkhqemcuConSZUYL/q
h8YjqbpUh4nFBEkzP/CKmHoLw6mWq5V/gpK0Kos/0jDkncngbXwn73jlRqbbNCTf
wWp1hYE2JkSFlT9LybuWlFOHq8uFqTl9DbXiW/UNwhPDIVQgPhqdkrqMolCZrnGT
gWelhiAHwW281grBaPS7Kg4OX3U30xw+JNoAaVCMnq0H3BJ3sL5Mka7Q6M4VEltP
xj6JlgfOozI39v0HRreGYckb+AeMJDUhy82ehFTunhjNxBhaMD3BWHAXTjW0OBpW
/i2ZvMwHFB0Nt/5nFdR9U0MGHxuQ0mZ9dny8TkiOnPu6MjpUL8AaVuuGtJ49Q5A=
=hZI5
-----END PGP SIGNATURE-----

--5VuzLDXibKSJvVYD--

--===============1165960914131284312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1165960914131284312==--
