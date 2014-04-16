From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 05/18] ASoC: omap-mcbsp: Bind the platform
	driver to the dai driver when loading
Date: Wed, 16 Apr 2014 12:23:18 +0300
Message-ID: <1397640211-15447-6-git-send-email-peter.ujfalusi@ti.com>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DAF1261A2F
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 11:23:49 +0200 (CEST)
In-Reply-To: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

Use the same device for the platform driver when registering as the dai
driver. This will enable us to clean up some DT booted cases.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index c01a64619661..89843ea4bbf6 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -38,6 +38,7 @@
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include "mcbsp.h"
 #include "omap-mcbsp.h"
+#include "omap-pcm.h"
 
 #define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_96000)
 
@@ -799,11 +800,15 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mcbsp);
 
 	ret = omap_mcbsp_init(pdev);
-	if (!ret)
-		return snd_soc_register_component(&pdev->dev, &omap_mcbsp_component,
-						  &omap_mcbsp_dai, 1);
+	if (ret)
+		return ret;
 
-	return ret;
+	ret = snd_soc_register_component(&pdev->dev, &omap_mcbsp_component,
+					 &omap_mcbsp_dai, 1);
+	if (ret)
+		return ret;
+
+	return omap_pcm_platform_register(&pdev->dev);
 }
 
 static int asoc_mcbsp_remove(struct platform_device *pdev)
-- 
1.9.2
