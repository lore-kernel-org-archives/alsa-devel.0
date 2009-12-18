From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Fri, 18 Dec 2009 13:59:00 +0000
Message-ID: <20091218135900.GB9630@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2ECC61038F9
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 14:59:02 +0100 (CET)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit bc2580061e42c323d7777029f01318f395edac0d:
  Julia Lawall (1):
        ASoC: Correct code taking the size of a pointer

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Nothing terribly exciting here, almost all of it is a bunch of new
drivers.

Chaithrika U S (1):
      ASoC: DaVinci: Update suspend/resume support for McASP driver

Daniel Mack (1):
      ASoC: Add regulator support to CS4270 codec driver

Guennadi Liakhovetski (1):
      ASoC: wm8974: fix a wrong bit definition

Ilkka Koskinen (2):
      ASoC: tlv320dac33: Add support for regulator framework
      ASoC: tpa6130a2: Add support for regulator framework

Jassi Brar (2):
      ASoC: S3C64XX: Remove unnecessary header includes
      ASoC: S3C64XX: Compress and generalize the CPU driver

Jon Smirl (1):
      ASoC: Fix disable of SPDIF on STAC9766 codec

Kuninori Morimoto (4):
      ASoC: sh_fsi: avoid using global variable
      ASoC: ak4642: Add default return value in ak4642_modinit
      ASoC: Add DA7210 codec device support for ALSA
      ASoC: Add FSI-DA7210 sound support for SuperH

Mark Brown (12):
      Merge branch 'for-2.6.33' into for-2.6.34
      ASoC: Export snd_soc_update_bits_unlocked()
      ASoC: Display the power register in DAPM widget debugfs
      ASoC: Initial WM8904 CODEC driver
      ASoC: Push registers out of mixer power decision
      ASoC: Sort DAPM sequences by CODEC as well
      ASoC: Register the CODEC in WM8727
      ASoC: Fix sorting of codecs Makefile entries
      ASoC: Fix build of DA7210
      ASoC: Add initial WM8955 CODEC driver
      ASoC: Set AIF word length for WM8904
      Merge branch 'for-2.6.33' into for-2.6.34

Peter Meerwald (1):
      ASoC: PLL computation in TLV320AIC3x SoC driver

 include/sound/soc.h               |    3 +
 include/sound/wm8904.h            |   57 +
 include/sound/wm8955.h            |   26 +
 sound/soc/codecs/Kconfig          |   12 +
 sound/soc/codecs/Makefile         |   10 +-
 sound/soc/codecs/ak4642.c         |    2 +-
 sound/soc/codecs/cs4270.c         |   43 +-
 sound/soc/codecs/da7210.c         |  589 +++++++++
 sound/soc/codecs/da7210.h         |   24 +
 sound/soc/codecs/stac9766.c       |   18 +-
 sound/soc/codecs/tlv320aic3x.c    |   75 +-
 sound/soc/codecs/tlv320dac33.c    |   92 ++-
 sound/soc/codecs/tpa6130a2.c      |   87 +-
 sound/soc/codecs/wm8727.c         |   66 +-
 sound/soc/codecs/wm8904.c         | 2555 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8904.h         | 1681 ++++++++++++++++++++++++
 sound/soc/codecs/wm8955.c         | 1151 +++++++++++++++++
 sound/soc/codecs/wm8955.h         |  489 +++++++
 sound/soc/codecs/wm8974.c         |    2 +-
 sound/soc/davinci/davinci-mcasp.c |   18 +-
 sound/soc/davinci/davinci-mcasp.h |    1 +
 sound/soc/davinci/davinci-pcm.c   |    2 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c   |  120 +--
 sound/soc/sh/Kconfig              |    8 +
 sound/soc/sh/Makefile             |    2 +
 sound/soc/sh/fsi-da7210.c         |   83 ++
 sound/soc/sh/fsi.c                |  115 +-
 sound/soc/soc-core.c              |    7 +-
 sound/soc/soc-dapm.c              |   37 +-
 29 files changed, 7127 insertions(+), 248 deletions(-)
 create mode 100644 include/sound/wm8904.h
 create mode 100644 include/sound/wm8955.h
 create mode 100644 sound/soc/codecs/da7210.c
 create mode 100644 sound/soc/codecs/da7210.h
 create mode 100644 sound/soc/codecs/wm8904.c
 create mode 100644 sound/soc/codecs/wm8904.h
 create mode 100644 sound/soc/codecs/wm8955.c
 create mode 100644 sound/soc/codecs/wm8955.h
 create mode 100644 sound/soc/sh/fsi-da7210.c
