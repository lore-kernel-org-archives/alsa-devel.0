From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/5] ASoC driver updates
Date: Fri, 31 Oct 2008 13:18:28 +0000
Message-ID: <20081031131828.GA8253@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8496D24526
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 14:18:29 +0100 (CET)
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

The following changes since commit 57b41898c2ecd13a9d338b66ef23f66caab5c4e9:
  Stephen Rothwell (1):
        ALSA: ASoC - restore removed variable declaration

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Note that this series was generated with git format-patch -M and so
won't apply with ordianary diff.

Sedji Gaouaou (2):
      ASoC: Merge AT91 and AVR32 support into a single atmel architecture
      ASoC: Add audio support for the Atmel AT91SAM9G20ek board(uing wolfson 8731).

Steve Sakoman (3):
      ASoC: Add support for TWL4030 audio codec
      ASoC: Add support for Gumstix Overo
      ASoC: Add support for Beagleboard

 sound/soc/Kconfig                                |    3 +-
 sound/soc/Makefile                               |    2 +-
 sound/soc/at32/Kconfig                           |   34 -
 sound/soc/at32/Makefile                          |   11 -
 sound/soc/at32/at32-pcm.h                        |   79 --
 sound/soc/at32/at32-ssc.c                        |  849 ----------------------
 sound/soc/at32/at32-ssc.h                        |   59 --
 sound/soc/at91/Kconfig                           |   10 -
 sound/soc/at91/Makefile                          |    6 -
 sound/soc/at91/at91-pcm.c                        |  434 -----------
 sound/soc/at91/at91-pcm.h                        |   72 --
 sound/soc/at91/at91-ssc.c                        |  791 --------------------
 sound/soc/at91/at91-ssc.h                        |   27 -
 sound/soc/atmel/Kconfig                          |   43 ++
 sound/soc/atmel/Makefile                         |   15 +
 sound/soc/{at32/at32-pcm.c => atmel/atmel-pcm.c} |  376 +++++-----
 sound/soc/atmel/atmel-pcm.h                      |   86 +++
 sound/soc/atmel/atmel_ssc_dai.c                  |  782 ++++++++++++++++++++
 sound/soc/atmel/atmel_ssc_dai.h                  |  121 +++
 sound/soc/{at32 => atmel}/playpaq_wm8510.c       |    4 +-
 sound/soc/atmel/sam9g20_wm8731.c                 |  329 +++++++++
 sound/soc/codecs/Kconfig                         |    5 +
 sound/soc/codecs/Makefile                        |    2 +
 sound/soc/codecs/twl4030.c                       |  653 +++++++++++++++++
 sound/soc/codecs/twl4030.h                       |  197 +++++
 sound/soc/omap/Kconfig                           |   10 +
 sound/soc/omap/Makefile                          |    3 +
 sound/soc/omap/omap3beagle.c                     |  149 ++++
 sound/soc/omap/overo.c                           |  148 ++++
 29 files changed, 2731 insertions(+), 2569 deletions(-)
 delete mode 100644 sound/soc/at32/Kconfig
 delete mode 100644 sound/soc/at32/Makefile
 delete mode 100644 sound/soc/at32/at32-pcm.h
 delete mode 100644 sound/soc/at32/at32-ssc.c
 delete mode 100644 sound/soc/at32/at32-ssc.h
 delete mode 100644 sound/soc/at91/Kconfig
 delete mode 100644 sound/soc/at91/Makefile
 delete mode 100644 sound/soc/at91/at91-pcm.c
 delete mode 100644 sound/soc/at91/at91-pcm.h
 delete mode 100644 sound/soc/at91/at91-ssc.c
 delete mode 100644 sound/soc/at91/at91-ssc.h
 create mode 100644 sound/soc/atmel/Kconfig
 create mode 100644 sound/soc/atmel/Makefile
 rename sound/soc/{at32/at32-pcm.c => atmel/atmel-pcm.c} (50%)
 create mode 100644 sound/soc/atmel/atmel-pcm.h
 create mode 100644 sound/soc/atmel/atmel_ssc_dai.c
 create mode 100644 sound/soc/atmel/atmel_ssc_dai.h
 rename sound/soc/{at32 => atmel}/playpaq_wm8510.c (99%)
 create mode 100644 sound/soc/atmel/sam9g20_wm8731.c
 create mode 100644 sound/soc/codecs/twl4030.c
 create mode 100644 sound/soc/codecs/twl4030.h
 create mode 100644 sound/soc/omap/omap3beagle.c
 create mode 100644 sound/soc/omap/overo.c
