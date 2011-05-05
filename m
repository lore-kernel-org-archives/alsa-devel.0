From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 5/6] ASoC: OMAP4: Add HDMI Audio machine driver
	for OMAP4 boards
Date: Thu,  5 May 2011 02:21:52 -0500
Message-ID: <1304580113-24819-6-git-send-email-ricardo.neri@ti.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 789D3103992
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 09:21:50 +0200 (CEST)
In-Reply-To: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, lrg@ti.com
Cc: Ricardo Neri <ricardo.neri@ti.com>
List-Id: alsa-devel@alsa-project.org

Add machine driver for HDMI audio on OMAP4 boards. This driver is
in charge of putting together the HDMI audio codec and the CPU DAI
and register the HDMI sound card with ALSA.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap4-hdmi-card.c |  100 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap4-hdmi-card.c

diff --git a/sound/soc/omap/omap4-hdmi-card.c b/sound/soc/omap/omap4-hdmi-card.c
new file mode 100644
index 0000000..b1ecfc4
--- /dev/null
+++ b/sound/soc/omap/omap4-hdmi-card.c
@@ -0,0 +1,100 @@
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
+
+static struct snd_soc_dai_link omap4_hdmi_dai = {
+		.name = "HDMI",
+		.stream_name = "HDMI",
+		.cpu_dai_name = "hdmi-audio-dai",
+		.platform_name = "omap-pcm-audio",
+		.codec_name = "omapdss_hdmi",
+		.codec_dai_name = "hdmi-audio-codec"
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
+	if (!cpu_is_omap44xx()) {
+		dev_err(&pdev->dev, "Not running on OMAP4!\n");
+		return -ENODEV;
+	}
+
+	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		platform_set_drvdata(pdev, NULL);
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
+	platform_set_drvdata(pdev, NULL);
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
-- 
1.7.1
