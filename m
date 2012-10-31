From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/2] ASoC: mxs-saif: Remove platform data
Date: Wed, 31 Oct 2012 09:15:17 -0200
Message-ID: <1351682117-10316-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f51.google.com (mail-yh0-f51.google.com
 [209.85.213.51])
 by alsa0.perex.cz (Postfix) with ESMTP id DE148261613
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 12:15:31 +0100 (CET)
Received: by mail-yh0-f51.google.com with SMTP id n12so225658yhn.38
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 04:15:31 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dong.aisheng@linaro.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

All MXS users have been converted to device tree and the board files have been
removed.

No need to keep platform data in the driver.
  
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Also remove mxs_saif_platform_data and sound/saif.h, which was used only
to include mxs_saif_platform_data definition.

 include/sound/saif.h     |   16 ----------------
 sound/soc/mxs/mxs-saif.c |    9 ---------
 2 files changed, 25 deletions(-)
 delete mode 100644 include/sound/saif.h

diff --git a/include/sound/saif.h b/include/sound/saif.h
deleted file mode 100644
index f22f3e1..0000000
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index aa037b2..76a9c4a 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -32,7 +32,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/saif.h>
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/mxs.h>
@@ -652,7 +651,6 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *iores, *dmares;
 	struct mxs_saif *saif;
-	struct mxs_saif_platform_data *pdata;
 	struct pinctrl *pinctrl;
 	int ret = 0;
 
@@ -682,13 +680,6 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 			if (saif->master_id < 0)
 				return saif->master_id;
 		}
-	} else {
-		saif->id = pdev->id;
-		pdata = pdev->dev.platform_data;
-		if (pdata && !pdata->master_mode)
-			saif->master_id = pdata->master_id;
-		else
-			saif->master_id = saif->id;
 	}
 
 	if (saif->master_id < 0 || saif->master_id >= ARRAY_SIZE(mxs_saif)) {
-- 
1.7.9.5
