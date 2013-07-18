From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: fsl: imx-wm8962: Fix error path
Date: Thu, 18 Jul 2013 15:07:48 -0300
Message-ID: <1374170868-22845-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 by alsa0.perex.cz (Postfix) with ESMTP id B21962655DC
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 20:08:04 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

If the 'failed to find codec platform device' error path is executed, it should
jump to 'fail' label instead of returning an error immediately.

'fail' label will then free the ssi_np and codec_np previously acquired nodes.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-wm8962.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 52a36a9..1d70e27 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -217,7 +217,8 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	codec_dev = of_find_i2c_device_by_node(codec_np);
 	if (!codec_dev || !codec_dev->driver) {
 		dev_err(&pdev->dev, "failed to find codec platform device\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-- 
1.8.1.2
