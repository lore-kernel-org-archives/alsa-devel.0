From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/6] ASoC updates
Date: Mon, 15 Sep 2008 14:24:19 +0100
Message-ID: <20080915132418.GA23825@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A998624652
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 15:24:20 +0200 (CEST)
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

The following changes since commit 3e3b5651631629482e0e1541f8c4298a435bb100:
  Mark Brown (1):
        ALSA: ASoC: Use codec digital mute when stopping playback

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Alan Horstmann (1):
      ASoC: Fix WM8731 SPI write

Dmitry Baryshkov (4):
      ASoC: Support runtime selection of CPU in pxa2xx-i2s
      ALSA: Separate common pxa2xx-ac97 code
      ALSA: pxa2xx-ac97-lib: support building for several CPUs
      ALSA: Separate common pxa2xx-pcm code

Kenneth Kiraly (1):
      ASoC: Add WM8971 CODEC driver

 include/sound/pxa2xx-lib.h  |   45 ++
 sound/arm/Kconfig           |    9 +
 sound/arm/Makefile          |    4 +
 sound/arm/pxa2xx-ac97-lib.c |  384 ++++++++++++++++++
 sound/arm/pxa2xx-ac97.c     |  247 +-----------
 sound/arm/pxa2xx-pcm-lib.c  |  278 +++++++++++++
 sound/arm/pxa2xx-pcm.c      |  252 +-----------
 sound/arm/pxa2xx-pcm.h      |   13 +-
 sound/soc/codecs/Kconfig    |    4 +
 sound/soc/codecs/Makefile   |    2 +
 sound/soc/codecs/wm8731.c   |    5 +-
 sound/soc/codecs/wm8971.c   |  942 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8971.h   |   64 +++
 sound/soc/pxa/Kconfig       |    3 +
 sound/soc/pxa/pxa2xx-ac97.c |  272 +------------
 sound/soc/pxa/pxa2xx-i2s.c  |   20 +-
 sound/soc/pxa/pxa2xx-pcm.c  |  261 +------------
 sound/soc/pxa/pxa2xx-pcm.h  |   15 -
 18 files changed, 1802 insertions(+), 1018 deletions(-)
 create mode 100644 include/sound/pxa2xx-lib.h
 create mode 100644 sound/arm/pxa2xx-ac97-lib.c
 create mode 100644 sound/arm/pxa2xx-pcm-lib.c
 create mode 100644 sound/soc/codecs/wm8971.c
 create mode 100644 sound/soc/codecs/wm8971.h
