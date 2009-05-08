From: Sergey Lapin <slapin@ossfans.org>
Subject: [PATCH] AFEB9260 ASoC driver
Date: Fri,  8 May 2009 19:19:41 +0400
Message-ID: <1241795981-21871-1-git-send-email-slapin@ossfans.org>
References: <20090507154611.GK27897@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from build.ossfans.org (build.ossfans.org [67.223.233.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FEEE1038E2
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 17:19:42 +0200 (CEST)
In-Reply-To: <20090507154611.GK27897@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Sergey Lapin <slapin@ossfans.org>
List-Id: alsa-devel@alsa-project.org

ASoC driver for AT91SAM9260-based AFEB9260 board

Signed-off-by: Sergey Lapin <slapin@ossfans.org>
---
 sound/soc/atmel/Kconfig            |    8 ++
 sound/soc/atmel/Makefile           |    1 +
 sound/soc/atmel/snd-soc-afeb9260.c |  203 ++++++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/atmel/snd-soc-afeb9260.c

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index a608d70..e720d5e 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -41,3 +41,11 @@ config SND_AT32_SOC_PLAYPAQ_SLAVE
           and FRAME signals on the PlayPaq.  Unless you want to play
           with the AT32 as the SSC master, you probably want to say N here,
           as this will give you better sound quality.
+
+config SND_AT91_SOC_AFEB9260
+	tristate "SoC Audio support for AFEB9260 board"
+	depends on ARCH_AT91 && MACH_AFEB9260 && SND_ATMEL_SOC
+	select SND_ATMEL_SOC_SSC
+	select SND_SOC_TLV320AIC23
+	help
+	  Say Y here to support sound on AFEB9260 board.
diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
index f54a7cc..e7ea56b 100644
--- a/sound/soc/atmel/Makefile
+++ b/sound/soc/atmel/Makefile
@@ -13,3 +13,4 @@ snd-soc-playpaq-objs := playpaq_wm8510.o
 
 obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) += snd-soc-sam9g20-wm8731.o
 obj-$(CONFIG_SND_AT32_SOC_PLAYPAQ) += snd-soc-playpaq.o
+obj-$(CONFIG_SND_AT91_SOC_AFEB9260) += snd-soc-afeb9260.o
diff --git a/sound/soc/atmel/snd-soc-afeb9260.c b/sound/soc/atmel/snd-soc-afeb9260.c
new file mode 100644
index 0000000..23349de
--- /dev/null
+++ b/sound/soc/atmel/snd-soc-afeb9260.c
@@ -0,0 +1,203 @@
+/*
+ * afeb9260.c  --  SoC audio for AFEB9260
+ *
+ * Copyright (C) 2009 Sergey Lapin <slapin@ossfans.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+#include <linux/atmel-ssc.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+#include <linux/gpio.h>
+
+#include "../codecs/tlv320aic23.h"
+#include "atmel-pcm.h"
+#include "atmel_ssc_dai.h"
+
+#define CODEC_CLOCK 	12000000
+
+static int afeb9260_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int err;
+
+	/* Set codec DAI configuration */
+	err = snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_I2S|
+				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (err < 0) {
+		printk(KERN_ERR "can't set codec DAI configuration\n");
+		return err;
+	}
+
+	/* Set cpu DAI configuration */
+	err = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (err < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return err;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	err =
+	    snd_soc_dai_set_sysclk(codec_dai, 0, CODEC_CLOCK, SND_SOC_CLOCK_IN);
+
+	if (err < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return err;
+	}
+
+	return err;
+}
+
+static struct snd_soc_ops afeb9260_ops = {
+	.hw_params = afeb9260_hw_params,
+};
+
+static const struct snd_soc_dapm_widget tlv320aic23_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headphone Jack", NULL, "LHPOUT"},
+	{"Headphone Jack", NULL, "RHPOUT"},
+
+	{"LLINEIN", NULL, "Line In"},
+	{"RLINEIN", NULL, "Line In"},
+
+	{"MICIN", NULL, "Mic Jack"},
+};
+
+static int afeb9260_tlv320aic23_init(struct snd_soc_codec *codec)
+{
+
+	/* Add afeb9260 specific widgets */
+	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
+				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
+
+	/* Set up afeb9260 specific audio path audio_map */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Line In");
+	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link afeb9260_dai = {
+	.name = "TLV320AIC23",
+	.stream_name = "AIC23",
+	.cpu_dai = &atmel_ssc_dai[0],
+	.codec_dai = &tlv320aic23_dai,
+	.init = afeb9260_tlv320aic23_init,
+	.ops = &afeb9260_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_card snd_soc_machine_afeb9260 = {
+	.name = "AFEB9260",
+	.platform = &atmel_soc_platform,
+	.dai_link = &afeb9260_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device afeb9260_snd_devdata = {
+	.card = &snd_soc_machine_afeb9260,
+	.codec_dev = &soc_codec_dev_tlv320aic23,
+};
+
+static struct platform_device *afeb9260_snd_device;
+
+static int __init afeb9260_soc_init(void)
+{
+	int err;
+	struct device *dev;
+	struct atmel_ssc_info *ssc_p = afeb9260_dai.cpu_dai->private_data;
+	struct ssc_device *ssc = NULL;
+
+	if (!(machine_is_afeb9260()))
+		return -ENODEV;
+
+	ssc = ssc_request(0);
+	if (IS_ERR(ssc)) {
+		printk(KERN_ERR "ASoC: Failed to request SSC 0\n");
+		err = PTR_ERR(ssc);
+		ssc = NULL;
+		goto err_ssc;
+	}
+	ssc_p->ssc = ssc;
+
+	afeb9260_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!afeb9260_snd_device) {
+		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(afeb9260_snd_device, &afeb9260_snd_devdata);
+	afeb9260_snd_devdata.dev = &afeb9260_snd_device->dev;
+	err = platform_device_add(afeb9260_snd_device);
+	if (err)
+		goto err1;
+
+	dev = &afeb9260_snd_device->dev;
+
+	return 0;
+err1:
+	platform_device_del(afeb9260_snd_device);
+	platform_device_put(afeb9260_snd_device);
+err_ssc:
+	return err;
+
+}
+
+static void __exit afeb9260_soc_exit(void)
+{
+	platform_device_unregister(afeb9260_snd_device);
+}
+
+module_init(afeb9260_soc_init);
+module_exit(afeb9260_soc_exit);
+
+MODULE_AUTHOR("Sergey Lapin <slapin@ossfans.org>");
+MODULE_DESCRIPTION("ALSA SoC for AFEB9260");
+MODULE_LICENSE("GPL");
+
-- 
1.5.6.5
