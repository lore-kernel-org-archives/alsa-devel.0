From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updats for 2.6.30
Date: Fri, 23 Jan 2009 17:16:19 +0000
Message-ID: <20090123171619.GB6003@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B36424482
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 18:16:20 +0100 (CET)
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

The following changes since commit 56692396447ca3fee061c26f22590a1046fd2d6b:
  Mark Brown (1):
        Merge branch 'for-2.6.29' into for-2.6.30

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

(the usual git URI should work eventually as well but the mirroring
appears to be stuck right now and it's past 5pm on a Friday.)

Mark Brown (7):
      ASoC: Fix merge with PXA tree
      ASoC: Remove unneeded e7x0 inclusion of pxa-regs.h and hardware.h
      ASoC: Configure SSP port PLL for Zylonite
      ASoC: Fix spurious codec driver dependencies
      Merge branch 'for-2.6.29' into for-2.6.30
      ASoC: Include header file in cs4270 and wm9705
      ASoC: Fix L3 bus handling in Kconfig

Peter Ujfalusi (1):
      ASoC: Add missing comma to SND_SOC_DAPM_SWITCH_E in soc-dapm.h

Steve Sakoman (1):
      ASoC: Complete Beagleboard support

Timur Tabi (1):
      ASoC: remove stand-alone mode support from CS4270 codec driver

 include/sound/soc-dapm.h    |    2 +-
 sound/soc/codecs/Kconfig    |    5 +--
 sound/soc/codecs/cs4270.c   |   90 +++++++++++++------------------------------
 sound/soc/codecs/wm9705.c   |    2 +
 sound/soc/fsl/Kconfig       |    3 +-
 sound/soc/omap/Kconfig      |   14 ++++++-
 sound/soc/omap/Makefile     |    2 +
 sound/soc/pxa/e740_wm9705.c |    2 -
 sound/soc/pxa/e750_wm9705.c |    2 -
 sound/soc/pxa/e800_wm9712.c |    5 +--
 sound/soc/pxa/zylonite.c    |    8 ++++
 sound/soc/s3c24xx/Kconfig   |    1 +
 12 files changed, 57 insertions(+), 79 deletions(-)
