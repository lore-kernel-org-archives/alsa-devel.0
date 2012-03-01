From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.3
Date: Thu, 1 Mar 2012 12:41:13 +0000
Message-ID: <20120301124112.GE3124@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7881254811504564604=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 517D3103C9C
	for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2012 13:41:15 +0100 (CET)
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


--===============7881254811504564604==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e555cf363167f09efae96d32a363e24c4de16b7b:

  ASoC: ak4642: fixup HeadPhone L/R dapm settings (2012-02-21 10:00:24 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.3

for you to fetch changes up to 5ed80a75b248bfaf840ea6b38f941edcf6ee7dc7:

  ASoC: i.MX SSI: Fix DSP_A format. (2012-02-23 18:58:17 +0000)

----------------------------------------------------------------
A small fix for the SSI driver and a fix for system shutdown with modern
devices.  Most of the modern devices will never get shut down normally
with a visible kernel log as the systems they're in tend not to shut
down often and when they do it's usually in form factors that don't have
a user visible console.
----------------------------------------------------------------

Javier Martin (1):
      ASoC: i.MX SSI: Fix DSP_A format.

Mark Brown (1):
      ASoC: dapm: Check for bias level when powering down

 sound/soc/imx/imx-ssi.c |    2 +-
 sound/soc/soc-dapm.c    |   12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPT25fAAoJEBus8iNuMP3dpIEP/2wtyITTEkeTh4ngSH2bQ5Lh
9Hqmm6/hsMIKNrkswhEggiFVRg5afm6DwD7mfjjJA4DsoJpkPyZs5GYqBxK7a1YE
CzdroUYbU9jy1DbjiCkuTfHNq8ejtXiwXb6eovX/aKOrncFlWyVyPMj3Oj5lHXSL
n5C66mWUoyjilSbSm0e350Uw8/zswlFPn5xw7HEeSFssUx4z7ljp1Ann9sWG+DwT
RjHGF4ZmAbl69CntKyBiTUlMKIuLFgea7vmQbWMRhazUaDBVugZIQk9npJC+jEXu
B2XIps9yPN5lfe8PLFK32X4FOI5eJEdk21/2U9HHVhYeEtF1zUqhupEKWs9YANLG
xG02Qa3u61Bma56iZvHXAf1yZOumkyAnGE6+biE/sXZwjIEXdGL6ssarTkl4PbsB
hGSrRIkXisz1MIUlHnYCMfDtbDm+ODc0A3rN7Qw8wmMM53od9DgX4yi5BRh6U0Qe
Ut7Z+TdAJ0+22WzRkA5/5dYmEXNrveyYxPapb70wx6OU95NTcALX3bCf8NqsZqng
0CIZHXSf8oxzYcwd4qW3Qu80yZAQrg4BdDh/Ky5dR4vjlG1oO7lOlvPo69GcJU/3
QXv/Icrk4Xpk4geF5ZdzhWYsqTWaJLscNIywMdltrFBrY7AKeoBA/5eKJF4QHO2y
R5Aqpr3sh6fTcwUOwVGW
=zXJA
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--

--===============7881254811504564604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7881254811504564604==--
