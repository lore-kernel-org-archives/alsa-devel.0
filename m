From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 1/2] ASoC: fsl_ssi: Remove an outdated comment
Date: Wed, 5 Apr 2017 13:40:10 -0300
Message-ID: <1491410411-6053-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0063.outbound.protection.outlook.com [104.47.40.63])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B31E266943
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 18:40:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

The comment for the FSLSSI_I2S_RATES definition states that the
driver currently only supports I2S slave mode, which is no longer
correct.

Remove such outdated comment.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/fsl_ssi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fde08660..b450d8d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -54,14 +54,6 @@
 #include "fsl_ssi.h"
 #include "imx-pcm.h"
 
-/**
- * FSLSSI_I2S_RATES: sample rates supported by the I2S
- *
- * This driver currently only supports the SSI running in I2S slave mode,
- * which means the codec determines the sample rate.  Therefore, we tell
- * ALSA that we support all rates and let the codec driver decide what rates
- * are really supported.
- */
 #define FSLSSI_I2S_RATES SNDRV_PCM_RATE_CONTINUOUS
 
 /**
-- 
2.7.4
