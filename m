From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: cs42xx8: Make of match table
	static
Date: Sat, 21 Jun 2014 20:58:58 +0100
Message-ID: <20140621195858.GK5099@sirena.org.uk>
References: <1403163631-26215-1-git-send-email-lars@metafoo.de>
 <1403163631-26215-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4903493684072485179=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E775B261A81
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 21:59:18 +0200 (CEST)
In-Reply-To: <1403163631-26215-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============4903493684072485179==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4K1DhCUNwbLbQ12L"
Content-Disposition: inline


--4K1DhCUNwbLbQ12L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 19, 2014 at 09:40:28AM +0200, Lars-Peter Clausen wrote:
> The cs42xx8_of_match table is not used outside of the driver, hence it can and
> should be made static.

Applied, thanks.

--4K1DhCUNwbLbQ12L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpeP/AAoJELSic+t+oim9EvkP/0y1WE5yRYhKeCgabmhv0/AA
XeXrATS1rhH5AdcJVALcGKXElcjt8Dk17Szg0nwHUF7QIxzbBv9tbPaMej0D1TPs
+/ppVB7PPHLik+KCU9VjPFJStWvxMZ+ulXwEzxY+zQpUiD4z+nSNiGc0312ZXrEM
5qjVuY1K2yyknhjNsPzBwqJzxe7WpYJx55IlzB/KDDJqqIioE8h+7ZWudr43phPJ
oC9FRW0VzFUbJ2fqRWH2eRDt6D165/lnnfWNOjRFiLj6RZYm39s1Xtbu8sotcWII
XELAwb/7VvqnAdCfXTWYqRm536XG0bu+hwoWcV7P+eZKGdXfmxmFdXB5j6I5JWF5
fnqMT6I5/CRSaVLfuMMNk63YvAC3v41K/WiywPlCupOiOEGE+iyKoDCDiERVr42J
JkdbNUcwzcvCYrcOgDbssCENoFKn2fg2oCBlWmeRrU8Xw9xb17xFmCt08OISOCO2
n4g1J4GMuJyopXfTrThgWuLbfT424F1P7BlqxS4Bp2AC26vIrDrZOdJPgEzapAxi
siq+JnY+3vNa8qjIrPngHTzwq8+5sJOlfLPCRLJA7j5h5qcDYAQ/nHHNnprPMyYd
it/oxqDkjB9LUzRmwZreGBE46jtHfAGdOUv/tp7rDD77XlbUthjP2zaV2qoIyQsh
XKbmfc3S+RPis0FCjNta
=w/4u
-----END PGP SIGNATURE-----

--4K1DhCUNwbLbQ12L--

--===============4903493684072485179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4903493684072485179==--
