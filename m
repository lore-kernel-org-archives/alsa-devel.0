From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: define playback and capture streams
	in dummy codec
Date: Fri, 12 Apr 2013 11:59:44 +0100
Message-ID: <20130412105943.GU9243@opensource.wolfsonmicro.com>
References: <5167E7C4.7080501@list.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1244427848236387915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66FD326160D
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 12:59:45 +0200 (CEST)
In-Reply-To: <5167E7C4.7080501@list.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@list.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1244427848236387915==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S6lVrJQMb5zD9/0X"
Content-Disposition: inline


--S6lVrJQMb5zD9/0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2013 at 02:53:56PM +0400, Stas Sergeev wrote:
> Hi.
>=20
> This patch adds a playback and capture streams to the dummy codec DAI
> configuration. Most permissive set of sampling rates and formats is used.

The changelog ought to explain why this is required...

> Signed-off-by: Stas Sergeev <stsp@users.sourceforge.net>

Please send patches as documented in SubmittingPatches - even as an
attachment this isn't coming out as plain text for me.

--S6lVrJQMb5zD9/0X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZ+kYAAoJELSic+t+oim9WjkP/1K/RHoXYPmTazMivE8JlZBi
zNvnWmbRiULmZKDvdhilbBJvsLS3QXq0Mdk6onPM4bEeFneiPdJaR2gvxsraMRX2
UqyzR5ohXzZayZkGGib1Z1NSa7dqS37h55qGVwvEcbTse7uUISQjHck1KHIOWutn
JZ6SaLhnj6FEmfp37vrjuiAr3tb6sw/6G6Kbrg6e9e0hCTP5DQbyAvK0zAV/dHQ9
kUbcQBT+Sa1YVlG4NFnHDt59lgrnjaExF3f51yWpKmRoOrM2f7lCenbMl2J8XrY1
9Jc033cuw0aJUgD8pZOg3eeHN2rV/cF8HIDDmep/ycwqfRxtSlr3FiBfyLumiy4q
Q4qmYeGk4OlEwIk+LBQxEKHU1qWKhdaun5dujt4qDH5e+DnXgp+GwWIjyPP92CVu
uE783DEDNA8fB762VO6fRVr54mmWikCSlZlY3ifgd+mhdPhC0u66p/6yeC/nSHnp
OkkwFDL/p/jRh+sasFqxZjGCv4WqiFDQJbsbAUzmyHZgQfUwvQIZIYW6mef9Wo/L
dlo+88waY8gjOwaaT1ZhPThUeR3l28E9mTzT+Pis0qdqPnyXqRCaWVim2mjJcVEj
RQeGep2Qc6RZWITPvFnc3YT+UR3Su7GErbhBCWMYCEEuEO3SZ9Hb/19Fqpf5msxG
J0M3DkpeTQt5Q2ZMezdo
=Zgkj
-----END PGP SIGNATURE-----

--S6lVrJQMb5zD9/0X--

--===============1244427848236387915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1244427848236387915==--
