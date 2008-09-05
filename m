From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/14] ASoC: Blackfin and I2C updats
Date: Fri, 5 Sep 2008 15:35:05 +0100
Message-ID: <20080905143504.GA27793@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 105351037EE
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 16:35:10 +0200 (CEST)
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

The following changes since commit 44e2c3045f77c69d18ba4afda888a4cdec4a33fd:
  Cliff Cai (1):
        ALSA: ASoC codec: fix compiling error in ad1980 driver after ASoC API changed

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Cliff Cai (10):
      ASoC codec: SSM2602 audio codec driver
      ASoC: Blackfin: SPORT peripheral interface driver
      ASoC: Blackfin: DMA Driver for AC97 sound chip
      ASoC: Blackfin: AC97 Blackfin CPU DAI driver
      ASoC: Blackfin: DMA Driver for I2S sound chip
      ASoC: Blackfin: I2S CPU DAI driver
      ASoC: Blackfin: board driver for AD1980/1 audio codec
      ASoC: Blackfin: board driver for SSM2602 sound chip
      ASoC: Blackfin: add Blackfin arch ASoC Kconfig and Makefile
      ASoC: Blackfin: Include Blackfin architecture support in build

Jean Delvare (4):
      ASoC: Fix an error path in neo1973_wm8753
      ASoC: Convert wm8753 to a new-style i2c driver
      ASoC: Convert neo1973/lm4857 to a new-style i2c driver
      ASoC: Convert wm8510 to a new-style i2c driver

 sound/soc/Kconfig                   |    1 +
 sound/soc/Makefile                  |    2 +-
 sound/soc/at32/playpaq_wm8510.c     |    1 +
 sound/soc/blackfin/Kconfig          |   85 +++
 sound/soc/blackfin/Makefile         |   20 +
 sound/soc/blackfin/bf5xx-ac97-pcm.c |  429 +++++++++++++++
 sound/soc/blackfin/bf5xx-ac97-pcm.h |   29 +
 sound/soc/blackfin/bf5xx-ac97.c     |  407 ++++++++++++++
 sound/soc/blackfin/bf5xx-ac97.h     |   36 ++
 sound/soc/blackfin/bf5xx-ad1980.c   |  113 ++++
 sound/soc/blackfin/bf5xx-i2s-pcm.c  |  288 ++++++++++
 sound/soc/blackfin/bf5xx-i2s-pcm.h  |   29 +
 sound/soc/blackfin/bf5xx-i2s.c      |  292 ++++++++++
 sound/soc/blackfin/bf5xx-i2s.h      |   14 +
 sound/soc/blackfin/bf5xx-sport.c    | 1032 +++++++++++++++++++++++++++++++++++
 sound/soc/blackfin/bf5xx-sport.h    |  192 +++++++
 sound/soc/blackfin/bf5xx-ssm2602.c  |  186 +++++++
 sound/soc/codecs/Kconfig            |    4 +
 sound/soc/codecs/Makefile           |    2 +
 sound/soc/codecs/ssm2602.c          |  776 ++++++++++++++++++++++++++
 sound/soc/codecs/ssm2602.h          |  130 +++++
 sound/soc/codecs/wm8510.c           |  110 ++--
 sound/soc/codecs/wm8510.h           |    1 +
 sound/soc/codecs/wm8753.c           |  106 ++--
 sound/soc/codecs/wm8753.h           |    1 +
 sound/soc/s3c24xx/neo1973_wm8753.c  |  113 +++--
 26 files changed, 4237 insertions(+), 162 deletions(-)
 create mode 100644 sound/soc/blackfin/Kconfig
 create mode 100644 sound/soc/blackfin/Makefile
 create mode 100644 sound/soc/blackfin/bf5xx-ac97-pcm.c
 create mode 100644 sound/soc/blackfin/bf5xx-ac97-pcm.h
 create mode 100644 sound/soc/blackfin/bf5xx-ac97.c
 create mode 100644 sound/soc/blackfin/bf5xx-ac97.h
 create mode 100644 sound/soc/blackfin/bf5xx-ad1980.c
 create mode 100644 sound/soc/blackfin/bf5xx-i2s-pcm.c
 create mode 100644 sound/soc/blackfin/bf5xx-i2s-pcm.h
 create mode 100644 sound/soc/blackfin/bf5xx-i2s.c
 create mode 100644 sound/soc/blackfin/bf5xx-i2s.h
 create mode 100644 sound/soc/blackfin/bf5xx-sport.c
 create mode 100644 sound/soc/blackfin/bf5xx-sport.h
 create mode 100644 sound/soc/blackfin/bf5xx-ssm2602.c
 create mode 100644 sound/soc/codecs/ssm2602.c
 create mode 100644 sound/soc/codecs/ssm2602.h
