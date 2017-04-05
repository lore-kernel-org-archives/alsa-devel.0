From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/2] ASoC: fsl_ssi: Remove an outdated
	comment
Date: Wed,  5 Apr 2017 16:02:25 -0300
Message-ID: <1491418946-10585-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AE0A266943
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 21:02:41 +0200 (CEST)
Received: by mail-qk0-f193.google.com with SMTP id k139so2942978qke.2
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 12:02:41 -0700 (PDT)
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

From: Fabio Estevam <fabio.estevam@nxp.com>

The comment for the FSLSSI_I2S_RATES definition states that the
driver currently only supports I2S slave mode, which is no longer
correct.

Remove such outdated comment.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Only remove the outdated part of the comment

 sound/soc/fsl/fsl_ssi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fde08660..e0639e17 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -57,10 +57,8 @@
 /**
  * FSLSSI_I2S_RATES: sample rates supported by the I2S
  *
- * This driver currently only supports the SSI running in I2S slave mode,
- * which means the codec determines the sample rate.  Therefore, we tell
- * ALSA that we support all rates and let the codec driver decide what rates
- * are really supported.
+ * Tell ALSA that we support all rates and let the codec driver decide what
+ * rates are really supported.
  */
 #define FSLSSI_I2S_RATES SNDRV_PCM_RATE_CONTINUOUS
 
-- 
2.7.4
