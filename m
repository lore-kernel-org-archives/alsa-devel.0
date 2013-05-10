From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/2] ASoC: sgtl5000: Fix driver probe
	after reset
Date: Fri, 10 May 2013 10:16:58 +0100
Message-ID: <20130510091658.GK3200@sirena.org.uk>
References: <1368144947-23775-1-git-send-email-festevam@gmail.com>
 <1368144947-23775-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8552522285331855332=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EEDB2610D6
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 11:17:42 +0200 (CEST)
In-Reply-To: <1368144947-23775-2-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============8552522285331855332==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aqWxf8ydqYKP8htK"
Content-Disposition: inline


--aqWxf8ydqYKP8htK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2013 at 09:15:47PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> After a 'reboot' command in Linux or after pressing the system's reset bu=
tton
> the sgtl5000 driver fails to probe:

Looks good, can everyone confirm that this fixes the reset issues please?

--aqWxf8ydqYKP8htK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjLsGAAoJELSic+t+oim9+zcQAJv2EeTUdT0SbcqM1YL5qH9c
BtGh2B0fR7WXQ+U7spR/vCVNMPVV8s242NOvCZjJpsedokiZkOkvqZBmgMUa7CUx
QOz8FyOafU7xv7XXK2RO57eDCHAHbtULvpp48f0fjc19CCLIdidB3x0sQzg8BhwM
RJKlfbrmDykAJaq+CrP0mc7EmgB3Fja0wOZxJiwyGDzg9gHDzePYxKlgeD7iai+1
qHnxXinAWak1v1a5iyOfyCyxNiTcVSkX9rYq2ZE9h1enVqLFEqaiqqs/28LmTza6
WOir6xYJDyFceuS+Q/pw06KzBa5PccOrT/uzsrKfxyDmVUEe/2jYUNBUk1rmd7Iz
3eBsKWVvbjwvFnCHYbHJyg/0rshERWnIs4jNJntm2cf6tEG17mA4dIc0Vme5p73b
yAAkFuVqunupxsekwhRTAyn8fqLylPnJ6D2v+Dbvhsp6uZdLzVhUxGM1+WlRSe7F
drHNzOD9BPBYPgVLCp1hcZpvPTSihYn0yOKJuHuQr14ifG/i3Zu1vrVGpQA38kLY
fR33sejZWgFK3AHIYZG6my5Q/jtyOIv/77/yAtrJml5Yrq8HVZQRWG54CHqiZtPC
ktOtislb9jKskOtGrr2i3LtP3tmY55yKwruWG5fDBBs8ZU22z3LdEcVsA60gLWsW
UwcZkBv8WnLskVJBU8CS
=XmIA
-----END PGP SIGNATURE-----

--aqWxf8ydqYKP8htK--

--===============8552522285331855332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8552522285331855332==--
