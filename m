From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/2] ASoC: omap: sdma-pcm: modpost warning
	fix and include cleanup
Date: Tue, 15 May 2018 09:43:33 +0300
Message-ID: <20180515064335.20565-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 43AC0266F46
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 08:42:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
Cc: tony@atomide.com, alsa-devel@alsa-project.org, aaro.koskinen@iki.fi
List-Id: alsa-devel@alsa-project.org

Hi,

Changes since v1:
- Changed the MODULE_LICENSE from "GPL" to "GPL v2" to match the SPDX line.

Since the sdma-pcm can be built as module it must have MODULE_LICENSE defined,
whcih I have missed:

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdma.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdma.o
see include/linux/module.h for more information

The first patch also going to fix runtime issue with module loading:
snd_soc_sdma: Unknown symbol devm_kmalloc (err 0)
snd_soc_sdma: Unknown symbol omap_dma_filter_fn (err 0)
snd_soc_sdma: Unknown symbol snd_dmaengine_pcm_prepare_slave_config (err 0)
snd_soc_sdma: Unknown symbol devm_snd_dmaengine_pcm_register (err 0)

As these symbols are EXPORT_SYMBOL_GPL()...

Introduced by commit

  dde637f2daf1 ("ASoC: omap: Introduce the generic_dmaengine_pcm based sdma-pcm")

The second patch is kust a small adjustement for the include files.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: omap: sdma-pcm: Fix modpost warning
  ASoC: omap: sdma-pcm: Correction for the include files

 sound/soc/omap/sdma-pcm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
