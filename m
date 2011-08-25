From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.1
Date: Thu, 25 Aug 2011 12:07:42 +0100
Message-ID: <20110825110741.GA25818@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0363D243F6
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 13:07:45 +0200 (CEST)
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

The following changes since commit e574044acbad7421879270a80acd337459c94cc8:

  ASoC: omap: Fix build errors in ams-delta (2011-08-19 01:19:45 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.1

A fairly large collection of small, local patches that mostly only
affect individual drivers - should be safe.

Axel Lin (1):
      ASoC: soc-core: use GFP_KERNEL flag for kmalloc in snd_soc_cnew

Joseph Pentland (1):
      ASoC: Add Springbank I/O card to Speyside Kconfig

Julia Lawall (4):
      sound/soc/kirkwood/kirkwood-i2s.c: add missing kfree
      sound/soc/ep93xx/ep93xx-i2s.c: add missing kfree
      sound/soc/fsl/p1022_ds.c: add missing of_node_put
      sound/soc/fsl/mpc8610_hpcd.c: add missing of_node_put

Mark Brown (6):
      ASoC: WM8996 record paths need AIFCLK
      ASoC: Fix configuration of WM8996 input enables
      ASoC: Ensure we only run Speyside WM8962 bias level callbacks once
      ASoC: Clear any outstanding WM8962 FLL lock completions before waiting
      ASoC: Clear completions from late WM8996 FLL lock IRQs
      ASoC: Correct element count for WM8996 sidetone HPF

Sangbeom Kim (1):
      ASoC: Add samsung maintainer

Stephen Warren (1):
      ASoC: Tegra: wm8903 machine driver: Drop Ventana support

Timur Tabi (1):
      sound/soc/fsl/fsl_dma.c: add missing of_node_put

 MAINTAINERS                         |    1 +
 sound/soc/codecs/wm8962.c           |    4 ++++
 sound/soc/codecs/wm8996.c           |   28 ++++++++++++++++++----------
 sound/soc/ep93xx/ep93xx-i2s.c       |    5 +++--
 sound/soc/fsl/fsl_dma.c             |    2 ++
 sound/soc/fsl/mpc8610_hpcd.c        |   18 +++++++++---------
 sound/soc/fsl/p1022_ds.c            |    4 +++-
 sound/soc/kirkwood/kirkwood-i2s.c   |    2 +-
 sound/soc/samsung/Kconfig           |    1 +
 sound/soc/samsung/speyside_wm8962.c |    6 ++++++
 sound/soc/soc-core.c                |    2 +-
 sound/soc/tegra/tegra_wm8903.c      |    4 ++--
 12 files changed, 51 insertions(+), 26 deletions(-)
