From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Fix card RTD count for
	deferred probe.
Date: Tue, 17 Apr 2012 18:09:23 +0100
Message-ID: <20120417170922.GU6652@opensource.wolfsonmicro.com>
References: <1334682011-29411-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0743497676110939052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1ACBD10438F
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 19:09:26 +0200 (CEST)
In-Reply-To: <1334682011-29411-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0743497676110939052==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A+KtNVtgI4x4SWvL"
Content-Disposition: inline


--A+KtNVtgI4x4SWvL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 06:00:11PM +0100, Liam Girdwood wrote:
> Currently we increment the number of RTD's per card during the DAI link
> bind. This can cause an incorrect RTD count when we cannot find a compone=
nt
> and defer the probe (and hence perform the DAI link bind for the card aga=
in).
>=20
> Fix the count so that it is cleared before every card registration
> and bind attempt.

Hrm, I wonder why this ever worked even with the home grown retry
code...  anyway, I'll apply.

--A+KtNVtgI4x4SWvL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjaLIAAoJEBus8iNuMP3dFO4P/jywqBQDdrdGkskfQ68Bt3gQ
9ojz3/eeUXZYjHABc2dsrERdPGxG4mjgyLopBUc1/TI6Hc+TZfdFkLUxg+nGIuNF
OeEDa83JCXbrRo74oM6FR5PLj9Tr8XTQRaVUF70WHZvIvOx6Agd+u5VVPH5/OWai
3FXBN9iWiYMxF7nWy1VdGeyUkEGBmzWaSSs6LIs6vqtxowkJEBx/pJh3xfhTqW9L
bp7WUIzsaCYJ9nQgeSeYxx7YwNNLFQJSlsUW+eVrb6kRLkibKe+VSAA0xcNrrzx8
bTlZ9yBXYP959JwXgAEIUQwnA1WugzQS8EuDxhWihm3X02GVBo+VxrpCd8raGk+b
Wz4Auf1qelD0qsdT5t2/8MyFVum/w42gnSI6ScQ3AElxsKe0NSm3tKa7SqXr5GSE
fMhka6gU8Z47SSeJvno6NQwhfZHQCCnLwPx9Gqz9SFIg2LSDZrLtsoVrz+hELxHM
Ke4PQ1Gr5tCPKq1UwTpIJQOwlG4fdU0yXysbtA6JgNgJ3TsOqxxaIiP271H4+DLW
HX2cWH/Vzq883ku4CuxiQDeHrifrKEXp24dIBuc5d0hI3p1B8Du0J9B2doDeBotX
o6T7IUfDnzryQI9E7QWd3P8vFADzBJ/I1P0lxPhqsaNBtnivd2ShSPZpdlj8Gr0m
2kjkWkC8X3Tk6CezpE3n
=hcF0
-----END PGP SIGNATURE-----

--A+KtNVtgI4x4SWvL--

--===============0743497676110939052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0743497676110939052==--
