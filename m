From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Add Amesom ASoC machine support.
Date: Tue, 20 Nov 2007 09:25:42 +0000
Message-ID: <1195550746-6892-20-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-17-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-18-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-19-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C059249F7
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 10:43:31 +0100 (CET)
In-Reply-To: <1195550746-6892-19-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: liam.girdwood@opensource.wolfsonmicro.com, Liam Girdwood <liam@localhost.localdomain>, Nicola Perrino <nicola.perrino@atlab.it>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam@localhost.localdomain>

Signed-off-by: Nicola Perrino <nicola.perrino@atlab.it>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/Kconfig         |   10 ++
 sound/soc/pxa/Makefile        |    3 +-
 sound/soc/pxa/amesom_tlv320.c |  211 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/pxa/amesom_tlv320.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index ca825e6..bcb3aa0 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -57,3 +57,13 @@ config SND_PXA2XX_SOC_TOSA
 	help
 	  Say Y if you want to add support for SoC audio on Sharp
 	  Zaurus SL-C6000x models (Tosa).
+
+config SND_PXA2XX_SOC_AMESOM_TLV320
+	tristate "SoC SSP Audio support for AMESOM - TLV320AIC24k"
+	depends on SND_PXA2XX_SOC && MACH_AMESOM
+	select SND_PXA2XX_SOC_I2S
+	select SND_PXA2XX_SOC_SSP
+	select SND_SOC_TLV320
+	help
+	  Say Y if you want to add support for SoC audio on Amesom
+	  with the tlv320.
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index c631651..931bdc7 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -14,9 +14,10 @@ snd-soc-corgi-objs := corgi.o
 snd-soc-poodle-objs := poodle.o
 snd-soc-tosa-objs := tosa.o
 snd-soc-spitz-objs := spitz.o
+snd-soc-amesom-tlv320-objs := amesom_tlv320.o
 
 obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
 obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
 obj-$(CONFIG_SND_PXA2XX_SOC_TOSA) += snd-soc-tosa.o
 obj-$(CONFIG_SND_PXA2XX_SOC_SPITZ) += snd-soc-spitz.o
