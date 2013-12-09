From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 3/5] ASoC: SPEAr: get rid of spear-pcm-audio
	struct device
Date: Mon,  9 Dec 2013 13:24:14 -0700
Message-ID: <1386620656-18391-4-git-send-email-swarren@wwwdotorg.org>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id BADE22650DD
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 21:24:35 +0100 (CET)
In-Reply-To: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Modify the SPEAr PCM driver so that it's a utility library that can be
registered on each DAI, rather than a separate struct device. This is
more in line with how many recent DT-converted platforms operate, and
avoids the need for yet another struct device.

This is also required as a pre-cursor to removing
spear_pcm_request_chan().

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/spear/spdif_in.c  | 17 +++++++++++++++--
 sound/soc/spear/spdif_out.c | 18 ++++++++++++++++--
 sound/soc/spear/spear_pcm.c | 25 +++++++------------------
 sound/soc/spear/spear_pcm.h | 24 ++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 22 deletions(-)
 create mode 100644 sound/soc/spear/spear_pcm.h

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 21a8c954af1c..c1cfd333d81c 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -24,6 +24,7 @@
 #include <sound/spear_dma.h>
 #include <sound/spear_spdif.h>
 #include "spdif_in_regs.h"
+#include "spear_pcm.h"
 
 struct spdif_in_params {
 	u32 format;
@@ -257,12 +258,24 @@ static int spdif_in_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return devm_snd_soc_register_component(&pdev->dev, &spdif_in_component,
-					       &spdif_in_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev, &spdif_in_component,
+					      &spdif_in_dai, 1);
+	if (ret)
+		return ret;
+
+	return spear_pcm_platform_register(&pdev->dev);
+}
+
+static int spdif_in_remove(struct platform_device *pdev)
+{
+	spear_pcm_platform_unregister(&pdev->dev);
+
+	return 0;
 }
 
 static struct platform_driver spdif_in_driver = {
 	.probe		= spdif_in_probe,
+	.remove		= spdif_in_remove,
 	.driver		= {
 		.name	= "spdif-in",
 		.owner	= THIS_MODULE,
diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
index b6ef6f78dc78..ad3d5d684f0c 100644
--- a/sound/soc/spear/spdif_out.c
+++ b/sound/soc/spear/spdif_out.c
@@ -22,6 +22,7 @@
 #include <sound/spear_dma.h>
 #include <sound/spear_spdif.h>
 #include "spdif_out_regs.h"
+#include "spear_pcm.h"
 
 struct spdif_out_params {
 	u32 rate;
@@ -280,6 +281,7 @@ static int spdif_out_probe(struct platform_device *pdev)
 	struct spdif_out_dev *host;
 	struct spear_spdif_platform_data *pdata;
 	struct resource *res;
+	int ret;
 
 	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
 	if (!host) {
@@ -306,8 +308,19 @@ static int spdif_out_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, host);
 
-	return devm_snd_soc_register_component(&pdev->dev, &spdif_out_component,
-					       &spdif_out_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev, &spdif_out_component,
+					      &spdif_out_dai, 1);
+	if (ret)
+		return ret;
+
+	return spear_pcm_platform_register(&pdev->dev);
+}
+
+static int spdif_out_remove(struct platform_device *pdev)
+{
+	spear_pcm_platform_unregister(&pdev->dev);
+
+	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -348,6 +361,7 @@ static SIMPLE_DEV_PM_OPS(spdif_out_dev_pm_ops, spdif_out_suspend, \
 
 static struct platform_driver spdif_out_driver = {
 	.probe		= spdif_out_probe,
+	.remove		= spdif_out_remove,
 	.driver		= {
 		.name	= "spdif-out",
 		.owner	= THIS_MODULE,
diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index 4707f2b862c3..e849f28e10c2 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -18,6 +18,7 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/spear_dma.h>
+#include "spear_pcm.h"
 
 static const struct snd_pcm_hardware spear_pcm_hardware = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -47,33 +48,21 @@ static const struct snd_dmaengine_pcm_config spear_dmaengine_pcm_config = {
 	.prealloc_buffer_size = 16 * 1024,
 };
 
-static int spear_soc_platform_probe(struct platform_device *pdev)
+int spear_pcm_platform_register(struct device *dev)
 {
-	return snd_dmaengine_pcm_register(&pdev->dev,
+	return snd_dmaengine_pcm_register(dev,
 		&spear_dmaengine_pcm_config,
 		SND_DMAENGINE_PCM_FLAG_NO_DT |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
+EXPORT_SYMBOL_GPL(spear_pcm_platform_register);
 
-static int spear_soc_platform_remove(struct platform_device *pdev)
+void spear_pcm_platform_unregister(struct device *dev)
 {
-	snd_dmaengine_pcm_unregister(&pdev->dev);
-	return 0;
+	snd_dmaengine_pcm_unregister(dev);
 }
-
-static struct platform_driver spear_pcm_driver = {
-	.driver = {
-		.name = "spear-pcm-audio",
-		.owner = THIS_MODULE,
-	},
-
-	.probe = spear_soc_platform_probe,
-	.remove = spear_soc_platform_remove,
-};
-
-module_platform_driver(spear_pcm_driver);
+EXPORT_SYMBOL_GPL(spear_pcm_platform_unregister);
 
 MODULE_AUTHOR("Rajeev Kumar <rajeev-dlh.kumar@st.com>");
 MODULE_DESCRIPTION("SPEAr PCM DMA module");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:spear-pcm-audio");
diff --git a/sound/soc/spear/spear_pcm.h b/sound/soc/spear/spear_pcm.h
new file mode 100644
index 000000000000..0ece110eb3d6
--- /dev/null
+++ b/sound/soc/spear/spear_pcm.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __SPEAR_PCM_H__
+#define __SPEAR_PCM_H__
+
+int spear_pcm_platform_register(struct device *dev);
+void spear_pcm_platform_unregister(struct device *dev);
+
+#endif
+
-- 
1.8.1.5
