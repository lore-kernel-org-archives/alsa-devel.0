From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.1
Date: Sat, 13 Aug 2011 01:11:44 +0900
Message-ID: <20110812161142.GA31583@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 39BF11039DC
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 18:11:51 +0200 (CEST)
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

The following changes since commit 8c285645ab3b05942124020b5f0b89d3b539823a:

  Merge branch 'wm8996-rename' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6 into fix/asoc (2011-08-08 10:45:31 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.1

So more changes ended up cooking in -next for the wm8750 than had been
anticipated - it should've been a simple SPI driver ID addition but it
got messed up for the modular x86_64 builds that I have difficultly in
doing while travelling.

The change from Sangbeom is another change percolating through after the
merge window that I'd forgotten about until Kukjin reminded me.

Jarkko Nikula (1):
      ASoC: omap: Update e-mail address of Jarkko Nikula

Mark Brown (8):
      Merge branch 'for-3.1' of git://git.kernel.org/.../broonie/sound-2.6.git into for-3.1
      Merge branch 'fix/asoc' of git://git.kernel.org/.../tiwai/sound-2.6 into for-3.1
      ASoC: Fix binding of WM8750 on Jive
      ASoC: Fix SPI driver binding for WM8987
      ASoC: Fix warning in Speyside WM8962
      ASoC: Fix typo in wm8750 spi_ids
      ASoC: Add missing break in WM8994 probe
      ASoC: Terminate WM8750 SPI device ID table

Sangbeom Kim (1):
      ASoC: SAMSUNG: Add I2S0 internal dma driver

Stephen Warren (3):
      ASoC: Tegra: tegra_pcm_deallocate_dma_buffer: Don't OOPS
      ASoC: Tegra: wm8903 machine driver: Allow re-insertion of module
      ASoC: WM8903: Free IRQ on device removal

 MAINTAINERS                         |    2 +-
 include/sound/tlv320aic3x.h         |    2 +-
 sound/soc/codecs/wm8750.c           |    8 +
 sound/soc/codecs/wm8903.c           |    5 +
 sound/soc/codecs/wm8994.c           |    1 +
 sound/soc/omap/n810.c               |    4 +-
 sound/soc/omap/omap-mcbsp.c         |    4 +-
 sound/soc/omap/omap-mcbsp.h         |    2 +-
 sound/soc/omap/omap-pcm.c           |    4 +-
 sound/soc/omap/omap-pcm.h           |    2 +-
 sound/soc/omap/rx51.c               |    2 +-
 sound/soc/samsung/Makefile          |    2 +
 sound/soc/samsung/idma.c            |  453 +++++++++++++++++++++++++++++++++++
 sound/soc/samsung/idma.h            |   26 ++
 sound/soc/samsung/jive_wm8750.c     |    2 +-
 sound/soc/samsung/speyside_wm8962.c |    2 +-
 sound/soc/tegra/tegra_pcm.c         |    9 +-
 sound/soc/tegra/tegra_wm8903.c      |   15 +-
 18 files changed, 526 insertions(+), 19 deletions(-)
 create mode 100644 sound/soc/samsung/idma.c
 create mode 100644 sound/soc/samsung/idma.h
