From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Tue, 28 Apr 2009 16:22:56 +0100
Message-ID: <20090428152256.GB2244@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D9A5244B3
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 17:22:57 +0200 (CEST)
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

The following changes since commit 8a1f936acdfd53cb0a981f3f80483863dcd84fa9:
  Peter Ujfalusi (1):
        ASoC: TWL4030: Add 4 channel TDM support

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Daniel Mack (3):
      ASoC: add SOC_DOUBLE_EXT macro
      ASoC: cs4270: fix Master Capture Switch polarity
      ASoC: cs4270: add Master Playback Switch

Jon Smirl (3):
      ASoC: Set the MPC5200 i2s driver to BROKEN status.
      ASoC: Basic split of mpc5200 DMA code out from mpc5200_psc_i2s
      ASoC: Rename the PSC functions to DMA

Jonathan Cameron (1):
      ASoC WM8940 Driver

Joonyoung Shim (1):
      ASoC: TWL4030: Fix gain control for earpiece amplifier

Mark Brown (10):
      ASoC: Fix S3C64xx IIS device registration and support both ports
      ASoC: S3C2412: Failing to get the I2S clock is an error
      ASoC: Enforce symmetric rates for S3C64xx I2S interface
      ASoC: Include WM8350 register definitions in CODEC header
      ASoC: s3c-i2s-v2 diagnostic improvements
      ASoC: Use our registration function for S3C64xx
      ASoC: Fix logic in WM8350 master clocking check
      Merge branch 'for-2.6.30' into for-2.6.31
      ASoC: Staticise TLV values in WM8940
      Merge branch 'for-2.6.30' into for-2.6.31

Peter Ujfalusi (1):
      ASoC: Beagle: Add support for 4 channel

 include/sound/soc.h             |    8 +
 sound/soc/codecs/Kconfig        |    4 +
 sound/soc/codecs/Makefile       |    2 +
 sound/soc/codecs/cs4270.c       |   44 ++-
 sound/soc/codecs/twl4030.c      |    8 +-
 sound/soc/codecs/wm8350.c       |    2 +-
 sound/soc/codecs/wm8350.h       |    1 +
 sound/soc/codecs/wm8940.c       |  955 +++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8940.h       |  104 +++++
 sound/soc/fsl/Kconfig           |    6 +-
 sound/soc/fsl/Makefile          |    2 +
 sound/soc/fsl/mpc5200_dma.c     |  457 +++++++++++++++++++
 sound/soc/fsl/mpc5200_dma.h     |   81 ++++
 sound/soc/fsl/mpc5200_psc_i2s.c |  644 ++++-----------------------
 sound/soc/omap/omap3beagle.c    |   26 +-
 sound/soc/s3c24xx/s3c2412-i2s.c |    2 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c |  148 ++++--
 sound/soc/s3c24xx/s3c64xx-i2s.h |    2 +-
 18 files changed, 1867 insertions(+), 629 deletions(-)
 create mode 100644 sound/soc/codecs/wm8940.c
 create mode 100644 sound/soc/codecs/wm8940.h
 create mode 100644 sound/soc/fsl/mpc5200_dma.c
 create mode 100644 sound/soc/fsl/mpc5200_dma.h
