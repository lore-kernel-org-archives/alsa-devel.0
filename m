From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/7] ASoC updates
Date: Mon, 1 Dec 2008 20:07:03 +0000
Message-ID: <20081201200703.GA14376@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB00A1037E3
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 21:07:04 +0100 (CET)
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

The following changes since commit 682d5874f3d654b5d13d9b8dd56b9e05cfadd01b:
  Takashi Iwai (1):
        ALSA: ASoC: Fix old-style trigger callback in s3c2443-ac97.c

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Mark Brown (4):
      ASoC: Rename snd_soc_register_card() to snd_soc_init_card()
      ASoC: Annotate core removal function
      ASoC: Remove in-code changelog from AD73311 driver
      ASoC: Don't free static data in WM9713

Peter Ujfalusi (3):
      ASoC: TWL4030: Change the capture volume control to TLV
      ASoC: TWL4030: Change the common playback volume controls
      ASoC: TWL4030: Add volume controls for outputs

 include/sound/soc.h            |    2 +-
 sound/soc/codecs/ac97.c        |    2 +-
 sound/soc/codecs/ad1980.c      |    2 +-
 sound/soc/codecs/ad73311.c     |    5 +--
 sound/soc/codecs/ak4535.c      |    2 +-
 sound/soc/codecs/cs4270.c      |    2 +-
 sound/soc/codecs/pcm3008.c     |    2 +-
 sound/soc/codecs/ssm2602.c     |    2 +-
 sound/soc/codecs/tlv320aic23.c |    2 +-
 sound/soc/codecs/tlv320aic26.c |    2 +-
 sound/soc/codecs/tlv320aic3x.c |    2 +-
 sound/soc/codecs/twl4030.c     |   74 +++++++++++++++++++++++++++++++++------
 sound/soc/codecs/uda134x.c     |    2 +-
 sound/soc/codecs/uda1380.c     |    2 +-
 sound/soc/codecs/wm8510.c      |    2 +-
 sound/soc/codecs/wm8580.c      |    2 +-
 sound/soc/codecs/wm8728.c      |    2 +-
 sound/soc/codecs/wm8731.c      |    2 +-
 sound/soc/codecs/wm8750.c      |    2 +-
 sound/soc/codecs/wm8753.c      |    2 +-
 sound/soc/codecs/wm8900.c      |    2 +-
 sound/soc/codecs/wm8903.c      |    2 +-
 sound/soc/codecs/wm8971.c      |    2 +-
 sound/soc/codecs/wm8990.c      |    2 +-
 sound/soc/codecs/wm9712.c      |    2 +-
 sound/soc/codecs/wm9713.c      |    3 +-
 sound/soc/soc-core.c           |    8 ++--
 27 files changed, 91 insertions(+), 45 deletions(-)
