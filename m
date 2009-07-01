From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Wed, 1 Jul 2009 21:59:53 +0100
Message-ID: <20090701205952.GA12339@sirena.org.uk>
References: <20090701204503.GA11465@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 451512414D
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 23:00:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090701204503.GA11465@sirena.org.uk>
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

The following changes since commit 62b1653e29d8f359c4c7e045b965dc963459473d:
  Takashi Iwai (1):
        Merge branch 'for-2.6.32' of git://git.kernel.org/.../broonie/sound-2.6 into topic/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Atsushi Nemoto (1):
      ASoC: txx9aclc: dynamically allocate dmaengine devname

Grant Likely (2):
      ASoC: Fix typo in MPC5200 PSC AC97 driver Kconfig
      ASoC: remove BROKEN from Efika and pcm030 fabric drivers

Janusz Krzysztofik (1):
      ASoC: OMAP: fix OMAP1510 broken PCM pointer callback

Lopez Cruz, Misael (1):
      ASoC: Remove word "Switch" from Handsfree switch name

Mark Brown (6):
      ASoC: Fix widget powerdown on shutdown
      ASoC: Fix WM8961 suspend function type
      ASoC: Convert to dev_pm_ops
      ASoC: Only disable pxa2xx-i2s clocks if we enabled them
      ASoC: Add WM8523 CODEC driver
      Merge branch 'for-2.6.31' into for-2.6.32

 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/twl4030.c |   12 +-
 sound/soc/codecs/wm8523.c  |  755 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8523.h  |  160 ++++++++++
 sound/soc/codecs/wm8961.c  |    2 +-
 sound/soc/fsl/Kconfig      |    6 +-
 sound/soc/omap/omap-pcm.c  |   11 +-
 sound/soc/pxa/pxa2xx-i2s.c |    7 +-
 sound/soc/soc-core.c       |   30 ++-
 sound/soc/soc-dapm.c       |    1 +
 sound/soc/txx9/txx9aclc.c  |   10 +-
 12 files changed, 970 insertions(+), 30 deletions(-)
 create mode 100644 sound/soc/codecs/wm8523.c
 create mode 100644 sound/soc/codecs/wm8523.h
