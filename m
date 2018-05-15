From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/2] ASoC: omap: sdma-pcm: Fix modpost
	warning
Date: Tue, 15 May 2018 09:43:34 +0300
Message-ID: <20180515064335.20565-2-peter.ujfalusi@ti.com>
References: <20180515064335.20565-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id BA135266F46
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 08:42:54 +0200 (CEST)
In-Reply-To: <20180515064335.20565-1-peter.ujfalusi@ti.com>
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

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdma.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdma.o
see include/linux/module.h for more information

Add the missing MODULE_LICENSE.

This patch also going to solve:
snd_soc_sdma: Unknown symbol devm_kmalloc (err 0)
snd_soc_sdma: Unknown symbol omap_dma_filter_fn (err 0)
snd_soc_sdma: Unknown symbol snd_dmaengine_pcm_prepare_slave_config (err 0)
snd_soc_sdma: Unknown symbol devm_snd_dmaengine_pcm_register (err 0)

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/sdma-pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/omap/sdma-pcm.c b/sound/soc/omap/sdma-pcm.c
index f7b2b5b69d27..3e52ccb2ae26 100644
--- a/sound/soc/omap/sdma-pcm.c
+++ b/sound/soc/omap/sdma-pcm.c
@@ -4,6 +4,7 @@
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
+#include <linux/module.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -66,3 +67,7 @@ int sdma_pcm_platform_register(struct device *dev,
 	return devm_snd_dmaengine_pcm_register(dev, config, flags);
 }
 EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
+
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
+MODULE_DESCRIPTION("sDMA PCM ASoC platform driver");
+MODULE_LICENSE("GPL v2");
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
