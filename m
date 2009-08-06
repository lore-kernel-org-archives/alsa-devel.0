From: Ben Dooks <ben@simtec.co.uk>
Subject: Audio support for TLV320AIC23 on Simtec S3C24XX
	products
Date: Fri, 07 Aug 2009 00:01:49 +0100
Message-ID: <20090806230149.440747780@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kira.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id B65A010380E
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 01:01:58 +0200 (CEST)
Content-Disposition: inline; filename=initial-asoc-work.patch
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

Add support for the TLV320AIC23 on most of the current Simtec S3C24XX
with an initial core set of routines for use with the other S3C24XX
designs that do not use the TLV320AIC23.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 arch/arm/common/sbcd/s3c24xx/dev-audio.c       |  146 ++++++---
 arch/arm/plat-s3c/include/plat/audio-simtec.h  |   37 ++
 arch/arm/plat-s3c24xx/audio-simtec.c           |   97 +-----
 sound/soc/s3c24xx/Kconfig                      |   12 
 sound/soc/s3c24xx/Makefile                     |    4 
 sound/soc/s3c24xx/s3c24xx_simtec.c             |  391 +++++++++++++++++++++++++
 sound/soc/s3c24xx/s3c24xx_simtec.h             |   22 +
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c |  137 ++++++++
 8 files changed, 728 insertions(+), 118 deletions(-)

Index: b/sound/soc/s3c24xx/Kconfig
===================================================================
--- a/sound/soc/s3c24xx/Kconfig	2009-08-04 12:24:09.000000000 +0100
+++ b/sound/soc/s3c24xx/Kconfig	2009-08-06 11:53:38.000000000 +0100
@@ -115,3 +115,15 @@ config SND_S3C24XX_SOC_S3C24XX_UDA134X
        	select SND_S3C24XX_SOC_I2S
 	select SND_SOC_L3
        	select SND_SOC_UDA134X
+
+config SND_S3C24XX_SOC_SIMTEC
+	tristate
+	help
+	  Internal node for common S3C24XX/Simtec suppor
+
+config SND_S3C24XX_SOC_SIMTEC_TLV320AIC23
+	tristate "SoC I2S Audio support for TLV320AIC23 on Simtec boards"
+	depends on SND_S3C24XX_SOC
+	select SND_S3C24XX_SOC_I2S
+	select SND_SOC_TLV320AIC23
+	select SND_S3C24XX_SOC_SIMTEC
Index: b/sound/soc/s3c24xx/Makefile
===================================================================
--- a/sound/soc/s3c24xx/Makefile	2009-08-04 12:24:09.000000000 +0100
+++ b/sound/soc/s3c24xx/Makefile	2009-08-06 11:53:38.000000000 +0100
@@ -23,6 +23,8 @@ snd-soc-smdk2440-wm8991-objs := smdk2440
 snd-soc-ln2440sbc-alc650-objs := ln2440sbc_alc650.o
 snd-soc-neo1973-gta02-wm8753-objs := neo1973_gta02_wm8753.o
 snd-soc-s3c24xx-uda134x-objs := s3c24xx_uda134x.o
+snd-soc-s3c24xx-simtec-objs := s3c24xx_simtec.o
+snd-soc-s3c24xx-simtec-tlv320aic23-objs := s3c24xx_simtec_tlv320aic23.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -33,3 +35,5 @@ obj-$(CONFIG_SND_S3C24XX_SOC_SMDK2443_WM
 obj-$(CONFIG_SND_S3C24XX_SOC_LN2440SBC_ALC650) += snd-soc-ln2440sbc-alc650.o
 obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_GTA02_WM8753) += snd-soc-neo1973-gta02-wm8753.o
 obj-$(CONFIG_SND_S3C24XX_SOC_S3C24XX_UDA134X) += snd-soc-s3c24xx-uda134x.o
+obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC) += snd-soc-s3c24xx-simtec.o
+obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320aic23.o
Index: b/sound/soc/s3c24xx/s3c24xx_simtec.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/sound/soc/s3c24xx/s3c24xx_simtec.c	2009-08-04 12:29:02.000000000 +0100
@@ -0,0 +1,391 @@
+/* sound/soc/s3c24xx/s3c24xx_simtec.c
+ *
+ * Copyright 2009 Simtec Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#define DEBUG
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/clk.h>
+#include <linux/i2c.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <plat/audio-simtec.h>
+
+#include "s3c24xx-pcm.h"
+#include "s3c24xx-i2s.h"
+#include "s3c24xx_simtec.h"
+
+static struct s3c24xx_audio_simtec_pdata *pdata;
+static struct clk *xtal_clk;
+
+static int spk_gain;
+static int spk_unmute;
+
+/**
+ * speaker_gain_get - read the speaker gain setting.
+ * @kcontrol: The control for the speaker gain.
+ * @ucontrol: The value that needs to be updated.
+ *
+ * Read the value for the AMP gain control.
+ */
+static int speaker_gain_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = spk_gain;
+	return 0;
+}
+
+/**
+ * speaker_gain_set - set the value of the speaker amp gain
+ * @value: The value to write.
+ */
+static void speaker_gain_set(int value)
+{
+	gpio_set_value_cansleep(pdata->amp_gain[0], value & 1);
+	gpio_set_value_cansleep(pdata->amp_gain[1], value >> 1);
+}
+
+/**
+ * speaker_gain_put - set the speaker gain setting.
+ * @kcontrol: The control for the speaker gain.
+ * @ucontrol: The value that needs to be set.
+ *
+ * Set the value of the speaker gain from the specified
+ * @ucontrol setting.
+ *
+ * Note, if the speaker amp is muted, then we do not set a gain value
+ * as at-least one of the ICs that is fitted will try and power up even
+ * if the main control is set to off.
+ */
+static int speaker_gain_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	int value = ucontrol->value.integer.value[0];
+
+	spk_gain = value;
+
+	if (!spk_unmute)
+		speaker_gain_set(value);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new amp_gain_controls[] = {
+	SOC_SINGLE_EXT("Speaker Gain", 0, 0, 3, 0,
+		       speaker_gain_get, speaker_gain_put),
+};
+
+/**
+ * spk_unmute_state - set the unmute state of the speaker
+ * @to: zero to unmute, non-zero to ununmute.
+ */
+static void spk_unmute_state(int to)
+{
+	pr_debug("%s: to=%d\n", __func__, to);
+
+	spk_unmute = to;
+	gpio_set_value(pdata->amp_gpio, to);
+
+	/* if we're umuting, also re-set the gain */
+	if (to && pdata->amp_gain[0] > 0)
+		speaker_gain_set(spk_gain);
+}
+
+/**
+ * speaker_unmute_get - read the speaker unmute setting.
+ * @kcontrol: The control for the speaker gain.
+ * @ucontrol: The value that needs to be updated.
+ *
+ * Read the value for the AMP gain control.
+ */
+static int speaker_unmute_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = spk_unmute;
+	return 0;
+}
+
+/**
+ * speaker_unmute_put - set the speaker unmute setting.
+ * @kcontrol: The control for the speaker gain.
+ * @ucontrol: The value that needs to be set.
+ *
+ * Set the value of the speaker gain from the specified
+ * @ucontrol setting.
+ */
+static int speaker_unmute_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	spk_unmute_state(ucontrol->value.integer.value[0]);
+	return 0;
+}
+
+static const struct snd_kcontrol_new amp_unmute_controls[] = {
+	SOC_SINGLE_EXT("Speaker", 0, 0, 1, 0,
+		       speaker_unmute_get, speaker_unmute_put),
+};
+
+void simtec_audio_init(struct snd_soc_codec *codec)
+{
+	if (pdata->amp_gpio > 0) {
+		pr_debug("%s: adding amp routes\n", __func__);
+
+		snd_soc_add_controls(codec, amp_unmute_controls,
+				     ARRAY_SIZE(amp_unmute_controls));
+	}
+
+	if (pdata->amp_gain[0] > 0) {
+		pr_debug("%s: adding amp controls\n", __func__);
+		snd_soc_add_controls(codec, amp_gain_controls,
+				     ARRAY_SIZE(amp_gain_controls));
+	}
+}
+EXPORT_SYMBOL_GPL(simtec_audio_init);
+
+#define CODEC_CLOCK 12000000
+
+/**
+ * simtec_hw_params - update hardware parameters
+ * @substream: The audio substream instance.
+ * @params: The parameters requested.
+ *
+ * Update the codec data routing and configuration  settings
+ * from the supplied data.
+ */
+static int simtec_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+	/* Set the CODEC as the bus clock master, I2S */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret) {
+		pr_err("%s: failed set cpu dai format\n", __func__);
+		return ret;
+	}
+
+	/* Set the CODEC as the bus clock master */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret) {
+		pr_err("%s: failed set codec dai format\n", __func__);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
+				     CODEC_CLOCK, SND_SOC_CLOCK_IN);
+	if (ret) {
+		pr_err( "%s: failed setting codec sysclk\n", __func__);
+		return ret;
+	}
+
+	if (pdata->use_mpllin) {
+		ret = snd_soc_dai_set_sysclk(cpu_dai, S3C24XX_CLKSRC_MPLL,
+					     0, SND_SOC_CLOCK_OUT);
+
+		if (ret) {
+			pr_err("%s: failed to set MPLLin as clksrc\n",
+			       __func__);
+			return ret;
+		}
+	}
+
+	if (pdata->output_cdclk) {
+		int cdclk_scale;
+
+		cdclk_scale = clk_get_rate(xtal_clk) / CODEC_CLOCK;
+		cdclk_scale--;
+
+		ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
+					     cdclk_scale);
+	}
+
+	return 0;
+}
+
+static int simtec_call_startup(struct s3c24xx_audio_simtec_pdata *pd)
+{
+	/* call any board supplied startup code, this currently only
+	 * covers the bast/vr1000 which have a CPLD in the way of the
+	 * LRCLK */
+	if (pd->startup)
+		pd->startup();
+
+	return 0;
+}
+
+static struct snd_soc_ops simtec_snd_ops = {
+	.hw_params	= simtec_hw_params,
+};
+
+/**
+ * attach_gpio_amp - get and configure the necessary gpios
+ * @dev: The device we're probing.
+ * @pd: The platform data supplied by the board.
+ *
+ * If there is a GPIO based amplifier attached to the board, claim
+ * the necessary GPIO lines for it, and set default values.
+ */
+static int attach_gpio_amp(struct device *dev,
+			   struct s3c24xx_audio_simtec_pdata *pd)
+{
+	int ret;
+
+	/* attach gpio amp gain (if any) */
+	if (pdata->amp_gain[0] > 0) {
+		ret = gpio_request(pd->amp_gain[0], "gpio-amp-gain0");
+		if (ret) {
+			dev_err(dev, "cannot get amp gpio gain0\n");
+			return ret;
+		}
+
+		ret = gpio_request(pd->amp_gain[1], "gpio-amp-gain1");
+		if (ret) {
+			dev_err(dev, "cannot get amp gpio gain1\n");
+			gpio_free(pdata->amp_gain[0]);
+			return ret;
+		}
+
+		gpio_direction_output(pd->amp_gain[0], 0);
+		gpio_direction_output(pd->amp_gain[1], 0);
+	}
+
+	/* note, curently we assume GPA0 isn't valid amp */
+	if (pdata->amp_gpio > 0) {
+		ret = gpio_request(pd->amp_gpio, "gpio-amp");
+		if (ret) {
+			dev_err(dev, "cannot get amp gpio %d (%d)\n",
+				pd->amp_gpio, ret);
+			goto err_amp;
+		}
+
+		/* set the amp off at startup */
+		spk_unmute_state(0);
+	}
+
+	return 0;
+
+err_amp:
+	if (pd->amp_gain[0] > 0) {
+		gpio_free(pd->amp_gain[0]);
+		gpio_free(pd->amp_gain[1]);
+	}
+
+	return ret;
+}
+
+static void detach_gpio_amp(struct s3c24xx_audio_simtec_pdata *pd)
+{
+	if (pd->amp_gain[0] > 0) {
+		gpio_free(pd->amp_gain[0]);
+		gpio_free(pd->amp_gain[1]);
+	}
+
+	if (pd->amp_gpio > 0)
+		gpio_free(pd->amp_gpio);
+}
+
+#ifdef CONFIG_PM
+int simtec_audio_resume(struct device *dev)
+{
+	simtec_call_startup(pdata);
+	return 0;
+}
+
+struct dev_pm_ops simtec_audio_pmops = {
+	.resume	= simtec_audio_resume,
+};
+EXPORT_SYMBOL_GPL(simtec_audio_pmops);
+#endif
+
+int __devinit simtec_audio_core_probe(struct platform_device *pdev,
+				      struct snd_soc_device *socdev)
+{
+	struct platform_device *snd_dev;
+	int ret;
+
+	socdev->card->dai_link->ops = &simtec_snd_ops;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data supplied\n");
+		return -EINVAL;
+	}
+
+	simtec_call_startup(pdata);
+
+	xtal_clk = clk_get(&pdev->dev, "xtal");
+	if (IS_ERR(xtal_clk)) {
+		dev_err(&pdev->dev, "could not get clkout0\n");
+		return -EINVAL;
+	}
+
+	dev_info(&pdev->dev, "xtal rate is %ld\n", clk_get_rate(xtal_clk));
+
+	ret = attach_gpio_amp(&pdev->dev, pdata);
+	if (ret)
+		goto err_clk;
+
+	snd_dev = platform_device_alloc("soc-audio", -1);
+	if (!snd_dev) {
+		dev_err(&pdev->dev, "failed to alloc soc-audio devicec\n");
+		ret = -ENOMEM;
+		goto err_gpio;
+	}
+
+	platform_set_drvdata(snd_dev, socdev);
+	socdev->dev = &snd_dev->dev;
+
+	ret = platform_device_add(snd_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add soc-audio dev\n");
+		goto err_pdev;
+	}
+
+	platform_set_drvdata(pdev, snd_dev);
+	return 0;
+
+err_pdev:
+	platform_device_put(snd_dev);
+
+err_gpio:
+	detach_gpio_amp(pdata);
+
+err_clk:
+	clk_put(xtal_clk);
+	return ret;
+}
+
+int __devexit simtec_audio_remove(struct platform_device *pdev)
+{
+	struct platform_device *snd_dev = platform_get_drvdata(pdev);
+
+	platform_device_unregister(snd_dev);
+
+	detach_gpio_amp(pdata);
+	clk_put(xtal_clk);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(simtec_audio_remove);
+
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("ALSA SoC Simtec Audio common support");
+MODULE_LICENSE("GPL");
Index: b/arch/arm/plat-s3c/include/plat/audio-simtec.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/arm/plat-s3c/include/plat/audio-simtec.h	2009-08-04 12:24:11.000000000 +0100
@@ -0,0 +1,37 @@
+/* arch/arm/plat-s3c/include/plat/audio-simtec.h
+ *
+ * Copyright 2008 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Simtec Audio support.
+*/
+
+/**
+ * struct s3c24xx_audio_simtec_pdata - platform data for simtec audio
+ * @use_mpllin: Select codec clock from MPLLin
+ * @output_cdclk: Need to output CDCLK to the codec
+ * @have_mic: Set if we have a MIC socket
+ * @have_lout: Set if we have a LineOut socket
+ * @amp_gpio: GPIO pin to enable the AMP
+ * @amp_gain: Option GPIO to control AMP gain
+ */
+struct s3c24xx_audio_simtec_pdata {
+	unsigned int	use_mpllin:1;
+	unsigned int	output_cdclk:1;
+
+	unsigned int	have_mic:1;
+	unsigned int	have_lout:1;
+
+	int		amp_gpio;
+	int		amp_gain[2];
+
+	void	(*startup)(void);
+};
+
+extern int simtec_audio_add(const char *codec_name,
+			    struct s3c24xx_audio_simtec_pdata *pdata);
Index: b/arch/arm/plat-s3c24xx/audio-simtec.c
===================================================================
--- a/arch/arm/plat-s3c24xx/audio-simtec.c	2009-08-04 12:05:59.000000000 +0100
+++ b/arch/arm/plat-s3c24xx/audio-simtec.c	2009-08-04 12:24:11.000000000 +0100
@@ -45,7 +45,7 @@
 #include <plat/audio.h>
 
 #include <plat/regs-iis.h>
-#include <asm/plat-s3c24xx/audio-simtec.h>
+#include <plat/audio-simtec.h>
 #include <plat/devs.h>
 #include <plat/pm.h>
 
@@ -56,7 +56,7 @@ static inline int has_lr_routing(void)
 	return machine_is_bast() || machine_is_vr1000();
 }
 
