From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: fsl_asrc: Check for
	clk_prepare_enable() error
Date: Sat, 20 Jun 2015 15:41:14 -0300
Message-ID: <1434825674-8618-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f52.google.com (mail-qg0-f52.google.com
 [209.85.192.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 79121260713
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 20:41:41 +0200 (CEST)
Received: by qgal13 with SMTP id l13so44495004qga.3
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 11:41:40 -0700 (PDT)
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

clk_prepare_enable() may fail, so we should better check its return value
and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_asrc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index c068494..37dde26 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -931,14 +931,22 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 static int fsl_asrc_runtime_resume(struct device *dev)
 {
 	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
-	int i;
+	int i, ret;
 
-	clk_prepare_enable(asrc_priv->mem_clk);
-	clk_prepare_enable(asrc_priv->ipg_clk);
+	ret = clk_prepare_enable(asrc_priv->mem_clk);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(asrc_priv->ipg_clk);
+	if (ret)
+		goto disable_mem_clk;
 	for (i = 0; i < ASRC_CLK_MAX_NUM; i++)
 		clk_prepare_enable(asrc_priv->asrck_clk[i]);
 
 	return 0;
+
+disable_mem_clk:
+	clk_disable_unprepare(asrc_priv->mem_clk);
+	return ret;
 }
 
 static int fsl_asrc_runtime_suspend(struct device *dev)
-- 
1.9.1
