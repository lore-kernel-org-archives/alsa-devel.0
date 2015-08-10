From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH v2] ASoC: fsl-sai: add 32 bit word length
	support
Date: Mon, 10 Aug 2015 10:43:49 +0800
Message-ID: <deb461b426c4f24742e77dd58e0cb6713f1630ed.1439174417.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0145.outbound.protection.outlook.com [157.56.110.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 080E426512D
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 04:42:13 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Add 32 bit word length support. There are no code changes required
in the SAI driver since it has already wirten the word width to the
corresponding register.

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
