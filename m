From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/14] ASoC: Cleanup dmaengine PCM users
Date: Fri, 22 Mar 2013 14:12:00 +0100
Message-ID: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 7592226518B
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:10:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi,

This series cleans up a few of the current users of the dmaengine pcm lib in
order to make the introduction of a new more generic PCM dmaengine driver more
straight forward.

The series consists mainly of two types of changes. One is removing all
unnecessary wrappers of snd_soc_dmaengine_close(). For some reason quite a few
drivers started providing their own pcm_close callback, which does nothing but
calls snd_soc_dmaengine_close, although snd_soc_dmaengine_close can be used
directly as the pcm_close callback if nothing else needs to be done.

The other is getting rid of snd_dmaengine_pcm_{get,set}_data(). These two
functions were initially introduced to deal with a few oddball dmaengine drivers
which require that data is passed to them via the private_data field of the
channel and we had to keep the data allocated until the channel had been
released. A few other driver started using these functions although there is no
need to do so. E.g. some drivers just call snd_dmaengine_pcm_set_data(), but
never attempt to read the data again using snd_dmaengine_pcm_get_data().
For the drivers, for which snd_dmaengine_pcm_{set,get}_data() was originally
introduced, the responsibility of keeping the dma config allocated is shifted
from the pcm driver to the i2s drivers. Which in turn makes the code much more
straight forward since for most i2s drivers the dma config is either static or
setup once at driver probe time.

The series has only been compile tested, so please test these patches,
especially the non trivial ones for ep93xx, mmp, imx and mxs.

- Lars

Lars-Peter Clausen (14):
  ASoC: ux500_pcm: Remove duplicated SNDRV_PCM_HW_PARAM_PERIODS
    constraint
  ASoC: spear_pcm: No need to wrap snd_dmaengine_pcm_close()
  ASoC: omap-pcm: No need to wrap snd_dmaengine_pcm_close()
  ASoC: tegra_pcm: No need to wrap snd_dmaengine_pcm_close()
  ASoC: ux500_pcm: No need to wrap snd_dmaengine_pcm_close()
  ASoC: atmel-pcm-dma: No need to wrap snd_dmaengine_pcm_close()
  ASoC: ux500_pcm: No need to use snd_dmaengine_pcm_set_data()
  ASoC: speaer_pcm: No need to use snd_dmaengine_pcm_set_data()
  ASoC: atmel-pcm-dma: Do not use snd_dmaengine_pcm_{set,get}_data()
  ASoC: ep93xx: Use ep93xx_dma_params instead of ep93xx_pcm_dma_params
  ASoC: mmp-pcm: Allocate dma filter parameters on the stack
  ASoC: imx-pcm: Embed the imx_dma_data struct in the dma_params struct
  ASoC: mxs: Embed the mxs_dma_data struct in the mxs_pcm_dma_params
    struct
  ASoC: dmaengine-pcm: Remove snd_dmaengine_pcm_{set,get}_data

 include/sound/dmaengine_pcm.h   |  3 ---
 sound/soc/atmel/atmel-pcm-dma.c | 23 +++++++---------------
 sound/soc/cirrus/edb93xx.c      |  1 -
 sound/soc/cirrus/ep93xx-ac97.c  |  9 +++++----
 sound/soc/cirrus/ep93xx-i2s.c   | 12 ++++++------
 sound/soc/cirrus/ep93xx-pcm.c   | 37 +++--------------------------------
 sound/soc/cirrus/ep93xx-pcm.h   | 20 -------------------
 sound/soc/cirrus/simone.c       |  2 --
 sound/soc/cirrus/snappercl15.c  |  1 -
 sound/soc/fsl/fsl_ssi.c         | 17 ++++++++--------
 sound/soc/fsl/imx-pcm-dma.c     | 35 ++-------------------------------
 sound/soc/fsl/imx-pcm.h         | 17 ++++++++++++++--
 sound/soc/fsl/imx-ssi.c         | 12 ++++++++----
 sound/soc/mxs/mxs-pcm.c         | 43 +++++------------------------------------
 sound/soc/mxs/mxs-pcm.h         |  4 +++-
 sound/soc/mxs/mxs-saif.c        |  6 +++---
 sound/soc/omap/omap-pcm.c       |  8 +-------
 sound/soc/pxa/mmp-pcm.c         | 33 +++++--------------------------
 sound/soc/soc-dmaengine-pcm.c   | 29 ---------------------------
 sound/soc/spear/spear_pcm.c     | 18 ++---------------
 sound/soc/tegra/tegra_pcm.c     |  8 +-------
 sound/soc/ux500/ux500_pcm.c     | 25 +-----------------------
 22 files changed, 76 insertions(+), 287 deletions(-)
 delete mode 100644 sound/soc/cirrus/ep93xx-pcm.h

-- 
1.8.0
