From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Thu, 20 Aug 2009 21:10:52 +0100
Message-ID: <20090820201051.GA18415@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4700C24149
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 22:10:59 +0200 (CEST)
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

The following changes since commit 474e09ca017bd0f6e9bf41af643364a21bc27f43:
  Mark Brown (1):
        ASoC: Provide default set_bias_level() implementation

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Eduardo Valentin (11):
      OMAP: McBSP: Add IRQEN, IRQSTATUS, THRESHOLD2 and THRESHOLD1 registers.
      OMAP: McBSP: Use appropriate value for startup delay
      OMAP: McBSP: Add transmit/receive threshold handler
      OMAP: McBSP: Create and export max_(r|t)x_thres property
      OMAP: McBSP: Rename thres sysfs symbols
      OMAP: McBSP: Change wakeup signals
      OMAP: McBSP: Configure NO IDLE mode for DMA mode different of threshold
      ASoC: OMAP: Enable DMA burst mode
      ASoC: OMAP: Make DMA 64 aligned
      ASoC: OMAP: Use McBSP threshold to playback and capture
      ASoC: OMAP: Use DMA operating mode of McBSP

Eero Nurkkala (7):
      OMAP: McBSP: Provide functions for ASoC frame syncronization
      OMAP: McBSP: Wakeups utilized
      OMAP: McBSP: Retain McBSP FCLK clockactivity
      OMAP: McBSP: Do not enable wakeups for no-idle mode
      OMAP: McBSP: Let element DMA mode hit retention also
      ASoC: Add runtime check for RFIG and XFIG
      ASoC: Always syncronize audio transfers on frames

Kuninori Morimoto (1):
      ASoC: Add SuperH FSI driver support for ALSA

Mark Brown (1):
      ALSA: Restore support for DMAless DAIs on PXA

Peter Ujfalusi (2):
      OMAP3: McBSP: Lower the maximum buffersize for McBSP1, 3, 4, 5
      OMAP: McBSP: Add link DMA mode selection

Shine Liu (1):
      ASoC: S3C24XX : Align the peroid size to the buffer size

 arch/arm/mach-omap2/mcbsp.c             |    5 +
 arch/arm/plat-omap/include/mach/mcbsp.h |   49 ++
 arch/arm/plat-omap/mcbsp.c              |  377 ++++++++++++-
 include/sound/sh_fsi.h                  |   83 +++
 sound/arm/pxa2xx-pcm-lib.c              |    3 +
 sound/soc/omap/omap-mcbsp.c             |   77 +++-
 sound/soc/omap/omap-pcm.c               |   14 +-
 sound/soc/omap/omap-pcm.h               |    2 +
 sound/soc/s3c24xx/s3c24xx-pcm.c         |    1 +
 sound/soc/sh/Kconfig                    |    7 +-
 sound/soc/sh/Makefile                   |    2 +
 sound/soc/sh/fsi.c                      | 1004 +++++++++++++++++++++++++++++++
 12 files changed, 1610 insertions(+), 14 deletions(-)
 create mode 100644 include/sound/sh_fsi.h
 create mode 100644 sound/soc/sh/fsi.c
