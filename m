From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH] ASoC: fsl: imx-wm8962: defer probing if
	ssi/codec not found
Date: Thu, 19 Sep 2013 07:16:02 -0500
Message-ID: <1379592962-30028-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id D3E85261A10
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 14:16:12 +0200 (CEST)
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
 by relay1.mentorg.com with esmtp
 id 1VMd9X-0002p1-66 from Andrew_Gabbasov@mentor.com
 for alsa-devel@alsa-project.org; Thu, 19 Sep 2013 05:16:11 -0700
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
List-Id: alsa-devel@alsa-project.org

If the ssi or codec driver is not yet loaded by the time of imx-wm8962
driver probing, this probe should be deferred until the dependent drivers
loading. Return -EPROBE_DEFER in this case.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/soc/fsl/imx-wm8962.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 722afe6..9e60aa8 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -211,13 +211,13 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	ssi_pdev = of_find_device_by_node(ssi_np);
 	if (!ssi_pdev) {
 		dev_err(&pdev->dev, "failed to find SSI platform device\n");
-		ret = -EINVAL;
+		ret = -EPROBE_DEFER;
 		goto fail;
 	}
 	codec_dev = of_find_i2c_device_by_node(codec_np);
 	if (!codec_dev || !codec_dev->driver) {
 		dev_err(&pdev->dev, "failed to find codec platform device\n");
-		ret = -EINVAL;
+		ret = -EPROBE_DEFER;
 		goto fail;
 	}
 
-- 
1.7.10.4
