From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.3
Date: Thu, 12 Jan 2012 00:38:12 -0800
Message-ID: <20120112083811.GB1176@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 89D51103B37
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 09:38:17 +0100 (CET)
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

The following changes since commit d6b24507972341e5babdca8e25448325c9137232:

  Merge branch 'for-3.3' of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc into topic/asoc (2012-01-11 15:30:53 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.3

The MFD patch is an incremental patch on top of the WM8994 changes being
carried by ASoC this merge window.

Axel Lin (2):
      ASoC: Fix build dependency for SND_ATMEL_SOC_SSC
      ASoC: Fix recursive dependency due to select ATMEL_SSC in SND_ATMEL_SOC_SSC

Joachim Eastwood (1):
      ASoC: check for substream not channels_min in pcm engines

Mark Brown (3):
      ASoC: Fix idma build after update for channel count check
      mfd: Put WM8994 into cache only mode when suspending
      ASoC: Dynamically allocate the rtd device for a non-empty release()

 drivers/mfd/wm8994-core.c           |    2 +
 include/sound/soc.h                 |    6 ++--
 sound/soc/atmel/Kconfig             |    2 +-
 sound/soc/atmel/atmel-pcm.c         |    5 +--
 sound/soc/blackfin/bf5xx-ac97-pcm.c |    5 +--
 sound/soc/blackfin/bf5xx-i2s-pcm.c  |    5 +--
 sound/soc/blackfin/bf5xx-tdm-pcm.c  |    5 +--
 sound/soc/davinci/davinci-pcm.c     |    5 +--
 sound/soc/ep93xx/ep93xx-pcm.c       |    5 +--
 sound/soc/jz4740/jz4740-pcm.c       |    5 +--
 sound/soc/kirkwood/kirkwood-dma.c   |    5 +--
 sound/soc/mid-x86/sst_platform.c    |    5 +--
 sound/soc/omap/omap-pcm.c           |    5 +--
 sound/soc/samsung/dma.c             |    5 +--
 sound/soc/samsung/idma.c            |    4 +-
 sound/soc/soc-core.c                |   44 +++++++++++++++++++---------------
 sound/soc/soc-dapm.c                |    3 +-
 sound/soc/tegra/tegra_pcm.c         |    5 +--
 18 files changed, 58 insertions(+), 63 deletions(-)
