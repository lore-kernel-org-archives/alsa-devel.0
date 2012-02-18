From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/3] Coefficient configuration support
Date: Fri, 17 Feb 2012 16:49:10 -0800
Message-ID: <20120218004909.GA6712@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4188969496603532010=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82C5F103B27
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2012 01:49:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============4188969496603532010==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series is only compile tested as yet, I'll probably get a chance to
test it shortly - it should work out so hopefully the review can overlap
usefully with the testing.

Mark Brown (3):
      ASoC: core: Add SND_SOC_BYTES control for coefficient blocks
      ASoC: core: Add support for masking out parts of coefficient blocks
      ASoC: wm5100: Add DRC coefficient configuration

 include/sound/soc.h       |   27 +++++++++++
 sound/soc/codecs/wm5100.c |    2 +
 sound/soc/soc-core.c      |  110 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 0 deletions(-)

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPPvV9AAoJEBus8iNuMP3dvmUP/1uFL4qZuXR9mqYr3/Grh1UF
T5qZgndz81c4uur1yp//f9vE4sXXyRsklyur/HXLyx+Jy+9W8RKgpelltw33+c4j
1M3vcr+B/PphTilNmbXQGt7WY7R7HUKGHMi5BajLw1H0JMrqxYJ9kPJ0AG5v1sjj
gJrZyP+uTYibBiavgPnoISE1fTSfnnCvbwBJEkXXl9uj1cTPofLIr2rssbvXpT4A
LcwOX62HWm0RMzKYSVDAkKDiIt90Xqk+X1XvbD2pAUMT7Ty0S8KWMxHFjXJE5Wv/
JfG5RXhL+4nrTp29KeIXHUci9TWr65kIvmhBnOUHZJPLr1yDWDpn8qSoWF9gc0C+
03fEa6GYx9yDt/zo9Ep/HQuBiK8b1jJjyjjhCg+jwdxBFf3T+AfvphiYfJzpNdgC
JBjcKXaKuyRWKLf1uHheDXYkpxMWrm6zlOA/+2Pha1MYn3M0rVS99gjnWXyZqT4P
Hhhnw+4i/5GHz7NoIfKEV/vudBYJB4PWhqxePkL2dOGCQ7wzzzElGbrIK4BlEI5A
TWnYnZG49n99+M9v6JabmFxaxcaoEc7qEcL1JaEc4VAi+cbm3uQJurA1TVGz3qpp
mim8bU06yiVR1UjDqlxcyXOs4ZZ3c1v83Uj8GToAo2l8uvEe0PbOqmqS1uy9d8Sk
dHK2HDOztQNpI61RwyiV
=VzeE
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

--===============4188969496603532010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4188969496603532010==--
