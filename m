From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 00/13] ASoC updates
Date: Tue, 25 Nov 2008 15:43:03 +0000
Message-ID: <20081125154302.GA8319@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4971E24487
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:43:04 +0100 (CET)
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

The following changes since commit 4f904735c809e44c11f57cd4f82446aac1243e0e:
  Mark Brown (1):
        ALSA: ASoC: Fix typo in snd_soc_card update documentation

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-tiwai

Arun KS (1):
      ASoC: Fix TWL4030 Kconfig dependency

Dmitry Baryshkov (1):
      ASoC: tosa: move gpio probing to machine callbacks

Jarkko Nikula (2):
      ASoC: OMAP: Apply channel constrains to N810 machine driver
      ASoC: OMAP: Add support for mono audio links in McBSP DAI

Mark Brown (4):
      ASoC: Use supplied DAI for WM9713 rather than substream
      ASoC: Remove DAI type information
      ASoC: Flag AD1980 as an AC97 interface
      ASoC: Lower priority of resume work logging

Misael Lopez Cruz (1):
      ASoC: Add support for TI SDP3430

Peter Ujfalusi (4):
      ASoC: TWL4030: Disable soft-volume
      ASoC: TWL4030: Change the Master volume control to TLV
      ASoC: TWL4030: Add CGAIN volume control
      ASoC: TWL4030: Add helper function for output gain controls

 include/sound/soc-dai.h            |    2 +-
 include/sound/soc.h                |    8 --
 sound/soc/atmel/atmel_ssc_dai.c    |    3 -
 sound/soc/au1x/psc-ac97.c          |    2 +-
 sound/soc/au1x/psc-i2s.c           |    1 -
 sound/soc/blackfin/bf5xx-ac97.c    |    2 +-
 sound/soc/blackfin/bf5xx-i2s.c     |    1 -
 sound/soc/codecs/ac97.c            |    2 +-
 sound/soc/codecs/ad1980.c          |    1 +
 sound/soc/codecs/pcm3008.c         |    1 -
 sound/soc/codecs/twl4030.c         |  180 +++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm9712.c          |    2 +-
 sound/soc/codecs/wm9713.c          |   18 +---
 sound/soc/davinci/davinci-i2s.c    |    1 -
 sound/soc/fsl/mpc5200_psc_i2s.c    |    1 -
 sound/soc/omap/Kconfig             |   11 ++-
 sound/soc/omap/Makefile            |    3 +-
 sound/soc/omap/n810.c              |    4 +
 sound/soc/omap/omap-mcbsp.c        |   24 +++--
 sound/soc/omap/sdp3430.c           |  152 ++++++++++++++++++++++++++++++
 sound/soc/pxa/pxa-ssp.c            |    4 -
 sound/soc/pxa/pxa2xx-ac97.c        |    6 +-
 sound/soc/pxa/pxa2xx-i2s.c         |    1 -
 sound/soc/pxa/tosa.c               |   30 +++++--
 sound/soc/s3c24xx/neo1973_wm8753.c |    1 -
 sound/soc/s3c24xx/s3c2412-i2s.c    |    1 -
 sound/soc/s3c24xx/s3c2443-ac97.c   |    4 +-
 sound/soc/s3c24xx/s3c24xx-i2s.c    |    1 -
 sound/soc/sh/hac.c                 |    4 +-
 sound/soc/sh/ssi.c                 |    2 -
 sound/soc/soc-core.c               |   39 +++------
 31 files changed, 410 insertions(+), 102 deletions(-)
 create mode 100644 sound/soc/omap/sdp3430.c
