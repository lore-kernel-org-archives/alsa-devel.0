From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.40
Date: Tue, 3 May 2011 11:27:34 +0100
Message-ID: <20110503102734.GC1762@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 650AF1037EE
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 12:27:35 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 773b1d3d31bbf7257c48f6257b4ab06bcf4f5dfa:

  ASoC: Tegra: Support more boards (2011-04-18 21:34:16 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.40

Ben Gardiner (4):
      ASoC: davinci-mcasp: correct tdm_slots limit
      davinci-mcasp: use bitfield definitions for PDIR
      davinci-mcasp: fix _CBM_CFS hw_params
      davinci-mcasp: fix _CBM_CFS pin directions

Kuninori Morimoto (3):
      ASoC: sh: fsi: add fsi_is_clk_master function
      ASoC: sh: fsi: add dev_pm_ops :: suspend/resume
      ASoC: sh: fsi: Add module/port clock control function

Lars-Peter Clausen (1):
      ASoC: Add dapm_find_widget helper

Lu Guanqun (4):
      ASoC: fix a simple coding style issue
      ASoC: remove unused comment
      ASoC: simple style fix
      ASoC: fix two ident style problems

Mark Brown (19):
      Merge branch 'tegra' into for-2.6.40
      ASoC: Remove default settings from Tegra Kconfig
      Merge branch 'for-2.6.39' into for-2.6.40
      ASoC: Support 24.576MHz MCLKs in WM8915
      ASoC: Support FLL lock interrupt on WM8962
      ASoC: Move WM8962 FLL configuration to CODEC
      ASoC: Define constants for WM8962 GPIO functions
      ASoC: Implement WM8962 DMIC support
      ASoC: Don't warn if the WM8962 SYSCLK FLL setting doesn't match reality
      ASoC: Allow platform drivers to have no ops structure
      ASoC: Add more natural support for no-DMA DAIs
      ASoC: Don't specify the DMA driver for Speyside baseband link
      ASoC: Implement WM8962 ADC high pass filter configuration
      ASoC: Work around allmodconfig failure
      ASoC: Fix CODEC name in Goni
      ASoC: Fix CODEC DAI names for Goni
      Merge branch 'for-2.6.39' into for-2.6.40
      ASoC: Don't specify the DMA driver for OpenMoko baseband link
      ASoC: Don't specify the DMA driver for Goni baseband link

Peter Hsiang (1):
      ASoC: Add EQ and filter to max98095 CODEC driver

Stephen Warren (8):
      ASoC: Tegra: wm8903 probe: Don't call machine_is_*()
      ASoC: Tegra: wm8903: Remove redundant drvdata clears
      ASoC: Tegra: Don't return mclk_changed from utils_set_rate
      ASoC: Tegra: Retrieve card from DAPM context not codec
      ASoC: snd_soc_dapm_get_pin_status: Match other contexts too
      ASoC: Tegra: wm8903: s/code/data/ for control/widget/maps
      ASoC: WM8903: Implement DMIC support
      ARM: Tegra: select MACH_HAS_SND_SOC_TEGRA_WM8903

 arch/arm/mach-tegra/Kconfig        |    3 +
 include/sound/max98095.h           |   28 +++
 include/sound/soc-dapm.h           |    2 +-
 include/sound/soc.h                |    3 +
 include/sound/wm8962.h             |   22 ++
 sound/soc/codecs/max98095.c        |  391 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/max98095.h        |   15 ++
 sound/soc/codecs/wm8903.c          |   23 ++-
 sound/soc/codecs/wm8915.c          |    7 +-
 sound/soc/codecs/wm8962.c          |   63 ++++++-
 sound/soc/davinci/davinci-mcasp.c  |   19 +-
 sound/soc/samsung/goni_wm8994.c    |    9 +-
 sound/soc/samsung/neo1973_wm8753.c |    1 -
 sound/soc/samsung/speyside.c       |    1 -
 sound/soc/sh/fsi.c                 |  188 ++++++++++++++---
 sound/soc/soc-cache.c              |    1 -
 sound/soc/soc-core.c               |   67 ++++---
 sound/soc/soc-dapm.c               |  111 +++++------
 sound/soc/soc-utils.c              |   53 +++++
 sound/soc/tegra/Kconfig            |   12 +-
 sound/soc/tegra/tegra_asoc_utils.c |    9 +-
 sound/soc/tegra/tegra_asoc_utils.h |    2 +-
 sound/soc/tegra/tegra_wm8903.c     |   84 +++-----
 23 files changed, 904 insertions(+), 210 deletions(-)
