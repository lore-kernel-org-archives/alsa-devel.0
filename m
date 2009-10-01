From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Thu, 1 Oct 2009 16:20:52 +0100
Message-ID: <20091001152052.GC16177@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D21A244AB
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 17:20:57 +0200 (CEST)
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

The following changes since commit 140318aaa924ce9664ff59366993228cf1547f1d:
  Takashi Iwai (1):
        ASoC: Fix snd_soc_dai_set_pll() calls in neo1973_*.c

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Barry Song (1):
      ASoC: fix kconfig order of Blackfin drivers

Chaithrika U S (1):
      ASoC: DaVinci: McASP FIFO related updates

Lopez Cruz, Misael (1):
      ASoC: Add PDM DAI format definition

Mark Brown (6):
      ASoC: Clean up WM8974 PLL configuration
      Merge branch 'upstream/wm8974' into for-2.6.33
      ASoC: Factor out analogue platform data from WM8993
      Merge remote branch 'takashi/fix/asoc' into for-2.6.32
      Merge remote branch 'takashi/topic/asoc' into for-2.6.33
      Merge branch 'for-2.6.32' into for-2.6.33

Peter Ujfalusi (1):
      ASoC: add support for multiple cards/codecs in debugfs

Takashi Iwai (1):
      ASoC: Fix dependency of CONFIG_SND_PXA2XX_SOC_IMOTE2

 include/sound/soc-dai.h           |    1 +
 include/sound/soc.h               |    1 +
 sound/soc/blackfin/Kconfig        |   98 ++++++++++++++++++------------------
 sound/soc/codecs/wm8974.c         |   23 +++++----
 sound/soc/codecs/wm8993.c         |   36 +++----------
 sound/soc/codecs/wm_hubs.c        |   35 +++++++++++++
 sound/soc/codecs/wm_hubs.h        |    5 ++
 sound/soc/davinci/davinci-i2s.c   |    2 +
 sound/soc/davinci/davinci-mcasp.c |   17 +++----
 sound/soc/davinci/davinci-pcm.c   |   21 +++++++-
 sound/soc/davinci/davinci-pcm.h   |    1 +
 sound/soc/pxa/Kconfig             |    2 +-
 sound/soc/soc-core.c              |   26 +++++++---
 13 files changed, 161 insertions(+), 107 deletions(-)
