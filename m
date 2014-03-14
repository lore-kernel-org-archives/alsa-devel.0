From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/4] ASoC: davinci: Add edma dmaengine
	platform driver
Date: Fri, 14 Mar 2014 16:42:45 +0200
Message-ID: <1394808168-32608-2-git-send-email-peter.ujfalusi@ti.com>
References: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id A091C265453
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 15:42:57 +0100 (CET)
In-Reply-To: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, nsekhar@ti.com, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Platform driver glue for SoC using eDMA3 to use dmaengine PCM.
The maximum number of periods need to be limited to 19 since the
edma dmaengine driver limits the paRAM slot use for audio at
in cyclic mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/edma-pcm.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/davinci/edma-pcm.h | 25 +++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 sound/soc/davinci/edma-pcm.c
 create mode 100644 sound/soc/davinci/edma-pcm.h

diff --git a/sound/soc/davinci/edma-pcm.c b/sound/soc/davinci/edma-pcm.c
new file mode 100644
index 000000000000..d38afb1c61ae
--- /dev/null
+++ b/sound/soc/davinci/edma-pcm.c
@@ -0,0 +1,57 @@
+/*
+ * edma-pcm.c - eDMA PCM driver using dmaengine for AM3xxx, AM4xxx
+ *
+ * Copyright (C) 2014 Texas Instruments, Inc.
+ *
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
+ *
+ * Based on: sound/soc/tegra/tegra_pcm.c
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
+#include <linux/edma.h>
+
+static const struct snd_pcm_hardware edma_pcm_hardware = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_BATCH |
+				  SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME |
+				  SNDRV_PCM_INFO_INTERLEAVED,
+	.buffer_bytes_max	= 128 * 1024,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 64 * 1024,
+	.periods_min		= 2,
+	.periods_max		= 19, /* Limit by edma dmaengine driver */
+};
+
+static const struct snd_dmaengine_pcm_config edma_dmaengine_pcm_config = {
+	.pcm_hardware = &edma_pcm_hardware,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+	.compat_filter_fn = edma_filter_fn,
+	.prealloc_buffer_size = 128 * 1024,
+};
+
+int edma_pcm_platform_register(struct device *dev)
+{
+	return devm_snd_dmaengine_pcm_register(dev, &edma_dmaengine_pcm_config,
+					SND_DMAENGINE_PCM_FLAG_COMPAT);
+}
+EXPORT_SYMBOL_GPL(edma_pcm_platform_register);
+
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
+MODULE_DESCRIPTION("eDMA PCM ASoC platform driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/davinci/edma-pcm.h b/sound/soc/davinci/edma-pcm.h
new file mode 100644
index 000000000000..894c378c0f74
--- /dev/null
+++ b/sound/soc/davinci/edma-pcm.h
@@ -0,0 +1,25 @@
+/*
+ * edma-pcm.h - eDMA PCM driver using dmaengine for AM3xxx, AM4xxx
+ *
+ * Copyright (C) 2014 Texas Instruments, Inc.
+ *
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
+ *
+ * Based on: sound/soc/tegra/tegra_pcm.h
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef __EDMA_PCM_H__
+#define __EDMA_PCM_H__
+
+int edma_pcm_platform_register(struct device *dev);
+
+#endif /* __EDMA_PCM_H__ */
-- 
1.9.0
