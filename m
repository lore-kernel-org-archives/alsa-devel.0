From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5 v4] ASoC: soc-core: call
 soc_cleanup_card_debugfs() from snd_soc_unregister_card()
Date: Sun, 22 Mar 2015 18:33:47 +0000
Message-ID: <20150322183347.GD6643@sirena.org.uk>
References: <874mqq5slj.wl%kuninori.morimoto.gx@renesas.com>
 <87zj8i4dz4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1798493733237951162=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EA8726163C
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 06:02:19 +0100 (CET)
In-Reply-To: <87zj8i4dz4.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1798493733237951162==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HsYKTmaHn9HHfM39"
Content-Disposition: inline


--HsYKTmaHn9HHfM39
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2015 at 04:43:40AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> soc_cleanup_card_debugfs() is called from soc_cleanup_card_resources(),
> but, card debugfs is called from snd_soc_register_card().
> cleanup function should be called paired function.

This makes sense but there seems to be a dependency on one of the
earlier patches in the series.

--HsYKTmaHn9HHfM39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwsKAAoJECTWi3JdVIfQcrwH/i9Ie1HPXUoZHDWOqcxTvn0d
vtu14L1zdbu/Z69G/zFq5aO4uMHEOIDF8jtV7xtb8z4sOr6uGnfu5XLOog/kWlHF
C+K1FCMWdShSG+1eV9IVvpUGk+OtU/J3uO9NCaN4S/rHPdLtn8FJ6pPR4+gcjRVO
BYIe/FUZT9l4NemRa7qjowT/CBJtx/5/rzNhrQuD1Gia/UNLVAZVNw9o24Zg5jpZ
vAb9VuWDVn/8ZUpApHUDEWoP5fIajkHUPSZVTWf1Nr0aPsz0S+/0Gu/UNssLa4VT
2GP4wUuE6nDh80nCb7DJrow2nIo32GQyhieerUh4TtfGPXs7BK9oERT4Kla+CV0=
=HSRb
-----END PGP SIGNATURE-----

--HsYKTmaHn9HHfM39--

--===============1798493733237951162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1798493733237951162==--
