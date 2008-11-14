From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/4] ASoC updates
Date: Fri, 14 Nov 2008 14:57:06 +0000
Message-ID: <20081114145705.GA11635@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7E7C1037F3
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 15:57:07 +0100 (CET)
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

The following changes since commit fb0ef645f2c546f8297b2fbf9b2b8fff4a7455e8:
  Naresh Medisetty (1):
        ASoC: DaVinci: Audio: Fix swapping of channels at start of stereo playback

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Jarkko Nikula (2):
      ASoC: Fix supported sample rates of TWL4030 audio codec
      ASoC: OMAP: Add more supported sample rates into McBSP DAI driver

Mark Brown (2):
      ASoC: Revert "ASoC: Add new parameter to s3c24xx_pcm_enqueue"
      ASoC: Add WM8728 codec driver

 sound/soc/codecs/Kconfig        |    4 +
 sound/soc/codecs/Makefile       |    2 +
 sound/soc/codecs/twl4030.c      |    2 +-
 sound/soc/codecs/wm8728.c       |  574 +++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8728.h       |   30 ++
 sound/soc/omap/omap-mcbsp.c     |    4 +-
 sound/soc/s3c24xx/s3c24xx-pcm.c |   12 +-
 7 files changed, 616 insertions(+), 12 deletions(-)
 create mode 100644 sound/soc/codecs/wm8728.c
 create mode 100644 sound/soc/codecs/wm8728.h
