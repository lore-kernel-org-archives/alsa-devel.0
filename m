From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Wed, 10 Mar 2010 15:35:58 +0000
Message-ID: <20100310153558.GE24422@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0BC79103873
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 16:36:02 +0100 (CET)
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

The following changes since commit 57d54889cd00db2752994b389ba714138652e60c:
  Linus Torvalds (1):
        Linux 2.6.34-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Nothing terribly exciting in here yet, driver updates and minor things.
The biggest block is the updats to the Samsung CPU drivers.

Build testing has been limited by the fact that several of the machines
I usually use fail to build with mainline at the minute (I have posted
fixes) but the changes are fairly non-invasive.

Barry Song (1):
      ASoC: bf5xx-sport: use common SPORT code for MMR info

Chaithrika U S (1):
      ASoC: DaVinci: Add hw_param callback for S/PDIF DIT link

Cliff Cai (1):
      ASoC: SSM2602: add SND control for mic boost2 and default it to off

Jassi Brar (7):
      ASoC: Allow mulitple usage count of codec and cpu dai
      ASoC: S3C: I2Sv2: Add missing semicolon
      ASoC: S3C: I2Sv2: Unify clock source IDs
      ASoC: s3c-i2s-v2 remove unnecessary headers
      ASoC: s3c64xx-i2s remove unncessary headers
      ASoC: S3C64XX: I2S: Move RATE and FMT defines to header
      ASoC: S3C: I2Sv2: Reject immidiate register value

Kuninori Morimoto (1):
      ASoC: da7210: Add 8/12/16/24/32/48/96 kHz rate support

Mark Brown (9):
      ASoC: Wolfson Microelectronics 1133-EV1 audio support
      ASoC: Prettify wm8960 logging
      ASoC: Move WM8960 platform data into include/sound
      ASoC: Add support for WM8960 capless mode
      ASoC: Add delay information for Samsung IISv2 DAIs
      ASoC: Add 16/16 registers to soc-cache
      ASoC: Remove unused pmdown_time flag
      ASoC: Improve DAPM pop_wait delays
      Merge commit 'v2.6.34-rc1' into for-2.6.35

Peter Ujfalusi (3):
      ASoC: core: fix tailing whitespace in soc_pcm_apply_symmetry
      ASoC: core: soc level wrapper for pcm_pointer callback
      ASoC: core: Add delay operation to snd_soc_dai_ops

jassi brar (3):
      ASoC: Pass dai_link as argument to platform suspend and resume
      ASoC: Change how suspend and resume obtain the PCM runtime
      ASoC: Remove runtime field from DAI

 include/sound/soc-dai.h          |    7 +-
 include/sound/soc-dapm.h         |    1 -
 include/sound/soc.h              |   14 ++-
 include/sound/wm8960.h           |   24 +++
 sound/soc/atmel/atmel-pcm.c      |   14 ++-
 sound/soc/blackfin/bf5xx-sport.h |   28 +----
 sound/soc/codecs/da7210.c        |   67 ++++++---
 sound/soc/codecs/ssm2602.c       |    4 +-
 sound/soc/codecs/wm8960.c        |  209 +++++++++++++++++++++++----
 sound/soc/codecs/wm8960.h        |   10 --
 sound/soc/davinci/davinci-evm.c  |   16 ++-
 sound/soc/imx/Kconfig            |    8 +
 sound/soc/imx/Makefile           |    3 +
 sound/soc/imx/wm1133-ev1.c       |  291 ++++++++++++++++++++++++++++++++++++++
 sound/soc/s3c24xx/s3c-i2s-v2.c   |   93 +++++++------
 sound/soc/s3c24xx/s3c-i2s-v2.h   |    4 +
 sound/soc/s3c24xx/s3c2412-i2s.h  |    4 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c  |   12 --
 sound/soc/s3c24xx/s3c64xx-i2s.h  |   15 ++-
 sound/soc/soc-cache.c            |   83 +++++++++++
 sound/soc/soc-core.c             |   76 ++++++++---
 sound/soc/soc-dapm.c             |    4 +-
 22 files changed, 807 insertions(+), 180 deletions(-)
 create mode 100644 include/sound/wm8960.h
 create mode 100644 sound/soc/imx/wm1133-ev1.c
