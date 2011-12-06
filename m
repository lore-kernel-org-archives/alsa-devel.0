From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.2
Date: Tue, 6 Dec 2011 10:16:42 +0000
Message-ID: <20111206101641.GB28840@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 969A8103B68
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 11:16:45 +0100 (CET)
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

The following changes since commit bda63586bc5929e97288cdb371bb6456504867ed:

  firmware: Sigma: Fix endianess issues (2011-11-29 11:59:50 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.2

Mostly the usual small driver fixes - the DMA driver stub is really the
same thing, it's just for a stub driver that is provided by the core
rather than for an actual driver.

Axel Lin (4):
      ASoC: kirkwood: Make SND_KIRKWOOD_SOC_OPENRD and SND_KIRKWOOD_SOC_T5325 depend on I2C
      ASoC: uda1380: Return proper error in uda1380_modinit failure path
      ASoC: Fix dependency for SND_SOC_RAUMFELD and SND_PXA2XX_SOC_HX4700
      ASoC: Make SND_SOC_MX27VIS_AIC32X4 depend on I2C

Mark Brown (3):
      ASoC: Mark WM8994 ADC muxes as virtual
      ASoC: Remove references to corgi and spitz from machine driver document
      ASoC: Provide a more complete DMA driver stub

 Documentation/sound/alsa/soc/machine.txt |    6 +---
 sound/soc/codecs/uda1380.c               |    4 +-
 sound/soc/codecs/wm8994.c                |   12 +++++-----
 sound/soc/imx/Kconfig                    |    2 +-
 sound/soc/kirkwood/Kconfig               |    3 +-
 sound/soc/pxa/Kconfig                    |    3 +-
 sound/soc/soc-utils.c                    |   31 +++++++++++++++++++++++++++++-
 7 files changed, 45 insertions(+), 16 deletions(-)
