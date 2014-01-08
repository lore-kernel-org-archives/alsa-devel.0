From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 3/4] ASoC: fsl: Add VF610 simple audio card widgets driver.
Date: Wed, 8 Jan 2014 15:02:35 +0800
Message-ID: <1389164556-2728-3-git-send-email-Li.Xiubo@freescale.com>
References: <1389164556-2728-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389164556-2728-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This is the SGTL5000 codec based off-CODEC widgets supports.

Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 sound/soc/fsl/Kconfig                     | 25 ++++++++++++++++++
 sound/soc/fsl/Makefile                    |  3 +++
 sound/soc/fsl/snd-soc-simple-card-vf610.c | 44 +++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 sound/soc/fsl/snd-soc-simple-card-vf610.c

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 514c275..fc25d8a 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -216,3 +216,28 @@ config SND_SOC_IMX_MC13783
 	select SND_SOC_IMX_PCM_DMA
 
 endif # SND_IMX_SOC
+
+menuconfig SND_VF610_SOC
+       tristate "SoC Audio for Freescale VF610 CPUs"
+       select DMA_ENGINE
+       help
+         Say Y or M if you want to add support for codecs attached to
+         the VF610 CPUs.
+
+         This will enable Freeacale SAI and SGTL5000 codec, and an extra
+         TWR-AUDIO-SGTL sub-board is needed for SGTL5000.
+
+if SND_VF610_SOC
+
+config SND_SOC_VF610_SGTL5000
+       tristate "SoC Audio support for VF610 boards with SGTL5000"
+       depends on OF && I2C
+       select SND_SOC_FSL_SAI
+       select SND_SOC_SGTL5000
+       select SND_SIMPLE_CARD
+       help
+         Say Y if you want to add support for SoC audio on an VF610 board with
+         a SGTL5000 codec and a SAI.
+
+
+endif #SND_VF610_SOC
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index aaccbee..19690c5 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -58,3 +58,6 @@ obj-$(CONFIG_SND_SOC_IMX_SGTL5000) += snd-soc-imx-sgtl5000.o
 obj-$(CONFIG_SND_SOC_IMX_WM8962) += snd-soc-imx-wm8962.o
 obj-$(CONFIG_SND_SOC_IMX_SPDIF) += snd-soc-imx-spdif.o
 obj-$(CONFIG_SND_SOC_IMX_MC13783) += snd-soc-imx-mc13783.o
+
+# Simple audio card widgets Support
+obj-$(CONFIG_SND_SOC_VF610_SGTL5000) += snd-soc-simple-card-vf610.o
diff --git a/sound/soc/fsl/snd-soc-simple-card-vf610.c b/sound/soc/fsl/snd-soc-simple-card-vf610.c
new file mode 100644
index 0000000..692561c
--- /dev/null
+++ b/sound/soc/fsl/snd-soc-simple-card-vf610.c
@@ -0,0 +1,44 @@
+/*
+ * ASoC VF610 SGTL5000 off-CODEC widgets support
+ *
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ * Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <sound/simple_card.h>
+#include <sound/soc-dapm.h>
+
+static const struct snd_soc_dapm_widget vf610_sgtl5000_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In Jack", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Line Out Jack", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+struct asoc_simple_card_widgets vf610_sgtl5000_widgets = {
+	.name = "vf610-sgtl5000",
+	.widgets = vf610_sgtl5000_dapm_widgets,
+	.widgets_cnt = ARRAY_SIZE(vf610_sgtl5000_dapm_widgets),
+};
+
+static int __init __vf610_sgtl5000_widgets_init(void)
+{
+	return asoc_simple_card_widgets_register(&vf610_sgtl5000_widgets);
+}
+module_init(__vf610_sgtl5000_widgets_init);
+
+static void __exit __vf610_sgtl5000_widgets_exit(void)
+{
+	asoc_simple_card_widgets_unregister(&vf610_sgtl5000_widgets);
+}
+module_exit(__vf610_sgtl5000_widgets_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:vf610-simple-card-widgets");
+MODULE_DESCRIPTION("ASoC Simple Sound Card Widgets");
+MODULE_AUTHOR("Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>");
-- 
1.8.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
