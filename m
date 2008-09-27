From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 1/1] ASoC codec: AD73311 audio codec driver
Date: Sat, 27 Sep 2008 16:57:26 +0800
Message-ID: <1222505846-22142-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 84D8B103837
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 10:57:02 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id j3so507697tid.8
	for <alsa-devel@alsa-project.org>; Sat, 27 Sep 2008 01:57:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/codecs/Kconfig   |    4 ++
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/ad73311.c |  107 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ad73311.h |   90 +++++++++++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/ad73311.c
 create mode 100644 sound/soc/codecs/ad73311.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e0b9869..0507fcf 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -3,6 +3,7 @@ config SND_SOC_ALL_CODECS
 	depends on I2C
 	select SPI
 	select SPI_MASTER
+	select SND_SOC_AD73311
 	select SND_SOC_AK4535
 	select SND_SOC_CS4270
 	select SND_SOC_SSM2602
@@ -34,6 +35,9 @@ config SND_SOC_AC97_CODEC
 config SND_SOC_AD1980
 	tristate
 
+config SND_SOC_AD73311
+	tristate
+
 config SND_SOC_AK4535
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index f977978..0731844 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -1,5 +1,6 @@
 snd-soc-ac97-objs := ac97.o
 snd-soc-ad1980-objs := ad1980.o
+snd-soc-ad73311-objs := ad73311.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-ssm2602-objs := ssm2602.o
@@ -20,6 +21,7 @@ snd-soc-wm9713-objs := wm9713.o
 
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
+obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
diff --git a/sound/soc/codecs/ad73311.c b/sound/soc/codecs/ad73311.c
new file mode 100644
index 0000000..37af860
--- /dev/null
+++ b/sound/soc/codecs/ad73311.c
@@ -0,0 +1,107 @@
+/*
+ * ad73311.c  --  ALSA Soc AD73311 codec support
+ *
+ * Copyright:	Analog Device Inc.
+ * Author:	Cliff Cai <cliff.cai@analog.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  Revision history
+ *    25th Sep 2008   Initial version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include "ad73311.h"
+
+struct snd_soc_dai ad73311_dai = {
+	.name = "AD73311",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
+};
+EXPORT_SYMBOL_GPL(ad73311_dai);
+
+static int ad73311_soc_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret = 0;
+
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL)
+		return -ENOMEM;
+	mutex_init(&codec->mutex);
+	codec->name = "AD73311";
+	codec->owner = THIS_MODULE;
+	codec->dai = &ad73311_dai;
+	codec->num_dai = 1;
+	socdev->codec = codec;
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "ad73311: failed to create pcms\n");
+		goto pcm_err;
+	}
+
+	ret = snd_soc_register_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "ad73311: failed to register card\n");
+		goto register_err;
+	}
+
+	return ret;
+
+register_err:
+	snd_soc_free_pcms(socdev);
+pcm_err:
+	kfree(socdev->codec);
+	socdev->codec = NULL;
+	return ret;
+}
+
+static int ad73311_soc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	if (codec == NULL)
+		return 0;
+	snd_soc_free_pcms(socdev);
+	kfree(codec);
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_ad73311 = {
+	.probe = 	ad73311_soc_probe,
+	.remove = 	ad73311_soc_remove,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_ad73311);
+
+MODULE_DESCRIPTION("ASoC ad73311 driver");
+MODULE_AUTHOR("Cliff Cai ");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ad73311.h b/sound/soc/codecs/ad73311.h
new file mode 100644
index 0000000..507ce0c
--- /dev/null
+++ b/sound/soc/codecs/ad73311.h
@@ -0,0 +1,90 @@
+/*
+ * File:         sound/soc/codec/ad73311.h
+ * Based on:
+ * Author:       Cliff Cai <cliff.cai@analog.com>
+ *
+ * Created:      Thur Sep 25, 2008
+ * Description:  definitions for AD73311 registers
+ *
+ *
+ * Modified:
+ *               Copyright 2006 Analog Devices Inc.
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __AD73311_H__
+#define __AD73311_H__
+
+#define AD_CONTROL	0x8000
+#define AD_DATA		0x0000
+#define AD_READ		0x4000
+#define AD_WRITE	0x0000
+
+/* Control register A */
+#define CTRL_REG_A	(0 << 8)
+
+#define REGA_MODE_PRO	0x00
+#define REGA_MODE_DATA	0x01
+#define REGA_MODE_MIXED	0x03
+#define REGA_DLB		0x04
+#define REGA_SLB		0x08
+#define REGA_DEVC(x)		((x & 0x7) << 4)
+#define REGA_RESET		0x80
+
+/* Control register B */
+#define CTRL_REG_B	(1 << 8)
+
+#define REGB_DIRATE(x)	(x & 0x3)
+#define REGB_SCDIV(x)	((x & 0x3) << 2)
+#define REGB_MCDIV(x)	((x & 0x7) << 4)
+#define REGB_CEE		(1 << 7)
+
+/* Control register C */
+#define CTRL_REG_C	(2 << 8)
+
+#define REGC_PUDEV		(1 << 0)
+#define REGC_PUADC		(1 << 3)
+#define REGC_PUDAC		(1 << 4)
+#define REGC_PUREF		(1 << 5)
+#define REGC_REFUSE		(1 << 6)
+
+/* Control register D */
+#define CTRL_REG_D	(3 << 8)
+
+#define REGD_IGS(x)		(x & 0x7)
+#define REGD_RMOD		(1 << 3)
+#define REGD_OGS(x)		((x & 0x7) << 4)
+#define REGD_MUTE		(x << 7)
+
+/* Control register E */
+#define CTRL_REG_E	(4 << 8)
+
+#define REGE_DA(x)		(x & 0x1f)
+#define REGE_IBYP		(1 << 5)
+
+/* Control register F */
+#define CTRL_REG_F	(5 << 8)
+
+#define REGF_SEEN		(1 << 5)
+#define REGF_INV		(1 << 6)
+#define REGF_ALB		(1 << 7)
+
+extern struct snd_soc_dai ad73311_dai;
+extern struct snd_soc_codec_device soc_codec_dev_ad73311;
+#endif
-- 
1.5.6
