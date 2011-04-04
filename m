From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.40
Date: Tue, 5 Apr 2011 08:36:12 +0900
Message-ID: <20110404233611.GB5376@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2DC7A103814
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Apr 2011 01:36:03 +0200 (CEST)
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

The following changes since commit 00b317a41c5428b13eb7e5b4bbc691b1aa7afa80:

  ASoC: format_register_str: Don't clip register values (2011-04-03 22:11:26 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.40

Barry Song (1):
      ASoC: Blackfin: push down SPORT settings from global variables

Cliff Cai (2):
      ASoC: Blackfin I2S: add 8-bit sample support
      ASoC: SSM2602: convert to soc-cache

Dimitris Papastamos (11):
      ASoC: soc-cache: Factor-out the I2C read code
      ASoC: soc-cache: Introduce raw bulk write support
      ASoC: Add control_type in snd_soc_codec
      ASoC: soc-cache: Factor-out the hw_write() specific code
      ASoC: soc-cache: Factor-out the hw_read() specific code
      ASoC: soc-cache: Factor-out the SPI write code
      ASoC: soc-cache: Return -ENOSYS instead of -EINVAL
      ASoC: Add default snd_soc_default_writable_register() callback
      ASoC: Add snd_soc_codec_{readable,writable}_register()
      ASoC: soc-cache: Fix indentation issues
      ASoC: soc-cache: Warn on syncing any non-writable registers

Lu Guanqun (11):
      ASoC: Use data based init for ak4671 DAPM
      ASoC: Use data based init for cx20442 DAPM
      ASoC: Use data based init for max98088 DAPM
      ASoC: Use data based init for wm9713 DAPM
      ASoC: Use data based init for wm9712 DAPM
      ASoC: Use data based init for wm9705 DAPM
      ASoC: Use data based init for wm8728 DAPM
      ASoC: Use data based init for wm8711 DAPM
      ASoC: Use data based init for tlv320aic23 DAPM
      ASoC: Use data based init for ak4535 DAPM
      ASoC: Use data based init for sn95031 DAPM

Marek Vasut (1):
      ASoC: Properly handle spitz MIC GPIO

Mark Brown (18):
      ASoC: Treat WM8958 revision A as WM8994 revision D
      ASoC: Factor WM8958 DSP2 handling into separate file
      ASoC: Handle startup sequencing of WM8958 DSP2 with deferred clocking
      ASoC: Mark WM8958 DSP2 registers readable
      ASoC: Support download of WM8958 MBC firmware
      ASoC: Refactor WM8958 DSP to support additional algorithms
      ASoC: Add WM8958 VSS support
      ASoC: Add WM8958 enhanced EQ support
      Merge branch 'for-2.6.39' into for-2.6.40
      Merge branch 'for-2.6.39' into for-2.6.40
      ASoC: Convert WM8903 to table based DAPM setup
      ASoC: Convert WM8731 to table based DAPM setup
      ASoC: Remove -codec from WM8731 driver name
      Merge branch 'for-2.6.39' into for-2.6.40
      Merge branch 'for-2.6.39' into for-2.6.40
      ASoC: Remove excessively verbose logging on I2C write
      ASoC: Fix comment width in soc-cache.c
      ASoC: Add bias level data to DAPM context debugfs

Mike Frysinger (7):
      ASoC: fix sorting order of codecs in kconfig
      ASoC: SSM2602: fix codec name
      ASoC: ad73311: fix codec name
      ASoC: ad193x: fix codec name
      ASoC: ad1980: fix codec name
      ASoC: Blackfin: drop "-codec" from codec names
      ASoC: Blackfin: standardize machine driver names

Scott Jiang (3):
      ASoC: ad193x: tweak style to match other codecs
      ASoC: ad73311: drop I2C requirement
      ASoC: Blackfin: add ad193x sysclk configuration

Seungwhan Youn (1):
      ASoC: Fix to avoid compile error

Stephen Warren (1):
      ASoC: Name jack GPIOs based on jack not codec

Wolfram Sang (1):
      ASoC: imx: remove superfluous code in imx-ssi.c

 include/linux/mfd/wm8994/pdata.h    |   49 ++
 include/sound/soc.h                 |   14 +-
 sound/soc/atmel/sam9g20_wm8731.c    |    2 +-
 sound/soc/au1x/db1200.c             |    2 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c |   13 +-
 sound/soc/blackfin/bf5xx-ac97.c     |  166 ++----
 sound/soc/blackfin/bf5xx-ad1836.c   |   42 +-
 sound/soc/blackfin/bf5xx-ad193x.c   |   56 ++-
 sound/soc/blackfin/bf5xx-ad1980.c   |   45 +-
 sound/soc/blackfin/bf5xx-ad73311.c  |   42 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c  |   23 +-
 sound/soc/blackfin/bf5xx-i2s.c      |  172 +++----
 sound/soc/blackfin/bf5xx-sport.c    |  159 ++++--
 sound/soc/blackfin/bf5xx-sport.h    |   16 +-
 sound/soc/blackfin/bf5xx-ssm2602.c  |   42 +-
 sound/soc/blackfin/bf5xx-tdm-pcm.c  |   23 +-
 sound/soc/blackfin/bf5xx-tdm.c      |  110 ++---
 sound/soc/codecs/Kconfig            |    2 +-
 sound/soc/codecs/Makefile           |    2 +-
 sound/soc/codecs/ad193x.c           |   23 +-
 sound/soc/codecs/ad1980.c           |    2 +-
 sound/soc/codecs/ad73311.c          |    2 +-
 sound/soc/codecs/ak4535.c           |   19 +-
 sound/soc/codecs/ak4671.c           |   18 +-
 sound/soc/codecs/cx20442.c          |   18 +-
 sound/soc/codecs/max98088.c         |   25 +-
 sound/soc/codecs/sn95031.c          |   17 +-
 sound/soc/codecs/ssm2602.c          |  140 ++----
 sound/soc/codecs/tlv320aic23.c      |   19 +-
 sound/soc/codecs/wm8711.c           |   18 +-
 sound/soc/codecs/wm8728.c           |   18 +-
 sound/soc/codecs/wm8731.c           |   22 +-
 sound/soc/codecs/wm8903.c           |   18 +-
 sound/soc/codecs/wm8958-dsp2.c      | 1028 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8994.c           |  364 ++-----------
 sound/soc/codecs/wm8994.h           |   97 ++++
 sound/soc/codecs/wm9705.c           |   18 +-
 sound/soc/codecs/wm9712.c           |   18 +-
 sound/soc/codecs/wm9713.c           |   19 +-
 sound/soc/imx/imx-ssi.c             |    6 -
 sound/soc/pxa/corgi.c               |    2 +-
 sound/soc/pxa/poodle.c              |    2 +-
 sound/soc/pxa/spitz.c               |   41 +-
 sound/soc/soc-cache.c               |  572 +++++++-------------
 sound/soc/soc-core.c                |   46 ++
 sound/soc/soc-dapm.c                |   48 ++
 sound/soc/soc-jack.c                |    2 +-
 47 files changed, 2124 insertions(+), 1478 deletions(-)
 create mode 100644 sound/soc/codecs/wm8958-dsp2.c
