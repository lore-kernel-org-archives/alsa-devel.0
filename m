From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 08/18] ASoC: omap-hdmi: Bind the platform
	driver to the dai driver when loading
Date: Wed, 16 Apr 2014 12:23:21 +0300
Message-ID: <1397640211-15447-9-git-send-email-peter.ujfalusi@ti.com>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id A08DE26500B
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 11:23:56 +0200 (CEST)
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
 sound/soc/omap/omap-hdmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index ced3b88b44d4..32614b49653c 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -36,6 +36,7 @@
 #include <video/omapdss.h>
 
 #include "omap-hdmi.h"
+#include "omap-pcm.h"
 
 #define DRV_NAME "omap-hdmi-audio-dai"
 
@@ -324,7 +325,11 @@ static int omap_hdmi_probe(struct platform_device *pdev)
 	ret = snd_soc_register_component(&pdev->dev, &omap_hdmi_component,
 					 &omap_hdmi_dai, 1);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	return omap_pcm_platform_register(&pdev->dev);
+}
 }
 
 static int omap_hdmi_remove(struct platform_device *pdev)
-- 
1.9.2
