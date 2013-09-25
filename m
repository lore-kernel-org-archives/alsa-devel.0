From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] ASoC: fsl/imx-sgtl5000: Fix uninitialized
	pointer use in error path
Date: Wed, 25 Sep 2013 15:22:01 +0200
Message-ID: <1380115321-32311-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C4A6C2654BA
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 15:22:03 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

This patch avoids to dereference the uninitialized data pointer if the
error path is entered before devm_kzalloc is called (or if the allocation
fails). It fixes the following warning:

    sound/soc/fsl/imx-sgtl5000.c: In function 'imx_sgtl5000_probe':
    sound/soc/fsl/imx-sgtl5000.c:175:18: warning: 'data' may be used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 sound/soc/fsl/imx-sgtl5000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index c49e4cb..6f4bdc8 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -62,7 +62,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	struct device_node *ssi_np, *codec_np;
 	struct platform_device *ssi_pdev;
 	struct i2c_client *codec_dev;
-	struct imx_sgtl5000_data *data;
+	struct imx_sgtl5000_data *data = NULL;
 	int int_port, ext_port;
 	int ret;
 
@@ -172,7 +172,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	return 0;
 
 fail:
-	if (!IS_ERR(data->codec_clk))
+	if (data && !IS_ERR(data->codec_clk))
 		clk_put(data->codec_clk);
 	if (ssi_np)
 		of_node_put(ssi_np);
-- 
1.8.4.rc3
