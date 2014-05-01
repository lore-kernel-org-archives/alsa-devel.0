From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm8985: Use
	devm_regulator_bulk_get()
Date: Wed, 30 Apr 2014 20:36:23 -0700
Message-ID: <20140501033623.GT3245@sirena.org.uk>
References: <1398862240-4432-1-git-send-email-festevam@gmail.com>
 <1398862240-4432-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8928066377643707247=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32B082652B7
 for <alsa-devel@alsa-project.org>; Thu,  1 May 2014 05:36:37 +0200 (CEST)
In-Reply-To: <1398862240-4432-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8928066377643707247==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80Ds8Z/hZmemMosa"
Content-Disposition: inline


--80Ds8Z/hZmemMosa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2014 at 09:50:40AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Using devm_regulator_bulk_get() can make the code cleaner and smaller as =
we
> do not need to call regulator_bulk_free() in the error and remove paths.

Applied, thanks.  Please remember to CC maintainers on patches.

--80Ds8Z/hZmemMosa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYcE0AAoJELSic+t+oim9JXEP/0qdTOhMFyFPItojQ4gIOQRs
Eo/NrAAruhcT+nBVG7pfJMVEjONadXo1AdRhAemYvlYNjn6DoTRjGRVS65EBsgbL
PNkWQB5HfQ08xArBAsb5MXogWIyJmAJ4lMUzYMtsDigMCVg7KzowaSOxETxR8rpr
GI0fm/guaXNyB6wwRWD9eWS6PD+s5SKuHyHKg3fnUABp64bI2X6zdn7vHHEa99RI
2is0YIF/VTKLzpcujYH8hJJl+z3lbddMVCqLGhz1mIBZMt7dMvp34O3/vI9ueFBz
fEGU7GK/iSl2LhscKELxug9KxgUNXmivHwMhJodI1UpmIEPcC0gs9Y45gw0rZ26w
mXCX/n8xfWFOPoSQSXRfbeZOoUoot2tMJI9Rt+QlywNWYvC7utUz0jZ1hgkRWi7t
Tz+Bzx9pV2zXZdAc2exkzIgNYG3sssZKCgvM9mP5n93uXNktj9o09yRcs9rCygXE
Rk5SNVumSzt3qfZREKMduhPbGBAEifF7+duhxyYJ7pn5vT8oLCATE4+IhCYEiekQ
aoQ2jtKIOdL6e4QUf1JHHx0ITs4NDQ28kLpD6hQnvQf+1OFe+KcmK4aN4AINsulk
YWM+FkTdizJtZ/6xKnPIUzlj4SW5cCUgd8GvHE7ma2OWVTLKlk6p9cYO0DiS4T1N
J1Cm44oBS+AZRt20W/a4
=GgFN
-----END PGP SIGNATURE-----

--80Ds8Z/hZmemMosa--

--===============8928066377643707247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8928066377643707247==--
