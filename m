From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] ASoC: mxs: Use
	devm_snd_dmaengine_pcm_register()
Date: Thu, 28 Nov 2013 08:50:37 +0100
Message-ID: <1385625037-24973-6-git-send-email-lars@metafoo.de>
References: <1385625037-24973-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-014.synserver.de
 [212.40.185.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A1E12652C2
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 08:50:19 +0100 (CET)
In-Reply-To: <1385625037-24973-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Timur Tabi <timur@tabi.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Lars-Peter Clausen <lars@metafoo.de>, Florian Meier <florian.meier@koalo.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Makes the code shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
No changes since v1
---
 sound/soc/mxs/mxs-pcm.c  | 8 +-------
 sound/soc/mxs/mxs-pcm.h  | 1 -
 sound/soc/mxs/mxs-saif.c | 8 --------
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index b16abbb..04a6b0d 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -56,16 +56,10 @@ static const struct snd_dmaengine_pcm_config mxs_dmaengine_pcm_config = {
 
 int mxs_pcm_platform_register(struct device *dev)
 {
-	return snd_dmaengine_pcm_register(dev, &mxs_dmaengine_pcm_config,
+	return devm_snd_dmaengine_pcm_register(dev, &mxs_dmaengine_pcm_config,
 		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
 		SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX);
 }
 EXPORT_SYMBOL_GPL(mxs_pcm_platform_register);
 
-void mxs_pcm_platform_unregister(struct device *dev)
-{
-	snd_dmaengine_pcm_unregister(dev);
-}
-EXPORT_SYMBOL_GPL(mxs_pcm_platform_unregister);
-
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/mxs/mxs-pcm.h b/sound/soc/mxs/mxs-pcm.h
index bc685b6..035ea04 100644
--- a/sound/soc/mxs/mxs-pcm.h
+++ b/sound/soc/mxs/mxs-pcm.h
@@ -20,6 +20,5 @@
 #define _MXS_PCM_H
 
 int mxs_pcm_platform_register(struct device *dev);
-void mxs_pcm_platform_unregister(struct device *dev);
 
 #endif
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 54e622a..92db74d 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -804,13 +804,6 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mxs_saif_remove(struct platform_device *pdev)
-{
-	mxs_pcm_platform_unregister(&pdev->dev);
-
-	return 0;
-}
-
 static const struct of_device_id mxs_saif_dt_ids[] = {
 	{ .compatible = "fsl,imx28-saif", },
 	{ /* sentinel */ }
@@ -819,7 +812,6 @@ MODULE_DEVICE_TABLE(of, mxs_saif_dt_ids);
 
 static struct platform_driver mxs_saif_driver = {
 	.probe = mxs_saif_probe,
-	.remove = mxs_saif_remove,
 
 	.driver = {
 		.name = "mxs-saif",
-- 
1.8.0
