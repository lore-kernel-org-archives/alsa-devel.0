From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/4] ASoC updates
Date: Thu, 4 Dec 2008 11:25:43 +0000
Message-ID: <20081204112542.GA30250@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B56082413F
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2008 12:25:44 +0100 (CET)
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

The following changes since commit 6f2a974bfc8d3be7a30674c71e2fef003b39a8d2:
  Daniel Mack (1):
        ASoC: tlv320aic3x: headset/button press support

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Mark Brown (4):
      ASoC: Push debugfs files out of the snd_soc_device structure
      ASoC: Remove device from platform suspend and resume operations
      ASoC: Remove platform device from DAI suspend and resume operations
      ASoC: Remove obsolete declaration of struct snd_soc_clock_info

 include/sound/soc-dai.h         |    6 +--
 include/sound/soc.h             |   15 +++----
 sound/soc/atmel/atmel-pcm.c     |    6 +--
 sound/soc/atmel/atmel_ssc_dai.c |    6 +--
 sound/soc/au1x/psc-ac97.c       |    6 +--
 sound/soc/au1x/psc-i2s.c        |    6 +--
 sound/soc/blackfin/bf5xx-ac97.c |    6 +--
 sound/soc/blackfin/bf5xx-i2s.c  |    6 +--
 sound/soc/pxa/pxa-ssp.c         |    6 +--
 sound/soc/pxa/pxa2xx-ac97.c     |    6 +--
 sound/soc/pxa/pxa2xx-i2s.c      |    6 +--
 sound/soc/s3c24xx/s3c2412-i2s.c |   16 +++----
 sound/soc/s3c24xx/s3c24xx-i2s.c |    6 +--
 sound/soc/soc-core.c            |   85 +++++++++++++++++++++-----------------
 14 files changed, 83 insertions(+), 99 deletions(-)
