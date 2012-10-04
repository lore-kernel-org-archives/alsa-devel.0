From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/2] ASoC: omap-mcpdm: Remove OMAP revision check
Date: Thu,  4 Oct 2012 11:27:16 +0300
Message-ID: <1349339236-3622-3-git-send-email-peter.ujfalusi@ti.com>
References: <1349339236-3622-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1349339236-3622-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The OMAP revision check is not needed since the watchdog bit is not in use
on 4430 ES1.0 and have no effect when we set the bit. The watchdog need to
be enabled on all other revisions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index fdf655e..e134b27 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -40,7 +40,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <plat/cpu.h>
 #include "omap-mcpdm.h"
 #include "omap-pcm.h"
 
@@ -258,13 +257,9 @@ static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
 	mutex_lock(&mcpdm->mutex);
 
 	if (!dai->active) {
-		/* Enable watch dog for ES above ES 1.0 to avoid saturation */
-		if (omap_rev() != OMAP4430_REV_ES1_0) {
-			u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
+		u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
 
-			omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL,
-					 ctrl | MCPDM_WD_EN);
-		}
+		omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl | MCPDM_WD_EN);
 		omap_mcpdm_open_streams(mcpdm);
 	}
 	mutex_unlock(&mcpdm->mutex);
-- 
1.7.12

