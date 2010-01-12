From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Tue, 12 Jan 2010 13:20:02 +0000
Message-ID: <20100112132002.GC1418@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 331DA1037EE
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 14:20:04 +0100 (CET)
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

The following changes since your topic/asoc branch are available in the
git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Since they include (via the 2.6.33 merge) a merge of Linus' tree I've
only included the changes that aren't already in your tree or mainline
in the summary below, though it looks like the diffstat picked up some
extra changes due to the way I tried to do that.

Barry Song (4):
      ASoC: ad1836: reset and restore clock control mode in suspend/resume entry
      ASoC: ad1938: fix typo, rename mask to rx_mask for ad1938_set_tdm_slot
      ASoC: ad1938: let soc-core dapm handle PLL power
      ASoC: soc-cache: cleanup training whitespace and coding style

Ilkka Koskinen (2):
      ASoc: tpa6130a2: Remove unnecessary variable
      ASoC: tpa6130a2: Support for tpa6140's regulators

Kuninori Morimoto (3):
      ASoC: fsi: Add over_period flag to prevent the misunderstanding
      ASoC: fsi: Add fsi_get_dai to get snd_soc_dai
      ASoC: fsi: Add over/under run error settlement

Mark Brown (9):
      ASoC: Remove unneeded suspend checks from CODEC drivers
      ASoC: Use snprintf() when generating stream names
      ASoC: Fix variable shadowing warning in TLV320AIC3x
      ASoC: Only restore non-default registers for WM8731
      ASoC: Only restore non-default registers for WM8776
      ASoC: Only restore non-default registers for WM8961
      ASoC: Implement suspend and resume for WM8993
      ASoC: Fix WM8350 DSP mode B configuration
      Merge branch 'for-2.6.33' into for-2.6.34

Peter Ujfalusi (5):
      ASoC: tlv320dac33: Change nsample switch to FIFO mode enum
      ASoC: tlv320dac33: Introduce prefill and playback state handlers
      ASoC: tlv320dac33: Clean up the hardware configuration code
      ASoC: tlv320dac33: Add new FIFO mode: mode 7
      ASoC: tlv320dac33: Safety check for codec slave mode

 include/sound/soc.h               |    3 +
 include/sound/tpa6130a2-plat.h    |    6 +
 include/sound/wm8904.h            |   57 +
 include/sound/wm8955.h            |   26 +
 sound/soc/codecs/Kconfig          |   12 +
 sound/soc/codecs/Makefile         |   10 +-
 sound/soc/codecs/ad1836.c         |   32 +
 sound/soc/codecs/ad1938.c         |   64 +-
 sound/soc/codecs/cs4270.c         |   43 +-
 sound/soc/codecs/da7210.c         |  589 +++++++++
 sound/soc/codecs/da7210.h         |   24 +
 sound/soc/codecs/tlv320aic3x.c    |   75 +-
 sound/soc/codecs/tlv320dac33.c    |  282 ++++-
 sound/soc/codecs/tpa6130a2.c      |  109 ++-
 sound/soc/codecs/wm8350.c         |    2 +-
 sound/soc/codecs/wm8727.c         |   66 +-
 sound/soc/codecs/wm8731.c         |    3 +
 sound/soc/codecs/wm8753.c         |    8 -
 sound/soc/codecs/wm8776.c         |    2 +
 sound/soc/codecs/wm8904.c         | 2556 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8904.h         | 1681 ++++++++++++++++++++++++
 sound/soc/codecs/wm8955.c         | 1151 +++++++++++++++++
 sound/soc/codecs/wm8955.h         |  489 +++++++
 sound/soc/codecs/wm8961.c         |    3 +
 sound/soc/codecs/wm8990.c         |    8 -
 sound/soc/codecs/wm8993.c         |   67 +
 sound/soc/davinci/davinci-mcasp.c |   18 +-
 sound/soc/davinci/davinci-mcasp.h |    1 +
 sound/soc/davinci/davinci-pcm.c   |    2 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c   |  120 +--
 sound/soc/sh/Kconfig              |    8 +
 sound/soc/sh/Makefile             |    2 +
 sound/soc/sh/fsi-da7210.c         |   83 ++
 sound/soc/sh/fsi.c                |  164 ++-
 sound/soc/soc-cache.c             |    2 +-
 sound/soc/soc-core.c              |   11 +-
 sound/soc/soc-dapm.c              |   37 +-
 37 files changed, 7457 insertions(+), 359 deletions(-)
 create mode 100644 include/sound/wm8904.h
 create mode 100644 include/sound/wm8955.h
 create mode 100644 sound/soc/codecs/da7210.c
 create mode 100644 sound/soc/codecs/da7210.h
 create mode 100644 sound/soc/codecs/wm8904.c
 create mode 100644 sound/soc/codecs/wm8904.h
 create mode 100644 sound/soc/codecs/wm8955.c
 create mode 100644 sound/soc/codecs/wm8955.h
 create mode 100644 sound/soc/sh/fsi-da7210.c
