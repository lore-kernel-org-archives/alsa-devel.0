From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/6] ASoC: Regression fix for OMAP in DT boot
	(3.11)
Date: Thu, 11 Jul 2013 12:18:44 +0200
Message-ID: <1373537930-10467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id BED06265020
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 12:18:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I just noticed in mainline kernel (pre 3.11-rc1) that OMAP4 audio is not probing
anymore. This is because OMAP4 also moved to DT only mode (3.10 DT boot was
fine).
The issue underneath is that we can not use platform_get_resource_byname() for
DMA resources when booted with devicetree.

In case of DT boot we can use the DMA name to request the channel.

Due to technical issues OMAP can not be moved to generic dmaengine pcm as other
SoCs did.

Mark: can you queue this series for 3.11? Thank you.

Regards,
Peter
---
Peter Ujfalusi (6):
  ASoC: dmaengine_pcm: Add dma_name to snd_dmaengine_dai_dma_data
  ASoC: omap-pcm: Request the DMA channel by name when dma_name is set
    for the dai
  ASoC: omap-mcpdm: Do not use platform_get_resource_byname() for DMA
  ASoC: omap-dmic: Do not use platform_get_resource_byname() for DMA
  ASoC: omap-mcbsp: Use different method for DMA request when booted
    with DT
  ASoC: omap-dmic: Cleanup the probe function

 include/sound/dmaengine_pcm.h |  1 +
 sound/soc/omap/mcbsp.c        | 39 ++++++++++++++++++++++-----------------
 sound/soc/omap/omap-dmic.c    | 35 ++++++++++-------------------------
 sound/soc/omap/omap-mcpdm.c   | 16 ++--------------
 sound/soc/omap/omap-pcm.c     | 16 +++++++++++++---
 5 files changed, 48 insertions(+), 59 deletions(-)

-- 
1.8.2.1
