From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [patch 2/3] kirkwood: Add audio support to hp t5325
	thin clients
Date: Tue, 07 Sep 2010 09:01:29 +0200
Message-ID: <20100907071009.661466468@rtp-net.org>
References: <20100907070127.305740006@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id BF0D824407
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 09:12:08 +0200 (CEST)
Content-Disposition: inline; filename=t5325.patch
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
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Martin Michlmayr <tbm@cyrius.com>, Saeed Bishara <saeed@marvell.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch is adding support for hp t5325 thin clients.
There's a alc5623 codec connected to the i2s interface.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>


Index: sound-2.6/sound/soc/kirkwood/Kconfig
===================================================================
--- sound-2.6.orig/sound/soc/kirkwood/Kconfig	2010-09-06 23:39:39.000000000 +0200
+++ sound-2.6/sound/soc/kirkwood/Kconfig	2010-09-06 23:42:11.000000000 +0200
@@ -18,3 +18,13 @@
 	  Say Y if you want to add support for SoC audio on
 	  Openrd Client.
 
+config SND_KIRKWOOD_SOC_T5325
+	tristate "SoC Audio support for HP t5325"
+	#depends on SND_KIRKWOOD_SOC && MACH_T5325
+	depends on SND_KIRKWOOD_SOC
+	select SND_KIRKWOOD_SOC_I2S
+	select SND_SOC_ALC5623
+	help
+	  Say Y if you want to add support for SoC audio on
+	  the HP t5325 thin client.
+
Index: sound-2.6/sound/soc/kirkwood/Makefile
===================================================================
--- sound-2.6.orig/sound/soc/kirkwood/Makefile	2010-09-06 23:39:39.000000000 +0200
+++ sound-2.6/sound/soc/kirkwood/Makefile	2010-09-06 23:42:11.000000000 +0200
@@ -5,5 +5,7 @@
 obj-$(CONFIG_SND_KIRKWOOD_SOC_I2S) += snd-soc-kirkwood-i2s.o
 
 snd-soc-openrd-objs := kirkwood-openrd.o
+snd-soc-t5325-objs := kirkwood-t5325.o
 
 obj-$(CONFIG_SND_KIRKWOOD_SOC_OPENRD) += snd-soc-openrd.o
+obj-$(CONFIG_SND_KIRKWOOD_SOC_T5325) += snd-soc-t5325.o
Index: sound-2.6/sound/soc/kirkwood/kirkwood-t5325.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/kirkwood/kirkwood-t5325.c	2010-09-06 23:42:11.000000000 +0200
@@ -0,0 +1,155 @@
+/*
+ * kirkwood-t5325.c
+ *
+ * (c) 2010 Arnaud Patard <arnaud.patard@rtp-net.org>
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
+#include <sound/soc-dapm.h>
+#include <mach/kirkwood.h>
+#include <plat/audio.h>
+#include <asm/mach-types.h>
+#include "../codecs/alc5623.h"
+
+static int t5325_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
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
+static struct snd_soc_ops t5325_ops = {
+	.hw_params = t5325_hw_params,
+};
+
+static const struct snd_soc_dapm_widget t5325_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route t5325_route[] = {
+	{ "Headphone Jack",	NULL,	"HPL" },
+	{ "Headphone Jack",	NULL,	"HPR" },
+
+	{"Speaker",		NULL,	"SPKOUT"},
+	{"Speaker",		NULL,	"SPKOUTN"},
+
+	{ "MIC1",		NULL,	"Mic Jack" },
+	{ "MIC2",		NULL,	"Mic Jack" },
+};
+
+static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+
+	snd_soc_dapm_new_controls(codec, t5325_dapm_widgets,
+				ARRAY_SIZE(t5325_dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, t5325_route, ARRAY_SIZE(t5325_route));
+
+	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Speaker");
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link t5325_dai[] = {
+{
+	.name = "ALC5621",
+	.stream_name = "ALC5621 HiFi",
+	.cpu_dai_name = "kirkwood-i2s",
+	.platform_name = "kirkwood-pcm-audio",
+	.codec_dai_name = "alc5621-hifi",
+	.codec_name = "alc562x-codec.0-001a",
+	.ops = &t5325_ops,
+	.init = t5325_dai_init,
+},
+};
+
+
+static struct snd_soc_card t5325 = {
+	.name = "t5325",
+	.dai_link = t5325_dai,
+	.num_links = ARRAY_SIZE(t5325_dai),
+};
+
+static struct platform_device *t5325_snd_device;
+
+static int __init t5325_init(void)
+{
+	int ret;
+
+	if (!machine_is_t5325())
+		return 0;
+
+	t5325_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!t5325_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(t5325_snd_device,
+			&t5325);
+
+	ret = platform_device_add(t5325_snd_device);
+	if (ret) {
+		printk(KERN_ERR "%s: platform_device_add failed\n", __func__);
+		platform_device_put(t5325_snd_device);
+	}
+
+	return ret;
+}
+
+static void __exit t5325_exit(void)
+{
+	platform_device_unregister(t5325_snd_device);
+}
+
+module_init(t5325_init);
+module_exit(t5325_exit);
+
+/* Module information */
+MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
+MODULE_DESCRIPTION("ALSA SoC t5325 audio client");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:soc-audio");
