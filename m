From: Ben Dooks <ben-alsa@fluff.org>
Subject: [patch 8/9] SMDK6410: Add support for WM8731 on an
	add-on board
Date: Wed, 04 Mar 2009 00:49:33 +0000
Message-ID: <20090304005139.317005352@fluff.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id B377F2440B
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 01:54:00 +0100 (CET)
Content-Disposition: inline; filename=audio/smdk6410-wm8713-bjd.patch
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
Cc: Ben Dooks <benb@simtec.co.uk>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Add support for an WM8731 connected to an SMDK6410 instead
of the onboard codec.

Signed-off-by: Ben Dooks <benb@simtec.co.uk>

Index: linux.git/sound/soc/s3c24xx/Makefile
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/Makefile	2009-03-04 00:44:31.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/Makefile	2009-03-04 00:45:54.000000000 +0000
@@ -19,9 +19,11 @@ snd-soc-neo1973-wm8753-objs := neo1973_w
 snd-soc-smdk2443-wm9710-objs := smdk2443_wm9710.o
 snd-soc-ln2440sbc-alc650-objs := ln2440sbc_alc650.o
 snd-soc-s3c24xx-uda134x-objs := s3c24xx_uda134x.o
+snd-soc-smdk6410-wm8731-objs := smdk6410-wm8731.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SMDK2443_WM9710) += snd-soc-smdk2443-wm9710.o
 obj-$(CONFIG_SND_S3C24XX_SOC_LN2440SBC_ALC650) += snd-soc-ln2440sbc-alc650.o
 obj-$(CONFIG_SND_S3C24XX_SOC_S3C24XX_UDA134X) += snd-soc-s3c24xx-uda134x.o
