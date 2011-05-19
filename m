From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: spdif-dit: Add missing MODULE_*
Date: Thu, 19 May 2011 17:44:46 -0600
Message-ID: <1305848686-436-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B6041103800
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 01:44:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

MODULE_ALIAS is required so that the module will auto-load based on a
platform_device registration in the board file.

While we're at it, add some other MODULE_*.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/codecs/spdif_transciever.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transciever.c
index 4c32b54..6a1a7e7 100644
--- a/sound/soc/codecs/spdif_transciever.c
+++ b/sound/soc/codecs/spdif_transciever.c
@@ -21,7 +21,7 @@
 #include <sound/pcm.h>
 #include <sound/initval.h>
 
-MODULE_LICENSE("GPL");
+#define DRV_NAME "spdif-dit"
 
 #define STUB_RATES	SNDRV_PCM_RATE_8000_96000
 #define STUB_FORMATS	SNDRV_PCM_FMTBIT_S16_LE
@@ -56,7 +56,7 @@ static struct platform_driver spdif_dit_driver = {
 	.probe		= spdif_dit_probe,
 	.remove		= spdif_dit_remove,
 	.driver		= {
-		.name	= "spdif-dit",
+		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
 	},
 };
@@ -74,3 +74,7 @@ static void __exit dit_exit(void)
 module_init(dit_modinit);
 module_exit(dit_exit);
 
+MODULE_AUTHOR("Steve Chen <schen@mvista.com>");
+MODULE_DESCRIPTION("SPDIF dummy codec driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.0.4
