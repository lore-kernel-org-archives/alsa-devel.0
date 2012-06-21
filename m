From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V2 1/9] sound:asoc: Add support for spdif in
	Audio Codec
Date: Thu, 21 Jun 2012 15:54:49 +0530
Message-ID: <4293b6815ad92e19fe8791262cdec8e68f365ddb.1340273261.git.rajeev-dlh.kumar@st.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog106.obsmtp.com (eu1sys200aog106.obsmtp.com
	[207.126.144.121])
	by alsa0.perex.cz (Postfix) with ESMTP id E0BD010B974
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 11:03:59 +0200 (CEST)
In-Reply-To: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, perex@perex.cz
Cc: Vipin Kumar <vipin.kumar@st.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vipin Kumar <vipin.kumar@st.com>

This patch adds the support for spdif in audio codec.

Signed-off-by: vipin Kumar <vipin.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/codecs/Makefile         |    2 +-
 sound/soc/codecs/spdif_receiver.c |   76 +++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/codecs/spdif_receiver.c

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index fc27fec..20b2d57 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -41,7 +41,7 @@ snd-soc-alc5623-objs := alc5623.o
 snd-soc-alc5632-objs := alc5632.o
 snd-soc-sigmadsp-objs := sigmadsp.o
 snd-soc-sn95031-objs := sn95031.o
-snd-soc-spdif-objs := spdif_transciever.o
+snd-soc-spdif-objs := spdif_transciever.o spdif_receiver.o
 snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-sta32x-objs := sta32x.o
 snd-soc-stac9766-objs := stac9766.o
diff --git a/sound/soc/codecs/spdif_receiver.c b/sound/soc/codecs/spdif_receiver.c
new file mode 100644
index 0000000..229f49e
--- /dev/null
+++ b/sound/soc/codecs/spdif_receiver.c
@@ -0,0 +1,76 @@
+/*
+ * ALSA SoC SPDIF DIR (Digital Interface Reciever) driver
+ *
+ * Based on ALSA SoC SPDIF DIT driver
+ *
+ *  This driver is used by controllers which can operate in DIR (SPDI/F) where
+ *  no codec is needed.  This file provides stub codec that can be used
+ *  in these configurations. SPEAr SPDIF IN Audio controller uses this driver.
+ *
+ * Author:      Vipin Kumar,  <vipin.kumar@st.com>
+ * Copyright:   (C) 2012  ST Microelectronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <sound/soc.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+
+MODULE_LICENSE("GPL");
+
+#define STUB_RATES	SNDRV_PCM_RATE_8000_192000
+#define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
+
+static struct snd_soc_codec_driver soc_codec_spdif_dir;
+
+static struct snd_soc_dai_driver dir_stub_dai = {
+	.name		= "dir-hifi",
+	.capture	= {
+		.stream_name	= "Capture",
+		.channels_min	= 1,
+		.channels_max	= 384,
+		.rates		= STUB_RATES,
+		.formats	= STUB_FORMATS,
+	},
+};
+
+static int spdif_dir_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, &soc_codec_spdif_dir,
+			&dir_stub_dai, 1);
+}
+
+static int spdif_dir_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver spdif_dir_driver = {
+	.probe		= spdif_dir_probe,
+	.remove		= spdif_dir_remove,
+	.driver		= {
+		.name	= "spdif-dir",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init dir_modinit(void)
+{
+	return platform_driver_register(&spdif_dir_driver);
+}
+
+static void __exit dir_exit(void)
+{
+	platform_driver_unregister(&spdif_dir_driver);
+}
+
+module_init(dir_modinit);
+module_exit(dir_exit);
-- 
1.7.0.4
