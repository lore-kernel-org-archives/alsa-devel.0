From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Wed, 24 Nov 2010 13:07:28 +0000
Message-ID: <20101124130728.GE24970@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C3BBD103950
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 14:07:29 +0100 (CET)
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

The following changes since commit bf86f07e8479f4de20d8b19748482eccda240664:

  Merge branch 'for-2.6.37' of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6 into fix/asoc (2010-11-23 12:40:15 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

All very small, driver specific fixes - the majority of this is fallout
from the multi-component merge, we're expecting a greater volume of
fixes this time round than is normal.

Axel Lin (9):
      ASoC: stac9766 - set reg_cache_default to stac9766_reg
      ASoC: Do not update the cache if write to hardware failed
      ASoC: max98088 - fix a memory leak
      ASoC: wm8904 - fix memory leaks
      ASoC: wm8994 - fix memory leaks
      ASoC: wm8961 - clear WM8961_DACSLOPE bit for normal mode
      ASoC: wm8961 - clear WM8961_MCLKDIV bit for freq <= 16500000
      ASoC: Return proper error for omap3pandora_soc_init
      ASoC: nuc900-ac97: fix a memory leak

Jesper Juhl (1):
      ASoC: MPC5200: Eliminate duplicate include of of_device.h

Mark Brown (3):
      ASoC: Fix multi-component mismerge in WM8523
      ASoC: Restore WM8994 volatile and readable register operations
      Merge branch 'fix/asoc' of git://git.kernel.org/.../tiwai/sound-2.6 into for-2.6.37

Vasiliy Kulikov (2):
      ASoC: s3c24xx: test wrong variable
      ASoC: atmel: test wrong variable

 sound/soc/atmel/sam9g20_wm8731.c |    4 ++--
 sound/soc/codecs/max98088.c      |    3 +++
 sound/soc/codecs/stac9766.c      |    1 +
 sound/soc/codecs/tpa6130a2.c     |    4 +++-
 sound/soc/codecs/wm8523.c        |    1 -
 sound/soc/codecs/wm8904.c        |    2 ++
 sound/soc/codecs/wm8961.c        |    4 ++--
 sound/soc/codecs/wm8994.c        |    4 ++++
 sound/soc/fsl/mpc5200_dma.c      |    1 -
 sound/soc/nuc900/nuc900-ac97.c   |    2 +-
 sound/soc/omap/omap3pandora.c    |    1 +
 sound/soc/s3c24xx/smdk_spdif.c   |    4 ++--
 12 files changed, 21 insertions(+), 10 deletions(-)
