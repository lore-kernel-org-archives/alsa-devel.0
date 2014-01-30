From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 1/2] ASoC: fsl: imx-sgtl5000: No need to
	initialize local variable data
Date: Thu, 30 Jan 2014 10:47:17 +0100
Message-ID: <1391075238-20292-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id D7FE026532C
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 10:47:29 +0100 (CET)
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

The first access to this variable is an assignment to the result of a
kzalloc function call. Remove the superfluous initialisation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 sound/soc/fsl/imx-sgtl5000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index f2beae7..3e60b4c 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -62,7 +62,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	struct device_node *ssi_np, *codec_np;
 	struct platform_device *ssi_pdev;
 	struct i2c_client *codec_dev;
-	struct imx_sgtl5000_data *data = NULL;
+	struct imx_sgtl5000_data *data;
 	int int_port, ext_port;
 	int ret;
 
-- 
1.8.5.3
