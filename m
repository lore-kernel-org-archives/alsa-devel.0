From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: omap: sdma-pcm: Correction for the
	include files
Date: Fri, 11 May 2018 15:20:55 +0300
Message-ID: <20180511122055.14206-3-peter.ujfalusi@ti.com>
References: <20180511122055.14206-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AED6267281
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 14:20:21 +0200 (CEST)
In-Reply-To: <20180511122055.14206-1-peter.ujfalusi@ti.com>
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

The sdma-pcm does not need any information from omap-dma.h, it only needs
to include the omap-dmaengine.h - for the omap_dma_filter_fn, but that
might not be needed at all as OMAP1 was converted to dma_slave_map, but
I can not test OMAP1.

Add the linux/device.h include as well for devm_kzalloc()

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/sdma-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/sdma-pcm.c b/sound/soc/omap/sdma-pcm.c
index 403b90e2c89b..471d4ec12da5 100644
--- a/sound/soc/omap/sdma-pcm.c
+++ b/sound/soc/omap/sdma-pcm.c
@@ -4,13 +4,14 @@
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
+#include <linux/device.h>
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
-#include <linux/omap-dma.h>
+#include <linux/omap-dmaengine.h>
 
 #include "sdma-pcm.h"
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
