From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Fri, 26 Nov 2010 13:13:58 +0000
Message-ID: <20101126131358.GE30360@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 704D9244E9
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 14:14:00 +0100 (CET)
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

The following changes since commit d6f443ae4c1d54379ad5953d7bcb89a63387184d:

  ASoC: nuc900-ac97: fix a memory leak (2010-11-24 11:31:18 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

Axel has been very busy with lots of small fixes, mostly in error
handling or unregistration paths which are rarely exercised.

Axel Lin (11):
      ASoC: Call snd_soc_unregister_dais instead of snd_soc_unregister_dai in sh4_soc_dai_remove
      ASoC: efika-audio-fabric: fix resource leak in efika_fabric_init error path
      ASoC: pcm030-audio-fabric: fix resource leak in pcm030_fabric_init error path
      ASoC: snd-soc-afeb9260: remove unneeded platform_device_del in error path
      ASoC: sam9g20_wm8731: fix resource leak in at91sam9g20ek_init error path
      ASoC: simone: fix resource leak in simone_init error path
      ASoC: imx-ssi: fix resource leak
      ASoC: phycore-ac97: fix resource leak
      ASoC: davinci-vcif - fix a memory leak
      ASoC: tlv320aic3x - fix variable may be used uninitialized warning
      ASoC: Fix resource reclaim for osk5912

Dmitry Artamonow (1):
      ASoC: fix SND_PXA2XX_LIB Kconfig warning

 sound/soc/atmel/sam9g20_wm8731.c    |    5 ++++-
 sound/soc/atmel/snd-soc-afeb9260.c  |    1 -
 sound/soc/codecs/tlv320aic3x.c      |    6 +++---
 sound/soc/davinci/davinci-vcif.c    |    3 +++
 sound/soc/ep93xx/simone.c           |   18 ++++++++++--------
 sound/soc/fsl/efika-audio-fabric.c  |    1 +
 sound/soc/fsl/pcm030-audio-fabric.c |    1 +
 sound/soc/imx/imx-ssi.c             |   15 +++++++++++----
 sound/soc/imx/phycore-ac97.c        |   28 +++++++++++++++++++++-------
 sound/soc/omap/osk5912.c            |   11 ++++++++---
 sound/soc/pxa/Kconfig               |    1 +
 sound/soc/sh/ssi.c                  |    2 +-
 12 files changed, 64 insertions(+), 28 deletions(-)
