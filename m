From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: wm8804: Use
	devm_regulator_bulk_get()
Date: Fri, 25 Apr 2014 12:24:10 +0100
Message-ID: <20140425112410.GL12304@sirena.org.uk>
References: <1398389226-18569-1-git-send-email-festevam@gmail.com>
 <1398389226-18569-3-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8057802307781897956=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4213C261A34
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 13:24:19 +0200 (CEST)
In-Reply-To: <1398389226-18569-3-git-send-email-festevam@gmail.com>
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


--===============8057802307781897956==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1FASoxBNj+w9tqcF"
Content-Disposition: inline


--1FASoxBNj+w9tqcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2014 at 10:27:05PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Using devm_regulator_bulk_get() can make the code cleaner and smaller as =
we
> do not need to call regulator_bulk_free() in the error and remove paths.

Applied, thanks.

--1FASoxBNj+w9tqcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWkXXAAoJELSic+t+oim9SJUP/0Z4JL4tB4zqwDPontFllXUM
PPxmKdeBJ/OhByAXkFt+EAh1LjXrUj9BY9+OWkel5Uatv9km9dx14OBnJuS0xdaW
Mo1JhOnNPWFrhzxp+3tdodX8okoVlXs8fkuR4+vz7xZ6Qn/fQPRgvuwlpXqlxblk
rVsiwDxNAg/dd/8g/lOOIRRWmEMRcD+THcn2HExK3DUJ95OUdaAlBDxWv0H1P/M7
Enc718xtYclICJwVTp6OeJsvNPYOQkVKzM/qA7w05Vo5fCIDwzimtnCfKzQRuNqc
nZJaAaqJcCcWBoDMYjyTmKuW+K/pfjwlzq0xx/1wrWBTRskK9q+QMfzNyLGUkBmA
c0KUiduDHe8buCjumw3/eBFMLeuQDPG1fnqZlR0udzvL1qSX+LZMktVCGkXdAwCy
AHSqqjGVW/DbfHNzCcaxKQGCHJgXQKfHCpIoUbT4r80+IyI+oJ9ef0ONoXXiWTjX
t7i/H16L3DXfSJb4aqh2VqMABXli7Vdr1rmGa2XYuZ/guRBOZBIOi0nk2B4CA55Y
Hf74vx/6XH1QHmHwihwlDii2obktTusU+Na0AG+f5PKpRVgCSUMJcFVOePaXfApx
DD0g+uk21GIKfQ9J8FnSvyh7oVUSh4EbDOkqpUuQkztKi9jn/XVlsVwbpy6qPZpK
5/TuIfD3edZfmYISoG8X
=53ld
-----END PGP SIGNATURE-----

--1FASoxBNj+w9tqcF--

--===============8057802307781897956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8057802307781897956==--
