From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 2/2] ASoC: fsl: imx-sgtl5000: Use devm_clk_get
Date: Thu, 30 Jan 2014 10:47:18 +0100
Message-ID: <1391075238-20292-2-git-send-email-p.zabel@pengutronix.de>
References: <1391075238-20292-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 113FD2652F8
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 10:47:22 +0100 (CET)
In-Reply-To: <1391075238-20292-1-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, kernel@pengutronix.de, Nicolin Chen <b42378@freescale.com>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Use managed devm_clk_get. There is no need to manually
call clk_put anymore.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 sound/soc/fsl/imx-sgtl5000.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 3e60b4c..ba2c00b 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -128,7 +128,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	data->codec_clk = clk_get(&codec_dev->dev, NULL);
+	data->codec_clk = devm_clk_get(&codec_dev->dev, NULL);
 	if (IS_ERR(data->codec_clk)) {
 		ret = PTR_ERR(data->codec_clk);
 		goto fail;
@@ -172,8 +172,6 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	return 0;
 
 fail:
-	if (data && !IS_ERR(data->codec_clk))
-		clk_put(data->codec_clk);
 	if (ssi_np)
 		of_node_put(ssi_np);
 	if (codec_np)
@@ -184,10 +182,6 @@ fail:
 
 static int imx_sgtl5000_remove(struct platform_device *pdev)
 {
-	struct imx_sgtl5000_data *data = platform_get_drvdata(pdev);
-
-	clk_put(data->codec_clk);
-
 	return 0;
 }
 
-- 
1.8.5.3
