From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Change irq type to 'int'
Date: Wed, 14 Jan 2015 10:48:59 -0200
Message-ID: <1421239739-7755-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
 [209.85.192.45])
 by alsa0.perex.cz (Postfix) with ESMTP id A213C26156A
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 13:49:24 +0100 (CET)
Received: by mail-qg0-f45.google.com with SMTP id z107so6697099qgd.4
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 04:49:23 -0800 (PST)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 2ffa531078037a0 ("ASoC: fsl_ssi: Fix module unbound") the irq 
number is retrieved via platform_get_irq(), which may fail and return a negative
number, so adapt its type to 'int'.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 65400be..46549de 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -160,7 +160,7 @@ struct fsl_ssi_soc_data {
  */
 struct fsl_ssi_private {
 	struct regmap *regs;
-	unsigned int irq;
+	int irq;
 	struct snd_soc_dai_driver cpu_dai_drv;
 
 	unsigned int dai_fmt;
-- 
1.9.1
