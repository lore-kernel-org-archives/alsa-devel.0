From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Tue, 12 May 2009 11:25:29 +0100
Message-ID: <20090512102528.GA5488@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4CD7324714
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 12:25:30 +0200 (CEST)
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

The following changes since commit bec4c99e8637b5b8bd4b0513eacb51da25885e3b:
  Mark Brown (1):
        ASoC: Fix file patterns for PXA sound drivers

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Joonyoung Shim (1):
      ASoC: TWL4030: change DAPM for analog microphone selection

Mark Brown (3):
      ASoC: Fix up CODEC DAI formats for big endian CPUs
      ASoC: Enforce symmetric rates for PXA2xx I2S
      Merge branch 'for-2.6.30' into for-2.6.31

Mike Rapoport (3):
      ASoC: soc-core: fix crash when removing not instantiated card
      pxa2xx-ac97: fix reset gpio mode setting
      ASoC: em-x270: make the driver support also eXeda and CM-X300 machines

Roel Kluin (1):
      ASoC: remove driver_data direct access of struct device

Sergey Lapin (1):
      ASoC: AFEB9260 driver

 sound/arm/pxa2xx-ac97-lib.c        |    2 +-
 sound/soc/atmel/Kconfig            |    8 ++
 sound/soc/atmel/Makefile           |    1 +
 sound/soc/atmel/snd-soc-afeb9260.c |  203 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/twl4030.c         |   52 ++++------
 sound/soc/codecs/wm8400.c          |    4 +-
 sound/soc/codecs/wm8731.c          |    4 +-
 sound/soc/codecs/wm8753.c          |    4 +-
 sound/soc/pxa/Kconfig              |    4 +-
 sound/soc/pxa/em-x270.c            |    9 +-
 sound/soc/pxa/pxa2xx-i2s.c         |    1 +
 sound/soc/soc-core.c               |   43 ++++++++
 12 files changed, 289 insertions(+), 46 deletions(-)
 create mode 100644 sound/soc/atmel/snd-soc-afeb9260.c
