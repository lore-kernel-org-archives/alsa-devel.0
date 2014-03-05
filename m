From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/11] ASoC: rsnd: rename scu to src
Date: Wed, 5 Mar 2014 14:08:23 +0800
Message-ID: <20140305060823.GQ13126@sirena.org.uk>
References: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
 <878usq1scd.wl%kuninori.morimoto.gx@gmail.com>
 <87siqyzhvd.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4243048666198277768=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10134264F02
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 07:28:40 +0100 (CET)
In-Reply-To: <87siqyzhvd.wl%kuninori.morimoto.gx@gmail.com>
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


--===============4243048666198277768==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="De7JZ5cYyW/PeqB+"
Content-Disposition: inline


--De7JZ5cYyW/PeqB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2014 at 08:51:21PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> R-Car sound has SCU unit which has SRC/CTU/MIX/DVC,
> and current rsnd driver has scu.c and scu module.
> Current scu.c has SRC support only.

Applied all up to here, thanks.

--De7JZ5cYyW/PeqB+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFr9UAAoJELSic+t+oim9+pEQAICG+petQuGNfBOyDqX6U9xD
3Ke1MT3/LF2SYq8pLzJ72tb9yvuM1lRZgfP4O3Qa1G9OOVNtzXOjO421MoaFFRv9
oqRYc6iYVyWBDsmhUjdrWWWAvizLmzrACh3FaaMMjbdB9pz6n/QIhAhJ9nWTyDlG
0cLPeHtg59n3qYmzZzwq4YEYeLdrirL99a91v0D96285DmCVTtTKMCzDKqAROpoT
E28Gv3QN+km5cUi8eog2Sk0M6qzNRDUIqdFLoSVp8QGXPEdyVQCoIQBAZDbZZhZU
o/ChbRkniwOX9cQ2aSiWCDMYIW1YPBkHlaYNtFUH0Iuee+Ec5v2tYVFfzkYczaz7
nOLPBhmwcQ8jwxH8nAALAG1kbNs07HNUNbqnZ8KbeOVKsuCHKEm3ctZW7BxUaaem
/LonC6tBroXLh6VbvF9azbBreDoXD+iIwVNJssuh2ibw66P5nA0557Lm1IQWQ09w
XesARPPL5sMmcRM0/Lnr0FalsxlwHUf7xoZXIY6x5VUVMPkIm2CjNCdk7QklNN1l
+sn4HoYeFkOI2l6w65CXkYrYBExWbyivtlvqS+yJUjHEUcjUiMnzMoggeTRdgXD8
WVNOyexviyHg56PQJ+rSqzz84vc74RpPb368ucRIlYv1DLGdsR9wVylu1RNwgw3W
SQW31eNeyPnIjy55PAwV
=Cbil
-----END PGP SIGNATURE-----

--De7JZ5cYyW/PeqB+--

--===============4243048666198277768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4243048666198277768==--
