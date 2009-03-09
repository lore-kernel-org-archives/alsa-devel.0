From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Mon, 9 Mar 2009 10:52:54 +0000
Message-ID: <20090309105254.GA991@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5D791037F3
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 11:52:55 +0100 (CET)
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

The following changes since commit f271fa28fbaf947d9c79f188dd149176da727dd5:
  Takashi Iwai (1):
        ASoC: Fix Kconfig dependency of CONFIG_SND_S3C24XX_SOC_JIVE_WM8750

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Daniel Mack (2):
      ASoC: bring cs4270 feature/limitations list in sync
      ASoC: Add a driver for AK4104 S/PDIF transmitter

Hugo Villeneuve (1):
      ASoC: Davinci: Fix incorrect machine type for SFFSDR board

Mark Brown (3):
      ASoC: Re-remove hand-rolled pr_debug() macros
      ASoC: Fix logging severity for some S3C error messages
      ASoC: Remove unneeded forward reference to WM8753 SPI implementation

Timur Tabi (1):
      ASoC: Improve pause/unpause performance in Freescale 8610 drivers

 sound/soc/codecs/Kconfig           |    4 +
 sound/soc/codecs/Makefile          |    2 +
 sound/soc/codecs/ak4104.c          |  363 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ak4104.h          |    7 +
 sound/soc/codecs/cs4270.c          |   15 +-
 sound/soc/codecs/wm8753.c          |    5 -
 sound/soc/davinci/Kconfig          |    2 +-
 sound/soc/fsl/fsl_dma.c            |    3 +-
 sound/soc/fsl/fsl_ssi.c            |   23 ++-
 sound/soc/s3c24xx/neo1973_wm8753.c |   44 ++---
 sound/soc/s3c24xx/s3c-i2s-v2.c     |   49 ++---
 sound/soc/s3c24xx/s3c2412-i2s.c    |   12 +-
 sound/soc/s3c24xx/s3c24xx-i2s.c    |   49 ++---
 sound/soc/s3c24xx/s3c24xx-pcm.c    |   45 ++---
 14 files changed, 482 insertions(+), 141 deletions(-)
 create mode 100644 sound/soc/codecs/ak4104.c
 create mode 100644 sound/soc/codecs/ak4104.h
