From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: add config for rockchip
	dmaengine pcm register" to the asoc tree
Date: Mon, 18 Jun 2018 13:00:20 +0100
Message-ID: <E1fUspY-0000DI-3A@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2477226772E
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:24 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jianqun Xu <jay.xu@rock-chips.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: add config for rockchip dmaengine pcm register

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 75b31192fe6ad20b42276b20ee3bdf1493216d63 Mon Sep 17 00:00:00 2001
From: Jianqun Xu <jay.xu@rock-chips.com>
Date: Fri, 8 Jun 2018 16:31:09 +0800
Subject: [PATCH] ASoC: rockchip: add config for rockchip dmaengine pcm
 register

This patch makes the rockchip i2s pcm configurable by adding
rockchip pcm config for devm_snd_dmaengine_pcm_register.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/Makefile       |  3 ++-
 sound/soc/rockchip/rockchip_i2s.c |  3 ++-
 sound/soc/rockchip/rockchip_pcm.c | 45 +++++++++++++++++++++++++++++++
 sound/soc/rockchip/rockchip_pcm.h | 14 ++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/rockchip/rockchip_pcm.c
 create mode 100644 sound/soc/rockchip/rockchip_pcm.h

diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index 05b078e7b87f..65e814d46006 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # ROCKCHIP Platform Support
 snd-soc-rockchip-i2s-objs := rockchip_i2s.o
+snd-soc-rockchip-pcm-objs := rockchip_pcm.o
 snd-soc-rockchip-pdm-objs := rockchip_pdm.o
 snd-soc-rockchip-spdif-objs := rockchip_spdif.o
 
-obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-rockchip-i2s.o
+obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-rockchip-i2s.o snd-soc-rockchip-pcm.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_PDM) += snd-soc-rockchip-pdm.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_SPDIF) += snd-soc-rockchip-spdif.o
 
diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 950823d69e9c..60d43d53a8f5 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -22,6 +22,7 @@
 #include <sound/dmaengine_pcm.h>
 
 #include "rockchip_i2s.h"
+#include "rockchip_pcm.h"
 
 #define DRV_NAME "rockchip-i2s"
 
@@ -674,7 +675,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
-	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	ret = rockchip_pcm_platform_register(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
 		return ret;
diff --git a/sound/soc/rockchip/rockchip_pcm.c b/sound/soc/rockchip/rockchip_pcm.c
new file mode 100644
index 000000000000..f77538319221
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_pcm.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright (c) 2018 Rockchip Electronics Co. Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
+
+#include "rockchip_pcm.h"
+
+static const struct snd_pcm_hardware snd_rockchip_hardware = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_PAUSE |
+				  SNDRV_PCM_INFO_RESUME,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 8192,
+	.periods_min		= 1,
+	.periods_max		= 52,
+	.buffer_bytes_max	= 64 * 1024,
+	.fifo_size		= 32,
+};
+
+static const struct snd_dmaengine_pcm_config rk_dmaengine_pcm_config = {
+	.pcm_hardware = &snd_rockchip_hardware,
+	.prealloc_buffer_size = 32 * 1024,
+};
+
+int rockchip_pcm_platform_register(struct device *dev)
+{
+	return devm_snd_dmaengine_pcm_register(dev, &rk_dmaengine_pcm_config,
+		SND_DMAENGINE_PCM_FLAG_COMPAT);
+}
+EXPORT_SYMBOL_GPL(rockchip_pcm_platform_register);
+
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/rockchip/rockchip_pcm.h b/sound/soc/rockchip/rockchip_pcm.h
new file mode 100644
index 000000000000..d6c36115c60a
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_pcm.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (c) 2018 Rockchip Electronics Co. Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ROCKCHIP_PCM_H
+#define _ROCKCHIP_PCM_H
+
+int rockchip_pcm_platform_register(struct device *dev);
+
+#endif
-- 
2.17.1
