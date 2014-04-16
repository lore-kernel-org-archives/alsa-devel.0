From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 10/20] ASoC: davinci-mcasp: Update
	MCASP_VERSION_4 platform driver registration
Date: Wed, 16 Apr 2014 15:46:20 +0300
Message-ID: <1397652390-852-11-git-send-email-peter.ujfalusi@ti.com>
References: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id A561626549A
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 14:47:01 +0200 (CEST)
In-Reply-To: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

Version 4 of McASP is using omap-pcm as platform driver and the omap-pcm
platform need to be registered using the cpu dai's device.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index af92d3e8671d..d505fe7292a4 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -36,6 +36,7 @@
 
 #include "davinci-pcm.h"
 #include "davinci-mcasp.h"
+#include "../omap/omap-pcm.h"
 
 #define MCASP_MAX_AFIFO_DEPTH	64
 
@@ -1220,12 +1221,25 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (ret != 0)
 		goto err_release_clk;
 
-	if (mcasp->version != MCASP_VERSION_4) {
+	switch (mcasp->version) {
+	case MCASP_VERSION_1:
+	case MCASP_VERSION_2:
+	case MCASP_VERSION_3:
 		ret = davinci_soc_platform_register(&pdev->dev);
-		if (ret) {
-			dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
-			goto err_unregister_component;
-		}
+		break;
+	case MCASP_VERSION_4:
+		ret = omap_pcm_platform_register(&pdev->dev);
+		break;
+	default:
+		dev_err(&pdev->dev, "Invalid McASP version: %d\n",
+			mcasp->version);
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret) {
+		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
+		goto err_unregister_component;
 	}
 
 	return 0;
@@ -1243,8 +1257,19 @@ static int davinci_mcasp_remove(struct platform_device *pdev)
 	struct davinci_mcasp *mcasp = dev_get_drvdata(&pdev->dev);
 
 	snd_soc_unregister_component(&pdev->dev);
-	if (mcasp->version != MCASP_VERSION_4)
+
+	switch (mcasp->version) {
+	case MCASP_VERSION_1:
+	case MCASP_VERSION_2:
+	case MCASP_VERSION_3:
 		davinci_soc_platform_unregister(&pdev->dev);
+		break;
+	case MCASP_VERSION_4:
+		/* Using the resource managed omap-pcm as platform driver */
+		break;
+	default:
+		break;
+	}
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
1.9.2
