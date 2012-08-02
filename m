From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.6
Date: Thu, 2 Aug 2012 17:02:12 +0100
Message-ID: <20120802160212.GB4537@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 51FB726523E
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2012 18:11:24 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 15d47763b354256053c390a9b7bc9f2b4f197711:

  Merge branch 'for-3.5' into for-3.6 (2012-07-23 10:45:07 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.6

for you to fetch changes up to 98d3088e534a2a61f6690b5426909b0c3b57a785:

  ASoC: core: Fix check before defaulting to regmap (2012-08-02 11:43:45 +0100)

(this is a new subkey on my key which I just realised I didn't upload to
the server - will do that on Monday.)

----------------------------------------------------------------
ASoC: Additional updates for 3.6

A few updates for issues discovered during the merge window, the main
one being the fix for the issues with defaulting to use of regmap
without properly checking if there was I/O in place already.

----------------------------------------------------------------
Dong Aisheng (4):
      ASoC: mxs-saif: fix clock prepare and enable unbalance issue
      ASoC: mxs-saif: set a base clock rate for EXTMASTER mode work
      ASoC: sgtl5000: remove unneeded snd_soc_dapm_new_widgets in probe
      ASoC: sgtl5000: enable VAG_POWER for LINE_IN

Fabio Estevam (1):
      ASoC: mc13783: Provide codec->control_data

Guillaume Gardet (1):
      ASoC: omap: Add missing modules aliases to get sound working on omap devices

Lee Jones (2):
      ASoC: ux500: Include the correct header files
      ASoC: ab8500: Inform SoC Core that we have our own I/O arrangements

Manuel Lauss (1):
      ASoC: AC97 doesn't use regmap by default

Mark Brown (4):
      ASoC: wm8994: Ensure there are enough BCLKs for four channels
      ASoC: wm8994: Hold runtime PM reference while handling mic and jack IRQs
      ASoC: wm8962: Allow VMID time to fully ramp
      ASoC: core: Fix check before defaulting to regmap

Roland Stigge (2):
      sound: tegra_wm8903: Adjust to of_get_named_gpio() change
      sound: tegra_alc5632: Adjust to of_get_named_gpio() change

 sound/soc/codecs/ab8500-codec.c |    4 ++++
 sound/soc/codecs/ad1980.c       |    1 +
 sound/soc/codecs/mc13783.c      |    2 ++
 sound/soc/codecs/sgtl5000.c     |    3 +--
 sound/soc/codecs/stac9766.c     |    1 +
 sound/soc/codecs/wm8962.c       |    3 +++
 sound/soc/codecs/wm8994.c       |   15 ++++++++++++++-
 sound/soc/codecs/wm9712.c       |    1 +
 sound/soc/codecs/wm9713.c       |    1 +
 sound/soc/mxs/mxs-saif.c        |   24 ++++++++++++++++++++++++
 sound/soc/omap/omap-mcbsp.c     |    1 +
 sound/soc/omap/omap-pcm.c       |    1 +
 sound/soc/soc-core.c            |    2 +-
 sound/soc/tegra/tegra_alc5632.c |    2 +-
 sound/soc/tegra/tegra_wm8903.c  |   10 +++++-----
 sound/soc/ux500/ux500_msp_dai.c |    2 +-
 sound/soc/ux500/ux500_msp_i2s.c |    2 +-
 sound/soc/ux500/ux500_msp_i2s.h |    2 +-
 18 files changed, 64 insertions(+), 13 deletions(-)
