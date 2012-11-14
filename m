From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v5 2/2] ASoC: mxs-saif: Remove platform data
Date: Wed, 14 Nov 2012 18:28:58 -0200
Message-ID: <1352924938-24789-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
 [209.85.161.179])
 by alsa0.perex.cz (Postfix) with ESMTP id E7EFA2625E2
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 21:29:07 +0100 (CET)
Received: by mail-gg0-f179.google.com with SMTP id y6so185510ggc.38
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 12:29:07 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

All MXS users have been converted to device tree and the board files have been
removed.

No need to keep platform data in the driver.
  
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes since v4:
- Rebased against fix/mxs branch and fix file removal
Changes since v3:
- Remove pdev->id check
Changes since v2:
- Also remove 'if (np)' as dt is the only probing mechanism.
Changes since v1:
- Also remove mxs_saif_platform_data and sound/saif.h, which was used only
to include mxs_saif_platform_data definition.
 include/sound/saif.h     |   16 ----------------
 sound/soc/mxs/mxs-saif.c |   44 ++++++++++++++++----------------------------
 2 files changed, 16 insertions(+), 44 deletions(-)
 delete mode 100644 include/sound/saif.h

diff --git a/include/sound/saif.h b/include/sound/saif.h
deleted file mode 100644
index f22f3e1..0000000
--- a/include/sound/saif.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __SOUND_SAIF_H__
-#define __SOUND_SAIF_H__
-
-struct mxs_saif_platform_data {
-	bool master_mode;	/* if true use master mode */
-	int master_id;		/* id of the master if in slave mode */
-};
-#endif
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index c294fbb..05dbadb 100644
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
@@ -660,43 +659,32 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *iores, *dmares;
 	struct mxs_saif *saif;
-	struct mxs_saif_platform_data *pdata;
 	struct pinctrl *pinctrl;
 	int ret = 0;
+	struct device_node *master;
 
-
-	if (!np && pdev->id >= ARRAY_SIZE(mxs_saif))
+	if (!np)
 		return -EINVAL;
 
 	saif = devm_kzalloc(&pdev->dev, sizeof(*saif), GFP_KERNEL);
 	if (!saif)
 		return -ENOMEM;
 
-	if (np) {
-		struct device_node *master;
-		saif->id = of_alias_get_id(np, "saif");
-		if (saif->id < 0)
-			return saif->id;
-		/*
-		 * If there is no "fsl,saif-master" phandle, it's a saif
-		 * master.  Otherwise, it's a slave and its phandle points
-		 * to the master.
-		 */
-		master = of_parse_phandle(np, "fsl,saif-master", 0);
-		if (!master) {
-			saif->master_id = saif->id;
-		} else {
-			saif->master_id = of_alias_get_id(master, "saif");
-			if (saif->master_id < 0)
-				return saif->master_id;
-		}
+	saif->id = of_alias_get_id(np, "saif");
+	if (saif->id < 0)
+		return saif->id;
+	/*
+	 * If there is no "fsl,saif-master" phandle, it's a saif
+	 * master.  Otherwise, it's a slave and its phandle points
+	 * to the master.
+	 */
+	master = of_parse_phandle(np, "fsl,saif-master", 0);
+	if (!master) {
+		saif->master_id = saif->id;
 	} else {
-		saif->id = pdev->id;
-		pdata = pdev->dev.platform_data;
-		if (pdata && !pdata->master_mode)
-			saif->master_id = pdata->master_id;
-		else
-			saif->master_id = saif->id;
+		saif->master_id = of_alias_get_id(master, "saif");
+		if (saif->master_id < 0)
+			return saif->master_id;
 	}
 
 	if (saif->master_id < 0 || saif->master_id >= ARRAY_SIZE(mxs_saif)) {
-- 
1.7.9.5
