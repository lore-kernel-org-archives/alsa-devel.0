From: Mark Brown <broonie@kernel.org>
Subject: ASoC fixes for v4.14
Date: Wed, 1 Nov 2017 13:42:37 +0000
Message-ID: <20171101134237.4x4pnmy434kok56u@sirena.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7948821502001692479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AA15B26709F
 for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2017 14:42:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7948821502001692479==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fizg5noxjgeuqrok"
Content-Disposition: inline


--fizg5noxjgeuqrok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0b07194bb55ed836c2cc7c22e866b87a14681984:

  Linux 4.14-rc7 (2017-10-29 13:58:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.14-rc7

for you to fetch changes up to b817d936248b9bcee8282e97fb1dda1b03c903fe:

  Merge remote-tracking branches 'asoc/fix/topology', 'asoc/fix/adau17x1', 'asoc/fix/rt5514', 'asoc/fix/rt5616', 'asoc/fix/rt5659' and 'asoc/fix/rt5663' into tmp (2017-11-01 13:36:16 +0000)

----------------------------------------------------------------
ASoC: Fixes for v4.14

A bunch of fixes here, mostly device specific ones (the biggest one
being the revert of the hotword support for rt5514), with a couple of
core fixes for potential issues with corrupted or otherwise invalid
topology files.

----------------------------------------------------------------
Bard Liao (3):
      ASoC: rt5659: register power bit of LOUT Amp
      ASoC: rt5659: connect LOUT Amp with Charge Pump
      ASoC: rt5616: fix 0x91 default value

Christophe JAILLET (2):
      ASoC: topology: Fix a potential NULL pointer dereference in 'soc_tplg_dapm_widget_denum_create()'
      ASoC: topology: Fix a potential memory leak in 'soc_tplg_dapm_widget_denum_create()'

Hsin-Yu Chao (2):
      ASoC: rt5514-spi: check irq status to schedule data copy
      ASoC: rt5514: Revert Hotword Model control

Mark Brown (1):
      Merge remote-tracking branches 'asoc/fix/topology', 'asoc/fix/adau17x1', 'asoc/fix/rt5514', 'asoc/fix/rt5616', 'asoc/fix/rt5659' and 'asoc/fix/rt5663' into tmp

Ricard Wanderlof (1):
      ASoC: adau17x1: Workaround for noise bug in ADC

oder_chiou@realtek.com (1):
      ASoC: rt5663: Change the dev getting function in rt5663_irq

 sound/soc/codecs/adau17x1.c   | 24 ++++++++++++++++-
 sound/soc/codecs/adau17x1.h   |  2 ++
 sound/soc/codecs/rt5514-spi.c | 17 ++++++++++--
 sound/soc/codecs/rt5514-spi.h |  3 +++
 sound/soc/codecs/rt5514.c     | 63 -------------------------------------------
 sound/soc/codecs/rt5514.h     |  3 ---
 sound/soc/codecs/rt5616.c     |  2 +-
 sound/soc/codecs/rt5659.c     |  4 ++-
 sound/soc/codecs/rt5663.c     |  3 ++-
 sound/soc/soc-topology.c      |  5 +++-
 10 files changed, 53 insertions(+), 73 deletions(-)

--fizg5noxjgeuqrok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln5z00ACgkQJNaLcl1U
h9BzWgf9EOK+J5tiiGRlzvh4F4ZcRVHe5JKu3GW1iLjha8g++QfPF4DBZnDJ7UR+
p9C4aAWOLsQ1daoBaMHMUu1k1zTNS8RYGHnOrRrEj80ja//9pTOpCReEiP7Yn7zf
3pXXzj05r/mSuyCEchMw3OkEoKxRTpt53ees/WxnQzbEmlln1165SGzuJ4Q3K4eS
cHKCJwGPLBLoJ6UIIl25ErjX8GMcjqCPyq/h1ci5gUtAHJUMof+QiuJTU+gSqTbX
IZuQXFvLRSe5UzeMFklfo4EdvA8pxQSDsWUi0XY4+dhKftn1/05xyYeJ/B2GxH0+
0VVWg1q7NKPu4mSUGAnOWID9MOwA/w==
=dwlA
-----END PGP SIGNATURE-----

--fizg5noxjgeuqrok--

--===============7948821502001692479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7948821502001692479==--
