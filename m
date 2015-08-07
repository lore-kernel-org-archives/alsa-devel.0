From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 1/3] ASoC: fsl-sai: add 32 bit word length
	support
Date: Fri, 7 Aug 2015 14:23:51 +0800
Message-ID: <35057b1d49085839cdd1c6514a6ed7b690c713e9.1438928571.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0145.outbound.protection.outlook.com [65.55.169.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C00B26149D
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 08:22:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nicoleotsuka@gmail.com
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Add 32 bit word length support.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_sai.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 0662809..40280ce 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012-2013 Freescale Semiconductor, Inc.
+ * Copyright 2012-2015 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -13,7 +13,8 @@
 
 #define FSL_SAI_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
 			 SNDRV_PCM_FMTBIT_S20_3LE |\
-			 SNDRV_PCM_FMTBIT_S24_LE)
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
 
 /* SAI Register Map Register */
 #define FSL_SAI_TCSR	0x00 /* SAI Transmit Control */
-- 
1.9.1
