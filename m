From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Wed, 11 Mar 2009 22:26:40 +0000
Message-ID: <20090311222633.GB7536@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2894E24411
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 23:26:48 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit 3c081384007332ab95c8d8753f47719d6646bcb2:
  Mark Brown (1):
        Merge branch 's3c-iis-header' into for-2.6.30

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

David Brownell (1):
      ASoC: buildfix for OSK

Eric Miao (1):
      ASoC: make ops a pointer in 'struct snd_soc_dai'

Mark Brown (6):
      ASoC: Add initial driver for the WM8400 CODEC
      ASoC: Remove version display from WM8580 driver
      ASoC: Fix formats for s3c24xx-i2s register prints
      ASoC: Merge dai_ops factor out
      [ARM] Revert futher extraneous changes from the S3C header move
      Merge branch 's3c-iis-header' into for-2.6.30

 arch/arm/mach-s3c2410/include/mach/io.h |    2 +-
 arch/arm/plat-s3c24xx/clock-dclk.c      |    1 -
 include/linux/mfd/wm8400-audio.h        |    1 +
 include/sound/soc-dai.h                 |    2 +-
 sound/soc/atmel/atmel_ssc_dai.c         |   33 +-
 sound/soc/au1x/psc-ac97.c               |   10 +-
 sound/soc/au1x/psc-i2s.c                |   12 +-
 sound/soc/blackfin/bf5xx-i2s.c          |   14 +-
 sound/soc/codecs/Kconfig                |    4 +
 sound/soc/codecs/Makefile               |    2 +
 sound/soc/codecs/ac97.c                 |    7 +-
 sound/soc/codecs/ak4104.c               |   10 +-
 sound/soc/codecs/ak4535.c               |   14 +-
 sound/soc/codecs/cs4270.c               |   14 +-
 sound/soc/codecs/ssm2602.c              |   20 +-
 sound/soc/codecs/tlv320aic23.c          |   18 +-
 sound/soc/codecs/tlv320aic26.c          |   14 +-
 sound/soc/codecs/tlv320aic3x.c          |   14 +-
 sound/soc/codecs/uda134x.c              |   18 +-
 sound/soc/codecs/uda1380.c              |   42 +-
 sound/soc/codecs/wm8350.c               |   20 +-
 sound/soc/codecs/wm8400.c               | 1481 +++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8400.h               |   62 ++
 sound/soc/codecs/wm8510.c               |   16 +-
 sound/soc/codecs/wm8580.c               |   34 +-
 sound/soc/codecs/wm8728.c               |   12 +-
 sound/soc/codecs/wm8731.c               |   18 +-
 sound/soc/codecs/wm8750.c               |   14 +-
 sound/soc/codecs/wm8753.c               |   90 +-
 sound/soc/codecs/wm8900.c               |   16 +-
 sound/soc/codecs/wm8903.c               |   18 +-
 sound/soc/codecs/wm8971.c               |   14 +-
 sound/soc/codecs/wm8990.c               |   18 +-
 sound/soc/codecs/wm9705.c               |    8 +-
 sound/soc/codecs/wm9712.c               |   14 +-
 sound/soc/codecs/wm9713.c               |   40 +-
 sound/soc/davinci/davinci-i2s.c         |   14 +-
 sound/soc/fsl/fsl_ssi.c                 |   18 +-
 sound/soc/fsl/mpc5200_psc_i2s.c         |   20 +-
 sound/soc/omap/omap-mcbsp.c             |   20 +-
 sound/soc/omap/osk5912.c                |   12 +-
 sound/soc/pxa/pxa-ssp.c                 |   65 +-
 sound/soc/pxa/pxa2xx-ac97.c             |   13 +-
 sound/soc/pxa/pxa2xx-i2s.c              |   18 +-
 sound/soc/s3c24xx/s3c2412-i2s.c         |    8 +-
 sound/soc/s3c24xx/s3c2443-ac97.c        |   18 +-
 sound/soc/s3c24xx/s3c24xx-i2s.c         |   32 +-
 sound/soc/sh/ssi.c                      |   30 +-
 sound/soc/soc-core.c                    |  102 ++-
 49 files changed, 2047 insertions(+), 450 deletions(-)
 create mode 100644 sound/soc/codecs/wm8400.c
 create mode 100644 sound/soc/codecs/wm8400.h
