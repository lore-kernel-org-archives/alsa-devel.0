From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC codecs: generic AC97 support
Date: Mon, 02 Oct 2006 17:16:06 +0100
Message-ID: <1159805766.2382.113.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-DXtZ2FNgkRKKam2J/hzD"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-DXtZ2FNgkRKKam2J/hzD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch allows the std Alsa AC97 codec driver to use any AsoC AC97
controller driver. Currently, only HiFi playback and Capture are
supported atm.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

--=-DXtZ2FNgkRKKam2J/hzD
Content-Disposition: attachment; filename=asoc-ac97-generic.patch
Content-Type: text/x-patch; name=asoc-ac97-generic.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/soc/codecs/ac97.c
===================================================================
--- /dev/null
+++ alsa-kernel/soc/codecs/ac97.c
@@ -0,0 +1,167 @@
+/*
+ * ac97.c  --  ALSA Soc AC97 codec support
+ *
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ * Author: Liam Girdwood
+ *         liam.girdwood@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  Revision history
+ *    17th Oct 2005   Initial version.
+ *
+ * Generic AC97 support.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#define AC97_VERSION "0.5"
+
+#define AC97_DIR \
+	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
+
+#define AC97_RATES \
+	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
+	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+	SNDRV_PCM_RATE_48000)
+
+/* may need to expand this */
+static struct snd_soc_dai_mode soc_ac97[] = {
+	{0, 0,	SNDRV_PCM_FMTBIT_S16_LE,	AC97_RATES},
+	{0, 0,	SNDRV_PCM_FMTBIT_S18_3LE,	AC97_RATES},
+	{0, 0,	SNDRV_PCM_FMTBIT_S20_3LE,	AC97_RATES},
+};
+
+static int ac97_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+
+	int reg = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		  AC97_PCM_FRONT_DAC_RATE : AC97_PCM_LR_ADC_RATE;
+	return snd_ac97_set_rate(codec->ac97, reg, runtime->rate);
+}
+
+static struct snd_soc_codec_dai ac97_dai = {
+	.name = "AC97 HiFi",
+	.playback = {
+		.stream_name = "AC97 Playback",
+		.channels_min = 1,
+		.channels_max = 2,},
+	.capture = {
+		.stream_name = "AC97 Capture",
+		.channels_min = 1,
+		.channels_max = 2,},
+	.ops = {
+		.prepare = ac97_prepare,},
+	.caps = {
+		.num_modes = ARRAY_SIZE(soc_ac97),
+		.mode = soc_ac97,},
+};
+
+static unsigned int ac97_read(struct snd_soc_codec *codec,
+	unsigned int reg)
+{
+	return soc_ac97_ops.read(codec->ac97, reg);
+}
+
+static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
+	unsigned int val)
+{
+	soc_ac97_ops.write(codec->ac97, reg, val);
+	return 0;
+}
+
+static int ac97_soc_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	struct snd_ac97_bus *ac97_bus;
+	struct snd_ac97_template ac97_template;
+	int ret = 0;
+
+	printk(KERN_INFO "AC97 SoC Audio Codec %s\n", AC97_VERSION);
+
+	socdev->codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (socdev->codec == NULL)
+		return -ENOMEM;
+	codec = socdev->codec;
+	mutex_init(&codec->mutex);
+
+	codec->name = "AC97";
+	codec->owner = THIS_MODULE;
+	codec->dai = &ac97_dai;
+	codec->num_dai = 1;
+	codec->write = ac97_write;
+	codec->read = ac97_read;
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if(ret < 0)
+		goto err;
+
+	/* add codec as bus device for standard ac97 */
+	ret = snd_ac97_bus(codec->card, 0, &soc_ac97_ops, NULL, &ac97_bus);
+	if(ret < 0)
+		goto bus_err;
+
+	memset(&ac97_template, 0, sizeof(struct snd_ac97_template));
+	ret = snd_ac97_mixer(ac97_bus, &ac97_template, &codec->ac97);
+	if(ret < 0)
+		goto bus_err;
+
+	ret = snd_soc_register_card(socdev);
+	if (ret < 0)
+		goto bus_err;
+	return 0;
+
+bus_err:
+	snd_soc_free_pcms(socdev);
+
+err:
+	kfree(socdev->codec->reg_cache);
+	kfree(socdev->codec);
+	socdev->codec = NULL;
+	return ret;
+}
+
+static int ac97_soc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	if(codec == NULL)
+		return 0;
+
+	snd_soc_free_pcms(socdev);
+	kfree(socdev->codec->reg_cache);
+	kfree(socdev->codec);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_ac97= {
+	.probe = 	ac97_soc_probe,
+	.remove = 	ac97_soc_remove,
+};
+
+EXPORT_SYMBOL_GPL(soc_codec_dev_ac97);
+
+MODULE_DESCRIPTION("Soc Generic AC97 driver");
+MODULE_AUTHOR("Liam Girdwood");
+MODULE_LICENSE("GPL");
Index: alsa-kernel/soc/codecs/ac97.h
===================================================================
--- /dev/null
+++ alsa-kernel/soc/codecs/ac97.h
@@ -0,0 +1,18 @@
+/*
+ * linux/sound/codecs/ac97.h -- ALSA SoC Layer
+ *
+ * Author:		Liam Girdwood
+ * Created:		Dec 1st 2005
+ * Copyright:	Wolfson Microelectronics. PLC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_SOC_AC97_H
+#define __LINUX_SND_SOC_AC97_H
+
+extern struct snd_soc_codec_device soc_codec_dev_ac97;
+
+#endif

--=-DXtZ2FNgkRKKam2J/hzD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-DXtZ2FNgkRKKam2J/hzD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-DXtZ2FNgkRKKam2J/hzD--
