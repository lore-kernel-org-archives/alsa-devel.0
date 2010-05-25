From: apatard@mandriva.com
Subject: [patch 5/5] kirkwood: Add audio support to openrd
	client platforms
Date: Tue, 25 May 2010 14:22:41 +0200
Message-ID: <20100525122341.749472226@mandriva.com>
References: <20100525122236.841941526@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id 892381038C1
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 14:22:57 +0200 (CEST)
Content-Disposition: inline; filename=openrd_audio.patch
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
Cc: nico@fluxnic.net, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, Arnaud Patard <apatard@mandriva.com>, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch is adding support for openrd client platforms. It's using
the cs42l51 codec and has one mic and one speaker plugs.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Index: sound-2.6/sound/soc/orion/Kconfig
===================================================================
--- sound-2.6.orig/sound/soc/orion/Kconfig	2010-05-21 16:13:02.927865167 +0200
+++ sound-2.6/sound/soc/orion/Kconfig	2010-05-21 16:13:08.483865267 +0200
@@ -9,3 +9,12 @@ config SND_ORION_SOC
 config SND_ORION_SOC_I2S
 	tristate
 
+config SND_KIRKWOOD_SOC_OPENRD
+	tristate "SoC Audio support for Kirkwood Openrd Client"
+	depends on SND_ORION_SOC && MACH_OPENRD_CLIENT
+	select SND_ORION_SOC_I2S
+	select SND_SOC_CS42L51
+	help
+	  Say Y if you want to add support for SoC audio on
+	  Openrd Client.
+
Index: sound-2.6/sound/soc/orion/Makefile
===================================================================
--- sound-2.6.orig/sound/soc/orion/Makefile	2010-05-21 16:13:02.959865217 +0200
+++ sound-2.6/sound/soc/orion/Makefile	2010-05-21 16:13:08.555885332 +0200
@@ -4,3 +4,6 @@ snd-soc-orion-i2s-objs := orion-i2s.o
 obj-$(CONFIG_SND_ORION_SOC) += snd-soc-orion.o
 obj-$(CONFIG_SND_ORION_SOC_I2S) += snd-soc-orion-i2s.o
 
+snd-soc-openrd-objs := kirkwood-openrd.o
+
+obj-$(CONFIG_SND_KIRKWOOD_SOC_OPENRD) += snd-soc-openrd.o
Index: sound-2.6/sound/soc/orion/kirkwood-openrd.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/orion/kirkwood-openrd.c	2010-05-21 16:13:35.375906055 +0200
@@ -0,0 +1,126 @@
+/*
+ * kirkwood-openrd.c
+ *
+ * (c) 2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <sound/soc.h>
+#include <mach/kirkwood.h>
+#include <plat/audio.h>
+#include <asm/mach-types.h>
+#include "orion-i2s.h"
+#include "orion-dma.h"
+#include "../codecs/cs42l51.h"
+
+static int openrd_client_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+	unsigned int freq, fmt;
+
+	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS;
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0)
+		return ret;
+
+	switch (params_rate(params)) {
+	default:
+	case 44100:
+		freq = 11289600;
+		break;
+	case 48000:
+		freq = 12288000;
+		break;
+	case 96000:
+		freq = 24576000;
+		break;
+	}
+
+	return snd_soc_dai_set_sysclk(codec_dai, 0, freq, SND_SOC_CLOCK_IN);
+
+}
+
+static struct snd_soc_ops openrd_client_ops = {
+	.hw_params = openrd_client_hw_params,
+};
+
+
+static struct snd_soc_dai_link openrd_client_dai[] = {
+{
+	.name = "CS42L51",
+	.stream_name = "CS42L51 HiFi",
+	.cpu_dai = &orion_i2s_dai,
+	.codec_dai = &cs42l51_dai,
+	.ops = &openrd_client_ops,
+},
+};
+
+
+static struct snd_soc_card openrd_client = {
+	.name = "OpenRD Client",
+	.platform = &orion_soc_platform,
+	.dai_link = openrd_client_dai,
+	.num_links = ARRAY_SIZE(openrd_client_dai),
+};
+
+static struct snd_soc_device openrd_client_snd_devdata = {
+	.card = &openrd_client,
+	.codec_dev = &soc_codec_device_cs42l51,
+};
+
+static struct platform_device *openrd_client_snd_device;
+
+static int __init openrd_client_init(void)
+{
+	int ret;
+
+	if (!machine_is_openrd_client())
+		return 0;
+
+	openrd_client_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!openrd_client_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(openrd_client_snd_device,
+			&openrd_client_snd_devdata);
+	openrd_client_snd_devdata.dev = &openrd_client_snd_device->dev;
+
+	ret = platform_device_add(openrd_client_snd_device);
+	if (ret) {
+		printk(KERN_ERR "%s: platform_device_add failed\n", __func__);
+		platform_device_put(openrd_client_snd_device);
+	}
+
+	return ret;
+}
+
+static void __exit openrd_client_exit(void)
+{
+	platform_device_unregister(openrd_client_snd_device);
+}
+
+module_init(openrd_client_init);
+module_exit(openrd_client_exit);
+
+/* Module information */
+MODULE_AUTHOR("Arnaud Patard <apatard@mandriva.com>");
+MODULE_DESCRIPTION("ALSA SoC OpenRD Client");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:soc-audio");