-
+obj-$(CONFIG_SND_PXA2XX_SOC_AMESOM_TLV320) += snd-soc-amesom-tlv320.o
diff --git a/sound/soc/pxa/amesom_tlv320.c b/sound/soc/pxa/amesom_tlv320.c
new file mode 100644
index 0000000..6aa1c2c
--- /dev/null
+++ b/sound/soc/pxa/amesom_tlv320.c
@@ -0,0 +1,211 @@
+/*
+ * amesom_tlv320.c  --  SoC audio for Amesom
+ *
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ * Copyright 2006 Atlab srl.
+ *
+ * Authors: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
+ *          Nicola Perrino <nicola.perrino@atlab.it>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  Revision history
+ *    5th Dec 2006   Initial version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/hardware.h>
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/audio.h>
+
+#include "../codecs/tlv320.h"
+#include "pxa2xx-pcm.h"
+#include "pxa2xx-i2s.h"
+#include "pxa2xx-ssp.h"
+
+
+/*
+ * SSP2 GPIO's
+ */
+
+#define GPIO11_SSP2RX_MD	(11 | GPIO_ALT_FN_2_IN)
+#define GPIO13_SSP2TX_MD	(13 | GPIO_ALT_FN_1_OUT)
+#define GPIO50_SSP2CLKS_MD	(50 | GPIO_ALT_FN_3_IN)
+#define GPIO14_SSP2FRMS_MD	(14 | GPIO_ALT_FN_2_IN)
+#define GPIO50_SSP2CLKM_MD	(50 | GPIO_ALT_FN_3_OUT)
+#define GPIO14_SSP2FRMM_MD	(14 | GPIO_ALT_FN_2_OUT)
+
+
+static struct snd_soc_machine amesom;
+
+
+static int amesom_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int amesom_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int tlv320_voice_startup(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static void tlv320_voice_shutdown(struct snd_pcm_substream *substream)
+{
+	return;
+}
+
+/*
+ * Tlv320 uses SSP port for playback.
+ */
+static int tlv320_voice_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret = 0;
+
+	//printk("tlv320_voice_hw_params enter\n");
+	switch(params_rate(params)) {
+	case 8000:
+		//printk("tlv320_voice_hw_params 8000\n");
+		break;
+	case 16000:
+		//printk("tlv320_voice_hw_params 16000\n");
+		break;
+	default:
+		break;
+	}
+
+	// CODEC MASTER, SSP SLAVE
+
+	/* set codec DAI configuration */
+	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_MSB |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_MSB |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set the SSP system clock as input (unused) */
+	ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, PXA2XX_SSP_CLK_NET_PLL, 0,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* set SSP slots */
+	//ret = cpu_dai->dai_ops.set_tdm_slot(cpu_dai, 0x1, slots);
+	ret = cpu_dai->dai_ops.set_tdm_slot(cpu_dai, 0x3, 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int tlv320_voice_hw_free(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static struct snd_soc_ops tlv320_voice_ops = {
+	.startup = tlv320_voice_startup,
+	.shutdown = tlv320_voice_shutdown,
+	.hw_params = tlv320_voice_hw_params,
+	.hw_free = tlv320_voice_hw_free,
+};
+
+
+static struct snd_soc_dai_link amesom_dai[] = {
+{
+	.name = "TLV320",
+	.stream_name = "TLV320 Voice",
+	.cpu_dai = &pxa_ssp_dai[PXA2XX_DAI_SSP2],
+	.codec_dai = &tlv320_dai[TLV320_DAI_MODE1_VOICE],
+	.ops = &tlv320_voice_ops,
+},
+};
+
+static struct snd_soc_machine amesom = {
+	.name = "Amesom",
+	.probe = amesom_probe,
+	.remove = amesom_remove,
+	.dai_link = amesom_dai,
+	.num_links = ARRAY_SIZE(amesom_dai),
+};
+
+static struct tlv320_setup_data amesom_tlv320_setup = {
+#ifdef TLV320AIC24K //codec2
+	.i2c_address = 0x41,
+#else // TLV320AIC14k
+	.i2c_address = 0x40,
+#endif
+};
+
+static struct snd_soc_device amesom_snd_devdata = {
+	.machine = &amesom,
+	.platform = &pxa2xx_soc_platform,
+	.codec_dev = &soc_codec_dev_tlv320,
+	.codec_data = &amesom_tlv320_setup,
+};
+
+static struct platform_device *amesom_snd_device;
+
+static int __init amesom_init(void)
+{
+	int ret;
+
+	amesom_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!amesom_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(amesom_snd_device, &amesom_snd_devdata);
+	amesom_snd_devdata.dev = &amesom_snd_device->dev;
+	ret = platform_device_add(amesom_snd_device);
+
+	if (ret)
+		platform_device_put(amesom_snd_device);
+
+
+	/* SSP port 2 slave */
+	pxa_gpio_mode(GPIO11_SSP2RX_MD);
+	pxa_gpio_mode(GPIO13_SSP2TX_MD);
+	pxa_gpio_mode(GPIO50_SSP2CLKS_MD);
+	pxa_gpio_mode(GPIO14_SSP2FRMS_MD);
+
+	return ret;
+}
+
+static void __exit amesom_exit(void)
+{
+	platform_device_unregister(amesom_snd_device);
+}
+
+module_init(amesom_init);
+module_exit(amesom_exit);
+
+/* Module information */
+MODULE_AUTHOR("Nicola Perrino");
+MODULE_DESCRIPTION("ALSA SoC TLV320 Amesom");
+MODULE_LICENSE("GPL");
-- 
1.5.3.5
