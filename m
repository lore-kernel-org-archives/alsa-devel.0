From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/10] ASoC: sta32x: correct bit shift
 value for IDE register.
Date: Tue, 27 Jan 2015 17:09:35 +0000
Message-ID: <20150127170935.GY21293@sirena.org.uk>
References: <1421881322-27806-1-git-send-email-niederp@physik.uni-kl.de>
 <1421881322-27806-10-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4591585352234682004=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B18C22608ED
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 18:10:03 +0100 (CET)
In-Reply-To: <1421881322-27806-10-git-send-email-niederp@physik.uni-kl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, brandau@gmx.de, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4591585352234682004==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Td0dI20rpRb/lyQ/"
Content-Disposition: inline


--Td0dI20rpRb/lyQ/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2015 at 12:02:01AM +0100, Thomas Niederpr=FCm wrote:
> The IDE bit in the CONFF register is the third bit not the fourth.
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>

This is a bug fix, it should have been sent at the start of the series -
doing this ensures there are no dependencies on feature additions so
fixes can be sent to Linus and stable if required.

--Td0dI20rpRb/lyQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUx8ZOAAoJECTWi3JdVIfQIvUH/A8DQt62aZ9EZ+lPnpgsv/DX
1uG5xSUGB76tM9ceAvA+WvO80C3qnv6/vF9MM1GwOG6bv4b41y6BB7eTXn5WeJfl
A61IPA9qh4+P175bO20P30xUKF9XLYvPfW7um+cgQ4aJbkOBasSpMQUw54Cwwjsk
RuJ1lumOTY9syfh9U7urZO4lOoooN+LZwxX2mTut/e86fm7n9BkIsoELIBWj67pg
621tMDzDPVrF2Xxz5aeauyB2WJncnI6nxF+M2B0FblPMRzNqGwBbNhoXo69Fm2Kx
y12wv+mA1wpXORE/VDDcs2+5f7zJr2Opbc3wK+e5ik++Ri7nxvixNaw3kmDzG0M=
=g1OO
-----END PGP SIGNATURE-----

--Td0dI20rpRb/lyQ/--

--===============4591585352234682004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4591585352234682004==--
