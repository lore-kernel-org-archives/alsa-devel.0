From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 4/5] ASoC: fsl_esai: Make error message concise
Date: Wed,  7 Jan 2015 13:44:35 -0200
Message-ID: <1420645476-13193-4-git-send-email-festevam@gmail.com>
References: <1420645476-13193-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f177.google.com (mail-vc0-f177.google.com
 [209.85.220.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 540DA2605DC
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 16:45:02 +0100 (CET)
Received: by mail-vc0-f177.google.com with SMTP id ij19so555417vcb.8
 for <alsa-devel@alsa-project.org>; Wed, 07 Jan 2015 07:45:01 -0800 (PST)
In-Reply-To: <1420645476-13193-1-git-send-email-festevam@gmail.com>
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
log that contains the full path of the node.

We can have a concise log by using pdev->name instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_esai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 1c08ab1..5c75971 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -774,7 +774,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
+		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
 		return irq;
 	}
 
-- 
1.9.1
