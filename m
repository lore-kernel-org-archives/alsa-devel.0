From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Wed, 23 Sep 2009 11:11:13 -0700
Message-ID: <20090923181111.GA3126@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DD09103890
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 20:11:43 +0200 (CEST)
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

The following changes since commit 9f072b7b2260a588bfb5fb43418c3358104e7c13:
  Mark Brown (1):
        Merge branch 'for-2.6.32' into for-2.6.33

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Barry Song (2):
      ASoC: some minor changes for AD1836 and AD1938 codec drivers
      ASoC: Blackfin I2S: use dai state rather than local counter

Chaithrika U S (1):
      ASoC: DaVinci: Correct McASP FIFO initialization

Cliff Cai (1):
      ASoC: Blackfin: fix inverted handling of SPORT0 on PORT F/G

Mark Brown (9):
      ASoC: Update WM8711 to driver model registration method
      Merge branch 'topic/asoc' of git://git.kernel.org/.../tiwai/sound-2.6 into upstream/wm8711
      ASoC: Factor out WM8711 cache I/O
      ASoC: Add SPI support to WM8711
      ASoC: WM8711 minor cleanups
      ASoC: Add TLV information to WM8711
      ASoC: Convert soc-cache to use C99 style initialisers for the table
      Merge branch 'upstream/wm8711' into for-2.6.33
      Merge branch 'for-2.6.32' into for-2.6.33

Mike Arthur (1):
      ASoC: Add WM8711 CODEC driver

Phil Vandry (1):
      ASoC: wm8753: fix mapping when MONOMIX is set to Stereo

Troy Kisky (2):
      ASoC: DaVinci: Fix divide by zero error during 1st execution
      ASoC: Davinci: Fix race with cpu_dai->dma_data

jassi brar (1):
      ASoC: Support WM8580 based audio subsystem on SMDK64xx machines

 sound/soc/blackfin/bf5xx-i2s.c      |   23 +-
 sound/soc/blackfin/bf5xx-tdm.c      |    8 +-
 sound/soc/codecs/Kconfig            |    4 +
 sound/soc/codecs/Makefile           |    2 +
 sound/soc/codecs/ad1836.c           |    3 +-
 sound/soc/codecs/ad1938.c           |    2 +-
 sound/soc/codecs/wm8711.c           |  658 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8711.h           |   42 +++
 sound/soc/codecs/wm8753.c           |    1 +
 sound/soc/davinci/davinci-i2s.c     |   37 +--
 sound/soc/davinci/davinci-mcasp.c   |   80 ++---
 sound/soc/davinci/davinci-mcasp.h   |    7 +-
 sound/soc/davinci/davinci-pcm.c     |   13 +-
 sound/soc/davinci/davinci-pcm.h     |    1 -
 sound/soc/s3c24xx/Kconfig           |    9 +
 sound/soc/s3c24xx/Makefile          |    2 +
 sound/soc/s3c24xx/smdk64xx_wm8580.c |  273 +++++++++++++++
 sound/soc/soc-cache.c               |   18 +-
 18 files changed, 1068 insertions(+), 115 deletions(-)
 create mode 100644 sound/soc/codecs/wm8711.c
 create mode 100644 sound/soc/codecs/wm8711.h
 create mode 100644 sound/soc/s3c24xx/smdk64xx_wm8580.c
