From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 19/19] ALSA: SoC Audio support for OMAP4 boards
 with Yamaha YMU831 codec
Date: Wed, 16 Jan 2013 17:46:01 +0900
Message-ID: <20130116174601.1427658dd0091efa61fc7f74@linux-mips.org>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, yuasa@linux-mips.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 sound/soc/omap/Kconfig       |   11 +++
 sound/soc/omap/Makefile      |    2 +
 sound/soc/omap/omap-ymu831.c |  169 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 182 insertions(+)
 create mode 100644 sound/soc/omap/omap-ymu831.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 7048137..ff8975b 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -131,3 +131,14 @@ config SND_OMAP_SOC_ZOOM2
 	select SND_SOC_TWL4030
 	help
 	  Say Y if you want to add support for Soc audio on Zoom2 board.
+
+config SND_OMAP_SOC_OMAP_YMU831
+	tristate "SoC Audio support for OMAP4 boards with Yamaha YMU831 codec"
+	depends on SND_OMAP_SOC && ARCH_OMAP4 && SPI_MASTER
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_YMU831
+	help
+	  Say Y if you want to add support for SoC audio on OMAP4 boards
+	  using Yamaha YMU831 codec. This driver currently supports:
+	  - SDP4430
+	  - PandaBoard (4430)
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 19637e5..4bbff7b 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -23,6 +23,7 @@ snd-soc-omap-twl4030-objs := omap-twl4030.o
 snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-zoom2-objs := zoom2.o
 snd-soc-omap-hdmi-card-objs := omap-hdmi-card.o
+snd-soc-omap-ymu831-objs := omap-ymu831.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_RX51) += snd-soc-rx51.o
@@ -36,3 +37,4 @@ obj-$(CONFIG_SND_OMAP_SOC_OMAP_TWL4030) += snd-soc-omap-twl4030.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_HDMI) += snd-soc-omap-hdmi-card.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP_YMU831) += snd-soc-omap-ymu831.o
diff --git a/sound/soc/omap/omap-ymu831.c b/sound/soc/omap/omap-ymu831.c
new file mode 100644
index 0000000..2f16ca2
--- /dev/null
+++ b/sound/soc/omap/omap-ymu831.c
@@ -0,0 +1,169 @@
+/*
+ * ALSA SoC for OMAP4 boards with Yamaha YMU831 codec
+ *
+ * Copyright (c) 2011 Yamaha Corporation
+ *
+ * This software is provided 'as-is', without any express or implied
+ * warranty.  In no event will the authors be held liable for any damages
+ * arising from the use of this software.
+ *
+ * Permission is granted to anyone to use this software for any purpose,
+ * including commercial applications, and to alter it and redistribute it
+ * freely, subject to the following restrictions:
+ *
+ * 1. The origin of this software must not be misrepresented; you must not
+ *    claim that you wrote the original software. If you use this software
+ *    in a product, an acknowledgment in the product documentation would be
+ *    appreciated but is not required.
+ * 2. Altered source versions must be plainly marked as such, and must not be
+ *    misrepresented as being the original software.
+ * 3. This notice may not be removed or altered from any source distribution.
+ */
+#include <linux/io.h>
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <asm/mach-types.h>
+
+#include "omap-mcbsp.h"
+#include "../codecs/ymu831/ymu831.h"
+
+#define INTERNAL_FREQ	(196608000 / 2)
+
+static int omap_ymu831_dai_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	void *base;
+	int internal_freq = INTERNAL_FREQ;
+	int dev, ret;
+
+	base = ioremap(0x4a004108, 16);
+	if (base) {
+		if (params_rate(params) < 16000) {
+			internal_freq /= 4;
+			iowrite32(ioread32(base) | 0x02, base);
+		} else
+			iowrite32(ioread32(base) & ~0x02, base);
+		iounmap(base);
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0) {
+		pr_err("can't set cpu DAI configuration %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0) {
+		pr_err("can't set codec DAI configuration %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai,
+				     OMAP_MCBSP_SYSCLK_CLK,
+				     internal_freq, SND_SOC_CLOCK_OUT);
+	if (ret < 0) {
+		pr_err("can't set cpu system clock %d\n", ret);
+		return ret;
+	}
+
+	dev = internal_freq / (params_rate(params) * 32);
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, dev);
+	if (ret < 0) {
+		pr_err("can't set cpu clkdiv %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_clkdiv(codec_dai,
+				     MC_ASOC_BCLK_MULT, MC_ASOC_LRCK_X32);
+	if (ret < 0) {
+		pr_err("can't set codec clkdiv %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops omap_ymu831_dai_ops = {
+	.hw_params = omap_ymu831_dai_hw_params,
+};
+
+static int omap_ymu831_init(struct snd_soc_pcm_runtime *rtd)
+{
+	rtd->pmdown_time = 500;
+
+	return 0;
+}
+
+/* Machine DAI Configuration */
+static struct snd_soc_dai_link omap_ymu831_dai[] = {
+	{
+	 .name = "Application",
+	 .stream_name = "HiFi Audio",
+	 .codec_dai_name = MC_ASOC_NAME "-da0",
+	 .cpu_dai_name = "omap-mcbsp.2",
+	 .codec_name = "spi1.0",
+	 .platform_name = "omap-pcm-audio",
+	 .init = omap_ymu831_init,
+	 .ops = &omap_ymu831_dai_ops,
+	 },
+};
+
+/* Audio machine driver */
+static struct snd_soc_card omap_ymu831_card = {
+	.name = "omap-" MC_ASOC_NAME,
+	.owner = THIS_MODULE,
+	.dai_link = omap_ymu831_dai,
+	.long_name = "Yamaha YMU831 ASOC for OMAP",
+	.num_links = ARRAY_SIZE(omap_ymu831_dai),
+};
+
+static __devinit int omap_ymu831_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &omap_ymu831_card;
+	int ret;
+
+	if (!machine_is_omap_4430sdp() && !machine_is_omap4_panda()) {
+		pr_debug("Not SDP4430 or PandaBoard!\n");
+		return -ENODEV;
+	}
+
+	card->dev = &pdev->dev;
+	ret = snd_soc_register_card(card);
+	if (ret)
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
+
+	return ret;
+}
+
+static int __devexit omap_ymu831_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	return snd_soc_unregister_card(card);
+}
+
+static struct platform_driver omap_ymu831_driver = {
+	.driver = {
+		   .name = "omap-" MC_ASOC_NAME,
+		   .owner = THIS_MODULE,
+		   .pm = &snd_soc_pm_ops,
+		   },
+	.probe = omap_ymu831_probe,
+	.remove = __devexit_p(omap_ymu831_remove),
+};
+
+module_platform_driver(omap_ymu831_driver);
+
+MODULE_AUTHOR("Yamaha Corporation");
+MODULE_DESCRIPTION("ALSA SoC for OMAP4 boards with Yamaha YMU831 codec");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap-ymu831");
-- 
1.7.9.5
