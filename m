From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH][RFC] ASoC: simple-card: fixup cpu_dai_name
	clear case
Date: Wed, 3 Sep 2014 13:54:08 +0100
Message-ID: <20140903125408.GL29327@sirena.org.uk>
References: <20140902090005.4a2c80b2@armhf>
 <878um2jncd.wl%kuninori.morimoto.gx@gmail.com>
 <877g1mjn9i.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8032254839440419598=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 941582656C8
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 14:54:17 +0200 (CEST)
In-Reply-To: <877g1mjn9i.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============8032254839440419598==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s6Wo+7iKhEdF4/RK"
Content-Disposition: inline


--s6Wo+7iKhEdF4/RK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2014 at 04:05:30AM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> f687d900d30a61dda38db2a99239f5284a86a309
> (ASoC: simple-card: cpu_dai_name creates confusion when DT case)
> cleared cpu_dai_name for caring fmt_single_name case,
> and

Applied, thanks.

--s6Wo+7iKhEdF4/RK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBw9tAAoJELSic+t+oim9+sQP/1hJrRkhB2HY9VQaSqzQzRzc
cuHapINeu/zxlZQQPKE+gXg0grU+hN5LTx2EWvD+ETg6aXk2BlQVTIQCms/DAoZ1
SGWBmfcV5jXSSUvR76sI2sQTmZIYcJj2eFUq0Gcg18RLI/LZzbjMLr4sZAz0YQpf
M6hLeJMwgnmDPx/X2+eLNu89If3DdiO0CAYp74cJ8uACqa4d/zpNMsiEa5Da4Be0
KE9fEfhgzMFkFcFHBc5sK3wH838B/I92i3bcc3Opg+Ok9mJzU+2mlK3MJG+ss5fY
uMlsuwOsvf4FREuPnvU6OKPsRkVws3fL2wlQjb6Fp2PJ4gLRJ/LD1RNyC2kn75dn
Q6PiI75DOPGwh6pTT/GkV9B2DL9zHhFVHxVzXi36vUiat92kb1kgV1Y0kClX/bpg
DTJTblPXvoT6ndyYCE2aDw5cGKRVDebIeIuTkYDcIMlf2WhqQgOGiyB7rG/0ZEqL
jshbqynd9tQorG8OSJIS4i4DePoOlKh+/nlCZWxq1FEqbzEAKMi2b9fA4DU0IYCS
zSbIAMAqgBCe+vX8VZDmZEOG2merGemjrSjMKlaoFiFNlRZv2wB5SHN4LOFHip1J
GGjouZRUFzpRat/pRMO14mkE8ugpHC8Gc1Bt132ZTWOx7PN2lVQmBkNBoicOy+LG
or8vi3cW74xroFSsqu/s
=JeQd
-----END PGP SIGNATURE-----

--s6Wo+7iKhEdF4/RK--

--===============8032254839440419598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8032254839440419598==--
