From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: fsl: imx-sgtl5000: Use devm_clk_get()
Date: Tue, 12 Mar 2013 20:51:29 -0300
Message-ID: <1363132289-15211-2-git-send-email-festevam@gmail.com>
References: <1363132289-15211-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f54.google.com (mail-ee0-f54.google.com [74.125.83.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 52EEE265DDD
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 00:51:49 +0100 (CET)
Received: by mail-ee0-f54.google.com with SMTP id c41so181645eek.27
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 16:51:49 -0700 (PDT)
In-Reply-To: <1363132289-15211-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Using devm_clk_get() can make the code smaller and simpler.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-sgtl5000.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 424347e..74a4628 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -128,7 +128,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	data->codec_clk = clk_get(&codec_dev->dev, NULL);
+	data->codec_clk = devm_clk_get(&codec_dev->dev, NULL);
 	if (IS_ERR(data->codec_clk)) {
 		/* assuming clock enabled by default */
 		data->codec_clk = NULL;
@@ -175,7 +175,6 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 clk_fail:
-	clk_put(data->codec_clk);
 fail:
 	if (ssi_np)
 		of_node_put(ssi_np);
@@ -189,10 +188,9 @@ static int imx_sgtl5000_remove(struct platform_device *pdev)
 {
 	struct imx_sgtl5000_data *data = platform_get_drvdata(pdev);
 
-	if (data->codec_clk) {
+	if (data->codec_clk)
 		clk_disable_unprepare(data->codec_clk);
-		clk_put(data->codec_clk);
-	}
+
 	snd_soc_unregister_card(&data->card);
 
 	return 0;
-- 
1.7.9.5
