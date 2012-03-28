From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Samsung: fix DMA interface for
	s3c2442 boards
Date: Wed, 28 Mar 2012 12:04:25 +0100
Message-ID: <20120328110424.GK3232@opensource.wolfsonmicro.com>
References: <1332887869-3527-1-git-send-email-GNUtoo@no-log.org>
	<1332887869-3527-2-git-send-email-GNUtoo@no-log.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8514058227659167936=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A08AE244B2
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 13:04:51 +0200 (CEST)
In-Reply-To: <1332887869-3527-2-git-send-email-GNUtoo@no-log.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8514058227659167936==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sU4rRG038CsJurvk"
Content-Disposition: inline


--sU4rRG038CsJurvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2012 at 12:37:49AM +0200, Denis 'GNUtoo' Carikli wrote:
> Without this fix playing a wav file that said "incomming call"
>   resulted in the following beeing played: "in-in-in-co-co-co-mi-mi-mi...=
".
>=20
> This commit was tested on the GTA02 Machine.
>=20
> The problem was introduced by commit 344b4c48887a443f7478fc7047d1397b2082=
1ed3
>   (ASoC: Samsung: Update DMA interface)

Please provide some analysis of what change this patch makes and why
it's needed.  As Sangbeom says I'd expect this will break other
platforms, it looks like something that ought to be fixed in the s3c24xx
DMA layer.

--sU4rRG038CsJurvk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPcvAxAAoJEBus8iNuMP3dufEP/A8XwRLEkv1o/3YdCbG0rpZA
bTV0SWYQJ/tcRH4kQzQp6U25y2qpcoHf6/2RWqp5rQSoRrN/EhhamszDSpCvD65x
fIWXZ4B9G5u9T587JEGdR64EYSrcX2aQvQ0D3vET1Id+LpIvYxOJME8vlfsn85k6
aJhrvc9BqE9vaH2j22nkNT41xUj2uPE3xqKqfRiyK+t+GB5vjwjMp7nUgOdbv8XL
ouoGe67wM0C7y6Td0xhUO05Fq3vDi2g2fua4RxNx+PiOBSr44Ka/1x8+ZTJNMK0A
RCs1MUty8wp0rt5EwxGBhbtoF4XduJlLkSrNhpxzhv2J2RFrM2vXtGi9prh6/bpu
qkJH9rjMHmWhuWRdHO+lce6DZDe48e+1C+x9AX7krtHfsr+uv9vc/3QnK/WdI68G
ca+h2ce0hc0sLIyfdekNchadZEPgEsIF08s+eETY1d0AL36HzTBPaI2S2rHeFQkj
ez+uzLSaMUC2SVvA9J1eIlUUnL6vBjkQhzG0CeJhZzBHwPNrmjJzPjS7m+awZ5yq
EB6NsAm+J4/GLFOoLoQl7ucQ8eYvLChUAACnCKkTkePXIIj/9C1AIKfsNR1cs4Vk
l23Kr24T294cA9iUxhpaWfIs27XAoxb5XV5wD1kRyogphtXAWRS5m7g5l+bMZGfC
U0Nbsl7eaCBD63AXUeSX
=1hyd
-----END PGP SIGNATURE-----

--sU4rRG038CsJurvk--

--===============8514058227659167936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8514058227659167936==--