+obj-$(CONFIG_SND_S3C64XX_SOC_SMDK6410_WM8731) += snd-soc-smdk6410-wm8731.o
Index: linux.git/sound/soc/s3c24xx/smdk6410-wm8731.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/smdk6410-wm8731.c	2009-03-04 00:45:04.000000000 +0000
@@ -0,0 +1,227 @@
+
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+
+#include "../codecs/wm8731.h"
+#include "s3c64xx-i2s.h"
+
+static struct platform_device *socdev;
+
+
+
+static void wm_shutdown(struct snd_pcm_substream *substream)
+{
+	printk(KERN_INFO "%s: substream %p\n", __func__, substream);
+}
+
+static int wm_hw_params(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int fmt;
+	int ret;
+
+	printk(KERN_INFO "%s: (%p,%p)\n", __func__, substream, params);
+	printk(KERN_INFO "%s: dai: cpu %p, codec %p\n", __func__, cpu_dai, codec_dai);
+
+	//fmt = SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS;
+	fmt = SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM;
+	fmt |= SND_SOC_DAIFMT_I2S;
+
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0)
+		return ret;
+
+	if (fmt == (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM)) {
+		unsigned long iis_clkrate;
+
+		ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CLKSRC_MUX, 0,
+					     SND_SOC_CLOCK_OUT);
+		if (ret < 0) {
+			printk(KERN_ERR "%s: cpu set_sysclk err\n", __func__);
+			return ret;
+		}
+
+		/* set prescaler division for sample rate */
+		ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C64XX_DIV_PRESCALER, 1);
+		if (ret < 0) {
+			printk(KERN_ERR "%s: codec clkdiv err\n", __func__);
+			return ret;
+		}
+
+		iis_clkrate = s3c64xx_i2s_get_clockrate(cpu_dai) / 2;
+		printk(KERN_INFO "%s: clockrate %ld\n", __func__, iis_clkrate);
+
+		iis_clkrate = 12000000; //tmphack//
+
+		/* set the codec system clock for DAC and ADC */
+		ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
+					     iis_clkrate,
+					     SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			printk(KERN_ERR "%s: codec sysclk err\n", __func__);
+			return ret;
+		}
+
+	} else {
+		/* TODO */
+		BUG();
+	}
+
+	return 0;
+}
+
+static int wm_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CLKSRC_MUX, 0,
+				     SND_SOC_CLOCK_OUT);
+	if (ret < 0) {
+		printk(KERN_ERR "%s: cpu set_sysclk err\n", __func__);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C64XX_DIV_PRESCALER, 1);
+	if (ret < 0) {
+		printk(KERN_ERR "%s: cpu set_clkdiv err\n", __func__);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
+				     12000000, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "%s: codec sysclk err\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops wm_ops = {
+	.startup	= wm_startup,
+	.hw_params	= wm_hw_params,
+	.shutdown	= wm_shutdown,
+};
+
+static const struct snd_soc_dapm_widget widgets[] = {
+	SND_SOC_DAPM_LINE("Line Out", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_INPUT("Line In"),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+	/* headphone connected to LHPOUT1, RHPOUT1 */
+	{"Headphone Jack", NULL, "LHPOUT"},
+	{"Headphone Jack", NULL, "RHPOUT"},
+
+	{"Line Out", NULL, "LOUT" },
+	{"Line Out", NULL, "ROUT" },
+
+	{"LLINEIN", NULL, "Line In" },
+	{"RLINEIN", NULL, "Line In" },
+};
+
+static int wm_init(struct snd_soc_codec *codec)
+{
+	printk(KERN_DEBUG "%s: codec %p\n", __func__, codec);
+
+	snd_soc_dapm_new_controls(codec, widgets, ARRAY_SIZE(widgets));
+	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+#include "s3c24xx-pcm.h"
+
+static struct snd_soc_dai_link wm_dai_link = {
+	.name		= "WM8731",
+	.stream_name	= "WM8731",
+	.cpu_dai	= &s3c64xx_i2s_dai,
+	.codec_dai	= &wm8731_dai,
+	.init		= wm_init,
+	.ops		= &wm_ops,
+};
+
+static struct snd_soc_card wm_card = {
+	.name		= "SMDK6410-WM8731",
+	.dai_link	= &wm_dai_link,
+	.platform	= &s3c24xx_soc_platform,
+	.num_links	= 1,
+};
+
+struct wm8731_setup_data wm_setup = {
+	.i2c_bus	= 0,
+	.i2c_address	= 0x1a,
+};
+
+static struct snd_soc_device wm_snd_devdata = {
+	.card		= &wm_card,
+	.codec_dev	= &soc_codec_dev_wm8731,
+	.codec_data	= &wm_setup,
+};
+
+static int __init smdk6410_wm8731_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "%s: welcome\n", __func__);
+
+	if (!machine_is_smdk6410()) {
+		printk(KERN_INFO "%s: for SMDK6410s\n", __func__);
+		return -ENOENT;
+	}
+
+	socdev = platform_device_alloc("soc-audio", 0);
+	if (!socdev) {
+		printk(KERN_ERR "%s: no device\n", __func__);
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(socdev, &wm_snd_devdata);
+
+	wm_snd_devdata.dev = &socdev->dev;
+
+	ret = platform_device_add(socdev);
+	if (ret) {
+		printk(KERN_ERR "%s: failed to add\n", __func__);
+		goto err_dev;
+	}
+
+	printk(KERN_INFO "%s: succesfull\n", __func__);
+	return 0;
+
+err_dev:
+	platform_device_put(socdev);
+	return ret;
+}
+
+module_init(smdk6410_wm8731_init);
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_LICENSE("GPL");
Index: linux.git/sound/soc/s3c24xx/Kconfig
===================================================================
--- linux.git.orig/sound/soc/s3c24xx/Kconfig	2009-03-04 00:44:31.000000000 +0000
+++ linux.git/sound/soc/s3c24xx/Kconfig	2009-03-04 00:45:04.000000000 +0000
@@ -66,3 +66,11 @@ config SND_S3C24XX_SOC_S3C24XX_UDA134X
        	depends on SND_S3C24XX_SOC
        	select SND_S3C24XX_SOC_I2S
        	select SND_SOC_UDA134X
+
+config SND_S3C64XX_SOC_SMDK6410_WM8731
+	tristate "SoC I2S Audio support for WM8731 added to an SMDK6410"
+	depends on SND_S3C24XX_SOC
+	select SND_S3C64XX_SOC_I2S
+	select SND_SOC_WM8731
+	help
+	  Support for an WM8731 add-on board on I2S channel 0 on an SMDK6410

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
