From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2 1/2] ASoC: SPEAr: get rid of spear-pcm-audio
	struct device
Date: Tue, 10 Dec 2013 12:35:24 -0700
Message-ID: <1386704125-28698-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id E68D9265368
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 20:35:33 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Rajeev Kumar <rajeev-dlh.kumar@st.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Modify the SPEAr PCM driver so that it's a utility library that can be
registered on each DAI, rather than a separate struct device. This is
more in line with how many recent DT-converted platforms operate, and
avoids the need for yet another struct device.

This is also required as a pre-cursor to removing
spear_pcm_request_chan().

Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Rebased on a merge of topic/spear and topic/dma
---
 sound/soc/spear/spdif_in.c  |  9 +++++++--
 sound/soc/spear/spdif_out.c | 10 ++++++++--
 sound/soc/spear/spear_pcm.c | 18 ++++--------------
 sound/soc/spear/spear_pcm.h | 22 ++++++++++++++++++++++
 4 files changed, 41 insertions(+), 18 deletions(-)
 create mode 100644 sound/soc/spear/spear_pcm.h

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 21a8c954af1c..4627110f3441 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -24,6 +24,7 @@
 #include <sound/spear_dma.h>
 #include <sound/spear_spdif.h>
 #include "spdif_in_regs.h"
+#include "spear_pcm.h"
 
 struct spdif_in_params {
 	u32 format;
@@ -257,8 +258,12 @@ static int spdif_in_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return devm_snd_soc_register_component(&pdev->dev, &spdif_in_component,
-					       &spdif_in_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev, &spdif_in_component,
+					      &spdif_in_dai, 1);
+	if (ret)
+		return ret;
+
+	return devm_spear_pcm_platform_register(&pdev->dev);
 }
 
 static struct platform_driver spdif_in_driver = {
diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
index b6ef6f78dc78..731a1e0cfeaa 100644
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
@@ -306,8 +308,12 @@ static int spdif_out_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, host);
 
-	return devm_snd_soc_register_component(&pdev->dev, &spdif_out_component,
-					       &spdif_out_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev, &spdif_out_component,
+					      &spdif_out_dai, 1);
+	if (ret)
+		return ret;
+
+	return devm_spear_pcm_platform_register(&pdev->dev);
 }
 
 #ifdef CONFIG_PM
diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index 9a02141666ea..f288724961da 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -18,6 +18,7 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/spear_dma.h>
+#include "spear_pcm.h"
 
 static const struct snd_pcm_hardware spear_pcm_hardware = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -47,26 +48,15 @@ static const struct snd_dmaengine_pcm_config spear_dmaengine_pcm_config = {
 	.prealloc_buffer_size = 16 * 1024,
 };
 
-static int spear_soc_platform_probe(struct platform_device *pdev)
+int devm_spear_pcm_platform_register(struct device *dev)
 {
-	return devm_snd_dmaengine_pcm_register(&pdev->dev,
+	return devm_snd_dmaengine_pcm_register(dev,
 		&spear_dmaengine_pcm_config,
 		SND_DMAENGINE_PCM_FLAG_NO_DT |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
-
-static struct platform_driver spear_pcm_driver = {
-	.driver = {
-		.name = "spear-pcm-audio",
-		.owner = THIS_MODULE,
-	},
-
-	.probe = spear_soc_platform_probe,
-};
-
-module_platform_driver(spear_pcm_driver);
+EXPORT_SYMBOL_GPL(devm_spear_pcm_platform_register);
 
 MODULE_AUTHOR("Rajeev Kumar <rajeev-dlh.kumar@st.com>");
 MODULE_DESCRIPTION("SPEAr PCM DMA module");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:spear-pcm-audio");
diff --git a/sound/soc/spear/spear_pcm.h b/sound/soc/spear/spear_pcm.h
new file mode 100644
index 000000000000..631e2aa1fb33
--- /dev/null
+++ b/sound/soc/spear/spear_pcm.h
@@ -0,0 +1,22 @@
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
+int devm_spear_pcm_platform_register(struct device *dev);
+
+#endif
-- 
1.8.1.5
