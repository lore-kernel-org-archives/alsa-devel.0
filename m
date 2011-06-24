From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.1
Date: Fri, 24 Jun 2011 11:36:57 +0100
Message-ID: <20110624103657.GB9483@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0A3A52413A
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 12:36:59 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit f192c0ab2420aa59d6fae26564b14adf97456063:

  ASoC: SMDKV310: Enable SPDIF device (2011-06-10 11:05:09 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.1

Arnaud Patard (2):
      ASoC: imx: Remove unused Kconfig SND_MXC_SOC_SSI entry
      ASoC: imx: add missing module informations

Barry Song (1):
      ASoC: AD1836: rename suspend/resume funcs

Dan Carpenter (1):
      ASoC: adau1701: signedness bug in adau1701_write()

Daniel Mack (1):
      ASoC: pxa-ssp: Correct check for stream presence

Johannes Stezenbach (2):
      ASoC: add STA32X codec driver
      ASoC: add WM8782 ADC Codec Driver

Lars-Peter Clausen (2):
      ASoC: Add ADAU1701 codec driver
      ASoC: Blackfin: Add bf5xx-adau1701 machine driver

Liam Girdwood (1):
      ASoC: dapm - Refactor widget IO functions in preparation for platform widgets.

Mark Brown (15):
      ASoC: Factor out redundant read() functions
      ASoC: Move register I/O code into a separate file
      ASoC: Add weak routes for sidetone style paths
      ASoC: Don't use codec->control_data in bulk write
      ASoC: Remove unused and about to be broken SND_SOC_CUSTOM I/O bus
      Merge branch 'for-3.0' into for-3.1
      ASoC: Fix mismerge with release branch
      ASoC: Clean up some coding style nits in the bf5xx-i2s-pcm driver
      ASoC: Add adau* drivers to the Analog Devices file patterns
      ASoC: Remove adau1701 from SND_SOC_ALL_CODECS due to Sigma dependency
      ASoC: Fix DAPM sequence run for per-widget I/O methods
      ASoC: Trigger wm_hubs series update startup off a separate flag
      ASoC: Allow suppression of series updates on wm_hubs devices
      ASoC: Add basic WM8918 support
      Merge branch 'for-3.0' into for-3.1

Mike Frysinger (5):
      ASoC: AD1836: clean up comment headers
      ASoC: AD1836: drop unnecessary spi register check
      ASoC: AD1836: fix intermixed tab/space indentation
      ASoC: AD1836: fix codec name
      ASoC: Blackfin: allow SPI for SSM2602 parts

Taylor Hutt (1):
      ASoC: codecs: Max98095: Fix logging of hardware revision.

 MAINTAINERS                             |    1 +
 include/sound/soc-dapm.h                |    3 +
 include/sound/soc.h                     |    3 +-
 sound/soc/Makefile                      |    3 +-
 sound/soc/blackfin/Kconfig              |   14 +-
 sound/soc/blackfin/Makefile             |    2 +
 sound/soc/blackfin/bf5xx-i2s-pcm.c      |    6 +-
 sound/soc/blackfin/bfin-eval-adau1701.c |  139 ++++++
 sound/soc/codecs/Kconfig                |   14 +-
 sound/soc/codecs/Makefile               |    6 +
 sound/soc/codecs/ad1836.c               |   78 ++--
 sound/soc/codecs/ad1836.h               |   21 +-
 sound/soc/codecs/adau1701.c             |  549 ++++++++++++++++++++++
 sound/soc/codecs/adau1701.h             |   17 +
 sound/soc/codecs/max98095.c             |    8 +-
 sound/soc/codecs/sta32x.c               |  777 +++++++++++++++++++++++++++++++
 sound/soc/codecs/sta32x.h               |  210 +++++++++
 sound/soc/codecs/wm8782.c               |   80 ++++
 sound/soc/codecs/wm8904.c               |    1 +
 sound/soc/codecs/wm8993.c               |    1 +
 sound/soc/codecs/wm8994.c               |    1 +
 sound/soc/codecs/wm_hubs.c              |    5 +-
 sound/soc/codecs/wm_hubs.h              |    2 +
 sound/soc/imx/Kconfig                   |    7 -
 sound/soc/imx/imx-pcm-dma-mx2.c         |    2 +
 sound/soc/imx/imx-ssi.c                 |    2 +-
 sound/soc/pxa/pxa2xx-pcm.c              |    4 +-
 sound/soc/soc-cache.c                   |  416 -----------------
 sound/soc/soc-dapm.c                    |  142 ++++++-
 sound/soc/soc-io.c                      |  396 ++++++++++++++++
 30 files changed, 2399 insertions(+), 511 deletions(-)
 create mode 100644 sound/soc/blackfin/bfin-eval-adau1701.c
 create mode 100644 sound/soc/codecs/adau1701.c
 create mode 100644 sound/soc/codecs/adau1701.h
 create mode 100644 sound/soc/codecs/sta32x.c
 create mode 100644 sound/soc/codecs/sta32x.h
 create mode 100644 sound/soc/codecs/wm8782.c
 create mode 100644 sound/soc/soc-io.c
