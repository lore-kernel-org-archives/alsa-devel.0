From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Fix platform_get_irq() error
	handling
Date: Wed, 15 Apr 2015 00:08:15 -0300
Message-ID: <1429067295-16052-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 405912605BD
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2015 05:09:56 +0200 (CEST)
Received: by qkx62 with SMTP id 62so55271988qkx.0
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 20:09:55 -0700 (PDT)
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

We should check whether platform_get_irq() returns a negative number and
propagate the error in this case.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e8bb8ee..0d48804 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1357,7 +1357,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi_private->irq = platform_get_irq(pdev, 0);
-	if (!ssi_private->irq) {
+	if (ssi_private->irq < 0) {
 		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
 		return ssi_private->irq;
 	}
-- 
1.9.1
