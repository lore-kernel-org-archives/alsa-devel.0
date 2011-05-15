From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 4/5] ASoC: OMAP4: Add HDMI Audio machine
	driver for OMAP4 boards
Date: Sun, 15 May 2011 04:36:34 -0500
Message-ID: <1305452195-19177-5-git-send-email-ricardo.neri@ti.com>
References: <1305452195-19177-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id EB6D7103844
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

Add machine driver for HDMI audio on OMAP4 boards. This driver is
in charge of putting together the HDMI audio codec and the CPU DAI
and register the HDMI sound card with ALSA.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap4-hdmi-card.c |  129 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 129 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap4-hdmi-card.c

diff --git a/sound/soc/omap/omap4-hdmi-card.c b/sound/soc/omap/omap4-hdmi-card.c
new file mode 100644
index 0000000..b7fb812
--- /dev/null
+++ b/sound/soc/omap/omap4-hdmi-card.c
@@ -0,0 +1,129 @@
+/*
+ * omap4-hdmi-card.c
+ *
+ * OMAP ALSA SoC machine driver for TI OMAP4 HDMI
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: Ricardo Neri <ricardo.neri@ti.com>
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
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <asm/mach-types.h>
+#include <plat/display.h>
+
+#define DRV_NAME "omap4-hdmi-audio"
+
+static int omap4_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	int i;
+	struct omap_overlay_manager *mgr = NULL;
+	struct device *dev = substream->pcm->card->dev;
+
+	/* Find DSS HDMI device */
+	for (i = 0; i < omap_dss_get_num_overlay_managers(); i++) {
+		mgr = omap_dss_get_overlay_manager(i);
+		if (mgr && mgr->device
+			&& mgr->device->type == OMAP_DISPLAY_TYPE_HDMI)
+			break;
+	}
+
+	if (i == omap_dss_get_num_overlay_managers()) {
+		dev_err(dev, "HDMI display device not found!\n");
+		return -ENODEV;
+	}
+
+	/* Make sure HDMI is power-on to avoid L3 interconnect errors */
+	if (mgr->device->state != OMAP_DSS_DISPLAY_ACTIVE) {
+		dev_err(dev, "HDMI display is not active!\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops omap4_hdmi_dai_ops = {
+	.hw_params = omap4_hdmi_dai_hw_params,
+};
+
+static struct snd_soc_dai_link omap4_hdmi_dai = {
+	.name = "HDMI",
+	.stream_name = "HDMI",
+	.cpu_dai_name = "hdmi-audio-dai",
+	.platform_name = "omap-pcm-audio",
+	.codec_name = "omapdss_hdmi",
+	.codec_dai_name = "hdmi-audio-codec",
+	.ops = &omap4_hdmi_dai_ops,
+};
+
+static struct snd_soc_card snd_soc_omap4_hdmi = {
+	.name = "OMAP4HDMI",
+	.dai_link = &omap4_hdmi_dai,
+	.num_links = 1,
+};
+
+static __devinit int omap4_hdmi_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &snd_soc_omap4_hdmi;
+	int ret;
+
+	card->dev = &pdev->dev;
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		card->dev = NULL;
+		return ret;
+	}
+	return 0;
+}
+
+static int __devexit omap4_hdmi_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+	card->dev = NULL;
+	return 0;
+}
+
+static struct platform_driver omap4_hdmi_driver = {
+	.driver = {
+		.name = "omap4-hdmi-audio",
+		.owner = THIS_MODULE,
+	},
+	.probe = omap4_hdmi_probe,
+	.remove = __devexit_p(omap4_hdmi_remove),
+};
+
+static int __init omap4_hdmi_init(void)
+{
+	return platform_driver_register(&omap4_hdmi_driver);
+}
+module_init(omap4_hdmi_init);
+
+static void __exit omap4_hdmi_exit(void)
+{
+	platform_driver_unregister(&omap4_hdmi_driver);
+}
+module_exit(omap4_hdmi_exit);
+
+MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
+MODULE_DESCRIPTION("OMAP4 HDMI machine ASoC driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.0.4
