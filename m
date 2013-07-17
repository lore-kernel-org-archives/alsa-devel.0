From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: fsl: fsl_ssi: Check the return value
	from clk_prepare_enable()
Date: Wed, 17 Jul 2013 02:00:39 -0300
Message-ID: <1374037239-16984-2-git-send-email-festevam@gmail.com>
References: <1374037239-16984-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f171.google.com (mail-gg0-f171.google.com
 [209.85.161.171])
 by alsa0.perex.cz (Postfix) with ESMTP id E51692652B7
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 07:00:50 +0200 (CEST)
Received: by mail-gg0-f171.google.com with SMTP id q3so465135gge.30
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 22:00:50 -0700 (PDT)
In-Reply-To: <1374037239-16984-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so let's check its return value and propagate it
in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ab8d462..73534b0 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -743,7 +743,12 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "could not get clock: %d\n", ret);
 			goto error_irqmap;
 		}
-		clk_prepare_enable(ssi_private->clk);
+		ret = clk_prepare_enable(ssi_private->clk);
+		if (ret) {
+			dev_err(&pdev->dev, "clk_prepare_enable failed: %d\n",
+				ret);
+			goto error_irqmap;
+		}
 
 		/*
 		 * We have burstsize be "fifo_depth - 2" to match the SSI
-- 
1.8.1.2
