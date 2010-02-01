From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Mon, 1 Feb 2010 19:00:56 +0000
Message-ID: <20100201190044.GA22442@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3964C2442F
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 20:00:58 +0100 (CET)
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

The following changes since commit 2718625fba1e07bf2ce8a752036658737c1f76a7:
  Mark Brown (1):
        ASoC: Set codec->dev for AC97 devices

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Anuj Aggarwal (2):
      ASoC: AIC23: Fixing writes to non-existing registers in resume function
      ASoC: AM3517: ASoC driver not getting compiled

Guennadi Liakhovetski (4):
      ASoC: add support for the sh7722 Migo-R board
      ASoC: remove bogus SLEEP mode from wm8978 driver
      ASoC: clean up wm8974 and wm8978 clock divider handling
      ASoC: improve MCLKDIV calculation in wm8978, when OPCLK is not used

Jassi Brar (1):
      ASoC: AC97: SMDK-WM9713: Convert notes from cset to sset

Joe Perches (1):
      ASoC: Fix continuation line formats

Mark Brown (4):
      Merge branch 'for-2.6.33' into for-2.6.34
      ASoC: Improved wm_hubs headphone handling
      ASoC: Activate DCS correction for WM8993
      ASoC: Add WM8994 CODEC driver

 sound/soc/blackfin/bf5xx-ac97-pcm.c |    8 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c  |    3 +-
 sound/soc/blackfin/bf5xx-tdm-pcm.c  |    3 +-
 sound/soc/codecs/Kconfig            |    4 +
 sound/soc/codecs/Makefile           |    2 +
 sound/soc/codecs/tlv320aic23.c      |    2 +-
 sound/soc/codecs/wm8974.c           |   12 +-
 sound/soc/codecs/wm8974.h           |   12 +-
 sound/soc/codecs/wm8978.c           |  139 +-
 sound/soc/codecs/wm8978.h           |    3 -
 sound/soc/codecs/wm8993.c           |   11 +-
 sound/soc/codecs/wm8994.c           | 3870 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8994.h           |   26 +
 sound/soc/codecs/wm_hubs.c          |  142 ++-
 sound/soc/codecs/wm_hubs.h          |    6 +
 sound/soc/omap/Makefile             |    2 +-
 sound/soc/s3c24xx/smdk_wm9713.c     |   23 +-
 sound/soc/sh/Kconfig                |    8 +
 sound/soc/sh/Makefile               |    2 +
 sound/soc/sh/migor.c                |  218 ++
 20 files changed, 4362 insertions(+), 134 deletions(-)
 create mode 100644 sound/soc/codecs/wm8994.c
 create mode 100644 sound/soc/codecs/wm8994.h
 create mode 100644 sound/soc/sh/migor.c