-static int simtec_audio_startup(void *pw)
+static void simtec_audio_startup(void)
 {
 	unsigned int tmp;
 	unsigned long flags;
@@ -71,94 +71,40 @@ static int simtec_audio_startup(void *pw
 	}
 
 	local_irq_restore(flags);
-
-	return 0;
-}
-
-static void simtec_audio_shutdown(void *pw)
-{
-	unsigned int tmp;
-	unsigned long flags;
-
-	/* switch off LR clock routing */
-
-	local_irq_save(flags);
-
-	if (has_lr_routing()) {
-		tmp = __raw_readb(BAST_VA_CTRL1);
-		tmp &= ~BAST_CPLD_CTRL1_LRMASK;
-		tmp |= BAST_CPLD_CTRL1_LRCOFF;
-		__raw_writeb(tmp, BAST_VA_CTRL1);
-	}
-
-	local_irq_restore(flags);
-}
-
-static int simtec_audio_matchdev(struct device *dev)
-{
-	printk(KERN_INFO "%s: dev = %p\n", __func__, dev);
-
-	if (dev->parent == NULL || dev->parent->parent == NULL)
-		return 0;
-
-	printk(KERN_INFO "%s: %s\n", __func__, dev_name(dev->parent));
-	if (strncmp(dev_name(dev->parent), "i2c", strlen("i2c")) != 0)
-		return 0;
-
-	printk(KERN_INFO "%s: %s\n", __func__, dev_name(dev->parent->parent));
-	if (strncmp(dev_name(dev->parent->parent), "s3c24",
-		    strlen("s3c24")) == 0)
-		return 1;
-
-	return 0;
 }
 
