From: miguel.aguilar@ridgerun.com
Subject: [PATCH v2 3/5] ASoC: DaVinci: CQ93VC Voice Codec
Date: Tue,  9 Mar 2010 11:35:18 -0600
Message-ID: <1268156118-16939-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C81C24405
	for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2010 18:35:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, broonie@opensource.wolfsonmicro.com, diego.dompe@ridgerun.com, todd.fischer@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

Currently the DM365 is the only SoC that includes this Voice Codec.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/cq93vc.c |  298 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cq93vc.h |   29 +++++
 4 files changed, 333 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/cq93vc.c
 create mode 100644 sound/soc/codecs/cq93vc.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 52b005f..0daca22 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -21,6 +21,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AK4535 if I2C
 	select SND_SOC_AK4642 if I2C
 	select SND_SOC_AK4671 if I2C
+	select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
 	select SND_SOC_CS4270 if I2C
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_PCM3008
@@ -108,6 +109,9 @@ config SND_SOC_AK4642
 config SND_SOC_AK4671
 	tristate
 
+config SND_SOC_CQ0093VC
+	tristate
+
 # Cirrus Logic CS4270 Codec
 config SND_SOC_CS4270
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index dbaecb1..dff91fb 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -8,6 +8,7 @@ snd-soc-ak4104-objs := ak4104.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-ak4642-objs := ak4642.o
 snd-soc-ak4671-objs := ak4671.o
+snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-cx20442-objs := cx20442.o
 snd-soc-l3-objs := l3.o
@@ -64,6 +65,7 @@ obj-$(CONFIG_SND_SOC_AK4104)	+= snd-soc-ak4104.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_AK4642)	+= snd-soc-ak4642.o
 obj-$(CONFIG_SND_SOC_AK4671)	+= snd-soc-ak4671.o
+obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
new file mode 100644
index 0000000..5132974
--- /dev/null
+++ b/sound/soc/codecs/cq93vc.c
@@ -0,0 +1,298 @@
+/*
+ * ALSA SoC CQ0093 Voice Codec Driver for DaVinci platforms
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc
+ *
+ * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/mfd/davinci_voicecodec.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include <mach/dm365.h>
+
+#include "cq93vc.h"
+
+static inline unsigned int cq93vc_read(struct snd_soc_codec *codec,
+						unsigned int reg)
+{
+	struct davinci_vc *davinci_vc = codec->control_data;
+
+	return readl(davinci_vc->base + reg);
+}
+
+static inline int cq93vc_write(struct snd_soc_codec *codec, unsigned int reg,
+		       unsigned int value)
+{
+	struct davinci_vc *davinci_vc = codec->control_data;
+
+	writel(value, davinci_vc->base + reg);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new cq93vc_snd_controls[] = {
+	SOC_SINGLE("PGA Capture Volume", DAVINCI_VC_REG05, 0, 0x03, 0),
+	SOC_SINGLE("Mono DAC Playback Volume", DAVINCI_VC_REG09, 0, 0x3f, 0),
+};
+
+static int cq93vc_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u8 reg = cq93vc_read(codec, DAVINCI_VC_REG09) & ~DAVINCI_VC_REG09_MUTE;
+
+	if (mute)
+		cq93vc_write(codec, DAVINCI_VC_REG09,
+			     reg | DAVINCI_VC_REG09_MUTE);
+	else
+		cq93vc_write(codec, DAVINCI_VC_REG09, reg);
+
+	return 0;
+}
+
+static int cq93vc_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct davinci_vc *davinci_vc = codec->control_data;
+
+	switch (freq) {
+	case 22579200:
+	case 27000000:
+	case 33868800:
+		davinci_vc->cq93vc.sysclk = freq;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int cq93vc_set_bias_level(struct snd_soc_codec *codec,
+				enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		cq93vc_write(codec, DAVINCI_VC_REG12,
+			     DAVINCI_VC_REG12_POWER_ALL_ON);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		cq93vc_write(codec, DAVINCI_VC_REG12,
+			     DAVINCI_VC_REG12_POWER_ALL_OFF);
+		break;
+	case SND_SOC_BIAS_OFF:
+		/* force all power off */
+		cq93vc_write(codec, DAVINCI_VC_REG12,
+			     DAVINCI_VC_REG12_POWER_ALL_OFF);
+		break;
+	}
+	codec->bias_level = level;
+
+	return 0;
+}
+
+#define CQ93VC_RATES	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000)
+#define CQ93VC_FORMATS	(SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE)
+
+static struct snd_soc_dai_ops cq93vc_dai_ops = {
+	.digital_mute	= cq93vc_mute,
+	.set_sysclk	= cq93vc_set_dai_sysclk,
+};
+
+struct snd_soc_dai cq93vc_dai = {
+	.name = "CQ93VC",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = CQ93VC_RATES,
+		.formats = CQ93VC_FORMATS,},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = CQ93VC_RATES,
+		.formats = CQ93VC_FORMATS,},
+	.ops = &cq93vc_dai_ops,
+};
+EXPORT_SYMBOL_GPL(cq93vc_dai);
+
+static int cq93vc_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	cq93vc_set_bias_level(codec, codec->suspend_bias_level);
+
+	return 0;
+}
+
+static struct snd_soc_codec *cq93vc_codec;
+
+static int cq93vc_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct snd_soc_codec *codec;
+	int ret;
+
+	socdev->card->codec = cq93vc_codec;
+	codec = socdev->card->codec;
+
+	/* Register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(dev, "%s: failed to create pcms\n", pdev->name);
+		return ret;
+	}
+
+	/* Set controls */
+	snd_soc_add_controls(codec, cq93vc_snd_controls,
+			     ARRAY_SIZE(cq93vc_snd_controls));
+
+	/* Off, with power on */
+	cq93vc_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	return 0;
+}
+
+static int cq93vc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_cq93vc = {
+	.probe = cq93vc_probe,
+	.remove = cq93vc_remove,
+	.resume = cq93vc_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_cq93vc);
+
+static __init int cq93vc_codec_probe(struct platform_device *pdev)
+{
+	struct davinci_vc *davinci_vc = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret;
+
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL) {
+		dev_dbg(davinci_vc->dev,
+			"could not allocate memory for codec data\n");
+		return -ENOMEM;
+	}
+
+	davinci_vc->cq93vc.codec = codec;
+
+	cq93vc_dai.dev = &pdev->dev;
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+	codec->dev = &pdev->dev;
+	codec->name = "CQ93VC";
+	codec->owner = THIS_MODULE;
+	codec->read = cq93vc_read;
+	codec->write = cq93vc_write;
+	codec->set_bias_level = cq93vc_set_bias_level;
+	codec->dai = &cq93vc_dai;
+	codec->num_dai = 1;
+	codec->control_data = davinci_vc;
+
+	cq93vc_codec = codec;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret) {
+		dev_err(davinci_vc->dev, "failed to register codec\n");
+		goto fail1;
+	}
+
+	ret = snd_soc_register_dai(&cq93vc_dai);
+	if (ret) {
+		dev_err(davinci_vc->dev, "could register dai\n");
+		goto fail2;
+	}
+	return 0;
+
+fail2:
+	snd_soc_unregister_codec(codec);
+
+fail1:
+	kfree(codec);
+	cq93vc_codec = NULL;
+
+	return ret;
+}
+
+static int __devexit cq93vc_codec_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	snd_soc_unregister_dai(&cq93vc_dai);
+	snd_soc_unregister_codec(&codec);
+
+	kfree(codec);
+	cq93vc_codec = NULL;
+
+	return 0;
+}
+
+static struct platform_driver cq93vc_codec_driver = {
+	.driver = {
+		   .name = "cq93vc",
+		   .owner = THIS_MODULE,
+		   },
+	.probe = cq93vc_codec_probe,
+	.remove = __devexit_p(cq93vc_codec_remove),
+};
+
+static __init int cq93vc_init(void)
+{
+	return platform_driver_probe(&cq93vc_codec_driver, cq93vc_codec_probe);
+}
+module_init(cq93vc_init);
+
+static __exit void cq93vc_exit(void)
+{
+	platform_driver_unregister(&cq93vc_codec_driver);
+}
+module_exit(cq93vc_exit);
+
+MODULE_DESCRIPTION("Texas Instruments DaVinci ASoC CQ0093 Voice Codec Driver");
+MODULE_AUTHOR("Miguel Aguilar");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cq93vc.h b/sound/soc/codecs/cq93vc.h
new file mode 100644
index 0000000..845b196
--- /dev/null
+++ b/sound/soc/codecs/cq93vc.h
@@ -0,0 +1,29 @@
+/*
+ * ALSA SoC CQ0093 Voice Codec Driver for DaVinci platforms
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc
+ *
+ * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef _CQ93VC_H
+#define _CQ93VC_H
+
+extern struct snd_soc_dai cq93vc_dai;
+extern struct snd_soc_codec_device soc_codec_dev_cq93vc;
+
+#endif
-- 
1.6.0.4
