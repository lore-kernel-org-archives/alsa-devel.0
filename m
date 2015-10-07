From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825" to the asoc tree
Date: Wed, 07 Oct 2015 11:38:33 +0100
Message-ID: <E1Zjm7F-0004Fu-Ls@finisterre>
References: <1443804554-36592-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3174B266492
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 12:39:02 +0200 (CEST)
In-Reply-To: <1443804554-36592-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: Add driver for headset chip Nuvoton 8825

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 34ca27f34f413b4a684fc7336911799da3ac84d5 Mon Sep 17 00:00:00 2001
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Fri, 2 Oct 2015 09:49:14 -0700
Subject: [PATCH] ASoC: nau8825: Add driver for headset chip Nuvoton 8825

Sponsored-by: Google Chromium project
Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/nau8825.txt          |  102 ++
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/nau8825.c                         | 1107 ++++++++++++++++++++
 sound/soc/codecs/nau8825.h                         |  323 ++++++
 5 files changed, 1538 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nau8825.txt
 create mode 100644 sound/soc/codecs/nau8825.c
 create mode 100644 sound/soc/codecs/nau8825.h

diff --git a/Documentation/devicetree/bindings/sound/nau8825.txt b/Documentation/devicetree/bindings/sound/nau8825.txt
new file mode 100644
index 0000000..d337423
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nau8825.txt
@@ -0,0 +1,102 @@
+Nuvoton NAU8825 audio codec
+
+This device supports I2C only.
+
+Required properties:
+  - compatible : Must be "nuvoton,nau8825"
+
+  - reg : the I2C address of the device. This is either 0x1a (CSB=0) or 0x1b (CSB=1).
+
+Optional properties:
+  - nuvoton,jkdet-enable: Enable jack detection via JKDET pin.
+  - nuvoton,jkdet-pull-enable: Enable JKDET pin pull. If set - pin pull enabled,
+      otherwise pin in high impedance state.
+  - nuvoton,jkdet-pull-up: Pull-up JKDET pin. If set then JKDET pin is pull up, otherwise pull down.
+  - nuvoton,jkdet-polarity: JKDET pin polarity. 0 - active high, 1 - active low.
+
+  - nuvoton,vref-impedance: VREF Impedance selection
+      0 - Open
+      1 - 25 kOhm
+      2 - 125 kOhm
+      3 - 2.5 kOhm
+
+  - nuvoton,micbias-voltage: Micbias voltage level.
+      0 - VDDA
+      1 - VDDA
+      2 - VDDA * 1.1
+      3 - VDDA * 1.2
+      4 - VDDA * 1.3
+      5 - VDDA * 1.4
+      6 - VDDA * 1.53
+      7 - VDDA * 1.53
+
+  - nuvoton,sar-threshold-num: Number of buttons supported
+  - nuvoton,sar-threshold: Impedance threshold for each button. Array that contains up to 8 buttons configuration. SAR value is calculated as
+    SAR = 255 * MICBIAS / SAR_VOLTAGE * R / (2000 + R)
+    where MICBIAS is configured by 'nuvoton,micbias-voltage', SAR_VOLTAGE is configured by 'nuvoton,sar-voltage', R - button impedance.
+    Refer datasheet section 10.2 for more information about threshold calculation.
+
+  - nuvoton,sar-hysteresis: Button impedance measurement hysteresis.
+
+  - nuvoton,sar-voltage: Reference voltage for button impedance measurement.
+      0 - VDDA
+      1 - VDDA
+      2 - VDDA * 1.1
+      3 - VDDA * 1.2
+      4 - VDDA * 1.3
+      5 - VDDA * 1.4
+      6 - VDDA * 1.53
+      7 - VDDA * 1.53
+
+  - nuvoton,sar-compare-time: SAR compare time
+      0 - 500 ns
+      1 - 1 us
+      2 - 2 us
+      3 - 4 us
+
+  - nuvoton,sar-sampling-time: SAR sampling time
+      0 - 2 us
+      1 - 4 us
+      2 - 8 us
+      3 - 16 us
+
+  - nuvoton,short-key-debounce: Button short key press debounce time.
+      0 - 30 ms
+      1 - 50 ms
+      2 - 100 ms
+      3 - 30 ms
+
+  - nuvoton,jack-insert-debounce: number from 0 to 7 that sets debounce time to 2^(n+2) ms
+  - nuvoton,jack-eject-debounce: number from 0 to 7 that sets debounce time to 2^(n+2) ms
+
+  - clocks: list of phandle and clock specifier pairs according to common clock bindings for the
+      clocks described in clock-names
+  - clock-names: should include "mclk" for the MCLK master clock
+
+Example:
+
+  headset: nau8825@1a {
+      compatible = "nuvoton,nau8825";
+      reg = <0x1a>;
+      interrupt-parent = <&gpio>;
+      interrupts = <TEGRA_GPIO(E, 6) IRQ_TYPE_LEVEL_LOW>;
+      nuvoton,jkdet-enable;
+      nuvoton,jkdet-pull-enable;
+      nuvoton,jkdet-pull-up;
+      nuvoton,jkdet-polarity = <GPIO_ACTIVE_LOW>;
+      nuvoton,vref-impedance = <2>;
+      nuvoton,micbias-voltage = <6>;
+      // Setup 4 buttons impedance according to Android specification
+      nuvoton,sar-threshold-num = <4>;
+      nuvoton,sar-threshold = <0xc 0x1e 0x38 0x60>;
+      nuvoton,sar-hysteresis = <1>;
+      nuvoton,sar-voltage = <0>;
+      nuvoton,sar-compare-time = <0>;
+      nuvoton,sar-sampling-time = <0>;
+      nuvoton,short-key-debounce = <2>;
+      nuvoton,jack-insert-debounce = <7>;
+      nuvoton,jack-eject-debounce = <7>;
+
+      clock-names = "mclk";
+      clocks = <&tegra_car TEGRA210_CLK_CLK_OUT_2>;
+  };
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0142396..cc60ab9 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -79,6 +79,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_MC13783 if MFD_MC13XXX
 	select SND_SOC_ML26124 if I2C
+	select SND_SOC_NAU8825 if I2C
 	select SND_SOC_PCM1681 if I2C
 	select SND_SOC_PCM1792A if SPI_MASTER
 	select SND_SOC_PCM3008
@@ -892,6 +893,9 @@ config SND_SOC_MC13783
 config SND_SOC_ML26124
 	tristate
 
+config SND_SOC_NAU8825
+	tristate
+
 config SND_SOC_TPA6130A2
 	tristate "Texas Instruments TPA6130A2 headphone amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 7d7cc1b..d7b0f41 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -72,6 +72,7 @@ snd-soc-max98925-objs := max98925.o
 snd-soc-max9850-objs := max9850.o
 snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
+snd-soc-nau8825-objs := nau8825.o
 snd-soc-pcm1681-objs := pcm1681.o
 snd-soc-pcm1792a-codec-objs := pcm1792a.o
 snd-soc-pcm3008-objs := pcm3008.o
@@ -263,6 +264,7 @@ obj-$(CONFIG_SND_SOC_MAX98925)	+= snd-soc-max98925.o
 obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
 obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
+obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
 obj-$(CONFIG_SND_SOC_PCM1792A)	+= snd-soc-pcm1792a-codec.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
