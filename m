From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates
Date: Tue, 27 Jan 2009 20:03:11 +0000
Message-ID: <20090127200309.GB6424@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 109B324390
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 21:03:20 +0100 (CET)
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

The following changes since commit 070504ade7a95a0f4395673717f3bb7d41793ca8:
  Mark Brown (1):
        ASoC: Fix L3 bus handling in Kconfig

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Mark Brown (1):
      ASoC: Push the codec runtime storage into the card structure

Peter Ujfalusi (5):
      ASoC: TWL4030: Syncronize the reg_cache for ANAMICL after the offset cancelation
      ASoC: TWL4030: Code clean up for codec power up and down
      ASoC: TWL4030: Enable Headset Left anti-pop/bias ramp only if the Headset Left is in use
      ASoC: TWL4030: Physical ADC and amplifier power switch change
      ASoC: TWL4030: Move the twl4030_power_up and _power_down function

Timur Tabi (1):
      ASoC: improve I2C initialization code in CS4270 driver

 include/sound/soc.h            |    3 +-
 sound/soc/codecs/ac97.c        |   20 ++--
 sound/soc/codecs/ad1980.c      |   12 +-
 sound/soc/codecs/ad73311.c     |    8 +-
 sound/soc/codecs/ak4535.c      |   14 +-
 sound/soc/codecs/cs4270.c      |  254 ++++++++++++++++++----------------------
 sound/soc/codecs/pcm3008.c     |   12 +-
 sound/soc/codecs/ssm2602.c     |   20 ++--
 sound/soc/codecs/tlv320aic23.c |   18 ++--
 sound/soc/codecs/tlv320aic26.c |    4 +-
 sound/soc/codecs/tlv320aic3x.c |   14 +-
 sound/soc/codecs/twl4030.c     |  224 +++++++++++++++++++-----------------
 sound/soc/codecs/uda134x.c     |   18 ++--
 sound/soc/codecs/uda1380.c     |   18 ++--
 sound/soc/codecs/wm8350.c      |   10 +-
 sound/soc/codecs/wm8510.c      |   16 ++--
 sound/soc/codecs/wm8580.c      |   10 +-
 sound/soc/codecs/wm8728.c      |   16 ++--
 sound/soc/codecs/wm8731.c      |   20 ++--
 sound/soc/codecs/wm8750.c      |   16 ++--
 sound/soc/codecs/wm8753.c      |   18 ++--
 sound/soc/codecs/wm8900.c      |    8 +-
 sound/soc/codecs/wm8903.c      |   18 ++--
 sound/soc/codecs/wm8971.c      |   14 +-
 sound/soc/codecs/wm8990.c      |   14 +-
 sound/soc/codecs/wm9705.c      |   15 ++-
 sound/soc/codecs/wm9712.c      |   21 ++--
 sound/soc/codecs/wm9713.c      |   17 ++--
 sound/soc/soc-core.c           |   37 +++---
 sound/soc/soc-dapm.c           |    6 +-
 sound/soc/soc-jack.c           |    4 +-
 31 files changed, 443 insertions(+), 456 deletions(-)
