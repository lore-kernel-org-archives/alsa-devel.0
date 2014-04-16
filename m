From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 08/20] ASoC: omap-dmic: Bind the platform
	driver to the dai driver when loading
Date: Wed, 16 Apr 2014 15:46:18 +0300
Message-ID: <1397652390-852-9-git-send-email-peter.ujfalusi@ti.com>
References: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AFE926547C
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 14:46:56 +0200 (CEST)
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
 sound/soc/omap/omap-dmic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 7fb7703264fa..53da041896c4 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -42,6 +42,7 @@
 #include <sound/dmaengine_pcm.h>
 
 #include "omap-dmic.h"
+#include "omap-pcm.h"
 
 struct omap_dmic {
 	struct device *dev;
@@ -494,6 +495,10 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_put_clk;
 
+	ret = omap_pcm_platform_register(&pdev->dev);
+	if (ret)
+		goto err_put_clk;
+
 	return 0;
 
 err_put_clk:
-- 
1.9.2
