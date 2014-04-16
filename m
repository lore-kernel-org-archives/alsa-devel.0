From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 02/20] ASoC: omap-pcm: Support for binding
	the platform driver to dai devices
Date: Wed, 16 Apr 2014 15:46:12 +0300
Message-ID: <1397652390-852-3-git-send-email-peter.ujfalusi@ti.com>
References: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 44B8D2652FF
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 14:46:42 +0200 (CEST)
In-Reply-To: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

With the new calls it is going to be possible to bind the platform driver
to a dai device which makes it easier for us in a long run to handle DT
boots, and opens the possibility to move machine driver to generic simple
card.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-pcm.c |  6 ++++++
 sound/soc/omap/omap-pcm.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 sound/soc/omap/omap-pcm.h

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 07b8b7bc9d20..c3711b582d5f 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -232,6 +232,12 @@ static struct snd_soc_platform_driver omap_soc_platform = {
 	.pcm_free	= omap_pcm_free_dma_buffers,
 };
 
+int omap_pcm_platform_register(struct device *dev)
+{
+	return devm_snd_soc_register_platform(dev, &omap_soc_platform);
+}
+EXPORT_SYMBOL_GPL(omap_pcm_platform_register);
+
 static int omap_pcm_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev,
diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
new file mode 100644
index 000000000000..c1d2f31d71e9
--- /dev/null
+++ b/sound/soc/omap/omap-pcm.h
@@ -0,0 +1,30 @@
+/*
+ * omap-pcm.h - OMAP PCM driver
+ *
+ * Copyright (C) 2014 Texas Instruments, Inc.
+ *
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
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
+#ifndef __OMAP_PCM_H__
+#define __OMAP_PCM_H__
+
+#if IS_ENABLED(CONFIG_SND_OMAP_SOC)
+int omap_pcm_platform_register(struct device *dev);
+#else
+static inline int omap_pcm_platform_register(struct device *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_SND_OMAP_SOC */
+
+#endif /* __OMAP_PCM_H__ */
-- 
1.9.2
