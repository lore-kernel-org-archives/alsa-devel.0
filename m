From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 04/20] ASoC: omap-mcpdm: Bind the platform
	driver to the dai driver when loading
Date: Wed, 16 Apr 2014 15:46:14 +0300
Message-ID: <1397652390-852-5-git-send-email-peter.ujfalusi@ti.com>
References: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id DE96C26527F
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 14:46:45 +0200 (CEST)
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

Use the same device for the platform driver when registering as the dai
driver. This will enable us to clean up some DT booted cases.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index e984b0485e92..d8ebb52645a9 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -42,6 +42,7 @@
 #include <sound/dmaengine_pcm.h>
 
 #include "omap-mcpdm.h"
+#include "omap-pcm.h"
 
 struct mcpdm_link_config {
 	u32 link_mask; /* channel mask for the direction */
@@ -462,6 +463,7 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 {
 	struct omap_mcpdm *mcpdm;
 	struct resource *res;
+	int ret;
 
 	mcpdm = devm_kzalloc(&pdev->dev, sizeof(struct omap_mcpdm), GFP_KERNEL);
 	if (!mcpdm)
@@ -492,9 +494,13 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 
 	mcpdm->dev = &pdev->dev;
 
-	return devm_snd_soc_register_component(&pdev->dev,
+	ret =  devm_snd_soc_register_component(&pdev->dev,
 					       &omap_mcpdm_component,
 					       &omap_mcpdm_dai, 1);
+	if (ret)
+		return ret;
+
+	return omap_pcm_platform_register(&pdev->dev);
 }
 
 static const struct of_device_id omap_mcpdm_of_match[] = {
-- 
1.9.2
