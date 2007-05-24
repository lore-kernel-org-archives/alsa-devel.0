From: "Zoltan Devai" <zdevai@gmail.com>
Subject: [RFC] [PATCH 2/2] ASoC sound support for SMDK2440
	boards: board driver
Date: Thu, 24 May 2007 16:38:20 +0200
Message-ID: <5b7270f40705240738s69b9b68aw516de14889466cfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 0665A243FA
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2007 16:38:23 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so57173ana
	for <alsa-devel@alsa-project.org>; Thu, 24 May 2007 07:38:20 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--- /dev/null
+++ /sound/soc/s3c24xx/smdk2440.c
@@ -0,0 +1,162 @@
+/*
+ * smdk2440.c  --  SMDK2440 ALSA SoC Audio board driver
+ *
+ * Copyright 2007 Dension Audio Systems Ltd.
+ * Author: Zoltan Devai
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/l3.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+#include <asm/arch/regs-iis.h>
+
+#include "../codecs/uda1341.h"
+#include "s3c24xx-pcm.h"
+#include "s3c24xx-i2s.h"
+
+static int smdk2440_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int clk = 0;
+	unsigned int div = 0;
+	int ret = 0;
+
+	switch (params_rate(params)) {
+		case 11025:
+			div = 16;
+			clk = 4233600;
+			break;
+		case 22050:
+			div = 8;
+			clk = 8467200;
+			break;
+		case 44100:
+			div = 4;
+			clk = 16934400;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+	
+	ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, S3C24XX_CLKSRC_PCLK , clk,
+						SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK,
+						S3C2410_IISMOD_32FS);
+	if (ret < 0)
+		return ret;
+
+	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_BCLK,
+						S3C2410_IISMOD_384FS);
+	if (ret < 0)
+		return ret;
+	
+	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
+					  S3C24XX_PRESCALE(div,div));
+	if (ret < 0)
+		return ret;
+	
+	/* set the codec system clock for DAC and ADC */
+	ret = codec_dai->dai_ops.set_sysclk(codec_dai, 0, clk,
+						SND_SOC_CLOCK_OUT);
+	if (ret < 0)
+		return ret;
+	
+	return 0;
+}
+
+static const char* smdk2440_l3_link_name = "s3c24xx-l3";
+
+static struct snd_soc_ops smdk2440_ops = {
+	.hw_params = smdk2440_hw_params,
+};
+
+static struct snd_soc_dai_link smdk2440_dai_link = {
+	.name = "UDA1341",
+	.stream_name = "UDA1341",
+	.codec_dai = &uda1341_dai,
+	.cpu_dai = &s3c24xx_i2s_dai,
+	.ops = &smdk2440_ops,
+};
+
+static struct snd_soc_machine snd_soc_machine_smdk2440 = {
+	.name = "SMDK2440",
+	.dai_link = &smdk2440_dai_link,
+	.num_links = 1,
+};
+
+static struct snd_soc_device smdk2440_snd_devdata = {
+	.machine = &snd_soc_machine_smdk2440,
+	.platform = &s3c24xx_soc_platform,
+	.codec_dev = &soc_codec_dev_uda1341,
+	.codec_data = &smdk2440_l3_link_name,
+};
+
+static struct platform_device *smdk2440_snd_device;
+
+static int __init smdk2440_uda1341_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "SMDK2440 ALSA SoC Audio driver\n");
+	
+	if (!(machine_is_s3c2440()))
+		return -ENODEV;
+
+	smdk2440_snd_devdata.codec_data = l3_get_adapter("s3c24xx-l3");
+	if (smdk2440_snd_devdata.codec_data == NULL) {
+		printk(KERN_WARNING "SMDK2440 SoC Audio: \
+					Unable to find L3 bus adapter\n");
+		return -ENODEV;
+	}
+	
+	smdk2440_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!smdk2440_snd_device) {
+		printk(KERN_ERR "SMDK2440 SoC Audio: Unable to register\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(smdk2440_snd_device, &smdk2440_snd_devdata);
+	smdk2440_snd_devdata.dev = &smdk2440_snd_device->dev;
+	ret = platform_device_add(smdk2440_snd_device);
+
+	if (ret)
+		platform_device_put(smdk2440_snd_device);
+
+	return ret;
+}
+
+static void __exit smdk2440_uda1341_exit(void)
+{
+	platform_device_unregister(smdk2440_snd_device);
+}
+
+module_init(smdk2440_uda1341_init);
+module_exit(smdk2440_uda1341_exit);
+
+MODULE_AUTHOR("Zoltan Devai");
+MODULE_DESCRIPTION("SMDK2440 ALSA SoC audio driver");
+MODULE_LICENSE("GPL");
