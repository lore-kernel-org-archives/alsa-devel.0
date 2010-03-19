From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Fri, 19 Mar 2010 15:30:53 +0000
Message-ID: <20100319153053.GJ23306@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A06324390
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 16:30:54 +0100 (CET)
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

The following changes since commit f4bee1bb0083869b1b7d73c6eda7703a7aae0506:
  Barry Song (1):
        ASoC: soc-cache: let reg be AND'ed by 0xff instead of data buffer for 8_8 mode

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Barry Song (2):
      ASoC: rename ad1938 to ad193x and add support for ad1936/7/8/9
      ASoC: change bf5xx-ad1938 machine driver to bf5xx-ad193x machine driver

Guennadi Liakhovetski (2):
      ASoC: SIU driver shall select FW_LOADER
      ASoC: remove a card from the list, if instantiation failed

Jorge Eduardo Candelaria (1):
      ASoC: McPDM: Use tabs for indentation

Mark Brown (9):
      ALSA: Rename jack switch table in preparation for button support
      ALSA: Add support for key reporting via the jack interface
      ASoC: Correct typoed Mic2 connections on 1133-EV1 board
      ASoC: Bail out of wm_hubs DC servo if calibration fails
      ASoC: Unexport AD193x bus probe/remove functions
      Merge branch 'topic/jack' into for-2.6.35
      ASoC: Hook up microphone jack detection on 1133-EV1 board
      ASoC: move dma_data from snd_soc_dai to snd_soc_pcm_stream
      Merge branch 'for-2.6.34' into for-2.6.35

Misael Lopez Cruz (1):
      ASoC: TWL6040: Add twl6040 codec driver

Olaya, Margarita (1):
      OMAP4: PMIC: Rename twl6030_codec as twl6040_codec

Peter Ujfalusi (3):
      ASoC: omap-mcbsp: Add support for Left Justified format
      ASoC: tlv320dac33: Fix DSP modes
      ASoC: tlv320dac33: Internal clocking changes

 drivers/mfd/twl-core.c                             |    4 +-
 include/linux/i2c/twl.h                            |    6 +-
 include/sound/jack.h                               |    8 +
 include/sound/soc-dai.h                            |   18 +-
 include/sound/soc.h                                |    1 +
 sound/core/jack.c                                  |   71 +-
 sound/soc/atmel/atmel-pcm.c                        |    2 +-
 sound/soc/atmel/atmel_ssc_dai.c                    |    6 +-
 sound/soc/blackfin/Kconfig                         |    9 +-
 sound/soc/blackfin/Makefile                        |    4 +-
 .../blackfin/{bf5xx-ad1938.c => bf5xx-ad193x.c}    |   66 +-
 sound/soc/codecs/Kconfig                           |    8 +-
 sound/soc/codecs/Makefile                          |    6 +-
 sound/soc/codecs/ad1938.c                          |  521 ---------
 sound/soc/codecs/ad1938.h                          |  100 --
 sound/soc/codecs/ad193x.c                          |  558 +++++++++
 sound/soc/codecs/ad193x.h                          |   81 ++
 sound/soc/codecs/tlv320dac33.c                     |   10 +-
 sound/soc/codecs/twl6040.c                         | 1227 ++++++++++++++++++++
 sound/soc/codecs/twl6040.h                         |  141 +++
 sound/soc/codecs/wm_hubs.c                         |    2 +-
 sound/soc/davinci/davinci-i2s.c                    |    3 +-
 sound/soc/davinci/davinci-mcasp.c                  |    3 +-
 sound/soc/davinci/davinci-pcm.c                    |    4 +-
 sound/soc/davinci/davinci-vcif.c                   |    3 +-
 sound/soc/imx/imx-pcm-dma-mx2.c                    |    8 +-
 sound/soc/imx/imx-ssi.c                            |    7 +-
 sound/soc/imx/wm1133-ev1.c                         |   19 +-
 sound/soc/omap/mcpdm.c                             |  548 +++++-----
 sound/soc/omap/omap-mcbsp.c                        |   16 +-
 sound/soc/omap/omap-mcpdm.c                        |    3 +-
 sound/soc/omap/omap-pcm.c                          |    4 +-
 sound/soc/pxa/pxa-ssp.c                            |   23 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |   17 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |    7 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |    4 +-
 sound/soc/s3c24xx/s3c-ac97.c                       |   21 +-
 sound/soc/s3c24xx/s3c-dma.c                        |    4 +-
 sound/soc/s3c24xx/s3c-i2s-v2.c                     |   13 +-
 sound/soc/s3c24xx/s3c-pcm.c                        |    7 +-
 sound/soc/s3c24xx/s3c2412-i2s.c                    |    7 +-
 sound/soc/s3c24xx/s3c24xx-i2s.c                    |   19 +-
 sound/soc/s6000/s6000-i2s.c                        |    3 +-
 sound/soc/s6000/s6000-pcm.c                        |   40 +-
 sound/soc/sh/Kconfig                               |    1 +
 sound/soc/soc-core.c                               |   27 +-
 46 files changed, 2611 insertions(+), 1049 deletions(-)
 rename sound/soc/blackfin/{bf5xx-ad1938.c => bf5xx-ad193x.c} (65%)
 delete mode 100644 sound/soc/codecs/ad1938.c
 delete mode 100644 sound/soc/codecs/ad1938.h
 create mode 100644 sound/soc/codecs/ad193x.c
 create mode 100644 sound/soc/codecs/ad193x.h
 create mode 100755 sound/soc/codecs/twl6040.c
 create mode 100644 sound/soc/codecs/twl6040.h
