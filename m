From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Fri, 12 Feb 2010 16:27:09 +0000
Message-ID: <20100212162709.GA22297@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 54DB824133
	for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2010 17:27:12 +0100 (CET)
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

The following changes since commit c6848bf566c7217a6090693ff5cc47091fa772f5:
  Paul Menzel (1):
        ASoC: Typo. s/Freecale/Freescale/

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Guennadi Liakhovetski (1):
      ASoC: fix compile breakage if CONFIG_SH_DMA_API=y && CONFIG_SND_SIU_MIGOR!=n

Mark Brown (3):
      ASoC: Add WM2000 driver
      ASoC: Make pmdown_time a per-card setting
      ASoC: Make pmdown_time runtime configurable

Thomas Weber (1):
      ASoC: Add ASoC support for Devkit8000

 include/sound/soc.h          |    2 +
 include/sound/wm2000.h       |   26 ++
 sound/soc/codecs/Kconfig     |    4 +
 sound/soc/codecs/Makefile    |    2 +
 sound/soc/codecs/wm2000.c    |  888 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm2000.h    |   79 ++++
 sound/soc/omap/Kconfig       |    8 +-
 sound/soc/omap/omap3beagle.c |    6 +-
 sound/soc/sh/Kconfig         |    1 +
 sound/soc/soc-core.c         |   31 ++-
 10 files changed, 1040 insertions(+), 7 deletions(-)
 create mode 100644 include/sound/wm2000.h
 create mode 100644 sound/soc/codecs/wm2000.c
 create mode 100644 sound/soc/codecs/wm2000.h
