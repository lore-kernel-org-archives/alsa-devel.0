From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/17] ASoC updates
Date: Tue, 18 Nov 2008 12:37:35 +0000
Message-ID: <20081118123735.GA2747@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 608721037ED
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 13:37:37 +0100 (CET)
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

The following changes since commit 71cfc9028d762419ce4dea62b4afc9c32c4b4820:
  Mark Brown (1):
        ASoC: Add WM8728 codec driver

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Bryan Wu (1):
      ASoC: Blackfin: Simplify the MMAP_SUPPORT macros protected code

Christian Pellegrin (2):
      ASoC: UDA134x codec driver
      ASoC: Machine driver for for s3c24xx with uda134x

Cliff Cai (3):
      ASoC: AD1980 codec: add multi-channel function support
      ASoC: Blackfin: add multi-channel function support
      ASoC: Blackfin: Fix AD1980/1 build with MMAP support disabled

Mark Brown (5):
      ASoC: Allow writes to uncached registers in WM8990
      ASoC: Enable WM8990 ADC clocking workaround
      ASoC: Manage VMID mode for WM8990
      ASoC: Build tlv320aic23 cleanly
      ASoC: Move uda134x_codec.h to uda134x.h

Michael Hennerich (1):
      ASoC: Fix Blackfin AC97 DAI probe function return code

Mike Frysinger (3):
      ASoC: Blackfin: updates Kconfig for SPORT
      ASoC: Blackfin: do not force TWI bus for ssm2602 codec
      ASoC: Blackfin: always set a default value for that GPIO range

Naresh Medisetty (1):
      ASoC: DaVinci: Fix audio stall when doing full duplex

Peter Ujfalusi (1):
      ASoC: Fix for master playback/capture volume range for TWL4030 codec

 include/sound/l3.h                  |   18 +
 include/sound/s3c24xx_uda134x.h     |   14 +
 include/sound/uda134x.h             |   26 ++
 sound/soc/blackfin/Kconfig          |   18 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c |  101 +++---
 sound/soc/blackfin/bf5xx-ac97.c     |  158 +++++----
 sound/soc/blackfin/bf5xx-ac97.h     |   35 ++-
 sound/soc/blackfin/bf5xx-sport.h    |    2 +-
 sound/soc/codecs/Kconfig            |    8 +
 sound/soc/codecs/Makefile           |    4 +
 sound/soc/codecs/ad1980.c           |   19 +-
 sound/soc/codecs/l3.c               |   91 +++++
 sound/soc/codecs/tlv320aic23.c      |   13 +-
 sound/soc/codecs/twl4030.c          |    4 +-
 sound/soc/codecs/uda134x.c          |  656 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/uda134x.h          |   36 ++
 sound/soc/codecs/wm8990.c           |   23 +-
 sound/soc/codecs/wm8990.h           |    4 +-
 sound/soc/davinci/davinci-i2s.c     |   31 +-
 sound/soc/s3c24xx/Kconfig           |    5 +
 sound/soc/s3c24xx/Makefile          |    2 +
 sound/soc/s3c24xx/s3c24xx_uda134x.c |  374 ++++++++++++++++++++
 22 files changed, 1488 insertions(+), 154 deletions(-)
 create mode 100644 include/sound/l3.h
 create mode 100644 include/sound/s3c24xx_uda134x.h
 create mode 100644 include/sound/uda134x.h
 create mode 100644 sound/soc/codecs/l3.c
 create mode 100644 sound/soc/codecs/uda134x.c
 create mode 100644 sound/soc/codecs/uda134x.h
 create mode 100644 sound/soc/s3c24xx/s3c24xx_uda134x.c
