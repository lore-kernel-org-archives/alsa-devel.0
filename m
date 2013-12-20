From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: fsl-sai: Remove fsl_sai_remove()
Date: Fri, 20 Dec 2013 12:17:38 +0800
Message-ID: <1387513058-8314-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is no need of this function and makes the code slightly shorter

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 50a797e..1868ec3 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -385,19 +385,8 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
-static int fsl_sai_dai_remove(struct snd_soc_dai *cpu_dai)
-{
-	cpu_dai->playback_dma_data = NULL;
-	cpu_dai->capture_dma_data = NULL;
-
-	snd_soc_dai_set_drvdata(cpu_dai, NULL);
-
-	return 0;
-}
-
 static struct snd_soc_dai_driver fsl_sai_dai = {
 	.probe = fsl_sai_dai_probe,
-	.remove = fsl_sai_dai_remove,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
-- 
1.8.4
