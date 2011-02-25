From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.39
Date: Fri, 25 Feb 2011 12:48:23 +0000
Message-ID: <20110225124823.GF28980@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED7C7103962
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 13:48:02 +0100 (CET)
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

The following changes since commit fadddc8753ccfab26ee57f3205d6926fe4be1350:

  ASoC: Add kerneldoc for jack_status_check callback (2011-02-18 09:14:24 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.39

Dimitris Papastamos (1):
      ASoC: soc-dapm: Include quotes around contents in debugfs entries

Dmitry Eremin-Solenikov (1):
      ASoC: correct pxa AC97 DAI names

Justin P. Mattock (1):
      ASoC: remove one to many l's in the word

Mark Brown (15):
      ASoC: Mark WM8958 microphone detection registers readable
      ASoC: Hook wm_hubs micbiases up to CLK_SYS
      ASoC: Fix WM8958 default microphone detection argument ordering
      ASoC: Correct definition of WM8903_VMID_RES_5K
      ASoC: Hook wm_hubs micbiases up to CLK_SYS
      Merge branch 'for-2.6.38' into for-2.6.39
      ASoC: Remove card from snd_soc_dapm_set_bias_level()
      ASoC: Run bias level changes for all DAPM contexts in parallel
      ASoC: Mark WM8958 microphone bias registers as readable
      ASoC: Support WM8958 direct microphone detection IRQ
      ASoC: Support configuration of WM8958 microphone bias analogue parameters
      ASoC: Simplify default WM8958 jack detection code
      ASoC: Pass the jack to jack notifiers
      ASoC: Remove -codec suffix from WM9081 driver
      Merge branch 'for-2.6.38' into for-2.6.39

Stephen Warren (1):
      ASoC: Tegra: Move utilities to separate module

Zeng Zhaoming (1):
      ASoC: Add Freescale SGTL5000 codec support

 include/linux/mfd/wm8994/pdata.h     |   12 +-
 include/linux/mfd/wm8994/registers.h |    2 +
 sound/soc/codecs/Kconfig             |    5 +
 sound/soc/codecs/Makefile            |    2 +
 sound/soc/codecs/sgtl5000.c          | 1512 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/sgtl5000.h          |  402 +++++++++
 sound/soc/codecs/wm8903.h            |    2 +-
 sound/soc/codecs/wm8994-tables.c     |   10 +-
 sound/soc/codecs/wm8994.c            |  105 ++--
 sound/soc/codecs/wm9081.c            |    2 +-
 sound/soc/codecs/wm_hubs.c           |    3 +
 sound/soc/pxa/e740_wm9705.c          |    4 +-
 sound/soc/pxa/e750_wm9705.c          |    4 +-
 sound/soc/pxa/e800_wm9712.c          |    4 +-
 sound/soc/pxa/em-x270.c              |    4 +-
 sound/soc/pxa/mioa701_wm9713.c       |    4 +-
 sound/soc/pxa/palm27x.c              |    4 +-
 sound/soc/pxa/tosa.c                 |    4 +-
 sound/soc/pxa/zylonite.c             |    4 +-
 sound/soc/samsung/dma.c              |    2 +-
 sound/soc/soc-dapm.c                 |  134 ++--
 sound/soc/soc-jack.c                 |    2 +-
 sound/soc/tegra/Makefile             |    3 +-
 sound/soc/tegra/tegra_asoc_utils.c   |    6 +
 24 files changed, 2091 insertions(+), 145 deletions(-)
 create mode 100644 sound/soc/codecs/sgtl5000.c
 create mode 100644 sound/soc/codecs/sgtl5000.h
