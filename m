From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsi: remove original filter from
	fsi_dma_probe()
Date: Wed, 11 Dec 2013 11:08:36 +0000
Message-ID: <20131211110836.GO11468@sirena.org.uk>
References: <87iouwnge7.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6345614843438914460=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BFCAF261691
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 12:08:42 +0100 (CET)
In-Reply-To: <87iouwnge7.wl%kuninori.morimoto.gx@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============6345614843438914460==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YC8Ek3FeOE8ywfXk"
Content-Disposition: inline


--YC8Ek3FeOE8ywfXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2013 at 08:46:59PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Remove original filter from fsi_dma_probe(),
> and use SH-DMA suitable filter.

Applied, thanks.  Moving over to the standard dmaengine helpers would be
good...

--YC8Ek3FeOE8ywfXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqEewAAoJELSic+t+oim9Bl0P/jIckhqngnXxZJdYTkL9t43Q
uFIQYIm7wy9ztVKJEi3oddTByoh/moWfvUQeNzBt39sgighc59aF+59lyiIYeVJi
Ip8CbLav8EvpS1d6PlVene6AgCYw7D3K7rvMOpbHGMKdDbfcTu/vTKA1CAzRrjJ2
qP8sYarrxIlaIz60M5OtHGkxdELAVyAoI9T9vWhL7HA7OoPWkOYtDQkZeyp4kOVd
/mz6vJ1ymtAUAsnETAOxLZvZEyL90XdYGWxYd+Mdv9YoSUhdfJXGRv5g1Dl0/qPM
EQOjVV3bGYQD51mCIs/fSijQVVRpHdkiTBc8csgW37fFSv/+v+NUpWGTISH+Ku/f
27t3niN2kVNhFnC5YGw6TAhDbKRt1ezE/K+ipvuM4HRY8odwKQwh9et5f9cZslXx
liZIH/pzU5xGwrMrLhcp6LVPyjsy8mAs+jM1j/xq2Fd1AaXIrsKrnkmg++XdttI+
4H3cWKvN8+hsHjdvj80an9APoVtQiADvhwvCnu+E2wW6T9ZaQU04eqYBwqhSKbei
vrF1s0y6QRGoufWQMdEitON1B4ap4TUjeTxnJ7OjTyZ1QCQD6oVeKm7NHnpwi4Dr
MqeIOdlC6DesrOusbKhiTcbiy7xy0PRFBK8GjZIJQkczAvnDkChlmTe4fQRFawDB
QHRv1LOMZT/67L0Iyg2Y
=fzaG
-----END PGP SIGNATURE-----

--YC8Ek3FeOE8ywfXk--

--===============6345614843438914460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6345614843438914460==--
