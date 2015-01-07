From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/5] ASoC: fsl_ssi: Make error message concise
Date: Wed,  7 Jan 2015 13:44:32 -0200
Message-ID: <1420645476-13193-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f172.google.com (mail-vc0-f172.google.com
 [209.85.220.172])
 by alsa0.perex.cz (Postfix) with ESMTP id F134F26054F
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 16:44:55 +0100 (CET)
Received: by mail-vc0-f172.google.com with SMTP id hq11so566016vcb.31
 for <alsa-devel@alsa-project.org>; Wed, 07 Jan 2015 07:44:54 -0800 (PST)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Currently the error message uses 'np->full_name' which leads to a very verbose
log as:

fsl-ssi-dai 202c000.ssi: no irq for node /soc/aips-bus@02000000/spba-bus@02000000/ssi@0202c000

We can have a concise log by using pdev->name instead:

fsl-ssi-dai 202c000.ssi: no irq for node 202c000.ssi

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index a65f17d..fa19507 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1363,7 +1363,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	ssi_private->irq = platform_get_irq(pdev, 0);
 	if (!ssi_private->irq) {
-		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
+		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
 		return -ENXIO;
 	}
 
-- 
1.9.1
