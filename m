From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Wed, 11 Nov 2009 10:05:24 +0000
Message-ID: <20091111100524.GA6432@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B84B8243FC
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 11:05:25 +0100 (CET)
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

The following changes since commit 4cae37fa98f4d50778161ec033122444e3c10a01:
  Takashi Iwai (1):
        ASoC: Remove dead code and labels

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Graeme Gregory (1):
      ASoC: omap-mcbsp - add support for upto 16 channels.

Grant Likely (6):
      ASoC/mpc5200: Track DMA position by period number instead of bytes
      ASoC/mpc5200: get rid of the appl_ptr tracking nonsense
      ASoC/mpc5200: Improve printk debug output for trigger
      ASoC/mpc5200: add to_psc_dma_stream() helper
      ASoC/mpc5200: fix enable/disable of AC97 slots
      ASoC: mpc5200: remove duplicate identical IRQ handler

Jarkko Nikula (1):
      ASoC: Pandora: Pass SRG input clock frequency to the OMAP McBSP DAI

Mark Brown (1):
      Merge branch 'twl4030-mfd' into for-2.6.33

Peter Ujfalusi (4):
      MFD: TWL4030: Add audio_mclk to the codec platform data
      OMAP: Configure audio_mclk for twl4030-codec MFD
      MFD: twl4030-codec: APLL_INFREQ handling in the MFD driver
      ASoC: TWL4030: Do not modify the APLL_CTL register

 arch/arm/mach-omap2/board-3430sdp.c      |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c  |    1 +
 arch/arm/mach-omap2/board-omap3evm.c     |    1 +
 arch/arm/mach-omap2/board-omap3pandora.c |    1 +
 arch/arm/mach-omap2/board-overo.c        |    1 +
 arch/arm/mach-omap2/board-zoom2.c        |    1 +
 drivers/mfd/twl4030-codec.c              |   35 +++++++++
 include/linux/i2c/twl4030.h              |    1 +
 include/linux/mfd/twl4030-codec.h        |    1 +
 sound/soc/codecs/twl4030.c               |   76 ++++++++-----------
 sound/soc/fsl/mpc5200_dma.c              |  123 ++++++------------------------
 sound/soc/fsl/mpc5200_dma.h              |   24 ++++--
 sound/soc/fsl/mpc5200_psc_ac97.c         |   39 +++++-----
 sound/soc/omap/omap-mcbsp.c              |   63 +++++++++------
 sound/soc/omap/omap3pandora.c            |   24 +++----
 15 files changed, 183 insertions(+), 209 deletions(-)
