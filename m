From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: CS42L51_I2C depends on I2C
Date: Fri, 31 Oct 2014 19:26:13 +0000
Message-ID: <20141031192613.GU18557@sirena.org.uk>
References: <5453CCCF.5090201@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7479044099636186452=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B5BD261295
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 20:26:48 +0100 (CET)
In-Reply-To: <5453CCCF.5090201@infradead.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Brian Austin <brian.austin@cirrus.com>, moderated for non-subscribers <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============7479044099636186452==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vF5oyOIHWRbsqp7A"
Content-Disposition: inline


--vF5oyOIHWRbsqp7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2014 at 10:54:23AM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> Fix build errors when CONFIG_I2C is not enabled by making the
> driver depend on I2C.

Applied, please do try to follow the changelog style for the subsystem.

--vF5oyOIHWRbsqp7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU+JVAAoJECTWi3JdVIfQIU8IAIHJ2ZX2JnJo7AEPCbYUlKQk
BnH0Hjiy7DkCl7RmA2pFSgbB3bEUUbdleXOiAYKj0whlyIPYiSpevp4IP3MPCNar
2t3JelZw27LSTrtDxsYPRgmD3rRWIhSOlNdIyd4F5FeiVf0elEL/Ymo+QuGEqUPC
bPcwlbVSYBWmMFNaJBDXBaPDmpcSDMCv1MAU2MGOOnwMUGQtNdyW4nveA4L0Tr39
GZZLiKuzujHXtwsfzsctBGG3QlYgXDDSnmGwsiJhyufZ/Cmv0w9ChBra9WxSv1l5
a0kfRVhb8TKE3MBu27QaaixDuAZcMGi/Pa8VpeRNipKwCTSbhw2TpHdp/TOvSBk=
=vgNA
-----END PGP SIGNATURE-----

--vF5oyOIHWRbsqp7A--

--===============7479044099636186452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7479044099636186452==--