-/* device registration info */
-
-static struct s3c24xx_iis_ops simtec_audio_ops = {
-	.startup	= simtec_audio_startup,
-	.shutdown	= simtec_audio_shutdown,
+static struct s3c24xx_audio_simtec_pdata simtec_audio_platdata = {
 };
 
-static struct s3c24xx_platdata_iis simtec_audio_platdata = {
-	.ops		= &simtec_audio_ops,
-	.codec_clk	= "clkout0",
-	.match_dev	= simtec_audio_matchdev,
-};
+static char our_name[32];
 
 static struct platform_device audio_dev = {
-	.name	= "s3c24xx-tlv320aic23",
+	.name	= our_name,
+	.id	= -1,
 	.dev	= {
 		.parent		= &s3c_device_iis.dev,
 		.platform_data	= &simtec_audio_platdata,
 	},
 };
 
-static struct platform_device audio_dev2 = {
-	.name	= "s3c24xx-tlv320aic33",
-	.dev	= {
-		.parent		= &s3c_device_iis.dev,
-		.platform_data	= &simtec_audio_platdata,
-	},
-};
-
-static void __init simtec_audio_cdclk_mpllin(void)
+int __init simtec_audio_add(const char *name,
+			    struct s3c24xx_audio_simtec_pdata *spd)
 {
-	simtec_audio_platdata.flags = AUDIO_CDCLK_MPLL | AUDIO_CDCLK_OUTPUT;
-}
+	if (!name)
+		name = "tlv320aic23";
 
-int __init simtec_audio_add(unsigned int is_aic33,
-			    unsigned int cdclk_master)
-{
-	if (cdclk_master)
-		simtec_audio_cdclk_mpllin();
+	snprintf(our_name, sizeof(our_name)-1, "s3c24xx-simtec-%s", name);
 
-	platform_device_register(&s3c_device_iis);
+	if (!spd) {
+		printk(KERN_ERR "%s: no source platadata\n", __func__);
+		return -EINVAL;
+	}
 
-	if (is_aic33)
-		platform_device_register(&audio_dev2);
-	else
-		platform_device_register(&audio_dev);
+	/* copy platform data so the source can be __initdata */
+	simtec_audio_platdata = *spd;
+
+	platform_device_register(&s3c_device_iis);
+	platform_device_register(&audio_dev);
 
 	return 0;
 }
@@ -172,7 +118,8 @@ static int __init simtec_audio_init(void
 
 	printk(KERN_INFO "Simtec TLV320AIC23 Audio platform driver\n");
 
-	simtec_audio_shutdown(NULL);
+	if (has_lr_routing())
+		simtec_audio_platdata.startup = simtec_audio_startup;
 
 	platform_device_register(&s3c_device_iis);
 	return platform_device_register(&audio_dev);
Index: b/arch/arm/common/sbcd/s3c24xx/dev-audio.c
===================================================================
--- a/arch/arm/common/sbcd/s3c24xx/dev-audio.c	2009-08-04 12:05:59.000000000 +0100
+++ b/arch/arm/common/sbcd/s3c24xx/dev-audio.c	2009-08-04 12:24:11.000000000 +0100
@@ -12,6 +12,9 @@
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/device.h>
+#include <linux/ioport.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
 
 #include "s3c24xx.h"
 #include <asm/mach/sbcd-utils.h>
@@ -24,22 +27,69 @@
 #include "../devices/platform.h"
 
 #include <plat/devs.h>
-#include <asm/plat-s3c24xx/audio-simtec.h>
+#include <plat/audio-simtec.h>
+
+enum amp_type {
+	AMP_VR2K,
+	AMP_HERMES,	/* GAIN0 = GPD9, GAIN1 = GPD10 */
+};
+
+static void __iomem *reg;
+static enum amp_type type;
+
+static void amp_gpio_set(struct gpio_chip *chip,
+			 unsigned offset, int value)
+{
+	u32 to_write;
 
-static unsigned char is_cdclk_master;
+	if (type == AMP_VR2K) {
+		to_write = value ? 0x01 : 0x03;
+	} else {
+		to_write = value ? 0x03 : 0x02;
+	}
+
+	writeb(to_write, reg);
+}
+
+static int amp_gpio_output(struct gpio_chip *chip,
+			   unsigned offset, int value)
+{
+	amp_gpio_set(chip, offset, value);
+	return 0;
+}
+
+static struct gpio_chip amp_gpio = {
+	.label			= "amp",
+	.direction_output	= amp_gpio_output,
+	.set			= amp_gpio_set,
+	.ngpio			= 1,
+	.base			= -1,
+};
+
+static struct s3c24xx_audio_simtec_pdata __initdata pdata = {
+};
 
 static __init int s3c24xx_drv_bast_audio_attach(struct sbcd_state *state,
 						struct sbcd_item *parent,
 						struct sbcd_item *drv_it)
 {
-	int is_tlv320aic33 = sbcd_board_has_driver("tlv320aic33");
+	char *name = NULL;
 
 	/* some vr2000s do not have the necessary setup in their
-	 * configuration data, so force is_cdclk_master here. */
-	if (sbcd_board_has_driver("vr2k-amp"))
-		is_cdclk_master = 1;
+	 * configuration data, so force cdclk_master here. */
+
+	if (sbcd_board_has_driver("vr2k-amp") ||
+	    sbcd_board_has_driver("hermes-amp")) {
+		pdata.use_mpllin = 1;
+		pdata.output_cdclk = 1;
+	}
 
-	return simtec_audio_add(is_tlv320aic33, is_cdclk_master);
+	if (sbcd_board_has_driver("hermes-amp"))
+		name = "hermes-snd";
+
+	pdata.amp_gpio = amp_gpio.base;
+
+	return simtec_audio_add(name, &pdata);
 }
 
 
@@ -61,8 +111,10 @@ static __init int s3c24xx_drv_audio_atta
 			sbcd_get_optvals(ptr, &optname, &optval);
 
 			if (strcmp(optname, "cdclk") == 0 &&
-			    strcmp(optval, "master") == 0)
-				is_cdclk_master = 1;
+			    strcmp(optval, "master") == 0) {
+				pdata.use_mpllin = 1;
+				pdata.output_cdclk = 1;
+			}
 			break;
 		}
 	}
