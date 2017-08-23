From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-ac97: replace codec to component
Date: Wed, 23 Aug 2017 11:18:24 +0100
Message-ID: <20170823101824.5vjwgegngfhfwq3o@sirena.org.uk>
References: <87mv6qx46y.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0443839153430873966=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 060292664EB
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 12:18:26 +0200 (CEST)
In-Reply-To: <87mv6qx46y.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============0443839153430873966==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jzbpeykmns5hoojd"
Content-Disposition: inline


--jzbpeykmns5hoojd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 05:14:10AM +0000, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> codec will be replaced to component soon.
> AC97 is codec related feature now. Thus this patch replaces codec
> to component on AC97.

Given that there's Robert's big AC'97 refactoring patch in review right
now I don't want to apply this and cause him to have to rebase, I'm
expecting this version to go in.

--jzbpeykmns5hoojd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmdVnAACgkQJNaLcl1U
h9BP+gf+Mv0UvCtazKFBGbqHZ0lX0LuOMvbhXy3ITCRUxa3DFr9rfsHu7EjlRSE8
IYOhlInia+y2a6nj2ykX6shOMr9TdSxoqYSED+JS7ljb2V2MESzdHrqIagbTu89k
pF+pri+nrAl2PC89mjYxIn88qyggRLvMi46zwOMBnMOSqQzudnHMxcFMHFhbuY4J
c2N0a60S+Pn5cQscdBdLhx6EyEWt4ZvUHD5poDVcvWTsRtQrJeIGZX6qFVJPy+0v
X8QYamWZEOcwbfFoZbuKDgmPISm3os8/Zbrb4BJnxG8Bunnf1Tm7HmQZzWVe4Gl5
ajNsUlWpV34A7yfrh2JZs5gARyHAkQ==
=urt6
-----END PGP SIGNATURE-----

--jzbpeykmns5hoojd--

--===============0443839153430873966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0443839153430873966==--
