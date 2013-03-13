From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: add
	snd_soc_register_component()
Date: Wed, 13 Mar 2013 11:08:26 +0000
Message-ID: <20130313110825.GK25610@opensource.wolfsonmicro.com>
References: <87fw06ace9.wl%kuninori.morimoto.gx@renesas.com>
 <87k3pdtnlk.wl%kuninori.morimoto.gx@renesas.com>
 <87ip4xtnka.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1567197277174685906=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DC302265E0A
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 12:08:30 +0100 (CET)
In-Reply-To: <87ip4xtnka.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1567197277174685906==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKtFalx5NIx0HZ72"
Content-Disposition: inline


--tKtFalx5NIx0HZ72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2013 at 06:27:21PM -0700, Kuninori Morimoto wrote:
> Current ASoC has register function for platform/codec/dai/card,
> but doesn't have for cpu.
> It often produces confusion and fault on ASoC.

Applied, thanks.

--tKtFalx5NIx0HZ72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQF4gAAoJELSic+t+oim9D0wP+wcVqZe7lwKMj5dadwEWGYsv
p1FlTNQYHInxpCUY7nmXTlUmJwk7mDChCUjOa0s4lStcMazc3PrJaWqZCXippUiK
DcGlEEVrSzcoYtiOVg2ezqh9R5YKoJLDzC9/lsYPcEDRTK1v4s5U+nn84f3nkFVA
YB5IgGrZ7k1Z7g0iOFn35ze8VGz+gM7tZPVEeHqE85ADDmq8UM8vmjO+UX7g1lqu
6aFQMQ5rt20lxO5cwkAi+wT4QvPijYBo3awWfc6uR6XAt1iXtWJw5D/oLc2877Up
5sh46vdoAaiOB1anBv0gheeDWfsTdXrj/XXGo6l7r4sY6DgeFYZikovE/jILmFVZ
RfDvNb+sNHkYz9//vYAXrb2+crQGmNNogJQMt3TR2R1C7Je1Y2dugZo75maGyPy2
HJTeMdVQFbv4DKgFDtOh/1zZOcAEydAu3zRK/jOOstDtD1Te0WEltSMxK41h6C5z
dSMjeuQqEYgkaF6MowUbUyRxA0+afZru3lCSBxj343aEp5CMcD7LqUbVrzPbWgIq
sUdEEFgv9YZpc8wB/4iIGJWUQSDYYeam35qkaQVeCJXnyhoMHrJHWbOi6zMyLkJO
twtnmrBNiCpic54MF3DS5lXCMa+5BvD+skuJSQnkEbXq9ifiReQfbU3NKAkRgIiS
Jo/AQIPAEjQjTTxp6QQ2
=z0cy
-----END PGP SIGNATURE-----

--tKtFalx5NIx0HZ72--

--===============1567197277174685906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1567197277174685906==--
