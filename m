From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ASoC: fsl: fsl_asrc: Check for
	clk_prepare_enable() error
Date: Sat, 20 Jun 2015 18:00:13 -0300
Message-ID: <1434834013-23088-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f178.google.com (mail-qk0-f178.google.com
 [209.85.220.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 16FD026051B
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 23:00:52 +0200 (CEST)
Received: by qkbp125 with SMTP id p125so75282294qkb.2
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 14:00:51 -0700 (PDT)
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
Changes since v1:
- Also handle the error for asrck_clk[i] as suggested
by Nicolin

 sound/soc/fsl/fsl_asrc.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index c068494..9f087d4 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -931,14 +931,29 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 static int fsl_asrc_runtime_resume(struct device *dev)
 {
 	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
-	int i;
+	int i, ret;
 
-	clk_prepare_enable(asrc_priv->mem_clk);
-	clk_prepare_enable(asrc_priv->ipg_clk);
-	for (i = 0; i < ASRC_CLK_MAX_NUM; i++)
-		clk_prepare_enable(asrc_priv->asrck_clk[i]);
+	ret = clk_prepare_enable(asrc_priv->mem_clk);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(asrc_priv->ipg_clk);
+	if (ret)
+		goto disable_mem_clk;
+	for (i = 0; i < ASRC_CLK_MAX_NUM; i++) {
+		ret = clk_prepare_enable(asrc_priv->asrck_clk[i]);
+		if (ret)
+			goto disable_asrck_clk;
+	}
 
 	return 0;
+
+disable_asrck_clk:
+	for (i--; i >= 0; i--)
+		clk_disable_unprepare(asrc_priv->asrck_clk[i]);
+	clk_disable_unprepare(asrc_priv->ipg_clk);
+disable_mem_clk:
+	clk_disable_unprepare(asrc_priv->mem_clk);
+	return ret;
 }
 
 static int fsl_asrc_runtime_suspend(struct device *dev)
-- 
1.9.1
