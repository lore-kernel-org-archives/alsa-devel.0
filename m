From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 3/5] ASoC: OMAP: Add CPU DAI driver for HDMI
Date: Sun, 15 May 2011 04:36:33 -0500
Message-ID: <1305452195-19177-4-git-send-email-ricardo.neri@ti.com>
References: <1305452195-19177-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 6592210380F
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 11:38:11 +0200 (CEST)
In-Reply-To: <1305452195-19177-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, lrg@ti.com, tomi.valkeinen@ti.com
Cc: Ricardo Neri <ricardo.neri@ti.com>
List-Id: alsa-devel@alsa-project.org

Addition of the HDMI CPU DAI driver for OMAP4. This driver is in
charge of configuring DMA settings for HDMI. Also, it finds
the HDMI video device and determines if audio playback can proceed.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap-hdmi.c |  158 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-hdmi.h |   36 ++++++++++
 2 files changed, 194 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap-hdmi.c
 create mode 100644 sound/soc/omap/omap-hdmi.h

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
new file mode 100644
index 0000000..36c6eae
--- /dev/null
+++ b/sound/soc/omap/omap-hdmi.c
@@ -0,0 +1,158 @@
+/*
+ * omap-hdmi.c
+ *
+ * OMAP ALSA SoC DAI driver for HDMI audio on OMAP4 processors.
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Authors: Jorge Candelaria <jorge.candelaria@ti.com>
+ *          Ricardo Neri <ricardo.neri@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include <plat/dma.h>
+#include "omap-pcm.h"
+#include "omap-hdmi.h"
+
+#define DRV_NAME "hdmi-audio-dai"
+
+static struct omap_pcm_dma_data omap_hdmi_dai_dma_params = {
+	.name = "HDMI playback",
+	.sync_mode = OMAP_DMA_SYNC_PACKET,
+};
+
+static int omap_hdmi_dai_startup(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	int err;
+	/*
+	 * Make sure that the period bytes are multiple of the DMA packet size.
+	 * Largest packet size we use is 32 32-bit words = 128 bytes
+	 */
+	err = snd_pcm_hw_constraint_step(substream->runtime, 0,
+				 SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 128);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int omap_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params,
+				    struct snd_soc_dai *dai)
+{
+	int err = 0;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		omap_hdmi_dai_dma_params.packet_size = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		omap_hdmi_dai_dma_params.packet_size = 32;
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	omap_hdmi_dai_dma_params.data_type = OMAP_DMA_DATA_TYPE_S32;
+
+	snd_soc_dai_set_dma_data(dai, substream,
+				 &omap_hdmi_dai_dma_params);
+
+	return err;
+}
+
+static struct snd_soc_dai_ops omap_hdmi_dai_ops = {
+	.startup	= omap_hdmi_dai_startup,
+	.hw_params	= omap_hdmi_dai_hw_params,
+};
+
+static struct snd_soc_dai_driver omap_hdmi_dai = {
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = OMAP_HDMI_RATES,
+		.formats = OMAP_HDMI_FORMATS,
+	},
+	.ops = &omap_hdmi_dai_ops,
+};
+
+static __devinit int omap_hdmi_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct resource *hdmi_rsrc;
+
+	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!hdmi_rsrc) {
+		dev_err(&pdev->dev, "Cannot obtain IORESOURCE_MEM HDMI\n");
+		return -EINVAL;
+	}
+
+	omap_hdmi_dai_dma_params.port_addr =  hdmi_rsrc->start
+		+ OMAP_HDMI_AUDIO_DMA_PORT;
+
+	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!hdmi_rsrc) {
+		dev_err(&pdev->dev, "Cannot obtain IORESOURCE_DMA HDMI\n");
+		return -EINVAL;
+	}
+
+	omap_hdmi_dai_dma_params.dma_req =  hdmi_rsrc->start;
+
+	ret = snd_soc_register_dai(&pdev->dev, &omap_hdmi_dai);
+	return ret;
+}
+
+static int __devexit omap_hdmi_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver hdmi_dai_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = omap_hdmi_probe,
+	.remove = __devexit_p(omap_hdmi_remove),
+};
+
+static int __init hdmi_dai_init(void)
+{
+	return platform_driver_register(&hdmi_dai_driver);
+}
+module_init(hdmi_dai_init);
+
+static void __exit hdmi_dai_exit(void)
+{
+	platform_driver_unregister(&hdmi_dai_driver);
+}
+module_exit(hdmi_dai_exit);
+
+MODULE_AUTHOR("Jorge Candelaria <jorge.candelaria@ti.com>");
+MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
+MODULE_DESCRIPTION("OMAP HDMI SoC Interface");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/sound/soc/omap/omap-hdmi.h b/sound/soc/omap/omap-hdmi.h
new file mode 100644
index 0000000..34c298d
--- /dev/null
+++ b/sound/soc/omap/omap-hdmi.h
@@ -0,0 +1,36 @@
+/*
+ * omap-hdmi.h
+ *
+ * Definitions for OMAP ALSA SoC DAI driver for HDMI audio on OMAP4 processors.
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Authors: Jorge Candelaria <jorge.candelaria@ti.com>
+ *          Ricardo Neri <ricardo.neri@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __OMAP_HDMI_H__
+#define __OMAP_HDMI_H__
+
+#define OMAP_HDMI_AUDIO_DMA_PORT 0x8c
+
+#define OMAP_HDMI_RATES	(SNDRV_PCM_RATE_32000 | \
+				SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+
+#define OMAP_HDMI_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+				SNDRV_PCM_FMTBIT_S24_LE)
+
+#endif
-- 
1.7.0.4
