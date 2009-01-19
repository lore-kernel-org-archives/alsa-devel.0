From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Mon, 19 Jan 2009 16:20:35 +0000
Message-ID: <20090119162035.GA30511@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DCDF02436C
	for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2009 17:20:36 +0100 (CET)
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

The following changes since commit 2905a5df4a1600bc3c9ecace2fa65404196d1fda:
  Mark Brown (1):
        Merge branch 'for-2.6.29' into for-2.6.30

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Ian Molton (1):
      ASoC: machine support for Toshiba e740 PDA

Mark Brown (4):
      ASoC: Ignore output frequency for WM9713 PLL
      ASoC: Implement support for CLK_POUT as MCLK on Zylonite
      ASoC: fixes to caching implementations
      ASoC: Staticise PCM operations tables

 arch/arm/mach-pxa/e740.c                      |    5 +
 arch/arm/mach-pxa/include/mach/eseries-gpio.h |    5 +
 sound/soc/atmel/atmel-pcm.c                   |    2 +-
 sound/soc/au1x/dbdma2.c                       |    2 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c           |    2 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c            |    2 +-
 sound/soc/codecs/ac97.c                       |    2 -
 sound/soc/codecs/ad1980.c                     |    4 +-
 sound/soc/codecs/twl4030.c                    |    3 +
 sound/soc/codecs/wm8580.c                     |    4 +-
 sound/soc/codecs/wm8728.c                     |    4 +-
 sound/soc/codecs/wm8753.c                     |    4 +-
 sound/soc/codecs/wm8990.c                     |    4 +-
 sound/soc/codecs/wm9712.c                     |    4 +-
 sound/soc/codecs/wm9713.c                     |   14 +-
 sound/soc/davinci/davinci-pcm.c               |    2 +-
 sound/soc/omap/omap-pcm.c                     |    2 +-
 sound/soc/pxa/Kconfig                         |    9 +
 sound/soc/pxa/Makefile                        |    2 +
 sound/soc/pxa/e740_wm9705.c                   |  213 +++++++++++++++++++++++++
 sound/soc/pxa/zylonite.c                      |  101 ++++++++++--
 21 files changed, 345 insertions(+), 45 deletions(-)
 create mode 100644 sound/soc/pxa/e740_wm9705.c