@@ -76,49 +128,57 @@ static __init int s3c24xx_drv_audio_atta
 sbcd_drv_decl2(cpu_audio, "cpu-audio", s3c24xx_drv_audio_attach);
 sbcd_drv_decl2(bast_audio, "bast-audio", s3c24xx_drv_bast_audio_attach);
 
-static struct resource vr2k_amp_resource[] = {
-	[0]	= {
-		.start		= S3C2410_CS1 + 0xc0,
-		.end		= S3C2410_CS1 + 0xc1,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct resource hermes_amp_resource[] = {
-	[0]	= {
-		.start		= S3C2410_CS1 + 0x140,
-		.end		= S3C2410_CS1 + 0x141,
-		.flags		= IORESOURCE_MEM,
-	},
-};
 
 static __init int s3c24xx_drv_amp_attach(struct sbcd_state *state,
-					 struct sbcd_item *parent,
-					 struct sbcd_item *drv_it)
+					 enum amp_type amp_type)
 {
-	struct platform_device *pdev;
+	unsigned long base;
 	int ret;
 
-	ret = sbcd_dev_platform_create(state, parent, drv_it, &pdev);
-	if (ret) {
-		printk(KERN_ERR "%s: no platform device\n", __func__);
-		return -ENODEV;
+	if (state->pass != SBCD_PASS_GPIO)
+		return 0;
+
+	type = amp_type;
+
+	if (amp_type == AMP_VR2K) {
+		base = S3C2410_CS1 + 0xc0;
+	} else {
+		base = S3C2410_CS1 + 0x140;
+		pdata.amp_gain[0] = S3C2410_GPD(9);
+		pdata.amp_gain[1] = S3C2410_GPD(10);
 	}
 
-	if (pdev->num_resources == 0) {
-		if (strcmp(pdev->name, "vr2k-amp") == 0) {
-			pdev->resource = vr2k_amp_resource;
-			pdev->num_resources = ARRAY_SIZE(vr2k_amp_resource);
-		} else if (strcmp(pdev->name, "hermes-amp") == 0) {
-			pdev->resource = hermes_amp_resource;
-			pdev->num_resources = ARRAY_SIZE(hermes_amp_resource);
-		}
+	/* note, we don't request the region, other gpio blocks may
+	 * be sharing it. */
+
+	reg = ioremap(base, 2);
+	if (!reg) {
+		printk(KERN_ERR "%s: failed to map regs\n", __func__);
+		return -ENXIO;
+	}
+
+	ret = gpiochip_add(&amp_gpio);
+	if (!ret) {
+		printk(KERN_ERR "%s: failed to add gpio\n", __func__);
+		return ret;
 	}
 
-	pdev->dev.parent = &s3c_device_iis.dev;
-	platform_device_register(pdev);
 	return 0;
 }
 
-sbcd_drv_decl2(vr2k_amp, "vr2k-amp", s3c24xx_drv_amp_attach);
-sbcd_drv_decl2(hermes_amp, "hermes-amp", s3c24xx_drv_amp_attach);
+static __init int s3c24xx_drv_vr2k_amp_attach(struct sbcd_state *state,
+					      struct sbcd_item *parent,
+					      struct sbcd_item *drv_it)
+{
+	return s3c24xx_drv_amp_attach(state, AMP_VR2K);
+}
+
+static __init int s3c24xx_drv_hermes_amp_attach(struct sbcd_state *state,
+						struct sbcd_item *parent,
+						struct sbcd_item *drv_it)
+{
+	return s3c24xx_drv_amp_attach(state, AMP_HERMES);
+}
+
+sbcd_drv_decl2_gpio(vr2k_amp, "vr2k-amp", s3c24xx_drv_vr2k_amp_attach);
+sbcd_drv_decl2_gpio(hermes_amp, "hermes-amp", s3c24xx_drv_hermes_amp_attach);
Index: b/sound/soc/s3c24xx/s3c24xx_simtec.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/sound/soc/s3c24xx/s3c24xx_simtec.h	2009-08-04 12:24:11.000000000 +0100
@@ -0,0 +1,22 @@
+/* sound/soc/s3c24xx/s3c24xx_simtec.h
+ *
+ * Copyright 2009 Simtec Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+extern void simtec_audio_init(struct snd_soc_codec *codec);
+
+extern int simtec_audio_core_probe(struct platform_device *pdev,
+				   struct snd_soc_device *socdev);
+
+extern int simtec_audio_remove(struct platform_device *pdev);
+
+#ifdef CONFIG_PM
+extern struct dev_pm_ops simtec_audio_pmops;
+#define simtec_audio_pm &simtec_audio_pmops
+#else
+#define simtec_audio_pm NULL
+#endif
Index: b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c	2009-08-04 12:24:11.000000000 +0100
@@ -0,0 +1,137 @@
+/* sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+ *
+ * Copyright 2009 Simtec Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <plat/audio-simtec.h>
+
+#include "s3c24xx-pcm.h"
+#include "s3c24xx-i2s.h"
+#include "s3c24xx_simtec.h"
+
+#include "../codecs/tlv320aic23.h"
+
+/* supported machines:
+ *
+ * Machine	Connections		AMP
+ * -------	-----------		---
+ * BAST		MIC, HPOUT, LOUT, LIN	TPA2001D1 (HPOUTL,R) (gain hardwired)
+ * VR1000	HPOUT, LIN		None
+ * VR2000	LIN, LOUT, MIC, HP	LM4871 (HPOUTL,R)
+ * DePicture	LIN, LOUT, MIC, HP	LM4871 (HPOUTL,R)
+ * Anubis	LIN, LOUT, MIC, HP	TPA2001D1 (HPOUTL,R)
+ */
+
+static const struct snd_soc_dapm_widget dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route base_map[] = {
+	{ "Headphone Jack", NULL, "LHPOUT"},
+	{ "Headphone Jack", NULL, "RHPOUT"},
+
+	{ "Line Out", NULL, "LOUT" },
+	{ "Line Out", NULL, "ROUT" },
+
+	{ "LLINEIN", NULL, "Line In"},
+	{ "RLINEIN", NULL, "Line In"},
+
+	{ "MICIN", NULL, "Mic Jack"},
+};
+
+/**
+ * simtec_tlv320aic23_init - initialise and add controls
+ * @codec; The codec instance to attach to.
+ *
+ * Attach our controls and configure the necessary codec
+ * mappings for our sound card instance.
+*/
+static int simtec_tlv320aic23_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, dapm_widgets,
+				  ARRAY_SIZE(dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, base_map, ARRAY_SIZE(base_map));
+
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Line In");
+	snd_soc_dapm_enable_pin(codec, "Line Out");
+	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+
+	simtec_audio_init(codec);
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link simtec_dai_aic23 = {
+	.name		= "tlv320aic23",
+	.stream_name	= "TLV320AIC23",
+	.cpu_dai	= &s3c24xx_i2s_dai,
+	.codec_dai	= &tlv320aic23_dai,
+	.init		= simtec_tlv320aic23_init,
+};
+
+/* simtec audio machine driver */
+static struct snd_soc_card snd_soc_machine_simtec_aic23 = {
+	.name		= "Simtec",
+	.platform	= &s3c24xx_soc_platform,
+	.dai_link	= &simtec_dai_aic23,
+	.num_links	= 1,
+};
+
+/* simtec audio subsystem */
+static struct snd_soc_device simtec_snd_devdata_aic23 = {
+	.card		= &snd_soc_machine_simtec_aic23,
+	.codec_dev	= &soc_codec_dev_tlv320aic23,
+};
+
+static int __devinit simtec_audio_tlv320aic23_probe(struct platform_device *pd)
+{
+	return simtec_audio_core_probe(pd, &simtec_snd_devdata_aic23);
+}
+
+static struct platform_driver simtec_audio_tlv320aic23_platdrv = {
+	.driver	= {
+		.owner	= THIS_MODULE,
+		.name	= "s3c24xx-simtec-tlv320aic23",
+		.pm	= simtec_audio_pm,
+	},
+	.probe	= simtec_audio_tlv320aic23_probe,
+	.remove	= __devexit_p(simtec_audio_remove),
+};
+
+MODULE_ALIAS("platform:s3c24xx-simtec-tlv320aic23");
+
+static int __init simtec_tlv320aic23_modinit(void)
+{
+	return platform_driver_register(&simtec_audio_tlv320aic23_platdrv);
+}
+
+static void __exit simtec_tlv320aic23_modexit(void)
+{
+	platform_driver_unregister(&simtec_audio_tlv320aic23_platdrv);
+}
+
+module_init(simtec_tlv320aic23_modinit);
+module_exit(simtec_tlv320aic23_modexit);
+
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("ALSA SoC Simtec Audio support");
+MODULE_LICENSE("GPL");

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
