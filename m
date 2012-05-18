From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.5
Date: Fri, 18 May 2012 17:33:37 +0100
Message-ID: <20120518163337.GO4039@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5509954303165807403=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 897F6104448
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2012 18:33:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5509954303165807403==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr6hGnsCY8KeifOY"
Content-Disposition: inline


--Sr6hGnsCY8KeifOY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit fe33d4c5e2b27a4b82aa479a58f2621eec103d1b:

  ASoC: don't flip master of DT-instantiated DAI links (2012-05-16 09:44:18=
 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-3.5

for you to fetch changes up to 5fb86e5d4a951ddb0474cdfd809380c8e2a8d101:

  ARM: mx31_3ds: Add sound support (2012-05-18 16:42:44 +0100)

----------------------------------------------------------------
ASoC: mc13783 audio support

A few extra patches adding a new driver and some machines using it.

----------------------------------------------------------------
Philippe R=E9tornaz (7):
      mfd: mc13xxx: add codec platform data
      ASoC: Add mc13783 codec
      ASoC: add imx-mc13783 sound support
      ASoC: mc13783 codec cleanups
      mx31moboard: Add sound support
      ASoC: imx-mc13783 cleanup
      ARM: mx31_3ds: Add sound support

 arch/arm/mach-imx/Kconfig            |    2 +
 arch/arm/mach-imx/mach-mx31_3ds.c    |   22 +-
 arch/arm/mach-imx/mach-mx31moboard.c |   20 +-
 drivers/mfd/mc13xxx-core.c           |    3 +-
 include/linux/mfd/mc13xxx.h          |   11 +
 sound/soc/codecs/Kconfig             |    4 +
 sound/soc/codecs/Makefile            |    2 +
 sound/soc/codecs/mc13783.c           |  786 ++++++++++++++++++++++++++++++=
++++
 sound/soc/codecs/mc13783.h           |   28 ++
 sound/soc/fsl/Kconfig                |    8 +
 sound/soc/fsl/Makefile               |    2 +
 sound/soc/fsl/imx-mc13783.c          |  156 +++++++
 12 files changed, 1041 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/codecs/mc13783.c
 create mode 100644 sound/soc/codecs/mc13783.h
 create mode 100644 sound/soc/fsl/imx-mc13783.c

--Sr6hGnsCY8KeifOY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPtnnbAAoJEBus8iNuMP3dTNEP/3f9sEPYEUxLtKaxNLuaiBLb
O8+gZ3F3OjWvUv4JvdTHZ2kD3DpLmZkjDjiqj2qaPjX+MEqnNlqTZtLVvabREZC4
UgTa+QgHeCTnE4nl15mJPbe+tNKRBFM9vSaYD/cwu2O/3sqb5Glz7XBMHj4Nrp95
Ey+DJtPEPSEeZT32/8RfBubMax6gapoPatefqNF3aCTPj4XeBwZhkDkUQkwK9WLH
yq8jsFbxlY7iMdKO8LPMaS4MCrlF+KlMx6PqAtLwpIhimBEOwc1rg3XKia9PM9+d
lUV54Z8ngZonIQzawrKhvT/8LhUxJe3pxfAuOB9J94XDpKqke6+B/XCiGIRnd6eN
lPyAwkWr6yIH0RIu5Z/SRcBFe8eiucpXhVdWDJ9hPidjuZv9SKfXEgj6B0WFeRSS
FE9WHkez7P+6KopnMZtvf0WazKjOfMlJfQE+GlV8Ikitx5vcQEQeYAA0dZ98Q0VB
AN8UbtNe4QOOQOfw9beFOneVubm74G46FLyjNZXvARjx3Ps0YCeqZWXEK+eLhkAu
riG7PgX6r++mE1QN+kECXFBk/CWLODzYmhfVnJUxoxvfXg08dPOC8pDuuIuVFW2c
YvyjIhzvXjnX2Zvxh9lqMhtdwKkIO2OxVM/3IMxpHRU7ivGxr7w6O4RladBva8RQ
SIL/hIsyLoeoBn4aMiN6
=oJLr
-----END PGP SIGNATURE-----

--Sr6hGnsCY8KeifOY--

--===============5509954303165807403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5509954303165807403==--