new file mode 100644
index 0000000..f31a500
--- /dev/null
+++ b/sound/soc/codecs/nau8825.c
@@ -0,0 +1,1107 @@
+/*
+ * Nuvoton NAU8825 audio codec driver
+ *
+ * Copyright 2015 Google Chromium project.
+ *  Author: Anatol Pomozov <anatol@chromium.org>
+ * Copyright 2015 Nuvoton Technology Corp.
+ *  Co-author: Meng-Huang Kuo <mhkuo@nuvoton.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+
+
+#include "nau8825.h"
+
+static const struct reg_default nau8825_reg_defaults[] = {
+	{ NAU8825_REG_ENA_CTRL, 0x00ff },
+	{ NAU8825_REG_CLK_DIVIDER, 0x0050 },
+	{ NAU8825_REG_FLL1, 0x0 },
+	{ NAU8825_REG_FLL2, 0x3126 },
+	{ NAU8825_REG_FLL3, 0x0008 },
+	{ NAU8825_REG_FLL4, 0x0010 },
+	{ NAU8825_REG_FLL5, 0x0 },
+	{ NAU8825_REG_FLL6, 0x6000 },
+	{ NAU8825_REG_FLL_VCO_RSV, 0xf13c },
+	{ NAU8825_REG_HSD_CTRL, 0x000c },
+	{ NAU8825_REG_JACK_DET_CTRL, 0x0 },
+	{ NAU8825_REG_INTERRUPT_MASK, 0x0 },
+	{ NAU8825_REG_INTERRUPT_DIS_CTRL, 0xffff },
+	{ NAU8825_REG_SAR_CTRL, 0x0015 },
+	{ NAU8825_REG_KEYDET_CTRL, 0x0110 },
+	{ NAU8825_REG_VDET_THRESHOLD_1, 0x0 },
+	{ NAU8825_REG_VDET_THRESHOLD_2, 0x0 },
+	{ NAU8825_REG_VDET_THRESHOLD_3, 0x0 },
+	{ NAU8825_REG_VDET_THRESHOLD_4, 0x0 },
+	{ NAU8825_REG_GPIO34_CTRL, 0x0 },
+	{ NAU8825_REG_GPIO12_CTRL, 0x0 },
+	{ NAU8825_REG_TDM_CTRL, 0x0 },
+	{ NAU8825_REG_I2S_PCM_CTRL1, 0x000b },
+	{ NAU8825_REG_I2S_PCM_CTRL2, 0x8010 },
+	{ NAU8825_REG_LEFT_TIME_SLOT, 0x0 },
+	{ NAU8825_REG_RIGHT_TIME_SLOT, 0x0 },
+	{ NAU8825_REG_BIQ_CTRL, 0x0 },
+	{ NAU8825_REG_BIQ_COF1, 0x0 },
+	{ NAU8825_REG_BIQ_COF2, 0x0 },
+	{ NAU8825_REG_BIQ_COF3, 0x0 },
+	{ NAU8825_REG_BIQ_COF4, 0x0 },
+	{ NAU8825_REG_BIQ_COF5, 0x0 },
+	{ NAU8825_REG_BIQ_COF6, 0x0 },
+	{ NAU8825_REG_BIQ_COF7, 0x0 },
+	{ NAU8825_REG_BIQ_COF8, 0x0 },
+	{ NAU8825_REG_BIQ_COF9, 0x0 },
+	{ NAU8825_REG_BIQ_COF10, 0x0 },
+	{ NAU8825_REG_ADC_RATE, 0x0010 },
+	{ NAU8825_REG_DAC_CTRL1, 0x0001 },
+	{ NAU8825_REG_DAC_CTRL2, 0x0 },
+	{ NAU8825_REG_DAC_DGAIN_CTRL, 0x0 },
+	{ NAU8825_REG_ADC_DGAIN_CTRL, 0x00cf },
+	{ NAU8825_REG_MUTE_CTRL, 0x0 },
+	{ NAU8825_REG_HSVOL_CTRL, 0x0 },
+	{ NAU8825_REG_DACL_CTRL, 0x02cf },
+	{ NAU8825_REG_DACR_CTRL, 0x00cf },
+	{ NAU8825_REG_ADC_DRC_KNEE_IP12, 0x1486 },
+	{ NAU8825_REG_ADC_DRC_KNEE_IP34, 0x0f12 },
+	{ NAU8825_REG_ADC_DRC_SLOPES, 0x25ff },
+	{ NAU8825_REG_ADC_DRC_ATKDCY, 0x3457 },
+	{ NAU8825_REG_DAC_DRC_KNEE_IP12, 0x1486 },
+	{ NAU8825_REG_DAC_DRC_KNEE_IP34, 0x0f12 },
+	{ NAU8825_REG_DAC_DRC_SLOPES, 0x25f9 },
+	{ NAU8825_REG_DAC_DRC_ATKDCY, 0x3457 },
+	{ NAU8825_REG_IMM_MODE_CTRL, 0x0 },
+	{ NAU8825_REG_CLASSG_CTRL, 0x0 },
+	{ NAU8825_REG_OPT_EFUSE_CTRL, 0x0 },
+	{ NAU8825_REG_MISC_CTRL, 0x0 },
+	{ NAU8825_REG_BIAS_ADJ, 0x0 },
+	{ NAU8825_REG_TRIM_SETTINGS, 0x0 },
+	{ NAU8825_REG_ANALOG_CONTROL_1, 0x0 },
+	{ NAU8825_REG_ANALOG_CONTROL_2, 0x0 },
+	{ NAU8825_REG_ANALOG_ADC_1, 0x0011 },
+	{ NAU8825_REG_ANALOG_ADC_2, 0x0020 },
+	{ NAU8825_REG_RDAC, 0x0008 },
+	{ NAU8825_REG_MIC_BIAS, 0x0006 },
+	{ NAU8825_REG_BOOST, 0x0 },
+	{ NAU8825_REG_FEPGA, 0x0 },
+	{ NAU8825_REG_POWER_UP_CONTROL, 0x0 },
+	{ NAU8825_REG_CHARGE_PUMP, 0x0 },
+};
+
+static bool nau8825_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8825_REG_ENA_CTRL:
+	case NAU8825_REG_CLK_DIVIDER ... NAU8825_REG_FLL_VCO_RSV:
+	case NAU8825_REG_HSD_CTRL ... NAU8825_REG_JACK_DET_CTRL:
+	case NAU8825_REG_INTERRUPT_MASK ... NAU8825_REG_KEYDET_CTRL:
+	case NAU8825_REG_VDET_THRESHOLD_1 ... NAU8825_REG_DACR_CTRL:
+	case NAU8825_REG_ADC_DRC_KNEE_IP12 ... NAU8825_REG_ADC_DRC_ATKDCY:
+	case NAU8825_REG_DAC_DRC_KNEE_IP12 ... NAU8825_REG_DAC_DRC_ATKDCY:
+	case NAU8825_REG_IMM_MODE_CTRL ... NAU8825_REG_IMM_RMS_R:
+	case NAU8825_REG_CLASSG_CTRL ... NAU8825_REG_OPT_EFUSE_CTRL:
+	case NAU8825_REG_MISC_CTRL:
+	case NAU8825_REG_I2C_DEVICE_ID ... NAU8825_REG_SARDOUT_RAM_STATUS:
+	case NAU8825_REG_BIAS_ADJ:
+	case NAU8825_REG_TRIM_SETTINGS ... NAU8825_REG_ANALOG_CONTROL_2:
+	case NAU8825_REG_ANALOG_ADC_1 ... NAU8825_REG_MIC_BIAS:
+	case NAU8825_REG_BOOST ... NAU8825_REG_FEPGA:
+	case NAU8825_REG_POWER_UP_CONTROL ... NAU8825_REG_GENERAL_STATUS:
+		return true;
+	default:
+		return false;
+	}
+
+}
+
+static bool nau8825_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8825_REG_RESET ... NAU8825_REG_ENA_CTRL:
+	case NAU8825_REG_CLK_DIVIDER ... NAU8825_REG_FLL_VCO_RSV:
+	case NAU8825_REG_HSD_CTRL ... NAU8825_REG_JACK_DET_CTRL:
+	case NAU8825_REG_INTERRUPT_MASK:
+	case NAU8825_REG_INT_CLR_KEY_STATUS ... NAU8825_REG_KEYDET_CTRL:
+	case NAU8825_REG_VDET_THRESHOLD_1 ... NAU8825_REG_DACR_CTRL:
+	case NAU8825_REG_ADC_DRC_KNEE_IP12 ... NAU8825_REG_ADC_DRC_ATKDCY:
+	case NAU8825_REG_DAC_DRC_KNEE_IP12 ... NAU8825_REG_DAC_DRC_ATKDCY:
+	case NAU8825_REG_IMM_MODE_CTRL:
+	case NAU8825_REG_CLASSG_CTRL ... NAU8825_REG_OPT_EFUSE_CTRL:
+	case NAU8825_REG_MISC_CTRL:
+	case NAU8825_REG_BIAS_ADJ:
+	case NAU8825_REG_TRIM_SETTINGS ... NAU8825_REG_ANALOG_CONTROL_2:
+	case NAU8825_REG_ANALOG_ADC_1 ... NAU8825_REG_MIC_BIAS:
+	case NAU8825_REG_BOOST ... NAU8825_REG_FEPGA:
+	case NAU8825_REG_POWER_UP_CONTROL ... NAU8825_REG_CHARGE_PUMP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool nau8825_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8825_REG_RESET:
+	case NAU8825_REG_IRQ_STATUS:
+	case NAU8825_REG_INT_CLR_KEY_STATUS:
+	case NAU8825_REG_IMM_RMS_L:
+	case NAU8825_REG_IMM_RMS_R:
+	case NAU8825_REG_I2C_DEVICE_ID:
+	case NAU8825_REG_SARDOUT_RAM_STATUS:
+	case NAU8825_REG_CHARGE_PUMP_INPUT_READ:
+	case NAU8825_REG_GENERAL_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int nau8825_pump_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* Prevent startup click by letting charge pump to ramp up */
+		msleep(10);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const char * const nau8825_adc_decimation[] = {
+	"32", "64", "128", "256"
+};
+
+static const struct soc_enum nau8825_adc_decimation_enum =
+	SOC_ENUM_SINGLE(NAU8825_REG_ADC_RATE, NAU8825_ADC_SYNC_DOWN_SFT,
+		ARRAY_SIZE(nau8825_adc_decimation), nau8825_adc_decimation);
+
+static const char * const nau8825_dac_oversampl[] = {
+	"64", "256", "128", "", "32"
+};
+
+static const struct soc_enum nau8825_dac_oversampl_enum =
+	SOC_ENUM_SINGLE(NAU8825_REG_DAC_CTRL1, NAU8825_DAC_OVERSAMPLE_SFT,
+		ARRAY_SIZE(nau8825_dac_oversampl), nau8825_dac_oversampl);
+
+static const DECLARE_TLV_DB_MINMAX_MUTE(adc_vol_tlv, -10300, 2400);
+static const DECLARE_TLV_DB_MINMAX_MUTE(sidetone_vol_tlv, -4200, 0);
+static const DECLARE_TLV_DB_MINMAX(dac_vol_tlv, -5400, 0);
+static const DECLARE_TLV_DB_MINMAX(fepga_gain_tlv, -100, 3600);
+static const DECLARE_TLV_DB_MINMAX_MUTE(crosstalk_vol_tlv, -9600, 2400);
+
+static const struct snd_kcontrol_new nau8825_controls[] = {
+	SOC_SINGLE_TLV("Mic Volume", NAU8825_REG_ADC_DGAIN_CTRL,
+		0, 0xff, 0, adc_vol_tlv),
+	SOC_DOUBLE_TLV("Headphone Bypass Volume", NAU8825_REG_ADC_DGAIN_CTRL,
+		12, 8, 0x0f, 0, sidetone_vol_tlv),
+	SOC_DOUBLE_TLV("Headphone Volume", NAU8825_REG_HSVOL_CTRL,
+		6, 0, 0x3f, 1, dac_vol_tlv),
+	SOC_SINGLE_TLV("Frontend PGA Volume", NAU8825_REG_POWER_UP_CONTROL,
+		8, 37, 0, fepga_gain_tlv),
+	SOC_DOUBLE_TLV("Headphone Crosstalk Volume", NAU8825_REG_DAC_DGAIN_CTRL,
+		0, 8, 0xff, 0, crosstalk_vol_tlv),
+
+	SOC_ENUM("ADC Decimation Rate", nau8825_adc_decimation_enum),
+	SOC_ENUM("DAC Oversampling Rate", nau8825_dac_oversampl_enum),
+};
+
+/* DAC Mux 0x33[9] and 0x34[9] */
+static const char * const nau8825_dac_src[] = {
+	"DACL", "DACR",
+};
+
+static SOC_ENUM_SINGLE_DECL(
+	nau8825_dacl_enum, NAU8825_REG_DACL_CTRL,
+	NAU8825_DACL_CH_SEL_SFT, nau8825_dac_src);
+
+static SOC_ENUM_SINGLE_DECL(
+	nau8825_dacr_enum, NAU8825_REG_DACR_CTRL,
+	NAU8825_DACR_CH_SEL_SFT, nau8825_dac_src);
+
+static const struct snd_kcontrol_new nau8825_dacl_mux =
+	SOC_DAPM_ENUM("DACL Source", nau8825_dacl_enum);
+
+static const struct snd_kcontrol_new nau8825_dacr_mux =
+	SOC_DAPM_ENUM("DACR Source", nau8825_dacr_enum);
+
+
+static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_OUT("AIFTX", "Capture", 0, NAU8825_REG_I2S_PCM_CTRL2,
+		15, 1),
+
+	SND_SOC_DAPM_INPUT("MIC"),
+	SND_SOC_DAPM_MICBIAS("MICBIAS", NAU8825_REG_MIC_BIAS, 8, 0),
+
+	SND_SOC_DAPM_PGA("Frontend PGA", NAU8825_REG_POWER_UP_CONTROL, 14, 0,
+		NULL, 0),
+
+	SND_SOC_DAPM_ADC("ADC", NULL, NAU8825_REG_ENA_CTRL, 8, 0),
+	SND_SOC_DAPM_SUPPLY("ADC Clock", NAU8825_REG_ENA_CTRL, 7, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC Power", NAU8825_REG_ANALOG_ADC_2, 6, 0, NULL,
+		0),
+
+	/* ADC for button press detection */
+	SND_SOC_DAPM_ADC("SAR", NULL, NAU8825_REG_SAR_CTRL,
+		NAU8825_SAR_ADC_EN_SFT, 0),
+
+	SND_SOC_DAPM_DAC("ADACL", NULL, NAU8825_REG_RDAC, 12, 0),
+	SND_SOC_DAPM_DAC("ADACR", NULL, NAU8825_REG_RDAC, 13, 0),
+	SND_SOC_DAPM_SUPPLY("ADACL Clock", NAU8825_REG_RDAC, 8, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADACR Clock", NAU8825_REG_RDAC, 9, 0, NULL, 0),
+
+	SND_SOC_DAPM_DAC("DDACR", NULL, NAU8825_REG_ENA_CTRL,
+		NAU8825_ENABLE_DACR_SFT, 0),
+	SND_SOC_DAPM_DAC("DDACL", NULL, NAU8825_REG_ENA_CTRL,
+		NAU8825_ENABLE_DACL_SFT, 0),
+	SND_SOC_DAPM_SUPPLY("DDAC Clock", NAU8825_REG_ENA_CTRL, 6, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("DACL Mux", SND_SOC_NOPM, 0, 0, &nau8825_dacl_mux),
+	SND_SOC_DAPM_MUX("DACR Mux", SND_SOC_NOPM, 0, 0, &nau8825_dacr_mux),
+
+	SND_SOC_DAPM_PGA("HP amp L", NAU8825_REG_CLASSG_CTRL, 1, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("HP amp R", NAU8825_REG_CLASSG_CTRL, 2, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("HP amp power", NAU8825_REG_CLASSG_CTRL, 0, 0, NULL,
+		0),
+
+	SND_SOC_DAPM_SUPPLY("Charge Pump", NAU8825_REG_CHARGE_PUMP, 5, 0,
+		nau8825_pump_event, SND_SOC_DAPM_POST_PMU),
+
+	SND_SOC_DAPM_PGA("Output Driver R Stage 1",
+		NAU8825_REG_POWER_UP_CONTROL, 5, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Output Driver L Stage 1",
+		NAU8825_REG_POWER_UP_CONTROL, 4, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Output Driver R Stage 2",
+		NAU8825_REG_POWER_UP_CONTROL, 3, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Output Driver L Stage 2",
+		NAU8825_REG_POWER_UP_CONTROL, 2, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_S("Output Driver R Stage 3", 1,
+		NAU8825_REG_POWER_UP_CONTROL, 1, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_S("Output Driver L Stage 3", 1,
+		NAU8825_REG_POWER_UP_CONTROL, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_PGA_S("Output DACL", 2, NAU8825_REG_CHARGE_PUMP, 8, 1, NULL, 0),
+	SND_SOC_DAPM_PGA_S("Output DACR", 2, NAU8825_REG_CHARGE_PUMP, 9, 1, NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("HPOL"),
+	SND_SOC_DAPM_OUTPUT("HPOR"),
+};
+
+static const struct snd_soc_dapm_route nau8825_dapm_routes[] = {
+	{"Frontend PGA", NULL, "MIC"},
+	{"ADC", NULL, "Frontend PGA"},
+	{"ADC", NULL, "ADC Clock"},
+	{"ADC", NULL, "ADC Power"},
+	{"AIFTX", NULL, "ADC"},
+
+	{"DDACL", NULL, "Playback"},
+	{"DDACR", NULL, "Playback"},
+	{"DDACL", NULL, "DDAC Clock"},
+	{"DDACR", NULL, "DDAC Clock"},
+	{"DACL Mux", "DACL", "DDACL"},
+	{"DACL Mux", "DACR", "DDACR"},
+	{"DACR Mux", "DACL", "DDACL"},
+	{"DACR Mux", "DACR", "DDACR"},
+	{"HP amp L", NULL, "DACL Mux"},
+	{"HP amp R", NULL, "DACR Mux"},
+	{"HP amp L", NULL, "HP amp power"},
+	{"HP amp R", NULL, "HP amp power"},
+	{"ADACL", NULL, "HP amp L"},
+	{"ADACR", NULL, "HP amp R"},
+	{"ADACL", NULL, "ADACL Clock"},
+	{"ADACR", NULL, "ADACR Clock"},
+	{"Output Driver L Stage 1", NULL, "ADACL"},
+	{"Output Driver R Stage 1", NULL, "ADACR"},
+	{"Output Driver L Stage 2", NULL, "Output Driver L Stage 1"},
+	{"Output Driver R Stage 2", NULL, "Output Driver R Stage 1"},
+	{"Output Driver L Stage 3", NULL, "Output Driver L Stage 2"},
+	{"Output Driver R Stage 3", NULL, "Output Driver R Stage 2"},
+	{"Output DACL", NULL, "Output Driver L Stage 3"},
+	{"Output DACR", NULL, "Output Driver R Stage 3"},
+	{"HPOL", NULL, "Output DACL"},
+	{"HPOR", NULL, "Output DACR"},
+	{"HPOL", NULL, "Charge Pump"},
+	{"HPOR", NULL, "Charge Pump"},
+};
+
+static int nau8825_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val_len = 0;
+
+	switch (params_width(params)) {
+	case 16:
+		val_len |= NAU8825_I2S_DL_16;
+		break;
+	case 20:
+		val_len |= NAU8825_I2S_DL_20;
+		break;
+	case 24:
+		val_len |= NAU8825_I2S_DL_24;
+		break;
+	case 32:
+		val_len |= NAU8825_I2S_DL_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL1,
+		NAU8825_I2S_DL_MASK, val_len);
+
+	return 0;
+}
+
+static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+	unsigned int ctrl1_val = 0, ctrl2_val = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		ctrl2_val |= NAU8825_I2S_MS_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		ctrl1_val |= NAU8825_I2S_BP_INV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		ctrl1_val |= NAU8825_I2S_DF_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		ctrl1_val |= NAU8825_I2S_DF_LEFT;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		ctrl1_val |= NAU8825_I2S_DF_RIGTH;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		ctrl1_val |= NAU8825_I2S_DF_PCM_AB;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		ctrl1_val |= NAU8825_I2S_DF_PCM_AB;
+		ctrl1_val |= NAU8825_I2S_PCMB_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL1,
+		NAU8825_I2S_DL_MASK | NAU8825_I2S_DF_MASK |
+		NAU8825_I2S_BP_MASK | NAU8825_I2S_PCMB_MASK,
+		ctrl1_val);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK, ctrl2_val);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops nau8825_dai_ops = {
+	.hw_params	= nau8825_hw_params,
+	.set_fmt	= nau8825_set_dai_fmt,
+};
+
+#define NAU8825_RATES	SNDRV_PCM_RATE_8000_192000
+#define NAU8825_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
+			 | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver nau8825_dai = {
+	.name = "nau8825-hifi",
+	.playback = {
+		.stream_name	 = "Playback",
+		.channels_min	 = 1,
+		.channels_max	 = 2,
+		.rates		 = NAU8825_RATES,
+		.formats	 = NAU8825_FORMATS,
+	},
+	.capture = {
+		.stream_name	 = "Capture",
+		.channels_min	 = 1,
+		.channels_max	 = 1,
+		.rates		 = NAU8825_RATES,
+		.formats	 = NAU8825_FORMATS,
+	},
+	.ops = &nau8825_dai_ops,
+};
+
+/**
+ * nau8825_enable_jack_detect - Specify a jack for event reporting
+ *
+ * @component:  component to register the jack with
+ * @jack: jack to use to report headset and button events on
+ *
+ * After this function has been called the headset insert/remove and button
+ * events will be routed to the given jack.  Jack can be null to stop
+ * reporting.
+ */
+int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
+				struct snd_soc_jack *jack)
+{
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+	struct regmap *regmap = nau8825->regmap;
+
+	nau8825->jack = jack;
+
+	/* Ground HP Outputs[1:0], needed for headset auto detection
+	 * Enable Automatic Mic/Gnd switching reading on insert interrupt[6]
+	 */
+	regmap_update_bits(regmap, NAU8825_REG_HSD_CTRL,
+		NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L,
+		NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L);
+
+	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
+		NAU8825_IRQ_HEADSET_COMPLETE_EN | NAU8825_IRQ_EJECT_EN, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nau8825_enable_jack_detect);
+
+
+static bool nau8825_is_jack_inserted(struct regmap *regmap)
+{
+	int status;
+
+	regmap_read(regmap, NAU8825_REG_I2C_DEVICE_ID, &status);
+	return !(status & NAU8825_GPIO2JD1);
+}
+
+static void nau8825_restart_jack_detection(struct regmap *regmap)
+{
+	/* this will restart the entire jack detection process including MIC/GND
+	 * switching and create interrupts. We have to go from 0 to 1 and back
+	 * to 0 to restart.
+	 */
+	regmap_update_bits(regmap, NAU8825_REG_JACK_DET_CTRL,
+		NAU8825_JACK_DET_RESTART, NAU8825_JACK_DET_RESTART);
+	regmap_update_bits(regmap, NAU8825_REG_JACK_DET_CTRL,
+		NAU8825_JACK_DET_RESTART, 0);
+}
+
+static void nau8825_eject_jack(struct nau8825 *nau8825)
+{
+	struct snd_soc_dapm_context *dapm = nau8825->dapm;
+	struct regmap *regmap = nau8825->regmap;
+
+	snd_soc_dapm_disable_pin(dapm, "SAR");
+	snd_soc_dapm_disable_pin(dapm, "MICBIAS");
+	/* Detach 2kOhm Resistors from MICBIAS to MICGND1/2 */
+	regmap_update_bits(regmap, NAU8825_REG_MIC_BIAS,
+		NAU8825_MICBIAS_JKSLV | NAU8825_MICBIAS_JKR2, 0);
+	/* ground HPL/HPR, MICGRND1/2 */
+	regmap_update_bits(regmap, NAU8825_REG_HSD_CTRL, 0xf, 0xf);
+
+	snd_soc_dapm_sync(dapm);
+}
+
+static int nau8825_button_decode(int value)
+{
+	int buttons = 0;
+
+	/* The chip supports up to 8 buttons, but ALSA defines only 6 buttons */
+	if (value & BIT(0))
+		buttons |= SND_JACK_BTN_0;
+	if (value & BIT(1))
+		buttons |= SND_JACK_BTN_1;
+	if (value & BIT(2))
+		buttons |= SND_JACK_BTN_2;
+	if (value & BIT(3))
+		buttons |= SND_JACK_BTN_3;
+	if (value & BIT(4))
+		buttons |= SND_JACK_BTN_4;
+	if (value & BIT(5))
+		buttons |= SND_JACK_BTN_5;
+
+	return buttons;
+}
+
+static int nau8825_jack_insert(struct nau8825 *nau8825)
+{
+	struct regmap *regmap = nau8825->regmap;
+	struct snd_soc_dapm_context *dapm = nau8825->dapm;
+	int jack_status_reg, mic_detected;
+	int type = 0;
+
+	regmap_read(regmap, NAU8825_REG_GENERAL_STATUS, &jack_status_reg);
+	mic_detected = (jack_status_reg >> 10) & 3;
+
+	switch (mic_detected) {
+	case 0:
+		/* no mic */
+		type = SND_JACK_HEADPHONE;
+		break;
+	case 1:
+		dev_dbg(nau8825->dev, "OMTP (micgnd1) mic connected\n");
+		type = SND_JACK_HEADSET;
+
+		/* Unground MICGND1 */
+		regmap_update_bits(regmap, NAU8825_REG_HSD_CTRL, 3 << 2,
+			1 << 2);
+		/* Attach 2kOhm Resistor from MICBIAS to MICGND1 */
+		regmap_update_bits(regmap, NAU8825_REG_MIC_BIAS,
+			NAU8825_MICBIAS_JKSLV | NAU8825_MICBIAS_JKR2,
+			NAU8825_MICBIAS_JKR2);
+		/* Attach SARADC to MICGND1 */
+		regmap_update_bits(regmap, NAU8825_REG_SAR_CTRL,
+			NAU8825_SAR_INPUT_MASK,
+			NAU8825_SAR_INPUT_JKR2);
+
+		snd_soc_dapm_force_enable_pin(dapm, "MICBIAS");
+		snd_soc_dapm_force_enable_pin(dapm, "SAR");
+		snd_soc_dapm_sync(dapm);
+		break;
+	case 2:
+	case 3:
+		dev_dbg(nau8825->dev, "CTIA (micgnd2) mic connected\n");
+		type = SND_JACK_HEADSET;
+
+		/* Unground MICGND2 */
+		regmap_update_bits(regmap, NAU8825_REG_HSD_CTRL, 3 << 2,
+			2 << 2);
+		/* Attach 2kOhm Resistor from MICBIAS to MICGND2 */
+		regmap_update_bits(regmap, NAU8825_REG_MIC_BIAS,
+			NAU8825_MICBIAS_JKSLV | NAU8825_MICBIAS_JKR2,
+			NAU8825_MICBIAS_JKSLV);
+		/* Attach SARADC to MICGND2 */
+		regmap_update_bits(regmap, NAU8825_REG_SAR_CTRL,
+			NAU8825_SAR_INPUT_MASK,
+			NAU8825_SAR_INPUT_JKSLV);
+
+		snd_soc_dapm_force_enable_pin(dapm, "MICBIAS");
+		snd_soc_dapm_force_enable_pin(dapm, "SAR");
+		snd_soc_dapm_sync(dapm);
+		break;
+	}
+
+	if (type & SND_JACK_HEADPHONE) {
+		/* Unground HPL/R */
+		regmap_update_bits(regmap, NAU8825_REG_HSD_CTRL, 0x3, 0);
+	}
+
+	return type;
+}
+
+#define NAU8825_BUTTONS (SND_JACK_BTN_0 | SND_JACK_BTN_1 | \
+		SND_JACK_BTN_2 | SND_JACK_BTN_3)
+
+static irqreturn_t nau8825_interrupt(int irq, void *data)
+{
+	struct nau8825 *nau8825 = (struct nau8825 *)data;
+	struct regmap *regmap = nau8825->regmap;
+	int active_irq, clear_irq = 0, event = 0, event_mask = 0;
+
+	regmap_read(regmap, NAU8825_REG_IRQ_STATUS, &active_irq);
+
+	if ((active_irq & NAU8825_JACK_EJECTION_IRQ_MASK) ==
+		NAU8825_JACK_EJECTION_DETECTED) {
+
+		nau8825_eject_jack(nau8825);
+		event_mask |= SND_JACK_HEADSET;
+		clear_irq = NAU8825_JACK_EJECTION_IRQ_MASK;
+	} else if (active_irq & NAU8825_KEY_SHORT_PRESS_IRQ) {
+		int key_status;
+
+		regmap_read(regmap, NAU8825_REG_INT_CLR_KEY_STATUS,
+			&key_status);
+
+		/* upper 8 bits of the register are for short pressed keys,
+		 * lower 8 bits - for long pressed buttons
+		 */
+		nau8825->button_pressed = nau8825_button_decode(
+			key_status >> 8);
+
+		event |= nau8825->button_pressed;
+		event_mask |= NAU8825_BUTTONS;
+		clear_irq = NAU8825_KEY_SHORT_PRESS_IRQ;
+	} else if (active_irq & NAU8825_KEY_RELEASE_IRQ) {
+		event_mask = NAU8825_BUTTONS;
+		clear_irq = NAU8825_KEY_RELEASE_IRQ;
+	} else if (active_irq & NAU8825_HEADSET_COMPLETION_IRQ) {
+		if (nau8825_is_jack_inserted(regmap)) {
+			event |= nau8825_jack_insert(nau8825);
+		} else {
+			dev_warn(nau8825->dev, "Headset completion IRQ fired but no headset connected\n");
+			nau8825_eject_jack(nau8825);
+		}
+
+		event_mask |= SND_JACK_HEADSET;
+		clear_irq = NAU8825_HEADSET_COMPLETION_IRQ;
+	}
+
+	if (!clear_irq)
+		clear_irq = active_irq;
+	/* clears the rightmost interruption */
+	regmap_write(regmap, NAU8825_REG_INT_CLR_KEY_STATUS, clear_irq);
+
+	if (event_mask)
+		snd_soc_jack_report(nau8825->jack, event, event_mask);
+
+	return IRQ_HANDLED;
+}
+
+static void nau8825_setup_buttons(struct nau8825 *nau8825)
+{
+	struct regmap *regmap = nau8825->regmap;
+
+	regmap_update_bits(regmap, NAU8825_REG_SAR_CTRL,
+		NAU8825_SAR_TRACKING_GAIN_MASK,
+		nau8825->sar_voltage << NAU8825_SAR_TRACKING_GAIN_SFT);
+	regmap_update_bits(regmap, NAU8825_REG_SAR_CTRL,
+		NAU8825_SAR_COMPARE_TIME_MASK,
+		nau8825->sar_compare_time << NAU8825_SAR_COMPARE_TIME_SFT);
+	regmap_update_bits(regmap, NAU8825_REG_SAR_CTRL,
+		NAU8825_SAR_SAMPLING_TIME_MASK,
+		nau8825->sar_sampling_time << NAU8825_SAR_SAMPLING_TIME_SFT);
+
+	regmap_update_bits(regmap, NAU8825_REG_KEYDET_CTRL,
+		NAU8825_KEYDET_LEVELS_NR_MASK,
+		(nau8825->sar_threshold_num - 1) << NAU8825_KEYDET_LEVELS_NR_SFT);
+	regmap_update_bits(regmap, NAU8825_REG_KEYDET_CTRL,
+		NAU8825_KEYDET_HYSTERESIS_MASK,
+		nau8825->sar_hysteresis << NAU8825_KEYDET_HYSTERESIS_SFT);
+	regmap_update_bits(regmap, NAU8825_REG_KEYDET_CTRL,
+		NAU8825_KEYDET_SHORTKEY_DEBOUNCE_MASK,
+		nau8825->key_debounce << NAU8825_KEYDET_SHORTKEY_DEBOUNCE_SFT);
+
+	regmap_write(regmap, NAU8825_REG_VDET_THRESHOLD_1,
+		(nau8825->sar_threshold[0] << 8) | nau8825->sar_threshold[1]);
+	regmap_write(regmap, NAU8825_REG_VDET_THRESHOLD_2,
+		(nau8825->sar_threshold[2] << 8) | nau8825->sar_threshold[3]);
+	regmap_write(regmap, NAU8825_REG_VDET_THRESHOLD_3,
+		(nau8825->sar_threshold[4] << 8) | nau8825->sar_threshold[5]);
+	regmap_write(regmap, NAU8825_REG_VDET_THRESHOLD_4,
+		(nau8825->sar_threshold[6] << 8) | nau8825->sar_threshold[7]);
+
+	/* Enable short press and release interruptions */
+	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
+		NAU8825_IRQ_KEY_SHORT_PRESS_EN | NAU8825_IRQ_KEY_RELEASE_EN,
+		0);
+}
+
+static void nau8825_init_regs(struct nau8825 *nau8825)
+{
+	struct regmap *regmap = nau8825->regmap;
+
+	/* Enable Bias/Vmid */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
+		NAU8825_BIAS_VMID, NAU8825_BIAS_VMID);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
+		NAU8825_GLOBAL_BIAS_EN, NAU8825_GLOBAL_BIAS_EN);
+
+	/* VMID Tieoff */
+	regmap_update_bits(regmap, NAU8825_REG_BIAS_ADJ,
+		NAU8825_BIAS_VMID_SEL_MASK,
+		nau8825->vref_impedance << NAU8825_BIAS_VMID_SEL_SFT);
+	/* Disable Boost Driver, Automatic Short circuit protection enable */
+	regmap_update_bits(regmap, NAU8825_REG_BOOST,
+		NAU8825_PRECHARGE_DIS | NAU8825_HP_BOOST_G_DIS |
+		NAU8825_SHORT_SHUTDOWN_EN,
+		NAU8825_PRECHARGE_DIS | NAU8825_HP_BOOST_G_DIS |
+		NAU8825_SHORT_SHUTDOWN_EN);
+
+	regmap_update_bits(regmap, NAU8825_REG_GPIO12_CTRL,
+		NAU8825_JKDET_OUTPUT_EN,
+		nau8825->jkdet_enable ? 0 : NAU8825_JKDET_OUTPUT_EN);
+	regmap_update_bits(regmap, NAU8825_REG_GPIO12_CTRL,
+		NAU8825_JKDET_PULL_EN,
+		nau8825->jkdet_pull_enable ? 0 : NAU8825_JKDET_PULL_EN);
+	regmap_update_bits(regmap, NAU8825_REG_GPIO12_CTRL,
+		NAU8825_JKDET_PULL_UP,
+		nau8825->jkdet_pull_up ? NAU8825_JKDET_PULL_UP : 0);
+	regmap_update_bits(regmap, NAU8825_REG_JACK_DET_CTRL,
+		NAU8825_JACK_POLARITY,
+		/* jkdet_polarity - 1  is for active-low */
+		nau8825->jkdet_polarity ? 0 : NAU8825_JACK_POLARITY);
+
+	regmap_update_bits(regmap, NAU8825_REG_JACK_DET_CTRL,
+		NAU8825_JACK_INSERT_DEBOUNCE_MASK,
+		nau8825->jack_insert_debounce << NAU8825_JACK_INSERT_DEBOUNCE_SFT);
+	regmap_update_bits(regmap, NAU8825_REG_JACK_DET_CTRL,
+		NAU8825_JACK_EJECT_DEBOUNCE_MASK,
+		nau8825->jack_eject_debounce << NAU8825_JACK_EJECT_DEBOUNCE_SFT);
+
+	/* Mask unneeded IRQs: 1 - disable, 0 - enable */
+	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK, 0x7ff, 0x7ff);
+
+	regmap_update_bits(regmap, NAU8825_REG_MIC_BIAS,
+		NAU8825_MICBIAS_VOLTAGE_MASK, nau8825->micbias_voltage);
+
+	if (nau8825->sar_threshold_num)
+		nau8825_setup_buttons(nau8825);
+
+	/* Default oversampling/decimations settings are unusable
+	 * (audible hiss). Set it to something better.
+	 */
+	regmap_update_bits(regmap, NAU8825_REG_ADC_RATE,
+		NAU8825_ADC_SYNC_DOWN_MASK, NAU8825_ADC_SYNC_DOWN_128);
+	regmap_update_bits(regmap, NAU8825_REG_DAC_CTRL1,
+		NAU8825_DAC_OVERSAMPLE_MASK, NAU8825_DAC_OVERSAMPLE_128);
+}
+
+static const struct regmap_config nau8825_regmap_config = {
+	.val_bits = 16,
+	.reg_bits = 16,
+
+	.max_register = NAU8825_REG_MAX,
+	.readable_reg = nau8825_readable_reg,
+	.writeable_reg = nau8825_writeable_reg,
+	.volatile_reg = nau8825_volatile_reg,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = nau8825_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(nau8825_reg_defaults),
+};
+
+static int nau8825_codec_probe(struct snd_soc_codec *codec)
+{
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+
+	nau8825->dapm = dapm;
+
+	/* The interrupt clock is gated by x1[10:8],
+	 * one of them needs to be enabled all the time for
+	 * interrupts to happen.
+	 */
+	snd_soc_dapm_force_enable_pin(dapm, "DDACR");
+	snd_soc_dapm_sync(dapm);
+
+	/* Unmask interruptions. Handler uses dapm object so we can enable
+	 * interruptions only after dapm is fully initialized.
+	 */
+	regmap_write(nau8825->regmap, NAU8825_REG_INTERRUPT_DIS_CTRL, 0);
+	nau8825_restart_jack_detection(nau8825->regmap);
+
+	return 0;
+}
+
+static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
+	unsigned int freq)
+{
+	struct regmap *regmap = nau8825->regmap;
+	int ret;
+
+	switch (clk_id) {
+	case NAU8825_CLK_MCLK:
+		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
+			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_MCLK);
+		regmap_update_bits(regmap, NAU8825_REG_FLL6, NAU8825_DCO_EN, 0);
+
+		/* We selected MCLK source but the clock itself managed externally */
+		if (!nau8825->mclk)
+			break;
+
+		if (!nau8825->mclk_freq) {
+			ret = clk_prepare_enable(nau8825->mclk);
+			if (ret) {
+				dev_err(nau8825->dev, "Unable to prepare codec mclk\n");
+				return ret;
+			}
+		}
+
+		if (nau8825->mclk_freq != freq) {
+			nau8825->mclk_freq = freq;
+
+			freq = clk_round_rate(nau8825->mclk, freq);
+			ret = clk_set_rate(nau8825->mclk, freq);
+			if (ret) {
+				dev_err(nau8825->dev, "Unable to set mclk rate\n");
+				return ret;
+			}
+		}
+
+		break;
+	case NAU8825_CLK_INTERNAL:
+		regmap_update_bits(regmap, NAU8825_REG_FLL6, NAU8825_DCO_EN,
+			NAU8825_DCO_EN);
+		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
+			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_VCO);
+
+		if (nau8825->mclk_freq) {
+			clk_disable_unprepare(nau8825->mclk);
+			nau8825->mclk_freq = 0;
+		}
+
+		break;
+	default:
+		dev_err(nau8825->dev, "Invalid clock id (%d)\n", clk_id);
+		return -EINVAL;
+	}
+
+	dev_dbg(nau8825->dev, "Sysclk is %dHz and clock id is %d\n", freq,
+		clk_id);
+	return 0;
+}
+
+static int nau8825_set_sysclk(struct snd_soc_codec *codec, int clk_id,
+	int source, unsigned int freq, int dir)
+{
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	return nau8825_configure_sysclk(nau8825, clk_id, freq);
+}
+
+static int nau8825_set_bias_level(struct snd_soc_codec *codec,
+				   enum snd_soc_bias_level level)
+{
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+
+	case SND_SOC_BIAS_PREPARE:
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+			if (nau8825->mclk_freq) {
+				ret = clk_prepare_enable(nau8825->mclk);
+				if (ret) {
+					dev_err(nau8825->dev, "Unable to prepare codec mclk\n");
+					return ret;
+				}
+			}
+
+			ret = regcache_sync(nau8825->regmap);
+			if (ret) {
+				dev_err(codec->dev,
+					"Failed to sync cache: %d\n", ret);
+				return ret;
+			}
+		}
+
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		if (nau8825->mclk_freq)
+			clk_disable_unprepare(nau8825->mclk);
+
+		regcache_mark_dirty(nau8825->regmap);
+		break;
+	}
+	return 0;
+}
+
+static struct snd_soc_codec_driver nau8825_codec_driver = {
+	.probe = nau8825_codec_probe,
+	.set_sysclk = nau8825_set_sysclk,
+	.set_bias_level = nau8825_set_bias_level,
+	.suspend_bias_off = true,
+
+	.controls = nau8825_controls,
+	.num_controls = ARRAY_SIZE(nau8825_controls),
+	.dapm_widgets = nau8825_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(nau8825_dapm_widgets),
+	.dapm_routes = nau8825_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(nau8825_dapm_routes),
+};
+
+static void nau8825_reset_chip(struct regmap *regmap)
+{
+	regmap_write(regmap, NAU8825_REG_RESET, 0x00);
+	regmap_write(regmap, NAU8825_REG_RESET, 0x00);
+}
+
+static int nau8825_read_device_properties(struct device *dev,
+	struct nau8825 *nau8825) {
+
+	nau8825->jkdet_enable = device_property_read_bool(dev,
+		"nuvoton,jkdet-enable");
+	nau8825->jkdet_pull_enable = device_property_read_bool(dev,
+		"nuvoton,jkdet-pull-enable");
+	nau8825->jkdet_pull_up = device_property_read_bool(dev,
+		"nuvoton,jkdet-pull-up");
+	device_property_read_u32(dev, "nuvoton,jkdet-polarity",
+		&nau8825->jkdet_polarity);
+	device_property_read_u32(dev, "nuvoton,micbias-voltage",
+		&nau8825->micbias_voltage);
+	device_property_read_u32(dev, "nuvoton,vref-impedance",
+		&nau8825->vref_impedance);
+	device_property_read_u32(dev, "nuvoton,sar-threshold-num",
+		&nau8825->sar_threshold_num);
+	device_property_read_u32_array(dev, "nuvoton,sar-threshold",
+		nau8825->sar_threshold, nau8825->sar_threshold_num);
+	device_property_read_u32(dev, "nuvoton,sar-hysteresis",
+		&nau8825->sar_hysteresis);
+	device_property_read_u32(dev, "nuvoton,sar-voltage",
+		&nau8825->sar_voltage);
+	device_property_read_u32(dev, "nuvoton,sar-compare-time",
+		&nau8825->sar_compare_time);
+	device_property_read_u32(dev, "nuvoton,sar-sampling-time",
+		&nau8825->sar_sampling_time);
+	device_property_read_u32(dev, "nuvoton,short-key-debounce",
+		&nau8825->key_debounce);
+	device_property_read_u32(dev, "nuvoton,jack-insert-debounce",
+		&nau8825->jack_insert_debounce);
+	device_property_read_u32(dev, "nuvoton,jack-eject-debounce",
+		&nau8825->jack_eject_debounce);
+
+	nau8825->mclk = devm_clk_get(dev, "mclk");
+	if (PTR_ERR(nau8825->mclk) == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (PTR_ERR(nau8825->mclk) == -ENOENT) {
+		/* The MCLK is managed externally or not used at all */
+		nau8825->mclk = NULL;
+		dev_info(dev, "No 'mclk' clock found, assume MCLK is managed externally");
+	} else if (IS_ERR(nau8825->mclk)) {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nau8825_setup_irq(struct nau8825 *nau8825)
+{
+	struct regmap *regmap = nau8825->regmap;
+	int ret;
+
+	/* IRQ Output Enable */
+	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
+		NAU8825_IRQ_OUTPUT_EN, NAU8825_IRQ_OUTPUT_EN);
+
+	/* Enable internal VCO needed for interruptions */
+	nau8825_configure_sysclk(nau8825, NAU8825_CLK_INTERNAL, 0);
+
+	/* Enable DDACR needed for interrupts
+	 * It is the same as force_enable_pin("DDACR") we do later
+	 */
+	regmap_update_bits(regmap, NAU8825_REG_ENA_CTRL,
+		NAU8825_ENABLE_DACR, NAU8825_ENABLE_DACR);
+
+	/* Chip needs one FSCLK cycle in order to generate interrupts,
+	 * as we cannot guarantee one will be provided by the system. Turning
+	 * master mode on then off enables us to generate that FSCLK cycle
+	 * with a minimum of contention on the clock bus.
+	 */
+	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_MASTER);
+	regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
+		NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_SLAVE);
+
+	ret = devm_request_threaded_irq(nau8825->dev, nau8825->irq, NULL,
+		nau8825_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+		"nau8825", nau8825);
+
+	if (ret) {
+		dev_err(nau8825->dev, "Cannot request irq %d (%d)\n",
+			nau8825->irq, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int nau8825_i2c_probe(struct i2c_client *i2c,
+	const struct i2c_device_id *id)
+{
+	struct device *dev = &i2c->dev;
+	struct nau8825 *nau8825 = dev_get_platdata(&i2c->dev);
+	int ret, value;
+
+	if (!nau8825) {
+		nau8825 = devm_kzalloc(dev, sizeof(*nau8825), GFP_KERNEL);
+		if (!nau8825)
+			return -ENOMEM;
+		ret = nau8825_read_device_properties(dev, nau8825);
+		if (ret)
+			return ret;
+	}
+
+	i2c_set_clientdata(i2c, nau8825);
+
+	nau8825->regmap = devm_regmap_init_i2c(i2c, &nau8825_regmap_config);
+	if (IS_ERR(nau8825->regmap))
+		return PTR_ERR(nau8825->regmap);
+	nau8825->dev = dev;
+	nau8825->irq = i2c->irq;
+
+	nau8825_reset_chip(nau8825->regmap);
+	ret = regmap_read(nau8825->regmap, NAU8825_REG_I2C_DEVICE_ID, &value);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read device id from the NAU8825: %d\n",
+			ret);
+		return ret;
+	}
+	if ((value & NAU8825_SOFTWARE_ID_MASK) !=
+			NAU8825_SOFTWARE_ID_NAU8825) {
+		dev_err(dev, "Not a NAU8825 chip\n");
+		return -ENODEV;
+	}
+
+	nau8825_init_regs(nau8825);
+
+	if (i2c->irq)
+		nau8825_setup_irq(nau8825);
+
+	return snd_soc_register_codec(&i2c->dev, &nau8825_codec_driver,
+		&nau8825_dai, 1);
+}
+
+static int nau8825_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static const struct i2c_device_id nau8825_i2c_ids[] = {
+	{ "nau8825", 0 },
+	{ }
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id nau8825_of_ids[] = {
+	{ .compatible = "nuvoton,nau8825", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, nau8825_of_ids);
+#endif
+
+static struct i2c_driver nau8825_driver = {
+	.driver = {
+		.name = "nau8825",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(nau8825_of_ids),
+	},
+	.probe = nau8825_i2c_probe,
+	.remove = nau8825_i2c_remove,
+	.id_table = nau8825_i2c_ids,
+};
+module_i2c_driver(nau8825_driver);
+
+MODULE_DESCRIPTION("ASoC nau8825 driver");
+MODULE_AUTHOR("Anatol Pomozov <anatol@chromium.org>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
new file mode 100644
index 0000000..8774923
--- /dev/null
+++ b/sound/soc/codecs/nau8825.h
@@ -0,0 +1,323 @@
+/*
+ * NAU8825 ALSA SoC audio driver
+ *
+ * Copyright 2015 Google Inc.
+ * Author: Anatol Pomozov <anatol.pomozov@chrominium.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __NAU8825_H__
+#define __NAU8825_H__
+
+#define NAU8825_REG_RESET		0x00
+#define NAU8825_REG_ENA_CTRL		0x01
+#define NAU8825_REG_CLK_DIVIDER		0x03
+#define NAU8825_REG_FLL1		0x04
+#define NAU8825_REG_FLL2		0x05
+#define NAU8825_REG_FLL3		0x06
+#define NAU8825_REG_FLL4		0x07
+#define NAU8825_REG_FLL5		0x08
+#define NAU8825_REG_FLL6		0x09
+#define NAU8825_REG_FLL_VCO_RSV		0x0a
+#define NAU8825_REG_HSD_CTRL		0x0c
+#define NAU8825_REG_JACK_DET_CTRL		0x0d
+#define NAU8825_REG_INTERRUPT_MASK		0x0f
+#define NAU8825_REG_IRQ_STATUS		0x10
+#define NAU8825_REG_INT_CLR_KEY_STATUS		0x11
+#define NAU8825_REG_INTERRUPT_DIS_CTRL		0x12
+#define NAU8825_REG_SAR_CTRL		0x13
+#define NAU8825_REG_KEYDET_CTRL		0x14
+#define NAU8825_REG_VDET_THRESHOLD_1		0x15
+#define NAU8825_REG_VDET_THRESHOLD_2		0x16
+#define NAU8825_REG_VDET_THRESHOLD_3		0x17
+#define NAU8825_REG_VDET_THRESHOLD_4		0x18
+#define NAU8825_REG_GPIO34_CTRL		0x19
+#define NAU8825_REG_GPIO12_CTRL		0x1a
+#define NAU8825_REG_TDM_CTRL		0x1b
+#define NAU8825_REG_I2S_PCM_CTRL1		0x1c
+#define NAU8825_REG_I2S_PCM_CTRL2		0x1d
+#define NAU8825_REG_LEFT_TIME_SLOT		0x1e
+#define NAU8825_REG_RIGHT_TIME_SLOT		0x1f
+#define NAU8825_REG_BIQ_CTRL		0x20
+#define NAU8825_REG_BIQ_COF1		0x21
+#define NAU8825_REG_BIQ_COF2		0x22
+#define NAU8825_REG_BIQ_COF3		0x23
+#define NAU8825_REG_BIQ_COF4		0x24
+#define NAU8825_REG_BIQ_COF5		0x25
+#define NAU8825_REG_BIQ_COF6		0x26
+#define NAU8825_REG_BIQ_COF7		0x27
+#define NAU8825_REG_BIQ_COF8		0x28
+#define NAU8825_REG_BIQ_COF9		0x29
+#define NAU8825_REG_BIQ_COF10		0x2a
+#define NAU8825_REG_ADC_RATE		0x2b
+#define NAU8825_REG_DAC_CTRL1		0x2c
+#define NAU8825_REG_DAC_CTRL2		0x2d
+#define NAU8825_REG_DAC_DGAIN_CTRL		0x2f
+#define NAU8825_REG_ADC_DGAIN_CTRL		0x30
+#define NAU8825_REG_MUTE_CTRL		0x31
+#define NAU8825_REG_HSVOL_CTRL		0x32
+#define NAU8825_REG_DACL_CTRL		0x33
+#define NAU8825_REG_DACR_CTRL		0x34
+#define NAU8825_REG_ADC_DRC_KNEE_IP12		0x38
+#define NAU8825_REG_ADC_DRC_KNEE_IP34		0x39
+#define NAU8825_REG_ADC_DRC_SLOPES		0x3a
+#define NAU8825_REG_ADC_DRC_ATKDCY		0x3b
+#define NAU8825_REG_DAC_DRC_KNEE_IP12		0x45
+#define NAU8825_REG_DAC_DRC_KNEE_IP34		0x46
+#define NAU8825_REG_DAC_DRC_SLOPES		0x47
+#define NAU8825_REG_DAC_DRC_ATKDCY		0x48
+#define NAU8825_REG_IMM_MODE_CTRL		0x4c
+#define NAU8825_REG_IMM_RMS_L		0x4d
+#define NAU8825_REG_IMM_RMS_R		0x4e
+#define NAU8825_REG_CLASSG_CTRL		0x50
+#define NAU8825_REG_OPT_EFUSE_CTRL		0x51
+#define NAU8825_REG_MISC_CTRL		0x55
+#define NAU8825_REG_I2C_DEVICE_ID		0x58
+#define NAU8825_REG_SARDOUT_RAM_STATUS		0x59
+#define NAU8825_REG_BIAS_ADJ		0x66
+#define NAU8825_REG_TRIM_SETTINGS		0x68
+#define NAU8825_REG_ANALOG_CONTROL_1		0x69
+#define NAU8825_REG_ANALOG_CONTROL_2		0x6a
+#define NAU8825_REG_ANALOG_ADC_1		0x71
+#define NAU8825_REG_ANALOG_ADC_2		0x72
+#define NAU8825_REG_RDAC		0x73
+#define NAU8825_REG_MIC_BIAS		0x74
+#define NAU8825_REG_BOOST		0x76
+#define NAU8825_REG_FEPGA		0x77
+#define NAU8825_REG_POWER_UP_CONTROL		0x7f
+#define NAU8825_REG_CHARGE_PUMP		0x80
+#define NAU8825_REG_CHARGE_PUMP_INPUT_READ		0x81
+#define NAU8825_REG_GENERAL_STATUS		0x82
+#define NAU8825_REG_MAX		NAU8825_REG_GENERAL_STATUS
+
+/* ENA_CTRL (0x1) */
+#define NAU8825_ENABLE_DACR_SFT	10
+#define NAU8825_ENABLE_DACR	(1 << NAU8825_ENABLE_DACR_SFT)
+#define NAU8825_ENABLE_DACL_SFT	9
+#define NAU8825_ENABLE_ADC_SFT	8
+#define NAU8825_ENABLE_SAR_SFT	1
+
+/* CLK_DIVIDER (0x3) */
+#define NAU8825_CLK_SRC_SFT	15
+#define NAU8825_CLK_SRC_MASK	(1 << NAU8825_CLK_SRC_SFT)
+#define NAU8825_CLK_SRC_VCO	(1 << NAU8825_CLK_SRC_SFT)
+#define NAU8825_CLK_SRC_MCLK	(0 << NAU8825_CLK_SRC_SFT)
+
+/* FLL6 (0x9) */
+#define NAU8825_DCO_EN	(1 << 15)
+
+/* HSD_CTRL (0xc) */
+#define NAU8825_HSD_AUTO_MODE	(1 << 6)
+/* 0 - short to GND, 1 - open */
+#define NAU8825_SPKR_DWN1R	(1 << 1)
+#define NAU8825_SPKR_DWN1L	(1 << 0)
+
+/* JACK_DET_CTRL (0xd) */
+#define NAU8825_JACK_DET_RESTART	(1 << 9)
+#define NAU8825_JACK_INSERT_DEBOUNCE_SFT	5
+#define NAU8825_JACK_INSERT_DEBOUNCE_MASK	(0x7 << NAU8825_JACK_INSERT_DEBOUNCE_SFT)
+#define NAU8825_JACK_EJECT_DEBOUNCE_SFT		2
+#define NAU8825_JACK_EJECT_DEBOUNCE_MASK	(0x7 << NAU8825_JACK_EJECT_DEBOUNCE_SFT)
+#define NAU8825_JACK_POLARITY	(1 << 1) /* 0 - active low, 1 - active high */
+
+/* INTERRUPT_MASK (0xf) */
+#define NAU8825_IRQ_OUTPUT_EN (1 << 11)
+#define NAU8825_IRQ_HEADSET_COMPLETE_EN (1 << 10)
+#define NAU8825_IRQ_KEY_RELEASE_EN (1 << 7)
+#define NAU8825_IRQ_KEY_SHORT_PRESS_EN (1 << 5)
+#define NAU8825_IRQ_EJECT_EN (1 << 2)
+
+/* IRQ_STATUS (0x10) */
+#define NAU8825_HEADSET_COMPLETION_IRQ	(1 << 10)
+#define NAU8825_SHORT_CIRCUIT_IRQ	(1 << 9)
+#define NAU8825_IMPEDANCE_MEAS_IRQ	(1 << 8)
+#define NAU8825_KEY_IRQ_MASK	(0x7 << 5)
+#define NAU8825_KEY_RELEASE_IRQ	(1 << 7)
+#define NAU8825_KEY_LONG_PRESS_IRQ	(1 << 6)
+#define NAU8825_KEY_SHORT_PRESS_IRQ	(1 << 5)
+#define NAU8825_MIC_DETECTION_IRQ	(1 << 4)
+#define NAU8825_JACK_EJECTION_IRQ_MASK	(3 << 2)
+#define NAU8825_JACK_EJECTION_DETECTED	(1 << 2)
+#define NAU8825_JACK_INSERTION_IRQ_MASK	(3 << 0)
+#define NAU8825_JACK_INSERTION_DETECTED	(1 << 0)
+
+/* INTERRUPT_DIS_CTRL (0x12) */
+#define NAU8825_IRQ_HEADSET_COMPLETE_DIS (1 << 10)
+#define NAU8825_IRQ_KEY_RELEASE_DIS (1 << 7)
+#define NAU8825_IRQ_KEY_SHORT_PRESS_DIS (1 << 5)
+#define NAU8825_IRQ_EJECT_DIS (1 << 2)
+
+/* SAR_CTRL (0x13) */
+#define NAU8825_SAR_ADC_EN_SFT	12
+#define NAU8825_SAR_ADC_EN	(1 << NAU8825_SAR_ADC_EN_SFT)
+#define NAU8825_SAR_INPUT_MASK	(1 << 11)
+#define NAU8825_SAR_INPUT_JKSLV	(1 << 11)
+#define NAU8825_SAR_INPUT_JKR2	(0 << 11)
+#define NAU8825_SAR_TRACKING_GAIN_SFT	8
+#define NAU8825_SAR_TRACKING_GAIN_MASK	(0x7 << NAU8825_SAR_TRACKING_GAIN_SFT)
+#define NAU8825_SAR_COMPARE_TIME_SFT	2
+#define NAU8825_SAR_COMPARE_TIME_MASK	(3 << 2)
+#define NAU8825_SAR_SAMPLING_TIME_SFT	0
+#define NAU8825_SAR_SAMPLING_TIME_MASK	(3 << 0)
+
+/* KEYDET_CTRL (0x14) */
+#define NAU8825_KEYDET_SHORTKEY_DEBOUNCE_SFT	12
+#define NAU8825_KEYDET_SHORTKEY_DEBOUNCE_MASK	(0x3 << NAU8825_KEYDET_SHORTKEY_DEBOUNCE_SFT)
+#define NAU8825_KEYDET_LEVELS_NR_SFT	8
+#define NAU8825_KEYDET_LEVELS_NR_MASK	(0x7 << 8)
+#define NAU8825_KEYDET_HYSTERESIS_SFT	0
+#define NAU8825_KEYDET_HYSTERESIS_MASK	0xf
+
+/* GPIO12_CTRL (0x1a) */
+#define NAU8825_JKDET_PULL_UP	(1 << 11) /* 0 - pull down, 1 - pull up */
+#define NAU8825_JKDET_PULL_EN	(1 << 9) /* 0 - enable pull, 1 - disable */
+#define NAU8825_JKDET_OUTPUT_EN	(1 << 8) /* 0 - enable input, 1 - enable output */
+
+/* I2S_PCM_CTRL1 (0x1c) */
+#define NAU8825_I2S_BP_SFT	7
+#define NAU8825_I2S_BP_MASK	(1 << NAU8825_I2S_BP_SFT)
+#define NAU8825_I2S_BP_INV	(1 << NAU8825_I2S_BP_SFT)
+#define NAU8825_I2S_PCMB_SFT	6
+#define NAU8825_I2S_PCMB_MASK	(1 << NAU8825_I2S_PCMB_SFT)
+#define NAU8825_I2S_PCMB_EN	(1 << NAU8825_I2S_PCMB_SFT)
+#define NAU8825_I2S_DL_SFT	2
+#define NAU8825_I2S_DL_MASK	(0x3 << NAU8825_I2S_DL_SFT)
+#define NAU8825_I2S_DL_16	(0 << NAU8825_I2S_DL_SFT)
+#define NAU8825_I2S_DL_20	(1 << NAU8825_I2S_DL_SFT)
+#define NAU8825_I2S_DL_24	(2 << NAU8825_I2S_DL_SFT)
+#define NAU8825_I2S_DL_32	(3 << NAU8825_I2S_DL_SFT)
+#define NAU8825_I2S_DF_SFT	0
+#define NAU8825_I2S_DF_MASK	(0x3 << NAU8825_I2S_DF_SFT)
+#define NAU8825_I2S_DF_RIGTH	(0 << NAU8825_I2S_DF_SFT)
+#define NAU8825_I2S_DF_LEFT	(1 << NAU8825_I2S_DF_SFT)
+#define NAU8825_I2S_DF_I2S	(2 << NAU8825_I2S_DF_SFT)
+#define NAU8825_I2S_DF_PCM_AB	(3 << NAU8825_I2S_DF_SFT)
+
+/* I2S_PCM_CTRL2 (0x1d) */
+#define NAU8825_I2S_TRISTATE	(1 << 15) /* 0 - normal mode, 1 - Hi-Z output */
+#define NAU8825_I2S_MS_SFT	3
+#define NAU8825_I2S_MS_MASK	(1 << NAU8825_I2S_MS_SFT)
+#define NAU8825_I2S_MS_MASTER	(1 << NAU8825_I2S_MS_SFT)
+#define NAU8825_I2S_MS_SLAVE	(0 << NAU8825_I2S_MS_SFT)
+
+/* ADC_RATE (0x2b) */
+#define NAU8825_ADC_SYNC_DOWN_SFT	0
+#define NAU8825_ADC_SYNC_DOWN_MASK	0x3
+#define NAU8825_ADC_SYNC_DOWN_32	0
+#define NAU8825_ADC_SYNC_DOWN_64	1
+#define NAU8825_ADC_SYNC_DOWN_128	2
+#define NAU8825_ADC_SYNC_DOWN_256	3
+
+/* DAC_CTRL1 (0x2c) */
+#define NAU8825_DAC_CLIP_OFF	(1 << 7)
+#define NAU8825_DAC_OVERSAMPLE_SFT	0
+#define NAU8825_DAC_OVERSAMPLE_MASK	0x7
+#define NAU8825_DAC_OVERSAMPLE_64	0
+#define NAU8825_DAC_OVERSAMPLE_256	1
+#define NAU8825_DAC_OVERSAMPLE_128	2
+#define NAU8825_DAC_OVERSAMPLE_32	4
+
+/* MUTE_CTRL (0x31) */
+#define NAU8825_DAC_ZERO_CROSSING_EN	(1 << 9)
+#define NAU8825_DAC_SOFT_MUTE	(1 << 9)
+
+/* HSVOL_CTRL (0x32) */
+#define NAU8825_HP_MUTE	(1 << 15)
+
+/* DACL_CTRL (0x33) */
+#define NAU8825_DACL_CH_SEL_SFT	9
+
+/* DACR_CTRL (0x34) */
+#define NAU8825_DACR_CH_SEL_SFT	9
+
+/* I2C_DEVICE_ID (0x58) */
+#define NAU8825_GPIO2JD1	(1 << 7)
+#define NAU8825_SOFTWARE_ID_MASK	0x3
+#define NAU8825_SOFTWARE_ID_NAU8825	0x0
+
+/* BIAS_ADJ (0x66) */
+#define NAU8825_BIAS_VMID	(1 << 6)
+#define NAU8825_BIAS_VMID_SEL_SFT	4
+#define NAU8825_BIAS_VMID_SEL_MASK	(3 << NAU8825_BIAS_VMID_SEL_SFT)
+
+/* ANALOG_CONTROL_2 (0x6a) */
+#define NAU8825_HP_NON_CLASSG_CURRENT_2xADJ (1 << 12)
+#define NAU8825_DAC_CAPACITOR_MSB (1 << 1)
+#define NAU8825_DAC_CAPACITOR_LSB (1 << 0)
+
+/* ANALOG_ADC_2 (0x72) */
+#define NAU8825_ADC_VREFSEL_MASK	(0x3 << 8)
+#define NAU8825_ADC_VREFSEL_ANALOG	(0 << 8)
+#define NAU8825_ADC_VREFSEL_VMID	(1 << 8)
+#define NAU8825_ADC_VREFSEL_VMID_PLUS_0_5DB	(2 << 8)
+#define NAU8825_ADC_VREFSEL_VMID_PLUS_1DB	(3 << 8)
+#define NAU8825_POWERUP_ADCL	(1 << 6)
+
+/* MIC_BIAS (0x74) */
+#define NAU8825_MICBIAS_JKSLV	(1 << 14)
+#define NAU8825_MICBIAS_JKR2	(1 << 12)
+#define NAU8825_MICBIAS_POWERUP_SFT	8
+#define NAU8825_MICBIAS_VOLTAGE_SFT	0
+#define NAU8825_MICBIAS_VOLTAGE_MASK	0x7
+
+/* BOOST (0x76) */
+#define NAU8825_PRECHARGE_DIS	(1 << 13)
+#define NAU8825_GLOBAL_BIAS_EN	(1 << 12)
+#define NAU8825_HP_BOOST_G_DIS	(1 << 8)
+#define NAU8825_SHORT_SHUTDOWN_EN	(1 << 6)
+
+/* POWER_UP_CONTROL (0x7f) */
+#define NAU8825_POWERUP_INTEGR_R	(1 << 5)
+#define NAU8825_POWERUP_INTEGR_L	(1 << 4)
+#define NAU8825_POWERUP_DRV_IN_R	(1 << 3)
+#define NAU8825_POWERUP_DRV_IN_L	(1 << 2)
+#define NAU8825_POWERUP_HP_DRV_R	(1 << 1)
+#define NAU8825_POWERUP_HP_DRV_L	(1 << 0)
+
+/* CHARGE_PUMP (0x80) */
+#define NAU8825_JAMNODCLOW	(1 << 10)
+#define NAU8825_POWER_DOWN_DACR	(1 << 9)
+#define NAU8825_POWER_DOWN_DACL	(1 << 8)
+#define NAU8825_CHANRGE_PUMP_EN	(1 << 5)
+
+
+/* System Clock Source */
+enum {
+	NAU8825_CLK_MCLK = 0,
+	NAU8825_CLK_INTERNAL,
+};
+
+struct nau8825 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct snd_soc_dapm_context *dapm;
+	struct snd_soc_jack *jack;
+	struct clk *mclk;
+	int irq;
+	int mclk_freq; /* 0 - mclk is disabled */
+	int button_pressed;
+	int micbias_voltage;
+	int vref_impedance;
+	bool jkdet_enable;
+	bool jkdet_pull_enable;
+	bool jkdet_pull_up;
+	int jkdet_polarity;
+	int sar_threshold_num;
+	int sar_threshold[8];
+	int sar_hysteresis;
+	int sar_voltage;
+	int sar_compare_time;
+	int sar_sampling_time;
+	int key_debounce;
+	int jack_insert_debounce;
+	int jack_eject_debounce;
+};
+
+int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
+				struct snd_soc_jack *jack);
+
+
+#endif  /* __NAU8825_H__ */
-- 
2.5.0
