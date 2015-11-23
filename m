From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH 2/2] ASoC: img: Add driver for Pistachio
	internal DAC
Date: Mon, 23 Nov 2015 17:24:59 +0000
Message-ID: <1448299499-18435-3-git-send-email-Damien.Horsley@imgtec.com>
References: <1448299499-18435-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id A6AD9265745
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 18:28:10 +0100 (CET)
In-Reply-To: <1448299499-18435-1-git-send-email-Damien.Horsley@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, "Damien.Horsley" <Damien.Horsley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Add driver for Pistachio Internal DAC

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
---
 sound/soc/img/Kconfig                  |   8 +
 sound/soc/img/Makefile                 |   2 +
 sound/soc/img/pistachio-internal-dac.c | 350 +++++++++++++++++++++++++++++++++
 3 files changed, 360 insertions(+)
 create mode 100644 sound/soc/img/pistachio-internal-dac.c

diff --git a/sound/soc/img/Kconfig b/sound/soc/img/Kconfig
index d08537e..857a951 100644
--- a/sound/soc/img/Kconfig
+++ b/sound/soc/img/Kconfig
@@ -42,3 +42,11 @@ config SND_SOC_IMG_SPDIF_OUT
 	help
 	  Say Y or M if you want to add support for SPDIF out driver for
 	  Imagination Technologies SPDIF out device.
+
+
+config SND_SOC_IMG_PISTACHIO_INTERNAL_DAC
+	tristate "Support for Pistachio SoC Internal DAC Driver"
+	depends on SND_SOC_IMG
+	help
+	  Say Y or M if you want to add support for Pistachio internal DAC
+	  driver for Imagination Technologies Pistachio internal DAC device.
diff --git a/sound/soc/img/Makefile b/sound/soc/img/Makefile
index 1a44fb4..0508c1c 100644
--- a/sound/soc/img/Makefile
+++ b/sound/soc/img/Makefile
@@ -3,3 +3,5 @@ obj-$(CONFIG_SND_SOC_IMG_I2S_OUT) += img-i2s-out.o
 obj-$(CONFIG_SND_SOC_IMG_PARALLEL_OUT) += img-parallel-out.o
 obj-$(CONFIG_SND_SOC_IMG_SPDIF_IN) += img-spdif-in.o
 obj-$(CONFIG_SND_SOC_IMG_SPDIF_OUT) += img-spdif-out.o
