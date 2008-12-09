From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 00/18] ASoC updates
Date: Tue, 9 Dec 2008 14:01:01 +0000
Message-ID: <20081209140101.GA17558@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BFD342446A
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:01:02 +0100 (CET)
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

The following changes since commit 28a1d869560a49d960ba2a3b450ec965712e5560:
  Daniel Mack (1):
        ASoC: tlv320aic3x: control additions and cleanups

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Mark Brown (9):
      ASoC: Add card registration API
      ASoC: Add DAI registration API
      ASoC: Register platform DAIs
      ASoC: Add platform registration API
      ASoC: Register platform drivers
      ASoC: Register non-AC97 codec DAIs
      ASoC: Initial framework for dynamic card instantiation
      ASoC: Wait for non-AC97 codec DAIs before instantiating
      ASoC: Convert WM8900 to allow registration by machine code

Peter Ujfalusi (9):
      ASoC: TWL4030: Correct DAPM_DAC with power control
      ASoC: TWL4030: Add Analog PGA control switch to DAPM
      ASoC: TWL4030: Add DAPM event handler for output MUX selection
      ASoC: TWL4030: DAPM mapping of the Earpiece output
      ASoC: TWL4030: DAPM mapping of the PreDriv outputs
      ASoC: TWL4030: DAPM mapping of the Headset outputs
      ASoC: TWL4030: DAPM mapping of the Carkit outputs
      ASoC: TWL4030: DAPM mapping of the Handsfree outputs
      ASoC: TWL4030: Do not alter the Headset output volume on power-up/down

 include/sound/soc-dai.h             |    8 +
 include/sound/soc.h                 |   10 ++
 sound/soc/atmel/atmel-pcm.c         |   12 ++
 sound/soc/atmel/atmel_ssc_dai.c     |   11 ++
 sound/soc/au1x/dbdma2.c             |    3 +-
 sound/soc/au1x/psc-ac97.c           |    3 +-
 sound/soc/au1x/psc-i2s.c            |    3 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c |   12 ++
 sound/soc/blackfin/bf5xx-ac97.c     |   12 ++
 sound/soc/blackfin/bf5xx-i2s-pcm.c  |   12 ++
 sound/soc/blackfin/bf5xx-i2s.c      |   12 ++
 sound/soc/codecs/ad73311.c          |   12 ++
 sound/soc/codecs/ak4535.c           |   12 ++
 sound/soc/codecs/cs4270.c           |   12 ++
 sound/soc/codecs/pcm3008.c          |   12 ++
 sound/soc/codecs/ssm2602.c          |   12 ++
 sound/soc/codecs/tlv320aic23.c      |   12 ++
 sound/soc/codecs/tlv320aic26.c      |   15 ++-
 sound/soc/codecs/tlv320aic3x.c      |   12 ++
 sound/soc/codecs/twl4030.c          |  277 +++++++++++++++++++++++++++++++--
 sound/soc/codecs/uda134x.c          |   12 ++
 sound/soc/codecs/uda1380.c          |   12 ++
 sound/soc/codecs/wm8510.c           |   12 ++
 sound/soc/codecs/wm8580.c           |   12 ++
 sound/soc/codecs/wm8728.c           |   12 ++
 sound/soc/codecs/wm8731.c           |   12 ++
 sound/soc/codecs/wm8750.c           |   12 ++
 sound/soc/codecs/wm8753.c           |   12 ++
 sound/soc/codecs/wm8900.c           |  105 ++++---------
 sound/soc/codecs/wm8903.c           |   12 ++
 sound/soc/codecs/wm8971.c           |   12 ++
 sound/soc/codecs/wm8990.c           |   12 ++
 sound/soc/davinci/davinci-i2s.c     |   12 ++
 sound/soc/davinci/davinci-pcm.c     |   12 ++
 sound/soc/fsl/fsl_dma.c             |   12 ++
 sound/soc/fsl/fsl_ssi.c             |   10 ++
 sound/soc/fsl/mpc5200_psc_i2s.c     |    4 +
 sound/soc/omap/omap-mcbsp.c         |   13 ++
 sound/soc/omap/omap-pcm.c           |   12 ++
 sound/soc/pxa/pxa-ssp.c             |   12 ++
 sound/soc/pxa/pxa2xx-ac97.c         |   12 ++
 sound/soc/pxa/pxa2xx-i2s.c          |   13 ++-
 sound/soc/pxa/pxa2xx-pcm.c          |   12 ++
 sound/soc/s3c24xx/s3c2412-i2s.c     |   13 ++
 sound/soc/s3c24xx/s3c2443-ac97.c    |   13 ++
 sound/soc/s3c24xx/s3c24xx-i2s.c     |   12 ++
 sound/soc/s3c24xx/s3c24xx-pcm.c     |   12 ++
 sound/soc/sh/dma-sh7760.c           |   12 ++
 sound/soc/sh/hac.c                  |   12 ++
 sound/soc/sh/ssi.c                  |   12 ++
 sound/soc/soc-core.c                |  291 +++++++++++++++++++++++++++++++++--
 51 files changed, 1102 insertions(+), 110 deletions(-)
