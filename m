From: Michal Bachraty <michal.bachraty@streamunlimited.com>
Subject: [PATCH 1/2] ALSA: ASoc: spdif_transciever: Add DT
	support
Date: Fri, 19 Apr 2013 15:38:45 +0200
Message-ID: <1366378725-14471-1-git-send-email-michal.bachraty@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.inode.at (mx03.lb01.inode.at [62.99.145.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 704F426109B
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2013 15:38:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de, grant.likely@secretlab.ca, rob.herring@calxeda.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: marek.belisko@streamunlimited.com, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Michal Bachraty <michal.bachraty@streamunlimited.com>
List-Id: alsa-devel@alsa-project.org

Add devicetree support for this dummy audio soc driver.

Signed-off-by: Michal Bachraty <michal.bachraty@streamunlimited.com>
---
 sound/soc/codecs/spdif_transciever.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transciever.c
index 112a49d..4c8c295 100644
--- a/sound/soc/codecs/spdif_transciever.c
+++ b/sound/soc/codecs/spdif_transciever.c
@@ -20,6 +20,7 @@
 #include <sound/soc.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
+#include <linux/of.h>
 
 #define DRV_NAME "spdif-dit"
 
@@ -52,12 +53,21 @@ static int spdif_dit_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id spdif_dit_dt_ids[] = {
+	{ .compatible = DRV_NAME, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spdif_dits_dt_ids);
+#endif
+
 static struct platform_driver spdif_dit_driver = {
 	.probe		= spdif_dit_probe,
 	.remove		= spdif_dit_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(spdif_dit_dt_ids),
 	},
 };
 
-- 
1.7.9.5