+
+obj-$(CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC) += pistachio-internal-dac.o
diff --git a/sound/soc/img/pistachio-internal-dac.c b/sound/soc/img/pistachio-internal-dac.c
new file mode 100644
index 0000000..d7df2f3
--- /dev/null
+++ b/sound/soc/img/pistachio-internal-dac.c
@@ -0,0 +1,350 @@
+/*
+ * Pistachio internal dac driver
+ *
+ * Copyright (C) 2015 Imagination Technologies Ltd.
+ *
+ * Author: Damien Horsley <Damien.Horsley@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#define PISTACHIO_INTERNAL_DAC_CTRL			0x40
+#define PISTACHIO_INTERNAL_DAC_CTRL_MUTE_MASK		0x4
+#define PISTACHIO_INTERNAL_DAC_CTRL_PWR_SEL_MASK	0x2
+#define PISTACHIO_INTERNAL_DAC_CTRL_PWRDN_MASK		0x1
+
+#define PISTACHIO_INTERNAL_DAC_SRST			0x44
+#define PISTACHIO_INTERNAL_DAC_SRST_MASK		0x1
+
+#define PISTACHIO_INTERNAL_DAC_GTI_CTRL			0x48
+#define PISTACHIO_INTERNAL_DAC_GTI_CTRL_ADDR_SHIFT	0
+#define PISTACHIO_INTERNAL_DAC_GTI_CTRL_ADDR_MASK	0xFFF
+#define PISTACHIO_INTERNAL_DAC_GTI_CTRL_WE_MASK		0x1000
+#define PISTACHIO_INTERNAL_DAC_GTI_CTRL_WDATA_SHIFT	13
+#define PISTACHIO_INTERNAL_DAC_GTI_CTRL_WDATA_MASK	0x1FE000
+
+#define PISTACHIO_INTERNAL_DAC_PWR			0x1
+#define PISTACHIO_INTERNAL_DAC_PWR_MASK			0x1
+
+#define PISTACHIO_INTERNAL_DAC_FORMATS (SNDRV_PCM_FMTBIT_S24_LE |  \
+					SNDRV_PCM_FMTBIT_S32_LE)
+
+/* codec private data */
+struct pistachio_internal_dac {
+	spinlock_t lock;
+	struct regmap *regmap;
+	struct regulator *supply;
+
+	/* The mute state as set by alsa using the digital_mute callback */
+	bool alsa_mute_state;
+	/* The mute state as set by the userspace mute control */
+	bool control_mute_state;
+	/* The actual mute state is equal to an OR of the above */
+};
+
+static int pistachio_internal_dac_get_mute(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct pistachio_internal_dac *dac = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = dac->control_mute_state;
+
+	return 0;
+}
+
+static void pistachio_internal_dac_mute(struct pistachio_internal_dac *dac)
+{
+	u32 reg;
+
+	if (dac->control_mute_state || dac->alsa_mute_state)
+		reg = PISTACHIO_INTERNAL_DAC_CTRL_MUTE_MASK;
+	else
+		reg = 0;
+
+	regmap_update_bits(dac->regmap, PISTACHIO_INTERNAL_DAC_CTRL,
+			PISTACHIO_INTERNAL_DAC_CTRL_MUTE_MASK, reg);
+}
+
+static int pistachio_internal_dac_set_mute(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct pistachio_internal_dac *dac = snd_soc_codec_get_drvdata(codec);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dac->lock, flags);
+	dac->control_mute_state = ucontrol->value.integer.value[0];
+	pistachio_internal_dac_mute(dac);
+	spin_unlock_irqrestore(&dac->lock, flags);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new pistachio_internal_dac_snd_controls[] = {
+	{
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = "Mute Switch",
+		.info = snd_ctl_boolean_mono_info,
+		.get = pistachio_internal_dac_get_mute,
+		.put = pistachio_internal_dac_set_mute,
+	}
+};
+
+static int pistachio_internal_dac_digital_mute(struct snd_soc_dai *dai,
+						int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pistachio_internal_dac *dac = snd_soc_codec_get_drvdata(codec);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dac->lock, flags);
+	dac->alsa_mute_state = mute;
+	pistachio_internal_dac_mute(dac);
+	spin_unlock_irqrestore(&dac->lock, flags);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget pistachio_internal_dac_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("AOUTL"),
+	SND_SOC_DAPM_OUTPUT("AOUTR"),
+};
+
+static const struct snd_soc_dapm_route pistachio_internal_dac_routes[] = {
+	{ "AOUTL", NULL, "DAC" },
+	{ "AOUTR", NULL, "DAC" },
+};
+
+static void pistachio_internal_dac_reg_writel(struct regmap *top_regs,
+						u32 val, u32 reg)
+{
+	regmap_update_bits(top_regs, PISTACHIO_INTERNAL_DAC_GTI_CTRL,
+			PISTACHIO_INTERNAL_DAC_GTI_CTRL_ADDR_MASK,
+			reg << PISTACHIO_INTERNAL_DAC_GTI_CTRL_ADDR_SHIFT);
+
+	regmap_update_bits(top_regs, PISTACHIO_INTERNAL_DAC_GTI_CTRL,
+			PISTACHIO_INTERNAL_DAC_GTI_CTRL_WDATA_MASK,
+			val << PISTACHIO_INTERNAL_DAC_GTI_CTRL_WDATA_SHIFT);
+
+	regmap_update_bits(top_regs, PISTACHIO_INTERNAL_DAC_GTI_CTRL,
+			PISTACHIO_INTERNAL_DAC_GTI_CTRL_WE_MASK,
+			PISTACHIO_INTERNAL_DAC_GTI_CTRL_WE_MASK);
+
+	regmap_update_bits(top_regs, PISTACHIO_INTERNAL_DAC_GTI_CTRL,
+			PISTACHIO_INTERNAL_DAC_GTI_CTRL_WE_MASK, 0);
+}
+
+static void pistachio_internal_dac_pwr_off(struct pistachio_internal_dac *dac)
+{
+	regmap_update_bits(dac->regmap, PISTACHIO_INTERNAL_DAC_CTRL,
+		PISTACHIO_INTERNAL_DAC_CTRL_PWRDN_MASK,
+		PISTACHIO_INTERNAL_DAC_CTRL_PWRDN_MASK);
+
+	pistachio_internal_dac_reg_writel(dac->regmap, 0,
+					PISTACHIO_INTERNAL_DAC_PWR);
+}
+
+static void pistachio_internal_dac_pwr_on(struct pistachio_internal_dac *dac)
+{
+	regmap_update_bits(dac->regmap, PISTACHIO_INTERNAL_DAC_SRST,
+			PISTACHIO_INTERNAL_DAC_SRST_MASK,
+			PISTACHIO_INTERNAL_DAC_SRST_MASK);
+
+	regmap_update_bits(dac->regmap, PISTACHIO_INTERNAL_DAC_SRST,
+			PISTACHIO_INTERNAL_DAC_SRST_MASK, 0);
+
+	pistachio_internal_dac_reg_writel(dac->regmap,
+					PISTACHIO_INTERNAL_DAC_PWR_MASK,
+					PISTACHIO_INTERNAL_DAC_PWR);
+
+	regmap_update_bits(dac->regmap, PISTACHIO_INTERNAL_DAC_CTRL,
+			PISTACHIO_INTERNAL_DAC_CTRL_PWRDN_MASK, 0);
+}
+
+static const struct snd_soc_dai_ops pistachio_internal_dac_dac_dai_ops = {
+	.digital_mute	= pistachio_internal_dac_digital_mute,
+};
+
+static struct snd_soc_dai_driver pistachio_internal_dac_dais[] = {
+	{
+		.name = "pistachio_internal_dac",
+		.playback = {
+			.stream_name = "Playback",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = PISTACHIO_INTERNAL_DAC_FORMATS,
+		},
+		.ops = &pistachio_internal_dac_dac_dai_ops,
+	},
+};
+
+static const struct snd_soc_codec_driver pistachio_internal_dac_driver = {
+	.idle_bias_off = true,
+	.controls = pistachio_internal_dac_snd_controls,
+	.num_controls = ARRAY_SIZE(pistachio_internal_dac_snd_controls),
+	.dapm_widgets = pistachio_internal_dac_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(pistachio_internal_dac_widgets),
+	.dapm_routes = pistachio_internal_dac_routes,
+	.num_dapm_routes = ARRAY_SIZE(pistachio_internal_dac_routes),
+};
+
+static int pistachio_internal_dac_probe(struct platform_device *pdev)
+{
+	struct pistachio_internal_dac *dac;
+	int ret, voltage;
+	struct device *dev = &pdev->dev;
+	u32 reg;
+
+	dac = devm_kzalloc(dev, sizeof(*dac), GFP_KERNEL);
+
+	if (!dac)
+		return -ENOMEM;
+
+	spin_lock_init(&dac->lock);
+
+	platform_set_drvdata(pdev, dac);
+
+	dac->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							    "img,cr-top");
+	if (IS_ERR(dac->regmap))
+		return PTR_ERR(dac->regmap);
+
+	dac->supply = devm_regulator_get(dev, "VDD");
+	if (IS_ERR(dac->supply)) {
+		if (PTR_ERR(dac->supply) != -EPROBE_DEFER)
+			dev_err(dev, "failed to acquire supply 'VDD-supply'\n");
+		return PTR_ERR(dac->supply);
+	}
+
+	ret = regulator_enable(dac->supply);
+	if (ret) {
+		dev_err(dev, "failed to enable supply: %d\n", ret);
+		return ret;
+	}
+
+	voltage = regulator_get_voltage(dac->supply);
+
+	switch (voltage) {
+	case 1800000:
+		reg = 0;
+		break;
+	case 3300000:
+		reg = PISTACHIO_INTERNAL_DAC_CTRL_PWR_SEL_MASK;
+		break;
+	default:
+		dev_err(dev, "invalid voltage: %d\n", voltage);
+		ret = -EINVAL;
+		goto err_regulator;
+	}
+
+	regmap_update_bits(dac->regmap, PISTACHIO_INTERNAL_DAC_CTRL,
+			PISTACHIO_INTERNAL_DAC_CTRL_PWR_SEL_MASK, reg);
+
+	pistachio_internal_dac_pwr_off(dac);
+	pistachio_internal_dac_pwr_on(dac);
+
+	ret = snd_soc_register_codec(dev, &pistachio_internal_dac_driver,
+			pistachio_internal_dac_dais,
+			ARRAY_SIZE(pistachio_internal_dac_dais));
+	if (ret) {
+		dev_err(dev, "failed to register codec: %d\n", ret);
+		goto err_pwr;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_idle(dev);
+
+	return 0;
+
+err_pwr:
+	pistachio_internal_dac_pwr_off(dac);
+err_regulator:
+	regulator_disable(dac->supply);
+
+	return ret;
+}
+
+static int pistachio_internal_dac_remove(struct platform_device *pdev)
+{
+	struct pistachio_internal_dac *dac = dev_get_drvdata(&pdev->dev);
+
+	snd_soc_unregister_codec(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pistachio_internal_dac_pwr_off(dac);
+	regulator_disable(dac->supply);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int pistachio_internal_dac_rt_resume(struct device *dev)
+{
+	struct pistachio_internal_dac *dac = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_enable(dac->supply);
+	if (ret) {
+		dev_err(dev, "failed to enable supply: %d\n", ret);
+		return ret;
+	}
+
+	pistachio_internal_dac_pwr_on(dac);
+
+	return 0;
+}
+
+static int pistachio_internal_dac_rt_suspend(struct device *dev)
+{
+	struct pistachio_internal_dac *dac = dev_get_drvdata(dev);
+
+	pistachio_internal_dac_pwr_off(dac);
+
+	regulator_disable(dac->supply);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops pistachio_internal_dac_pm_ops = {
+	SET_RUNTIME_PM_OPS(pistachio_internal_dac_rt_suspend,
+			pistachio_internal_dac_rt_resume, NULL)
+};
+
+static const struct of_device_id pistachio_internal_dac_of_match[] = {
+	{ .compatible = "img,pistachio-internal-dac" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pistachio_internal_dac_of_match);
+
+static struct platform_driver pistachio_internal_dac_plat_driver = {
+	.driver = {
+		.name = "img-pistachio-internal-dac",
+		.of_match_table = pistachio_internal_dac_of_match,
+		.pm = &pistachio_internal_dac_pm_ops
+	},
+	.probe = pistachio_internal_dac_probe,
+	.remove = pistachio_internal_dac_remove
+};
+module_platform_driver(pistachio_internal_dac_plat_driver);
+
+MODULE_DESCRIPTION("Pistachio Internal DAC driver");
+MODULE_AUTHOR("Damien Horsley <Damien.Horsley@imgtec.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4
