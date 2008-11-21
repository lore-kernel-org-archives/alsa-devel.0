From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/10] ASoC updates
Date: Fri, 21 Nov 2008 14:47:34 +0000
Message-ID: <20081121144734.GA25238@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2706244DD
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 15:47:35 +0100 (CET)
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

The following changes since commit 9b0db7e7fd20d5a38844e9435f7d4246ea44978a:
  Mark Brown (1):
        ASoC: Convert blackfin machines to use DAI accessor functions

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Jarkko Nikula (1):
      ASoC: OMAP: Fix preprocessor filled DAI name in McBSP DAI

Karl Beldan (2):
      ASoC: ssm2602: Fix priv substreams refs
      ASoC: ssm2602: Update supported stream formats

Mark Brown (7):
      ASoC: Rename snd_soc_card to snd_soc_machine
      ASoC: Add abbreviation to maintainers for searchability
      ASoC: Move DAI structure definitions into new soc-dai.h
      ASoC: Merge snd_soc_ops into snd_soc_dai_ops
      ASoC: Add Marvell Zylonite machine support
      ASoC: Staticise pxa2xx_pcm_ops
      ASoC: Improve error reporting for AC97 reset failures

 Documentation/sound/alsa/soc/machine.txt |    8 +-
 MAINTAINERS                              |    2 +-
 include/sound/soc-dai.h                  |  225 ++++++++++++++++++++++++++++++
 include/sound/soc.h                      |  156 +--------------------
 sound/soc/atmel/atmel_ssc_dai.c          |   21 ++--
 sound/soc/atmel/playpaq_wm8510.c         |    4 +-
 sound/soc/atmel/sam9g20_wm8731.c         |    4 +-
 sound/soc/au1x/psc-ac97.c                |    5 +-
 sound/soc/au1x/psc-i2s.c                 |    8 +-
 sound/soc/au1x/sample-ac97.c             |    4 +-
 sound/soc/blackfin/bf5xx-ad1980.c        |    6 +-
 sound/soc/blackfin/bf5xx-ad73311.c       |    6 +-
 sound/soc/blackfin/bf5xx-i2s.c           |   12 +-
 sound/soc/blackfin/bf5xx-ssm2602.c       |    6 +-
 sound/soc/codecs/ac97.c                  |    3 +-
 sound/soc/codecs/ad1980.c                |    2 +-
 sound/soc/codecs/ak4535.c                |    5 +-
 sound/soc/codecs/cs4270.c                |   11 +-
 sound/soc/codecs/ssm2602.c               |   39 ++++-
 sound/soc/codecs/tlv320aic23.c           |   19 ++--
 sound/soc/codecs/tlv320aic26.c           |    5 +-
 sound/soc/codecs/tlv320aic3x.c           |    5 +-
 sound/soc/codecs/twl4030.c               |    5 +-
 sound/soc/codecs/uda134x.c               |   12 +-
 sound/soc/codecs/uda1380.c               |   15 +--
 sound/soc/codecs/wm8510.c                |    5 +-
 sound/soc/codecs/wm8580.c                |   12 +-
 sound/soc/codecs/wm8728.c                |    5 +-
 sound/soc/codecs/wm8731.c                |   11 +-
 sound/soc/codecs/wm8750.c                |    5 +-
 sound/soc/codecs/wm8753.c                |   25 ++--
 sound/soc/codecs/wm8900.c                |    5 +-
 sound/soc/codecs/wm8903.c                |   11 +-
 sound/soc/codecs/wm8971.c                |    5 +-
 sound/soc/codecs/wm8990.c                |    6 +-
 sound/soc/codecs/wm9712.c                |    8 +-
 sound/soc/codecs/wm9713.c                |   23 ++--
 sound/soc/davinci/davinci-evm.c          |    4 +-
 sound/soc/davinci/davinci-i2s.c          |   20 ++--
 sound/soc/davinci/davinci-sffsdr.c       |    7 +-
 sound/soc/fsl/fsl_dma.c                  |    2 +-
 sound/soc/fsl/fsl_ssi.c                  |   14 +-
 sound/soc/fsl/mpc5200_psc_i2s.c          |   17 ++-
 sound/soc/fsl/mpc8610_hpcd.c             |    6 +-
 sound/soc/fsl/soc-of-simple.c            |   10 +-
 sound/soc/omap/n810.c                    |    4 +-
 sound/soc/omap/omap-mcbsp.c              |   16 ++-
 sound/soc/omap/omap2evm.c                |    7 +-
 sound/soc/omap/omap3beagle.c             |    4 +-
 sound/soc/omap/osk5912.c                 |    4 +-
 sound/soc/omap/overo.c                   |    4 +-
 sound/soc/pxa/Makefile                   |    2 +
 sound/soc/pxa/corgi.c                    |    4 +-
 sound/soc/pxa/e800_wm9712.c              |    6 +-
 sound/soc/pxa/em-x270.c                  |    4 +-
 sound/soc/pxa/palm27x.c                  |    4 +-
 sound/soc/pxa/poodle.c                   |    4 +-
 sound/soc/pxa/pxa-ssp.c                  |   20 +--
 sound/soc/pxa/pxa2xx-ac97.c              |    9 +-
 sound/soc/pxa/pxa2xx-i2s.c               |   15 ++-
 sound/soc/pxa/pxa2xx-pcm.c               |    2 +-
 sound/soc/pxa/spitz.c                    |    4 +-
 sound/soc/pxa/tosa.c                     |    6 +-
 sound/soc/pxa/zylonite.c                 |  219 +++++++++++++++++++++++++++++
 sound/soc/s3c24xx/ln2440sbc_alc650.c     |    6 +-
 sound/soc/s3c24xx/neo1973_wm8753.c       |    6 +-
 sound/soc/s3c24xx/s3c2412-i2s.c          |    8 +-
 sound/soc/s3c24xx/s3c2443-ac97.c         |    8 +-
 sound/soc/s3c24xx/s3c24xx-i2s.c          |    9 +-
 sound/soc/s3c24xx/s3c24xx_uda134x.c      |    4 +-
 sound/soc/s3c24xx/smdk2443_wm9710.c      |    6 +-
 sound/soc/sh/hac.c                       |    3 +-
 sound/soc/sh/sh7760-ac97.c               |    4 +-
 sound/soc/sh/ssi.c                       |   16 +-
 sound/soc/soc-core.c                     |  164 +++++++++++-----------
 sound/soc/soc-dapm.c                     |    6 +-
 76 files changed, 851 insertions(+), 516 deletions(-)
 create mode 100644 include/sound/soc-dai.h
 create mode 100644 sound/soc/pxa/zylonite.c
