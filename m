From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: fsl-sai: Use
	devm_snd_dmaengine_pcm_register()
Date: Fri, 20 Dec 2013 12:30:26 +0800
Message-ID: <1387513826-15846-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 by alsa0.perex.cz (Postfix) with ESMTP id C98032654D4
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 06:22:38 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Makes the code slightly shorter

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 50a797e..39cb9ee 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -454,19 +454,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = snd_dmaengine_pcm_register(&pdev->dev, NULL,
+	return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL,
 			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int fsl_sai_remove(struct platform_device *pdev)
-{
-	snd_dmaengine_pcm_unregister(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id fsl_sai_ids[] = {
@@ -476,8 +465,6 @@ static const struct of_device_id fsl_sai_ids[] = {
 
 static struct platform_driver fsl_sai_driver = {
 	.probe = fsl_sai_probe,
-	.remove = fsl_sai_remove,
-
 	.driver = {
 		.name = "fsl-sai",
 		.owner = THIS_MODULE,
-- 
1.8.4
