From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.0
Date: Fri, 10 Jun 2011 11:26:25 +0100
Message-ID: <20110610102624.GH26436@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BC55103826
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 12:26:28 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 59c5f46fbe01a00eedf54a23789634438bb80603:

  Linux 3.0-rc2 (2011-06-06 18:06:33 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.0

This also includes a merge up of 3.0-rc1.  The core change is the
relatively large but straightforward patch to pass the DAPM context
around when creating new mixers. 

Joachim Eastwood (1):
      ASoC: atmel_ssc: Don't try to free ssc if request failed

Lars-Peter Clausen (3):
      ASoC: AD1836: Fix setting the PCM format
      ASoC: Blackfin: bf5xx-ad1836: Fix codec device name
      ASoC: snd_soc_new_{mixer,mux,pga} make sure to use right DAPM context

Mark Brown (6):
      Merge branch 'for-3.0' of git://git.kernel.org/.../broonie/sound-2.6 into for-3.0
      ASoC: Only update SYSCLK_ENA when pausing WM8915 SYSCLK
      ASoC: Add missing break in WM8915 FLL source selection
      ASoC: Check for NULL register bank in snd_soc_get_cache_val()
      ASoC: Fix WM8962 headphone volume update for use of advanced caches
      ASoC: WM8804 does not support sample rates below 32kHz

Sangbeom Kim (1):
      ASoC: SAMSUNG: Fix the incorrect referencing of I2SCON register

Timur Tabi (1):
      ASoC: fsl: fix initialization of DMA buffers

 sound/soc/atmel/atmel_ssc_dai.c   |    5 +++--
 sound/soc/blackfin/bf5xx-ad1836.c |    4 ++--
 sound/soc/codecs/ad1836.c         |   14 +++++++-------
 sound/soc/codecs/ad1836.h         |    6 ++++++
 sound/soc/codecs/wm8804.c         |    9 +++++++--
 sound/soc/codecs/wm8915.c         |    3 ++-
 sound/soc/codecs/wm8962.c         |    4 ++--
 sound/soc/codecs/wm_hubs.c        |    8 ++++----
 sound/soc/fsl/fsl_dma.c           |    9 +++++----
 sound/soc/samsung/i2s.c           |    4 ++--
 sound/soc/soc-cache.c             |    3 +++
 sound/soc/soc-dapm.c              |   22 ++++++++++++----------
 12 files changed, 55 insertions(+), 36 deletions(-)
