From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add trivial pm_runtime usage to Samsung
	DAI drivers
Date: Mon, 12 Dec 2011 19:27:39 +0800
Message-ID: <1323689259-1606-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4DBE2244FA
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 12:27:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently this won't actually do anything but using this will help the
core SoC code track when the system is idle.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/i2s.c |    6 +++++-
 sound/soc/samsung/pcm.c |    5 +++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index ff5d919..87a874d 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
@@ -1095,6 +1096,8 @@ static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 
 	snd_soc_register_dai(&pri_dai->pdev->dev, &pri_dai->i2s_dai_drv);
 
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 err:
 	release_mem_region(regs_base, resource_size(res));
@@ -1105,6 +1108,7 @@ err:
 static __devexit int samsung_i2s_remove(struct platform_device *pdev)
 {
 	struct i2s_dai *i2s, *other;
+	struct resource *res;
 
 	i2s = dev_get_drvdata(&pdev->dev);
 	other = i2s->pri_dai ? : i2s->sec_dai;
@@ -1113,7 +1117,7 @@ static __devexit int samsung_i2s_remove(struct platform_device *pdev)
 		other->pri_dai = NULL;
 		other->sec_dai = NULL;
 	} else {
-		struct resource *res;
+		pm_runtime_disable(&pdev->dev);
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (res)
 			release_mem_region(res->start, resource_size(res));
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 3a29c26..a1dc141c 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
@@ -581,6 +582,8 @@ static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
 	pcm->dma_capture = &s3c_pcm_stereo_in[pdev->id];
 	pcm->dma_playback = &s3c_pcm_stereo_out[pdev->id];
 
+	pm_runtime_enable(&pdev->dev);
+
 	ret = snd_soc_register_dai(&pdev->dev, &s3c_pcm_dai[pdev->id]);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "failed to get register DAI: %d\n", ret);
@@ -610,6 +613,8 @@ static __devexit int s3c_pcm_dev_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_dai(&pdev->dev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	iounmap(pcm->regs);
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.7.3
