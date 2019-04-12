From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH] ASoC: sprd: Add reserved DMA memory support
Date: Fri, 12 Apr 2019 14:40:17 +0800
Message-ID: <ee4a22c3491628abf94c8d356dccd67984604811.1555049554.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, baolin.wang@linaro.org, orsonzhai@gmail.com, zhang.lyra@gmail.com
List-Id: alsa-devel@alsa-project.org

For Spreadtrum audio platform driver, it need allocate a larger DMA buffer
dynamically to copy audio data between userspace and kernel space, but that
will increase the risk of memory allocation failure especially the system
is under heavy load situation.

To make sure the audio can work in this scenario, we usually reserve one
region of memory to be used as a shared pool of DMA buffers for the
platform component. So add of_reserved_mem_device_init_by_idx() function
to initialize the shared pool of DMA buffers to be used by the platform
component.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 sound/soc/sprd/sprd-pcm-dma.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
index 9be6d4b..d38ebbb 100644
--- a/sound/soc/sprd/sprd-pcm-dma.c
+++ b/sound/soc/sprd/sprd-pcm-dma.c
@@ -6,6 +6,7 @@
 #include <linux/dma/sprd-dma.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -530,8 +531,14 @@ static void sprd_pcm_free(struct snd_pcm *pcm)
 
 static int sprd_soc_platform_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
+	ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
+	if (ret)
+		dev_warn(&pdev->dev,
+			 "no reserved DMA memory for audio platform device\n");
+
 	ret = devm_snd_soc_register_component(&pdev->dev, &sprd_soc_component,
 					      NULL, 0);
 	if (ret)
-- 
1.7.9.5
