From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Fix irq error check
Date: Wed,  7 Jan 2015 19:45:40 -0200
Message-ID: <1420667140-32744-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f174.google.com (mail-vc0-f174.google.com
 [209.85.220.174])
 by alsa0.perex.cz (Postfix) with ESMTP id D4552265253
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 22:46:06 +0100 (CET)
Received: by mail-vc0-f174.google.com with SMTP id id10so835976vcb.19
 for <alsa-devel@alsa-project.org>; Wed, 07 Jan 2015 13:46:05 -0800 (PST)
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

Commit 2ffa531078037a0 ("ASoC: fsl_ssi: Fix module unbound") changed the way to 
retrieve the irq number from irq_of_parse_and_map() to platform_get_irq(), but
missed to updated the irq error check accordingly.

We should test for negative irq number and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index a65f17d..059496e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1362,9 +1362,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi_private->irq = platform_get_irq(pdev, 0);
-	if (!ssi_private->irq) {
+	if (ssi_private->irq < 0) {
 		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
-		return -ENXIO;
+		return ssi_private->irq;
 	}
 
 	/* Are the RX and the TX clocks locked? */
-- 
1.9.1
