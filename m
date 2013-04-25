From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/4] ASoC: imx-sgtl5000: Do not enter
 the error path on success
Date: Thu, 25 Apr 2013 11:41:20 +0100
Message-ID: <20130425104120.GJ5019@opensource.wolfsonmicro.com>
References: <1366815286-31820-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8625573572128175544=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 852FC265384
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 12:41:22 +0200 (CEST)
In-Reply-To: <1366815286-31820-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============8625573572128175544==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JKvC8Wn6JllzUPdT"
Content-Disposition: inline


--JKvC8Wn6JllzUPdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2013 at 11:54:43AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Return on success instead of entering the error path.

Applied, thanks.

--JKvC8Wn6JllzUPdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJReQgoAAoJELSic+t+oim9hFUP/1oBGyP/h0pqrOskBWpiTtRO
iVK5gMQNwjqN/2UAIoP2ZCP2+knak5gN3ijao1ckgQGZJMuyOCxN20rn2kweEIYT
t0+ldJ1APiboqP/uN3q03DdVvbAl5eLZFQKSITF8aWnN5PXwtGfFIPruVgsuf+ko
PJuHURv+Yez1Z5h1ZxyCD0YD+Teo3N0aBH6RKOo/tKXLSjxvsf0kXruW/pax/snU
8naBlLGCeZtsbzbABPVWV2gEwuF4VVsPxRTHA1UPibVV//GCkZ6stiuNIeuxVnlK
FhXSZUM9m2IN0tSomcccYNa0BwLeYqzJawjs98QGoE0dGHMuE3XjDku0L3JFZpC1
K/SY5qhvqxzos+GR26iai2MWPZaUeBGuM0SBD6QnNaZWveOTSSZ9aI0S0V4g1Trz
PNFkF2/RfeAkCvHtZ4JOdI2P7hahu3uVZgEcNMkf6sXZiG77okzgYiXVB6SVegYQ
yh9//eplSEKJO1VCrcLrOjtx1UpVtE45JmSrTo5e5bdcG8A1V14UcewDHReWzFF5
k1ET+Swvm9jsjH2MXQly9BwjouSH6No69LvHh4pTDBlFKu446DOHi1W+vI8PvBFz
8RdyVyC6pJD4fTIV7I1JmaU2U+rxWhXzH9inWMYG8kJQOnSeif+8g7Qe+mUwFbj3
8zoXhgiKw/nf9JOoAl6b
=rohP
-----END PGP SIGNATURE-----

--JKvC8Wn6JllzUPdT--

--===============8625573572128175544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8625573572128175544==--
