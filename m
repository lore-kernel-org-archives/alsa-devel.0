From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/6] ASoC: Add driver for the Lyrtech SFFSDR
	board
Date: Wed, 19 Nov 2008 13:36:30 +0000
Message-ID: <1227101793-3768-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081119133427.GA3687@rakim.wolfsonmicro.main>
	<1227101793-3768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227101793-3768-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 442682461C
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 14:36:35 +0100 (CET)
In-Reply-To: <1227101793-3768-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Hugo Villeneuve <hugo@hugovil.com>
List-Id: alsa-devel@alsa-project.org

From: Hugo Villeneuve <hugo@hugovil.com>

The PCM3008 is used on the Lyrtech SFFSDR board, in conjunction with an
FPGA that generates the bit clock and the master clock

[Downgraded the rate debug print to pr_debug() in hw_params, converted
asm/gpio.h to linux/gpio.h -- broonie]

Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/davinci/Kconfig          |   10 +++
 sound/soc/davinci/Makefile         |    2 +
 sound/soc/davinci/davinci-sffsdr.c |  156 ++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/davinci/davinci-sffsdr.c

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 8f7e338..b502741 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -17,3 +17,13 @@ config SND_DAVINCI_SOC_EVM
 	help
 	  Say Y if you want to add support for SoC audio on TI
 	  DaVinci EVM platform.
+
+config SND_DAVINCI_SOC_SFFSDR
+	tristate "SoC Audio support for SFFSDR"
+	depends on SND_DAVINCI_SOC && MACH_DAVINCI_SFFSDR
+	select SND_DAVINCI_SOC_I2S
+	select SND_SOC_PCM3008
+	select SFFSDR_FPGA
+	help
+	  Say Y if you want to add support for SoC audio on
+	  Lyrtech SFFSDR board.
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index ca772e5..ca8bae1 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -7,5 +7,7 @@ obj-$(CONFIG_SND_DAVINCI_SOC_I2S) += snd-soc-davinci-i2s.o
 
 # DAVINCI Machine Support
 snd-soc-evm-objs := davinci-evm.o
+snd-soc-sffsdr-objs := davinci-sffsdr.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_DAVINCI_SOC_SFFSDR) += snd-soc-sffsdr.o
diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
new file mode 100644
index 0000000..69a8a76
--- /dev/null
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -0,0 +1,156 @@
+/*
+ * ASoC driver for Lyrtech SFFSDR board.
+ *
+ * Author:	Hugo Villeneuve
+ * Copyright (C) 2008 Lyrtech inc
+ *
+ * Based on ASoC driver for TI DAVINCI EVM platform, original copyright follow:
+ * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/dma.h>
+#include <asm/plat-sffsdr/sffsdr-fpga.h>
+
+#include <mach/mcbsp.h>
+#include <mach/edma.h>
+
+#include "../codecs/pcm3008.h"
+#include "davinci-pcm.h"
+#include "davinci-i2s.h"
+
+static int sffsdr_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int fs;
+	int ret = 0;
+
+	/* Set cpu DAI configuration:
+	 * CLKX and CLKR are the inputs for the Sample Rate Generator.
+	 * FSX and FSR are outputs, driven by the sample Rate Generator. */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_RIGHT_J |
+				  SND_SOC_DAIFMT_CBM_CFS |
+				  SND_SOC_DAIFMT_IB_NF);
+	if (ret < 0)
+		return ret;
+
+	/* Fsref can be 32000, 44100 or 48000. */
+	fs = params_rate(params);
+
+	pr_debug("sffsdr_hw_params: rate = %d Hz\n", fs);
+
+	return sffsdr_fpga_set_codec_fs(fs);
+}
+
+static struct snd_soc_ops sffsdr_ops = {
+	.hw_params = sffsdr_hw_params,
+};
+
+/* davinci-sffsdr digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link sffsdr_dai = {
+	.name = "PCM3008", /* Codec name */
+	.stream_name = "PCM3008 HiFi",
+	.cpu_dai = &davinci_i2s_dai,
+	.codec_dai = &pcm3008_dai,
+	.ops = &sffsdr_ops,
+};
+
+/* davinci-sffsdr audio machine driver */
+static struct snd_soc_machine snd_soc_machine_sffsdr = {
+	.name = "DaVinci SFFSDR",
+	.dai_link = &sffsdr_dai,
+	.num_links = 1,
+};
+
+/* sffsdr audio private data */
+static struct pcm3008_setup_data sffsdr_pcm3008_setup = {
+	.dem0_pin = GPIO(45),
+	.dem1_pin = GPIO(46),
+	.pdad_pin = GPIO(47),
+	.pdda_pin = GPIO(38),
+};
+
+/* sffsdr audio subsystem */
+static struct snd_soc_device sffsdr_snd_devdata = {
+	.machine = &snd_soc_machine_sffsdr,
+	.platform = &davinci_soc_platform,
+	.codec_dev = &soc_codec_dev_pcm3008,
+	.codec_data = &sffsdr_pcm3008_setup,
+};
+
+static struct resource sffsdr_snd_resources[] = {
+	{
+		.start = DAVINCI_MCBSP_BASE,
+		.end = DAVINCI_MCBSP_BASE + SZ_8K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct evm_snd_platform_data sffsdr_snd_data = {
+	.tx_dma_ch	= DAVINCI_DMA_MCBSP_TX,
+	.rx_dma_ch	= DAVINCI_DMA_MCBSP_RX,
+};
+
+static struct platform_device *sffsdr_snd_device;
+
+static int __init sffsdr_init(void)
+{
+	int ret;
+
+	sffsdr_snd_device = platform_device_alloc("soc-audio", 0);
+	if (!sffsdr_snd_device) {
+		printk(KERN_ERR "platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(sffsdr_snd_device, &sffsdr_snd_devdata);
+	sffsdr_snd_devdata.dev = &sffsdr_snd_device->dev;
+	sffsdr_snd_device->dev.platform_data = &sffsdr_snd_data;
+
+	ret = platform_device_add_resources(sffsdr_snd_device,
+					    sffsdr_snd_resources,
+					    ARRAY_SIZE(sffsdr_snd_resources));
+	if (ret) {
+		printk(KERN_ERR "platform device add ressources failed\n");
+		goto error;
+	}
+
+	ret = platform_device_add(sffsdr_snd_device);
+	if (ret)
+		goto error;
+
+	return ret;
+
+error:
+	platform_device_put(sffsdr_snd_device);
+	return ret;
+}
+
+static void __exit sffsdr_exit(void)
+{
+	platform_device_unregister(sffsdr_snd_device);
+}
+
+module_init(sffsdr_init);
+module_exit(sffsdr_exit);
+
+MODULE_AUTHOR("Hugo Villeneuve");
+MODULE_DESCRIPTION("Lyrtech SFFSDR ASoC driver");
+MODULE_LICENSE("GPL");
-- 
1.5.6.5
