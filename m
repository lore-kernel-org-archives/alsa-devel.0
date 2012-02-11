From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 02/12] ASoC: alc5632: Fixed voice DAC
	volume step.
Date: Sat, 11 Feb 2012 22:56:30 +0000
Message-ID: <20120211225629.GB3745@opensource.wolfsonmicro.com>
References: <1328995598-8788-1-git-send-email-leon@leon.nu>
	<1328995598-8788-3-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2355632612364815875=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D8B25103A09
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 23:56:31 +0100 (CET)
In-Reply-To: <1328995598-8788-3-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============2355632612364815875==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 11, 2012 at 11:26:28PM +0200, Leon Romanovsky wrote:
> From: Andrey Danin <danindrey@mail.ru>
>=20
> Remove extra zero from volume step in DECLARE_TLV_DB_SCALE macro.
>=20
> Signed-off-by: Andrey Danin <danindrey@mail.ru>
> Signed-off-by: Leon Romanovsky <leon@leon.nu>

Applied, thanks.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNvIXAAoJEBus8iNuMP3dKooQAJ6DV4/mH2L0HneN7OdfpUKM
fJmGPopvd0Xc9OsepfK5sRaqBWbxLzjbl72t22Elzdgjf//ZllkqRZwf0BWQufGJ
l3PgPjTp2zEOGjtFhpmlgKPUMScF1C+LWQQqXQIMHjZbesYOZd80DIXxQ32NzZbG
troDEdsTlKss5rj1F777kZayCXm4U+4DDUrm4R+YLJzfQjs+whcMkG+UmNnrVKfC
uL8+RHG121ledOlbg3GQTS2jsr4PJUvT84k1nfs++dH3CyQ2HrOCOIZHoz0udWV6
S6ucgTKBN/bSfAdmMrg8U/Y8nabyA7tWCBQx1ApKbKjEH+hzHzx6D5nL+ccea+61
ygg4Bk4mh3abS40kcsV7dK7kjpaZCXCpvBr2g3uVEYvEoa360jPNZhieUgFVwOpD
APiAJL++6adDu4wKqQ71Ojz6mbHoTgRjSb+6UTAeY/xkxnjPvx4Z0cQhT30QWUg7
5Zl+iUwYStRYxdm7jBxi9bG2LBG19ICy+t4yZt2cb8W6UBNMLCIu1DBBENMuf6fL
4tmlHWMW0yllj2q8UcoVu6BgJN3QmzYdFVsAHUZdWXRr1Dc+/trlX0nemqAvI2xK
az8Mvr95WjGpBuW7aAYXvfpD6vTA1izaVe9n/Ph21X7EQ24PYDgtfXBMtvKgBpxx
7qBTZrZ/kO3XwVKVy83c
=g4SF
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

--===============2355632612364815875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2355632612364815875==--
