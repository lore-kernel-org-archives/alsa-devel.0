From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 4/4] ASoC: imx-sgtl5000: Convert to
	devm_clk_get()
Date: Wed, 24 Apr 2013 11:54:46 -0300
Message-ID: <1366815286-31820-4-git-send-email-festevam@gmail.com>
References: <1366815286-31820-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f181.google.com (mail-gg0-f181.google.com
 [209.85.161.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 56E0B261615
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 16:55:15 +0200 (CEST)
Received: by mail-gg0-f181.google.com with SMTP id l4so254881ggi.12
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 07:55:14 -0700 (PDT)
In-Reply-To: <1366815286-31820-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Converting to devm_clk_get() can simplify the code a bit.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 sound/soc/fsl/imx-sgtl5000.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 18af815..c869996 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -137,7 +137,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	data->codec_clk = clk_get(&codec_dev->dev, NULL);
+	data->codec_clk = devm_clk_get(&codec_dev->dev, NULL);
 	if (IS_ERR(data->codec_clk)) {
 		ret = PTR_ERR(data->codec_clk);
 		dev_err(&codec_dev->dev, "could not get codec clk: %d\n", ret);
@@ -186,7 +186,6 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 
 clk_fail:
 	clk_disable_unprepare(data->codec_clk);
-	clk_put(data->codec_clk);
 fail:
 	if (ssi_np)
 		of_node_put(ssi_np);
@@ -200,10 +199,7 @@ static int imx_sgtl5000_remove(struct platform_device *pdev)
 {
 	struct imx_sgtl5000_data *data = platform_get_drvdata(pdev);
 
-	if (data->codec_clk) {
-		clk_disable_unprepare(data->codec_clk);
-		clk_put(data->codec_clk);
-	}
+	clk_disable_unprepare(data->codec_clk);
 	snd_soc_unregister_card(&data->card);
 
 	return 0;
-- 
1.7.9.5
