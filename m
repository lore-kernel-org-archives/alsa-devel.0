From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 1/3] ASoC: fsl_asrc: Propagate the real error
	code
Date: Fri, 19 Aug 2016 10:30:59 -0300
Message-ID: <1471613461-21654-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0043.outbound.protection.outlook.com [104.47.37.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D949C267520
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 15:33:03 +0200 (CEST)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

Instead of returning -EINVAL on error, return the real error code.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index c1a0e01..15f8ba5 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -892,7 +892,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	ret = fsl_asrc_init(asrc_priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to init asrc %d\n", ret);
-		return -EINVAL;
+		return ret;
 	}
 
 	asrc_priv->channel_avail = 10;
@@ -901,14 +901,14 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 				   &asrc_priv->asrc_rate);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get output rate\n");
-		return -EINVAL;
+		return ret;
 	}
 
 	ret = of_property_read_u32(np, "fsl,asrc-width",
 				   &asrc_priv->asrc_width);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get output width\n");
-		return -EINVAL;
+		return ret;
 	}
 
 	if (asrc_priv->asrc_width != 16 && asrc_priv->asrc_width != 24) {
-- 
1.9.1
