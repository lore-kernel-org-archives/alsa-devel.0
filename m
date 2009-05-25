From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Mon, 25 May 2009 13:07:57 +0100
Message-ID: <20090525120757.GA13010@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D89B910385A
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 14:07:58 +0200 (CEST)
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

The following changes since commit 86ed3669f068b514ab85ffd548456a342b3fb8d3:
  Mark Brown (1):
        ASoC: WM9081 mono DAC with integrated 2.6W class AB/D amplifier driver

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Jon Smirl (4):
      ASoC: Codec for STAC9766 used on the Efika
      ASoC: Basic split of mpc5200 DMA code out of mpc5200_psc_i2s
      ASoC: Rename the PSC functions to DMA
      ASoC: Add a few more mpc5200 PSC defines

Mark Brown (2):
      ASoC: Fix WM9081 PowerPC compiler issues
      ASoC: Fix minor issues in STAC9766 driver

Peter Ujfalusi (3):
      ASoC: TWL4030: Handsfree pop removal redesign
      ASoC: TWL4030: Add shadow register
      ASoC: TWL4030: HandsfreeL/R mute DAPM switch

 arch/powerpc/include/asm/mpc52xx_psc.h |   11 +
 sound/soc/codecs/Kconfig               |    4 +
 sound/soc/codecs/Makefile              |    2 +
 sound/soc/codecs/stac9766.c            |  463 +++++++++++++++++++++++
 sound/soc/codecs/stac9766.h            |   21 +
 sound/soc/codecs/twl4030.c             |   99 ++++-
 sound/soc/codecs/twl4030.h             |    7 +-
 sound/soc/codecs/wm9081.c              |    6 +-
 sound/soc/fsl/Kconfig                  |    4 +
 sound/soc/fsl/Makefile                 |    2 +
 sound/soc/fsl/mpc5200_dma.c            |  458 ++++++++++++++++++++++
 sound/soc/fsl/mpc5200_dma.h            |   81 ++++
 sound/soc/fsl/mpc5200_psc_i2s.c        |  645 ++++----------------------------
 13 files changed, 1217 insertions(+), 586 deletions(-)
 create mode 100644 sound/soc/codecs/stac9766.c
 create mode 100644 sound/soc/codecs/stac9766.h
 create mode 100644 sound/soc/fsl/mpc5200_dma.c
 create mode 100644 sound/soc/fsl/mpc5200_dma.h
