From: Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Subject: [PATCH v2] ALSA SoC MAX98927 driver - Revision
Date: Fri, 25 Nov 2016 14:02:47 +0900
Message-ID: <1480050167-83444-1-git-send-email-RyanS.Lee@maximintegrated.com>
References: <1479877026-5172-1-git-send-email-RyanS.Lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479877026-5172-1-git-send-email-RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yesanishhere-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org, Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, nh6z-fFIq/eER6g8@public.gmane.org, ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
---
 .../devicetree/bindings/sound/max98927.txt         |   33 +-
 sound/soc/codecs/max98927.c                        |  839 +++++------
 sound/soc/codecs/max98927.h                        | 1463 ++++----------------
 3 files changed, 692 insertions(+), 1643 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/max98927.txt b/Documentation/devicetree/bindings/sound/max98927.txt
index ddcd332..d610879 100755
--- a/Documentation/devicetree/bindings/sound/max98927.txt
+++ b/Documentation/devicetree/bindings/sound/max98927.txt
@@ -6,19 +6,25 @@ Required properties:
 
   - compatible : "maxim,max98927"
 
-  - vmon-slot-no : slot number used to send voltage information
+  - maxim,vmon-slot-no : slot number used to send voltage information
                    or in inteleave mode this will be used as
                    interleave slot.
-
-  - imon-slot-no : slot number used to send current information
-
-  - interleave-mode : When using two MAX98927 in a system it is
-                      possible to create ADC data that that will
-                      overflow the frame size. Digital Audio Interleave
-                      mode provides a means to output VMON and IMON data
-                      from two devices on a single DOUT line when running
-                      smaller frames sizes such as 32 BCLKS per LRCLK or
-                      48 BCLKS per LRCLK.
+                   This property can be set to values from 0 to 15 for slot 0 to 15.
+                   Default value is 0.
+
+  - maxim,imon-slot-no : slot number used to send current information
+                   This property can be set to values from 0 to 15 for slot 0 to 15.
+                   Default value is 0.
+
+  - maxim,interleave-mode : When using two MAX98927 in a system it is
+                   possible to create ADC data that that will
+                   overflow the frame size. Digital Audio Interleave
+                   mode provides a means to output VMON and IMON data
+                   from two devices on a single DOUT line when running
+                   smaller frames sizes such as 32 BCLKS per LRCLK or
+                   48 BCLKS per LRCLK.
+                   This property can be set to values from 0 to 1 for off and on.
+                   Default value is 0.
 
   - reg : the I2C address of the device for I2C
 
@@ -26,7 +32,8 @@ Example:
 
 codec: max98927@3a {
    compatible = "maxim,max98927";
-   vmon-slot-no = <1>;
-   imon-slot-no = <0>;
+   maxim,vmon-slot-no = <0>;
+   maxim,imon-slot-no = <1>;
+   maxim,interleave-mode = <0>;
    reg = <0x3a>;
 };
diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index d85c84f..9c16fe8 100755
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -1,7 +1,7 @@
 /*
  * max98927.c  --  MAX98927 ALSA Soc Audio driver
  *
- * Copyright 2013-15 Maxim Integrated Products
+ * Copyright 2013-16 Maxim Integrated Products
  * Author: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -10,7 +10,6 @@
  *  option) any later version.
  */
 
-#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -24,54 +23,122 @@
 #include <sound/tlv.h>
 #include "max98927.h"
 
-static struct reg_default max98927_reg_map[] = {
-	{0x0014,  0x78},
-	{0x0015,  0xFF},
-	{0x0043,  0x04},
-	{0x0017,  0x55},
-	/* For mono driver we are just enabling one channel*/
-	{MAX98927_PCM_Rx_Enables_A,  0x03},
-	{MAX98927_PCM_Tx_HiZ_Control_A, 0xfc},
-	{MAX98927_PCM_Tx_HiZ_Control_B, 0xff},
-	{MAX98927_PCM_Tx_Channel_Sources_A, 0x01},
-	{MAX98927_PCM_Tx_Channel_Sources_B, 0x01},
-	{MAX98927_Measurement_DSP_Config, 0xf7},
-	{0x0025,  0x80},
-	{0x0026,  0x01},
-	{0x0035,  0x40},
-	{0x0036,  0x40},
-	{0x0037,  0x02},
-	{0x0039,  0x01},
-	{0x003c,  0x44},
-	{0x003d,  0x04},
-	{0x0040,  0x10},
-	{0x0042,  0x3f},
-	{0x0044,  0x00},
-	{0x0045,  0x24},
-	{0x007f,  0x06},
-	{0x0087,  0x1c},
-	{0x0089,  0x03},
-	{0x009f,  0x01},
+static struct reg_default max98927_reg[] = {
+	{MAX98927_R0001_INT_RAW1,  0x00},
+	{MAX98927_R0002_INT_RAW2,  0x00},
+	{MAX98927_R0003_INT_RAW3,  0x00},
+	{MAX98927_R0004_INT_STATE1,  0x00},
+	{MAX98927_R0005_INT_STATE2,  0x00},
+	{MAX98927_R0006_INT_STATE3,  0x00},
+	{MAX98927_R0007_INT_FLAG1,  0x00},
+	{MAX98927_R0008_INT_FLAG2,  0x00},
+	{MAX98927_R0009_INT_FLAG3,  0x00},
+	{MAX98927_R000A_INT_EN1,  0x00},
+	{MAX98927_R000B_INT_EN2,  0x00},
+	{MAX98927_R000C_INT_EN3,  0x00},
+	{MAX98927_R000D_INT_FLAG_CLR1,  0x00},
+	{MAX98927_R000E_INT_FLAG_CLR2,  0x00},
+	{MAX98927_R000F_INT_FLAG_CLR3,  0x00},
+	{MAX98927_R0010_IRQ_CTRL,  0x00},
+	{MAX98927_R0011_CLK_MON,  0x00},
+	{MAX98927_R0012_WDOG_CTRL,  0x00},
+	{MAX98927_R0013_WDOG_RST,  0x00},
+	{MAX98927_R0014_MEAS_ADC_THERM_WARN_THRESH,  0x00},
+	{MAX98927_R0015_MEAS_ADC_THERM_SHDN_THRESH,  0x00},
+	{MAX98927_R0016_MEAS_ADC_THERM_HYSTERESIS,  0x00},
+	{MAX98927_R0017_PIN_CFG,  0x55},
+	{MAX98927_R0018_PCM_RX_EN_A,  0x00},
+	{MAX98927_R0019_PCM_RX_EN_B,  0x00},
+	{MAX98927_R001A_PCM_TX_EN_A,  0x00},
+	{MAX98927_R001B_PCM_TX_EN_B,  0x00},
+	{MAX98927_R001C_PCM_TX_HIZ_CTRL_A,  0x00},
+	{MAX98927_R001D_PCM_TX_HIZ_CTRL_B,  0x00},
+	{MAX98927_R001E_PCM_TX_CH_SRC_A,  0x00},
+	{MAX98927_R001F_PCM_TX_CH_SRC_B,  0x00},
+	{MAX98927_R0020_PCM_MODE_CFG,  0x40},
+	{MAX98927_R0021_PCM_MASTER_MODE,  0x00},
+	{MAX98927_R0022_PCM_CLK_SETUP,  0x22},
+	{MAX98927_R0023_PCM_SR_SETUP1,  0x00},
+	{MAX98927_R0024_PCM_SR_SETUP2,  0x00},
+	{MAX98927_R0025_PCM_TO_SPK_MONOMIX_A,  0x00},
+	{MAX98927_R0026_PCM_TO_SPK_MONOMIX_B,  0x00},
+	{MAX98927_R0027_ICC_RX_EN_A,  0x00},
+	{MAX98927_R0028_ICC_RX_EN_B,  0x00},
+	{MAX98927_R002B_ICC_TX_EN_A,  0x00},
+	{MAX98927_R002C_ICC_TX_EN_B,  0x00},
+	{MAX98927_R002E_ICC_HIZ_MANUAL_MODE,  0x00},
+	{MAX98927_R002F_ICC_TX_HIZ_EN_A,  0x00},
+	{MAX98927_R0030_ICC_TX_HIZ_EN_B,  0x00},
+	{MAX98927_R0031_ICC_LNK_EN,  0x00},
+	{MAX98927_R0032_PDM_TX_EN,  0x00},
+	{MAX98927_R0033_PDM_TX_HIZ_CTRL,  0x00},
+	{MAX98927_R0034_PDM_TX_CTRL,  0x00},
+	{MAX98927_R0035_PDM_RX_CTRL,  0x00},
+	{MAX98927_R0036_AMP_VOL_CTRL,  0x00},
+	{MAX98927_R0037_AMP_DSP_CFG,  0x02},
+	{MAX98927_R0038_TONE_GEN_DC_CFG,  0x00},
+	{MAX98927_R0039_DRE_CTRL,  0x01},
+	{MAX98927_R003A_AMP_EN,  0x00},
+	{MAX98927_R003B_SPK_SRC_SEL,  0x00},
+	{MAX98927_R003C_SPK_GAIN,  0x00},
+	{MAX98927_R003D_SSM_CFG,  0x01},
+	{MAX98927_R003E_MEAS_EN,  0x00},
+	{MAX98927_R003F_MEAS_DSP_CFG,  0x04},
+	{MAX98927_R0040_BOOST_CTRL0,  0x00},
+	{MAX98927_R0041_BOOST_CTRL3,  0x00},
+	{MAX98927_R0042_BOOST_CTRL1,  0x00},
+	{MAX98927_R0043_MEAS_ADC_CFG,  0x00},
+	{MAX98927_R0044_MEAS_ADC_BASE_MSB,  0x00},
+	{MAX98927_R0045_MEAS_ADC_BASE_LSB,  0x00},
+	{MAX98927_R0046_ADC_CH0_DIVIDE,  0x00},
+	{MAX98927_R0047_ADC_CH1_DIVIDE,  0x00},
+	{MAX98927_R0048_ADC_CH2_DIVIDE,  0x00},
+	{MAX98927_R0049_ADC_CH0_FILT_CFG,  0x00},
+	{MAX98927_R004A_ADC_CH1_FILT_CFG,  0x00},
+	{MAX98927_R004B_ADC_CH2_FILT_CFG,  0x00},
+	{MAX98927_R004C_MEAS_ADC_CH0_READ,  0x00},
+	{MAX98927_R004D_MEAS_ADC_CH1_READ,  0x00},
+	{MAX98927_R004E_MEAS_ADC_CH2_READ,  0x00},
+	{MAX98927_R0051_BROWNOUT_STATUS,  0x00},
+	{MAX98927_R0052_BROWNOUT_EN,  0x00},
+	{MAX98927_R0053_BROWNOUT_INFINITE_HOLD,  0x00},
+	{MAX98927_R0054_BROWNOUT_INFINITE_HOLD_CLR,  0x00},
+	{MAX98927_R0055_BROWNOUT_LVL_HOLD,  0x00},
+	{MAX98927_R005A_BROWNOUT_LVL1_THRESH,  0x00},
+	{MAX98927_R005B_BROWNOUT_LVL2_THRESH,  0x00},
+	{MAX98927_R005C_BROWNOUT_LVL3_THRESH,  0x00},
+	{MAX98927_R005D_BROWNOUT_LVL4_THRESH,  0x00},
+	{MAX98927_R005E_BROWNOUT_THRESH_HYSTERYSIS,  0x00},
+	{MAX98927_R005F_BROWNOUT_AMP_LIMITER_ATK_REL,  0x00},
+	{MAX98927_R0060_BROWNOUT_AMP_GAIN_ATK_REL,  0x00},
+	{MAX98927_R0061_BROWNOUT_AMP1_CLIP_MODE,  0x00},
+	{MAX98927_R0072_BROWNOUT_LVL1_CUR_LIMIT,  0x00},
+	{MAX98927_R0073_BROWNOUT_LVL1_AMP1_CTRL1,  0x00},
+	{MAX98927_R0074_BROWNOUT_LVL1_AMP1_CTRL2,  0x00},
+	{MAX98927_R0075_BROWNOUT_LVL1_AMP1_CTRL3,  0x00},
+	{MAX98927_R0076_BROWNOUT_LVL2_CUR_LIMIT,  0x00},
+	{MAX98927_R0077_BROWNOUT_LVL2_AMP1_CTRL1,  0x00},
+	{MAX98927_R0078_BROWNOUT_LVL2_AMP1_CTRL2,  0x00},
+	{MAX98927_R0079_BROWNOUT_LVL2_AMP1_CTRL3,  0x00},
+	{MAX98927_R007A_BROWNOUT_LVL3_CUR_LIMIT,  0x00},
+	{MAX98927_R007B_BROWNOUT_LVL3_AMP1_CTRL1,  0x00},
+	{MAX98927_R007C_BROWNOUT_LVL3_AMP1_CTRL2,  0x00},
+	{MAX98927_R007D_BROWNOUT_LVL3_AMP1_CTRL3,  0x00},
+	{MAX98927_R007E_BROWNOUT_LVL4_CUR_LIMIT,  0x00},
+	{MAX98927_R007F_BROWNOUT_LVL4_AMP1_CTRL1,  0x00},
+	{MAX98927_R0080_BROWNOUT_LVL4_AMP1_CTRL2,  0x00},
+	{MAX98927_R0081_BROWNOUT_LVL4_AMP1_CTRL3,  0x00},
+	{MAX98927_R0082_ENV_TRACK_VOUT_HEADROOM,  0x00},
+	{MAX98927_R0083_ENV_TRACK_BOOST_VOUT_DELAY,  0x00},
+	{MAX98927_R0084_ENV_TRACK_REL_RATE,  0x00},
+	{MAX98927_R0085_ENV_TRACK_HOLD_RATE,  0x00},
+	{MAX98927_R0086_ENV_TRACK_CTRL,  0x00},
+	{MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ,  0x00},
+	{MAX98927_R00FF_GLOBAL_SHDN,  0x00},
+	{MAX98927_R0100_SOFT_RESET,  0x00},
+	{MAX98927_R01FF_REV_ID,  0x40},
 };
 
-void max98927_wrapper_write(struct max98927_priv *max98927,
-	unsigned int reg, unsigned int val)
-{
-	if (max98927->regmap)
-		regmap_write(max98927->regmap, reg, val);
-	if (max98927->sub_regmap)
-		regmap_write(max98927->sub_regmap, reg, val);
-}
-
-void max98927_wrap_update_bits(struct max98927_priv *max98927,
-	unsigned int reg, unsigned int mask, unsigned int val)
-{
-	if (max98927->regmap)
-		regmap_update_bits(max98927->regmap, reg, mask, val);
-	if (max98927->sub_regmap)
-		regmap_update_bits(max98927->sub_regmap, reg, mask, val);
-}
-
 static int max98927_reg_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol, unsigned int reg,
 		unsigned int mask, unsigned int shift)
@@ -81,8 +148,7 @@ static int max98927_reg_get(struct snd_kcontrol *kcontrol,
 	int data;
 
 	regmap_read(max98927->regmap, reg, &data);
-	ucontrol->value.integer.value[0] =
-		(data & mask) >> shift;
+	ucontrol->value.integer.value[0] = (data & mask) >> shift;
 	return 0;
 }
 
@@ -94,83 +160,81 @@ static int max98927_reg_put(struct snd_kcontrol *kcontrol,
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 	unsigned int sel = ucontrol->value.integer.value[0];
 
-	max98927_wrap_update_bits(max98927, reg, mask, sel << shift);
+	regmap_update_bits(max98927->regmap, reg, mask, sel << shift);
 	dev_dbg(codec->dev, "%s: register 0x%02X, value 0x%02X\n",
-				__func__, reg, sel);
+		__func__, reg, sel);
 	return 0;
 }
 
 static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai,
-	unsigned int fmt)
+		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
+	unsigned int mode = 0;
 	unsigned int invert = 0;
 
 	dev_dbg(codec->dev, "%s: fmt 0x%08X\n", __func__, fmt);
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
-		max98927_wrap_update_bits(max98927, MAX98927_PCM_Master_Mode,
-		MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_Mask,
-		MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_SLAVE);
+		mode = MAX98927_PCM_MASTER_MODE_SLAVE;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		max98927->master = true;
-		max98927_wrap_update_bits(max98927, MAX98927_PCM_Master_Mode,
-		MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_Mask,
-		MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_MASTER);
+		mode = MAX98927_PCM_MASTER_MODE_MASTER;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM:
-		max98927_wrap_update_bits(max98927, MAX98927_PCM_Master_Mode,
-		MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_Mask,
-		MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_HYBRID);
+		mode = MAX98927_PCM_MASTER_MODE_HYBRID;
 	default:
 		dev_err(codec->dev, "DAI clock mode unsupported");
 		return -EINVAL;
 	}
 
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0021_PCM_MASTER_MODE,
+		MAX98927_PCM_MASTER_MODE_MASK,
+		mode);
+
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
-		invert = MAX98927_PCM_Mode_Config_PCM_BCLKEDGE;
+		invert = MAX98927_PCM_MODE_CFG_PCM_BCLKEDGE;
 		break;
 	default:
 		dev_err(codec->dev, "DAI invert mode unsupported");
 		return -EINVAL;
 	}
 
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0020_PCM_MODE_CFG,
+		MAX98927_PCM_MODE_CFG_PCM_BCLKEDGE,
+		invert);
+
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		max98927->iface |= SND_SOC_DAIFMT_I2S;
-		max98927_wrap_update_bits(max98927,
-			MAX98927_PCM_Mode_Config,
-		max98927->iface, max98927->iface);
+
 	break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		max98927->iface |= SND_SOC_DAIFMT_LEFT_J;
-		max98927_wrap_update_bits(max98927,
-			MAX98927_PCM_Mode_Config,
-		max98927->iface, max98927->iface);
 	break;
 	default:
 		return -EINVAL;
 	}
 
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0020_PCM_MODE_CFG,
+		max98927->iface, max98927->iface);
+
 	/* pcm channel configuration */
-	if (max98927->iface & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J)) {
-		max98927_wrapper_write(max98927,
-			MAX98927_PCM_Rx_Enables_A,
-			MAX98927_PCM_Rx_Enables_A_PCM_RX_CH0_EN|
-			MAX98927_PCM_Rx_Enables_A_PCM_RX_CH1_EN);
-		max98927_wrapper_write(max98927,
-			MAX98927_PCM_Tx_Enables_A,
-			MAX98927_PCM_Tx_Enables_A_PCM_TX_CH0_EN|
-			MAX98927_PCM_Tx_Enables_A_PCM_TX_CH1_EN);
-	}
-	max98927_wrap_update_bits(max98927, MAX98927_PCM_Mode_Config,
-		MAX98927_PCM_Mode_Config_PCM_BCLKEDGE, invert);
+	if (max98927->iface & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J))
+		regmap_write(max98927->regmap,
+			MAX98927_R0018_PCM_RX_EN_A,
+			MAX98927_PCM_RX_CH0_EN|
+			MAX98927_PCM_RX_CH1_EN);
+
 	return 0;
 }
 
@@ -182,12 +246,13 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai,
 };
 
 static int max98927_set_clock(struct max98927_priv *max98927,
-	struct snd_pcm_hw_params *params)
+		struct snd_pcm_hw_params *params)
 {
+	struct snd_soc_codec *codec = max98927->codec;
 	/* BCLK/LRCLK ratio calculation */
 	int blr_clk_ratio = params_channels(params) * max98927->ch_size;
-	int reg = MAX98927_PCM_Clock_setup;
-	int mask = MAX98927_PCM_Clock_setup_PCM_BSEL_Mask;
+	int reg = MAX98927_R0022_PCM_CLK_SETUP;
+	int mask = MAX98927_PCM_CLK_SETUP_BSEL_MASK;
 	int value;
 
 	if (max98927->master) {
@@ -198,13 +263,13 @@ static int max98927_set_clock(struct max98927_priv *max98927,
 				break;
 		}
 		if (i == ARRAY_SIZE(rate_table)) {
-			pr_err("%s couldn't get the MCLK to match codec\n",
-				__func__);
+			dev_err(codec->dev, "failed to find proper clock rate.\n");
 			return -EINVAL;
 		}
-		max98927_wrap_update_bits(max98927, MAX98927_PCM_Master_Mode,
-			MAX98927_PCM_Master_Mode_PCM_MCLK_RATE_Mask,
-			i << MAX98927_PCM_Master_Mode_PCM_MCLK_RATE_SHIFT);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R0021_PCM_MASTER_MODE,
+			MAX98927_PCM_MASTER_MODE_MCLK_MASK,
+			i << MAX98927_PCM_MASTER_MODE_MCLK_RATE_SHIFT);
 	}
 
 	switch (blr_clk_ratio) {
@@ -220,100 +285,93 @@ static int max98927_set_clock(struct max98927_priv *max98927,
 	default:
 		return -EINVAL;
 	}
-	max98927_wrap_update_bits(max98927,
-	reg, mask, value);
+	regmap_update_bits(max98927->regmap, reg, mask, value);
 	return 0;
 }
 
 static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params,
-	struct snd_soc_dai *dai)
+		struct snd_pcm_hw_params *params,
+		struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
-	int sampling_rate = 0;
+	unsigned int sampling_rate = 0;
+	unsigned int chan_sz = 0;
 
 	/* pcm mode configuration */
 	switch (snd_pcm_format_width(params_format(params))) {
 	case 16:
-		max98927_wrap_update_bits(max98927,
-			MAX98927_PCM_Mode_Config,
-			MAX98927_PCM_Mode_Config_PCM_CHANSZ_16,
-			MAX98927_PCM_Mode_Config_PCM_CHANSZ_16);
+		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_16;
 		max98927->ch_size = 16;
 		break;
 	case 24:
-		max98927_wrap_update_bits(max98927,
-			MAX98927_PCM_Mode_Config,
-			MAX98927_PCM_Mode_Config_PCM_CHANSZ_24,
-			MAX98927_PCM_Mode_Config_PCM_CHANSZ_24);
+		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_24;
 		max98927->ch_size = 24;
 		break;
 	case 32:
-		max98927_wrap_update_bits(max98927,
-			MAX98927_PCM_Mode_Config,
-			MAX98927_PCM_Mode_Config_PCM_CHANSZ_32,
-			MAX98927_PCM_Mode_Config_PCM_CHANSZ_32);
+		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_32;
 		max98927->ch_size = 32;
 		break;
 	default:
-		pr_err("%s: format unsupported %d",
-			__func__, params_format(params));
+		dev_err(codec->dev, "format unsupported %d",
+			params_format(params));
 		goto err;
 	}
-	dev_dbg(codec->dev, "%s: format supported %d",
-		__func__, params_format(params));
+
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0020_PCM_MODE_CFG,
+		chan_sz, chan_sz);
+
+	dev_dbg(codec->dev, "format supported %d",
+		params_format(params));
 
 	/* sampling rate configuration */
 	switch (params_rate(params)) {
 	case 8000:
-		sampling_rate |=
-			MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_8000;
+		sampling_rate |= MAX98927_PCM_SR_SET1_SR_8000;
 		break;
 	case 11025:
-		sampling_rate |=
-			MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_11025;
+		sampling_rate |= MAX98927_PCM_SR_SET1_SR_11025;
 		break;
 	case 12000:
-		sampling_rate |=
-			MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_12000;
+		sampling_rate |= MAX98927_PCM_SR_SET1_SR_12000;
 		break;
 	case 16000:
-		sampling_rate |=
-			MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_16000;
+		sampling_rate |= MAX98927_PCM_SR_SET1_SR_16000;
 		break;
 	case 22050:
-		sampling_rate |=
-			MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_22050;
+		sampling_rate |= MAX98927_PCM_SR_SET1_SR_22050;
 		break;
 	case 24000:
-		sampling_rate |=
-			MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_24000;
+		sampling_rate |= MAX98927_PCM_SR_SET1_SR_24000;
 		break;
 	case 32000:
-		sampling_rate |=
-			MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_32000;
+		sampling_rate |= MAX98927_PCM_SR_SET1_SR_32000;
 		break;
 	case 44100:
-		sampling_rate |=
-			MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_44100;
+		sampling_rate |= MAX98927_PCM_SR_SET1_SR_44100;
 		break;
 	case 48000:
-		sampling_rate |=
-			MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_48000;
+		sampling_rate |= MAX98927_PCM_SR_SET1_SR_48000;
 		break;
 	default:
-		pr_err("%s rate %d not supported\n",
-			__func__, params_rate(params));
+		dev_err(codec->dev, "rate %d not supported\n",
+			params_rate(params));
 		goto err;
 	}
 	/* set DAI_SR to correct LRCLK frequency */
-	max98927_wrap_update_bits(max98927, MAX98927_PCM_Sample_rate_setup_1,
-		MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_Mask, sampling_rate);
-	max98927_wrap_update_bits(max98927, MAX98927_PCM_Sample_rate_setup_2,
-		MAX98927_PCM_Sample_rate_setup_2_SPK_SR_Mask, sampling_rate<<4);
-	max98927_wrap_update_bits(max98927, MAX98927_PCM_Sample_rate_setup_2,
-		MAX98927_PCM_Sample_rate_setup_2_IVADC_SR_Mask, sampling_rate);
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0023_PCM_SR_SETUP1,
+		MAX98927_PCM_SR_SET1_SR_MASK,
+		sampling_rate);
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0024_PCM_SR_SETUP2,
+		MAX98927_PCM_SR_SET2_SR_MASK,
+		sampling_rate << MAX98927_PCM_SR_SET2_SR_SHIFT);
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0024_PCM_SR_SETUP2,
+		MAX98927_PCM_SR_SET2_IVADC_SR_MASK,
+		sampling_rate);
 	return max98927_set_clock(max98927, params);
 err:
 	return -EINVAL;
@@ -325,7 +383,7 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static int max98927_dai_set_sysclk(struct snd_soc_dai *dai,
-				   int clk_id, unsigned int freq, int dir)
+		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
@@ -340,78 +398,37 @@ static int max98927_dai_set_sysclk(struct snd_soc_dai *dai,
 	.hw_params = max98927_dai_hw_params,
 };
 
-static void max98927_handle_pdata(struct snd_soc_codec *codec)
-{
-	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
-	struct max98927_reg_default *regInfo;
-	int cfg_size = 0;
-	int x;
-
-	if (max98927->regcfg != NULL)
-		cfg_size = max98927->regcfg_sz / sizeof(uint32_t);
-
-	if (cfg_size <= 0) {
-		dev_dbg(codec->dev,
-			"Register configuration is not required.\n");
-		return;
-	}
-
-	/* direct configuration from device tree */
-	for (x = 0; x < cfg_size; x += 3) {
-		regInfo = (struct max98927_reg_default *)&max98927->regcfg[x];
-		dev_info(codec->dev, "CH:%d, reg:0x%02x, value:0x%02x\n",
-			be32_to_cpu(regInfo->ch),
-			be32_to_cpu(regInfo->reg),
-			be32_to_cpu(regInfo->def));
-		if (be32_to_cpu(regInfo->ch) == PRI_MAX98927
-			&& max98927->regmap)
-			regmap_write(max98927->regmap,
-				be32_to_cpu(regInfo->reg),
-				be32_to_cpu(regInfo->def));
-		else if (be32_to_cpu(regInfo->ch) == SEC_MAX98927
-			&& max98927->sub_regmap)
-			regmap_write(max98927->sub_regmap,
-				be32_to_cpu(regInfo->reg),
-				be32_to_cpu(regInfo->def));
-	}
-}
-
 static int max98927_dac_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
+		struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		max98927_wrap_update_bits(max98927,
-			MAX98927_AMP_enables, 1, 1);
-		/* enable the v and i for vi feedback */
-		max98927_wrap_update_bits(max98927,
-			MAX98927_Measurement_enables,
-			MAX98927_Measurement_enables_IVADC_V_EN,
-			MAX98927_Measurement_enables_IVADC_V_EN);
-		max98927_wrap_update_bits(max98927,
-			MAX98927_Measurement_enables,
-			MAX98927_Measurement_enables_IVADC_I_EN,
-			MAX98927_Measurement_enables_IVADC_I_EN);
-		max98927_wrap_update_bits(max98927,
-			MAX98927_Global_Enable, 1, 1);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R003A_AMP_EN,
+			MAX98927_AMP_EN_MASK, 1);
+		/* enable VMON and IMON */
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R003E_MEAS_EN,
+			MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN,
+			MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R00FF_GLOBAL_SHDN,
+			MAX98927_GLOBAL_EN_MASK, 1);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		max98927_wrap_update_bits(max98927,
-			MAX98927_Global_Enable, 1, 0);
-		max98927_wrap_update_bits(max98927,
-			MAX98927_AMP_enables, 1, 0);
-		/* disable the v and i for vi feedback */
-		max98927_wrap_update_bits(max98927,
-			MAX98927_Measurement_enables,
-			MAX98927_Measurement_enables_IVADC_V_EN,
-			0);
-		max98927_wrap_update_bits(max98927,
-			MAX98927_Measurement_enables,
-			MAX98927_Measurement_enables_IVADC_I_EN,
-			0);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R00FF_GLOBAL_SHDN,
+			MAX98927_GLOBAL_EN_MASK, 0);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R003A_AMP_EN,
+			MAX98927_AMP_EN_MASK, 0);
+		/* disable VMON and IMON */
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R003E_MEAS_EN,
+			MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN, 0);
 		break;
 	default:
 		return 0;
@@ -421,7 +438,7 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 
 static const struct snd_soc_dapm_widget max98927_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("DAI_OUT", "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_DAC_E("Amp Enable", "HiFi Playback", MAX98927_AMP_enables,
+	SND_SOC_DAPM_DAC_E("Amp Enable", "HiFi Playback", MAX98927_R003A_AMP_EN,
 		0, 0, max98927_dac_event,
 		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_OUTPUT("BE_OUT"),
@@ -431,7 +448,7 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 static DECLARE_TLV_DB_SCALE(max98927_digital_tlv, -1600, 25, 0);
 
 static int max98927_spk_gain_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+		struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
@@ -443,22 +460,23 @@ static int max98927_spk_gain_get(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_spk_gain_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+		struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 	unsigned int sel = ucontrol->value.integer.value[0];
 
-	if (sel < ((1 << MAX98927_Speaker_Gain_Width) - 1)) {
-		max98927_wrap_update_bits(max98927, MAX98927_Speaker_Gain,
-			MAX98927_Speaker_Gain_SPK_PCM_GAIN_Mask, sel);
+	if (sel < ((1 << MAX98927_SPK_GAIN_WIDTH) - 1)) {
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R003C_SPK_GAIN,
+			MAX98927_SPK_PCM_GAIN_MASK, sel);
 		max98927->spk_gain = sel;
 	}
 	return 0;
 }
 
 static int max98927_digital_gain_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+		struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
@@ -470,15 +488,16 @@ static int max98927_digital_gain_get(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_digital_gain_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+		struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 	unsigned int sel = ucontrol->value.integer.value[0];
 
 	if (sel < ((1 << MAX98927_AMP_VOL_WIDTH) - 1)) {
-		max98927_wrap_update_bits(max98927, MAX98927_AMP_volume_control,
-			MAX98927_AMP_volume_control_AMP_VOL_Mask, sel);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R0036_AMP_VOL_CTRL,
+			MAX98927_AMP_VOL_MASK, sel);
 		max98927->digital_gain = sel;
 	}
 	return 0;
@@ -487,113 +506,126 @@ static int max98927_digital_gain_put(struct snd_kcontrol *kcontrol,
 static int max98927_boost_voltage_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	return max98927_reg_get(kcontrol, ucontrol, MAX98927_Boost_Control_0,
-		MAX98927_Boost_Control_0_BST_VOUT_Mask, 0);
+	return max98927_reg_get(kcontrol, ucontrol,
+		MAX98927_R0040_BOOST_CTRL0,
+		MAX98927_BOOST_CTRL0_VOUT_MASK, 0);
 }
 
 static int max98927_boost_voltage_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	return max98927_reg_put(kcontrol, ucontrol, MAX98927_Boost_Control_0,
-		MAX98927_Boost_Control_0_BST_VOUT_Mask, 0);
+	return max98927_reg_put(kcontrol, ucontrol,
+		MAX98927_R0040_BOOST_CTRL0,
+		MAX98927_BOOST_CTRL0_VOUT_MASK, 0);
 }
 
 static int max98927_amp_vol_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	return max98927_reg_get(kcontrol, ucontrol, MAX98927_Boost_Control_0,
-		MAX98927_Boost_Control_0_BST_VOUT_Mask,
-		MAX98927_AMP_VOL_LOCATION_SHIFT);
+	return max98927_reg_get(kcontrol, ucontrol,
+		MAX98927_R0036_AMP_VOL_CTRL,
+		MAX98927_AMP_VOL_SEL,
+		MAX98927_AMP_VOL_SHIFT);
+}
+
+static int max98927_amp_vol_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	return max98927_reg_put(kcontrol, ucontrol,
+		MAX98927_R0036_AMP_VOL_CTRL,
+		MAX98927_AMP_VOL_SEL,
+		MAX98927_AMP_VOL_SHIFT);
 }
 
 static int max98927_amp_dsp_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	return max98927_reg_put(kcontrol, ucontrol, MAX98927_Brownout_enables,
-		MAX98927_Brownout_enables_AMP_DSP_EN, MAX98927_BDE_DSP_SHIFT);
+	return max98927_reg_put(kcontrol, ucontrol,
+		MAX98927_R0052_BROWNOUT_EN,
+		MAX98927_BROWNOUT_DSP_EN,
+		MAX98927_BROWNOUT_DSP_SHIFT);
 }
 
 static int max98927_amp_dsp_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	return max98927_reg_get(kcontrol, ucontrol, MAX98927_Brownout_enables,
-		MAX98927_Brownout_enables_AMP_DSP_EN, MAX98927_BDE_DSP_SHIFT);
+	return max98927_reg_get(kcontrol, ucontrol,
+		MAX98927_R0052_BROWNOUT_EN,
+		MAX98927_BROWNOUT_DSP_EN,
+		MAX98927_BROWNOUT_DSP_SHIFT);
 }
 
 static int max98927_ramp_switch_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	return max98927_reg_put(kcontrol, ucontrol, MAX98927_AMP_DSP_Config,
-		MAX98927_AMP_DSP_Config_AMP_VOL_RMP_BYPASS,
-		MAX98927_SPK_RMP_EN_SHIFT);
+	return max98927_reg_put(kcontrol, ucontrol,
+		MAX98927_R0037_AMP_DSP_CFG,
+		MAX98927_AMP_DSP_CFG_RMP_BYPASS,
+		MAX98927_AMP_DSP_CFG_RMP_SHIFT);
 }
 static int max98927_ramp_switch_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	return max98927_reg_get(kcontrol, ucontrol, MAX98927_AMP_DSP_Config,
-		MAX98927_AMP_DSP_Config_AMP_VOL_RMP_BYPASS,
-		MAX98927_SPK_RMP_EN_SHIFT);
+	return max98927_reg_get(kcontrol, ucontrol,
+		MAX98927_R0037_AMP_DSP_CFG,
+		MAX98927_AMP_DSP_CFG_RMP_BYPASS,
+		MAX98927_AMP_DSP_CFG_RMP_SHIFT);
 }
 
 static int max98927_dre_en_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	return max98927_reg_put(kcontrol, ucontrol, MAX98927_DRE_Control,
-		MAX98927_DRE_Control_DRE_EN, 0);
+	return max98927_reg_put(kcontrol, ucontrol,
+		MAX98927_R0039_DRE_CTRL,
+		MAX98927_DRE_CTRL_DRE_EN, 0);
 }
 static int max98927_dre_en_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	return max98927_reg_get(kcontrol, ucontrol, MAX98927_DRE_Control,
-		MAX98927_DRE_Control_DRE_EN, 0);
-}
-static int max98927_amp_vol_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
-{
-	return max98927_reg_put(kcontrol, ucontrol,
-		MAX98927_AMP_volume_control,
-		MAX98927_AMP_volume_control_AMP_VOL_SEL,
-		MAX98927_AMP_VOL_LOCATION_SHIFT);
+	return max98927_reg_get(kcontrol, ucontrol,
+		MAX98927_R0039_DRE_CTRL,
+		MAX98927_DRE_CTRL_DRE_EN, 0);
 }
 static int max98927_spk_src_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_get(kcontrol, ucontrol,
-		MAX98927_Speaker_source_select,
-		MAX98927_Speaker_source_select_SPK_SOURCE_Mask, 0);
+		MAX98927_R003B_SPK_SRC_SEL,
+		MAX98927_SPK_SRC_MASK, 0);
 }
 
 static int max98927_spk_src_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_put(kcontrol, ucontrol,
-		MAX98927_Speaker_source_select,
-		MAX98927_Speaker_source_select_SPK_SOURCE_Mask, 0);
+		MAX98927_R003B_SPK_SRC_SEL,
+		MAX98927_SPK_SRC_MASK, 0);
 }
 
 static int max98927_mono_out_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_get(kcontrol, ucontrol,
-		MAX98927_PCM_to_speaker_monomix_A,
-		MAX98927_PCM_to_spkmonomix_A_DMONOMIX_CFG_Mask,
-		MAX98927_PCM_to_speaker_monomix_A_SHIFT);
+		MAX98927_R0025_PCM_TO_SPK_MONOMIX_A,
+		MAX98927_PCM_TO_SPK_MONOMIX_CFG_MASK,
+		MAX98927_PCM_TO_SPK_MONOMIX_CFG_SHIFT);
 }
 
 static int max98927_mono_out_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_put(kcontrol, ucontrol,
-		MAX98927_PCM_to_speaker_monomix_A,
-		MAX98927_PCM_to_spkmonomix_A_DMONOMIX_CFG_Mask,
-		MAX98927_PCM_to_speaker_monomix_A_SHIFT);
+		MAX98927_R0025_PCM_TO_SPK_MONOMIX_A,
+		MAX98927_PCM_TO_SPK_MONOMIX_CFG_MASK,
+		MAX98927_PCM_TO_SPK_MONOMIX_CFG_SHIFT);
 }
 
 static bool max98927_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case 0x0001 ... 0x0028:
-	case 0x002B ... 0x004E:
+	case 0x002B ... 0x002C:
+	case 0x002E ... 0x004E:
 	case 0x0051 ... 0x0055:
 	case 0x005A ... 0x0061:
 	case 0x0072 ... 0x0087:
@@ -630,33 +662,39 @@ static bool max98927_readable_register(struct device *dev, unsigned int reg)
 };
 
 static const struct snd_kcontrol_new max98927_snd_controls[] = {
-	SOC_SINGLE_EXT_TLV("Speaker Volume", MAX98927_Speaker_Gain,
-		0, (1<<MAX98927_Speaker_Gain_Width)-1, 0,
+	SOC_SINGLE_EXT_TLV("Speaker Volume",
+		MAX98927_R003C_SPK_GAIN,
+		0, (1<<MAX98927_SPK_GAIN_WIDTH)-1, 0,
 		max98927_spk_gain_get, max98927_spk_gain_put,
 		max98927_spk_tlv),
-	SOC_SINGLE_EXT_TLV("Digital Gain", MAX98927_AMP_volume_control,
+	SOC_SINGLE_EXT_TLV("Digital Gain",
+		MAX98927_R0036_AMP_VOL_CTRL,
 		0, (1<<MAX98927_AMP_VOL_WIDTH)-1, 0,
 		max98927_digital_gain_get, max98927_digital_gain_put,
 		max98927_digital_tlv),
-	SOC_SINGLE_EXT("Amp DSP Enable", MAX98927_Brownout_enables,
-		MAX98927_BDE_DSP_SHIFT, 1, 0,
+	SOC_SINGLE_EXT("Amp DSP Enable",
+		MAX98927_R0052_BROWNOUT_EN,
+		MAX98927_BROWNOUT_DSP_SHIFT, 1, 0,
 		max98927_amp_dsp_get, max98927_amp_dsp_put),
-	SOC_SINGLE_EXT("Ramp Switch", MAX98927_AMP_DSP_Config,
-		MAX98927_SPK_RMP_EN_SHIFT, 1, 1,
+	SOC_SINGLE_EXT("Ramp Switch",
+		MAX98927_R0037_AMP_DSP_CFG,
+		MAX98927_AMP_DSP_CFG_RMP_SHIFT, 1, 1,
 		max98927_ramp_switch_get, max98927_ramp_switch_put),
-	SOC_SINGLE_EXT("DRE EN", MAX98927_DRE_Control,
-		MAX98927_DRE_Control_DRE_SHIFT, 1, 0,
+	SOC_SINGLE_EXT("DRE EN",
+		MAX98927_R0039_DRE_CTRL,
+		MAX98927_DRE_EN_SHIFT, 1, 0,
 		max98927_dre_en_get, max98927_dre_en_put),
-	SOC_SINGLE_EXT("Amp Volume Location", MAX98927_AMP_volume_control,
-		MAX98927_AMP_VOL_LOCATION_SHIFT, 1, 0,
+	SOC_SINGLE_EXT("Amp Volume Location",
+		MAX98927_R0036_AMP_VOL_CTRL,
+		MAX98927_AMP_VOL_SHIFT, 1, 0,
 		max98927_amp_vol_get, max98927_amp_vol_put),
 
 	SOC_ENUM_EXT("Boost Output Voltage", max98927_enum[2],
-	max98927_boost_voltage_get, max98927_boost_voltage_put),
+		max98927_boost_voltage_get, max98927_boost_voltage_put),
 	SOC_ENUM_EXT("Speaker Source", max98927_enum[1],
-	max98927_spk_src_get, max98927_spk_src_put),
+		max98927_spk_src_get, max98927_spk_src_put),
 	SOC_ENUM_EXT("Monomix Output", max98927_enum[0],
-	max98927_mono_out_get, max98927_mono_out_put),
+		max98927_mono_out_get, max98927_mono_out_put),
 };
 
 static const struct snd_soc_dapm_route max98927_audio_map[] = {
@@ -687,75 +725,143 @@ static bool max98927_readable_register(struct device *dev, unsigned int reg)
 static int max98927_probe(struct snd_soc_codec *codec)
 {
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
-	int ret = 0, reg = 0, i;
+	int ret = 0, reg = 0;
 
 	max98927->codec = codec;
 	codec->control_data = max98927->regmap;
 	codec->cache_bypass = 1;
 
 	/* Software Reset */
-	max98927_wrapper_write(max98927,
-		MAX98927_Software_Reset, MAX98927_Software_Reset_RST);
+	regmap_write(max98927->regmap,
+		MAX98927_R0100_SOFT_RESET, MAX98927_SOFT_RESET);
 
-	/* Check Revision ID for the primary MAX98927*/
-	ret = regmap_read(max98927->regmap, MAX98927_REV_ID, &reg);
+	/* Check Revision ID */
+	ret = regmap_read(max98927->regmap,
+		MAX98927_R01FF_REV_ID, &reg);
 	if (ret < 0)
 		dev_err(codec->dev,
-			"Failed to read: 0x%02X\n", MAX98927_REV_ID);
+			"Failed to read: 0x%02X\n", MAX98927_R01FF_REV_ID);
 	else
 		dev_info(codec->dev,
 			"MAX98927 revisionID: 0x%02X\n", reg);
 
-	/* Check Revision ID for the secondary MAX98927*/
-	if (max98927->sub_regmap) {
-		ret = regmap_read(max98927->sub_regmap, MAX98927_REV_ID, &reg);
-		if (ret < 0)
-			dev_err(codec->dev,
-				"Failed to read: 0x%02X from secodnary device\n"
-				, MAX98927_REV_ID);
-		else
-			dev_info(codec->dev,
-				"Secondary device revisionID: 0x%02X\n", reg);
+	/* IV default slot configuration */
+	regmap_write(max98927->regmap,
+		MAX98927_R001C_PCM_TX_HIZ_CTRL_A,
+		0xFF);
+	regmap_write(max98927->regmap,
+		MAX98927_R001D_PCM_TX_HIZ_CTRL_B,
+		0xFF);
+	regmap_write(max98927->regmap,
+		MAX98927_R0025_PCM_TO_SPK_MONOMIX_A,
+		0x80);
+	regmap_write(max98927->regmap,
+		MAX98927_R0026_PCM_TO_SPK_MONOMIX_B,
+		0x1);
+	/* Set inital volume (+13dB) */
+	regmap_write(max98927->regmap,
+		MAX98927_R0036_AMP_VOL_CTRL,
+		0x38);
+	regmap_write(max98927->regmap,
+		MAX98927_R003C_SPK_GAIN,
+		0x05);
+	/* Enable DC blocker */
+	regmap_write(max98927->regmap,
+		MAX98927_R0037_AMP_DSP_CFG,
+		0x03);
+	/* Enable IMON VMON DC blocker */
+	regmap_write(max98927->regmap,
+		MAX98927_R003F_MEAS_DSP_CFG,
+		0xF7);
+	/* Boost Output Voltage & Current limit */
+	regmap_write(max98927->regmap,
+		MAX98927_R0040_BOOST_CTRL0,
+		0x1C);
+	regmap_write(max98927->regmap,
+		MAX98927_R0042_BOOST_CTRL1,
+		0x3E);
+	/* Measurement ADC config */
+	regmap_write(max98927->regmap,
+		MAX98927_R0043_MEAS_ADC_CFG,
+		0x04);
+	regmap_write(max98927->regmap,
+		MAX98927_R0044_MEAS_ADC_BASE_MSB,
+		0x00);
+	regmap_write(max98927->regmap,
+		MAX98927_R0045_MEAS_ADC_BASE_LSB,
+		0x24);
+	/* Brownout Level */
+	regmap_write(max98927->regmap,
+		MAX98927_R007F_BROWNOUT_LVL4_AMP1_CTRL1,
+		0x06);
+	/* Envelope Tracking configuration */
+	regmap_write(max98927->regmap,
+		MAX98927_R0082_ENV_TRACK_VOUT_HEADROOM,
+		0x08);
+	regmap_write(max98927->regmap,
+		MAX98927_R0086_ENV_TRACK_CTRL,
+		0x01);
+	regmap_write(max98927->regmap,
+		MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ,
+		0x10);
+
+	/* voltage, current slot configuration */
+	regmap_write(max98927->regmap,
+		MAX98927_R001E_PCM_TX_CH_SRC_A,
+		(max98927->i_l_slot<<MAX98927_PCM_TX_CH_SRC_A_I_SHIFT|
+		max98927->v_l_slot)&0xFF);
+
+	if (max98927->v_l_slot < 8) {
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001C_PCM_TX_HIZ_CTRL_A,
+			1 << max98927->v_l_slot, 0);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001A_PCM_TX_EN_A,
+			1 << max98927->v_l_slot,
+			1 << max98927->v_l_slot);
+	} else {
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001D_PCM_TX_HIZ_CTRL_B,
+			1 << (max98927->v_l_slot - 8), 0);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001B_PCM_TX_EN_B,
+			1 << (max98927->v_l_slot - 8),
+			1 << (max98927->v_l_slot - 8));
 	}
 
-	/* Register initialization */
-	for (i = 0; i < sizeof(max98927_reg_map)/
-			sizeof(max98927_reg_map[0]); i++)
-		max98927_wrapper_write(max98927,
-			max98927_reg_map[i].reg,
-			max98927_reg_map[i].def);
-
-	if (max98927->regmap)
-		regmap_write(max98927->regmap,
-			MAX98927_PCM_Tx_Channel_Sources_A,
-			(max98927->i_l_slot
-				<<MAX98927_PCM_Tx_Ch_Sources_A_I_SHIFT|
-			max98927->v_l_slot)&0xFF);
-	if (max98927->sub_regmap)
-		regmap_write(max98927->sub_regmap,
-			MAX98927_PCM_Tx_Channel_Sources_A,
-			(max98927->i_r_slot
-				<<MAX98927_PCM_Tx_Ch_Sources_A_I_SHIFT|
-			max98927->v_r_slot)&0xFF);
+	if (max98927->i_l_slot < 8) {
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001C_PCM_TX_HIZ_CTRL_A,
+			1 << max98927->i_l_slot, 0);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001A_PCM_TX_EN_A,
+			1 << max98927->i_l_slot,
+			1 << max98927->i_l_slot);
+	} else {
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001D_PCM_TX_HIZ_CTRL_B,
+			1 << (max98927->i_l_slot - 8), 0);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001B_PCM_TX_EN_B,
+			1 << (max98927->i_l_slot - 8),
+			1 << (max98927->i_l_slot - 8));
+	}
 
 	/* Set interleave mode */
 	if (max98927->interleave_mode)
-		max98927_wrap_update_bits(max98927,
-				MAX98927_PCM_Tx_Channel_Sources_B,
-				MAX98927_PCM_Tx_Channel_Src_INTERLEAVE_Mask,
-				MAX98927_PCM_Tx_Channel_Src_INTERLEAVE_Mask);
-
-	max98927_handle_pdata(codec);
-
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001F_PCM_TX_CH_SRC_B,
+			MAX98927_PCM_TX_CH_INTERLEAVE_MASK,
+			MAX98927_PCM_TX_CH_INTERLEAVE_MASK);
 	return ret;
 }
 
 static const struct snd_soc_codec_driver soc_codec_dev_max98927 = {
 	.probe            = max98927_probe,
-	.dapm_routes = max98927_audio_map,
-	.num_dapm_routes = ARRAY_SIZE(max98927_audio_map),
 	.dapm_widgets = max98927_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(max98927_dapm_widgets),
+	.dapm_routes = max98927_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(max98927_audio_map),
 	.controls = max98927_snd_controls,
 	.num_controls = ARRAY_SIZE(max98927_snd_controls),
 };
@@ -763,74 +869,32 @@ static int max98927_probe(struct snd_soc_codec *codec)
 static const struct regmap_config max98927_regmap = {
 	.reg_bits         = 16,
 	.val_bits         = 8,
-	.max_register     = MAX98927_REV_ID,
-	.reg_defaults     = max98927_reg_map,
-	.num_reg_defaults = ARRAY_SIZE(max98927_reg_map),
+	.max_register     = MAX98927_R01FF_REV_ID,
+	.reg_defaults     = max98927_reg,
+	.num_reg_defaults = ARRAY_SIZE(max98927_reg),
 	.readable_reg	  = max98927_readable_register,
 	.cache_type       = REGCACHE_RBTREE,
 };
 
-static struct i2c_board_info max98927_i2c_sub_board[] = {
-	{
-		I2C_BOARD_INFO("max98927_sub", 0x39),
-	}
-};
-
-static struct i2c_driver max98927_i2c_sub_driver = {
-	.driver = {
-		.name = "max98927_sub",
-		.owner = THIS_MODULE,
-	},
-};
-
-struct i2c_client *max98927_add_sub_device(int bus_id, int slave_addr)
-{
-	struct i2c_client *i2c = NULL;
-	struct i2c_adapter *adapter;
-
-	max98927_i2c_sub_board[0].addr = slave_addr;
-
-	adapter = i2c_get_adapter(bus_id);
-	if (adapter) {
-		i2c = i2c_new_device(adapter, max98927_i2c_sub_board);
-		if (i2c)
-			i2c->dev.driver = &max98927_i2c_sub_driver.driver;
-	}
-
-	return i2c;
-}
-
-int probe_common(struct i2c_client *i2c, struct max98927_priv *max98927)
+static void max98927_slot_config(struct i2c_client *i2c,
+	struct max98927_priv *max98927)
 {
-	int ret = 0, value;
+	int value;
 
-	if (!of_property_read_u32(i2c->dev.of_node, "vmon-l-slot", &value))
+	if (!of_property_read_u32(i2c->dev.of_node,
+		"maxim,vmon-slot-no", &value))
 		max98927->v_l_slot = value & 0xF;
 	else
 		max98927->v_l_slot = 0;
-	if (!of_property_read_u32(i2c->dev.of_node, "imon-l-slot", &value))
+	if (!of_property_read_u32(i2c->dev.of_node,
+		"maxim,imon-slot-no", &value))
 		max98927->i_l_slot = value & 0xF;
 	else
 		max98927->i_l_slot = 1;
-	if (!of_property_read_u32(i2c->dev.of_node, "vmon-r-slot", &value))
-		max98927->v_r_slot = value & 0xF;
-	else
-		max98927->v_r_slot = 2;
-	if (!of_property_read_u32(i2c->dev.of_node, "imon-r-slot", &value))
-		max98927->i_r_slot = value & 0xF;
-	else
-		max98927->i_r_slot = 3;
-
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98927,
-		max98927_dai, ARRAY_SIZE(max98927_dai));
-	if (ret < 0)
-		dev_err(&i2c->dev,
-		    "Failed to register codec: %d\n", ret);
-	return ret;
 }
 
 static int max98927_i2c_probe(struct i2c_client *i2c,
-	const struct i2c_device_id *id)
+		const struct i2c_device_id *id)
 {
 
 	int ret = 0, value;
@@ -847,7 +911,7 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 
 	/* update interleave mode info */
 	if (!of_property_read_u32(i2c->dev.of_node,
-		"interleave_mode", &value)) {
+		"maxim,interleave_mode", &value)) {
 		if (value > 0)
 			max98927->interleave_mode = 1;
 		else
@@ -855,25 +919,7 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	} else
 		max98927->interleave_mode = 0;
 
-	/* update direct configuration info */
-	max98927->regcfg = of_get_property(i2c->dev.of_node,
-			"maxim,regcfg", &max98927->regcfg_sz);
-
-	/* check for secondary MAX98927 */
-	ret = of_property_read_u32(i2c->dev.of_node,
-			"maxim,sub_reg", &max98927->sub_reg);
-	if (ret) {
-		dev_err(&i2c->dev, "Sub-device slave address was not found.\n");
-		max98927->sub_reg = -1;
-	}
-	ret = of_property_read_u32(i2c->dev.of_node,
-			"maxim,sub_bus", &max98927->sub_bus);
-	if (ret) {
-		dev_err(&i2c->dev, "Sub-device bus information was not found.\n");
-		max98927->sub_bus = i2c->adapter->nr;
-	}
-
-	/* regmap initialization for primary device */
+	/* regmap initialization */
 	max98927->regmap
 		= devm_regmap_init_i2c(i2c, &max98927_regmap);
 	if (IS_ERR(max98927->regmap)) {
@@ -883,30 +929,14 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 		goto err;
 	}
 
-	/* regmap initialization for secondary device */
-	if (max98927->sub_reg > 0)	{
-		max98927->sub_i2c = max98927_add_sub_device(max98927->sub_bus,
-			max98927->sub_reg);
-		if (IS_ERR(max98927->sub_i2c)) {
-			dev_err(&max98927->sub_i2c->dev,
-					"Second MAX98927 was not found\n");
-			ret = PTR_ERR(max98927->regmap);
-			goto err;
-		} else {
-			max98927->sub_regmap = regmap_init_i2c(
-					max98927->sub_i2c, &max98927_regmap);
-			if (IS_ERR(max98927->sub_regmap)) {
-				ret = PTR_ERR(max98927->sub_regmap);
-				dev_err(&max98927->sub_i2c->dev,
-					"Failed to allocate sub_regmap: %d\n",
-					ret);
-				goto err;
-			}
-		}
-	}
+	/* voltage/current slot configuration */
+	max98927_slot_config(i2c, max98927);
 
 	/* codec registeration */
-	ret = probe_common(i2c, max98927);
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98927,
+		max98927_dai, ARRAY_SIZE(max98927_dai));
+	if (ret < 0)
+		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
 
 	return ret;
 
@@ -929,16 +959,17 @@ static int max98927_i2c_remove(struct i2c_client *client)
 
 MODULE_DEVICE_TABLE(i2c, max98927_i2c_id);
 
+#if defined(CONFIG_OF)
 static const struct of_device_id max98927_of_match[] = {
 	{ .compatible = "maxim,max98927", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max98927_of_match);
+#endif
 
 static struct i2c_driver max98927_i2c_driver = {
 	.driver = {
 		.name = "max98927",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(max98927_of_match),
 		.pm = NULL,
 	},
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index 2305185..9e5041a 100755
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -1,7 +1,7 @@
 /*
- * max98927.c  --  MAX98927 ALSA Soc Audio driver
+ * max98927.h  --  MAX98927 ALSA Soc Audio driver
  *
- * Copyright 2008-11 Wolfson Microelectronics PLC.
+ * Copyright 2013-15 Maxim Integrated Products
  * Author: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -10,1244 +10,255 @@
  *  option) any later version.
  *
  */
-#ifndef __MAX98927_REGISTERDEFS_H
-#define __MAX98927_REGISTERDEFS_H
-#ifdef CONFIG_SND_SOC_MAXIM_DSM
-#include <sound/maxim_dsm.h>
-#endif /* CONFIG_SND_SOC_MAXIM_DSM */
+#ifndef _MAX98927_H
+#define _MAX98927_H
+
+/* Register Values */
+#define MAX98927_R0001_INT_RAW1 0x0001
+#define MAX98927_R0002_INT_RAW2 0x0002
+#define MAX98927_R0003_INT_RAW3 0x0003
+#define MAX98927_R0004_INT_STATE1 0x0004
+#define MAX98927_R0005_INT_STATE2 0x0005
+#define MAX98927_R0006_INT_STATE3 0x0006
+#define MAX98927_R0007_INT_FLAG1 0x0007
+#define MAX98927_R0008_INT_FLAG2 0x0008
+#define MAX98927_R0009_INT_FLAG3 0x0009
+#define MAX98927_R000A_INT_EN1 0x000A
+#define MAX98927_R000B_INT_EN2 0x000B
+#define MAX98927_R000C_INT_EN3 0x000C
+#define MAX98927_R000D_INT_FLAG_CLR1	0x000D
+#define MAX98927_R000E_INT_FLAG_CLR2	0x000E
+#define MAX98927_R000F_INT_FLAG_CLR3	0x000F
+#define MAX98927_R0010_IRQ_CTRL 0x0010
+#define MAX98927_R0011_CLK_MON 0x0011
+#define MAX98927_R0012_WDOG_CTRL 0x0012
+#define MAX98927_R0013_WDOG_RST 0x0013
+#define MAX98927_R0014_MEAS_ADC_THERM_WARN_THRESH 0x0014
+#define MAX98927_R0015_MEAS_ADC_THERM_SHDN_THRESH 0x0015
+#define MAX98927_R0016_MEAS_ADC_THERM_HYSTERESIS 0x0016
+#define MAX98927_R0017_PIN_CFG 0x0017
+#define MAX98927_R0018_PCM_RX_EN_A 0x0018
+#define MAX98927_R0019_PCM_RX_EN_B 0x0019
+#define MAX98927_R001A_PCM_TX_EN_A 0x001A
+#define MAX98927_R001B_PCM_TX_EN_B 0x001B
+#define MAX98927_R001C_PCM_TX_HIZ_CTRL_A 0x001C
+#define MAX98927_R001D_PCM_TX_HIZ_CTRL_B 0x001D
+#define MAX98927_R001E_PCM_TX_CH_SRC_A 0x001E
+#define MAX98927_R001F_PCM_TX_CH_SRC_B 0x001F
+#define MAX98927_R0020_PCM_MODE_CFG 0x0020
+#define MAX98927_R0021_PCM_MASTER_MODE 0x0021
+#define MAX98927_R0022_PCM_CLK_SETUP 0x0022
+#define MAX98927_R0023_PCM_SR_SETUP1 0x0023
+#define MAX98927_R0024_PCM_SR_SETUP2	0x0024
+#define MAX98927_R0025_PCM_TO_SPK_MONOMIX_A 0x0025
+#define MAX98927_R0026_PCM_TO_SPK_MONOMIX_B 0x0026
+#define MAX98927_R0027_ICC_RX_EN_A 0x0027
+#define MAX98927_R0028_ICC_RX_EN_B 0x0028
+#define MAX98927_R002B_ICC_TX_EN_A 0x002B
+#define MAX98927_R002C_ICC_TX_EN_B 0x002C
+#define MAX98927_R002E_ICC_HIZ_MANUAL_MODE 0x002E
+#define MAX98927_R002F_ICC_TX_HIZ_EN_A 0x002F
+#define MAX98927_R0030_ICC_TX_HIZ_EN_B 0x0030
+#define MAX98927_R0031_ICC_LNK_EN 0x0031
+#define MAX98927_R0032_PDM_TX_EN 0x0032
+#define MAX98927_R0033_PDM_TX_HIZ_CTRL 0x0033
+#define MAX98927_R0034_PDM_TX_CTRL 0x0034
+#define MAX98927_R0035_PDM_RX_CTRL 0x0035
+#define MAX98927_R0036_AMP_VOL_CTRL 0x0036
+#define MAX98927_R0037_AMP_DSP_CFG 0x0037
+#define MAX98927_R0038_TONE_GEN_DC_CFG 0x0038
+#define MAX98927_R0039_DRE_CTRL 0x0039
+#define MAX98927_R003A_AMP_EN 0x003A
+#define MAX98927_R003B_SPK_SRC_SEL 0x003B
+#define MAX98927_R003C_SPK_GAIN 0x003C
+#define MAX98927_R003D_SSM_CFG 0x003D
+#define MAX98927_R003E_MEAS_EN 0x003E
+#define MAX98927_R003F_MEAS_DSP_CFG 0x003F
+#define MAX98927_R0040_BOOST_CTRL0 0x0040
+#define MAX98927_R0041_BOOST_CTRL3 0x0041
+#define MAX98927_R0042_BOOST_CTRL1 0x0042
+#define MAX98927_R0043_MEAS_ADC_CFG 0x0043
+#define MAX98927_R0044_MEAS_ADC_BASE_MSB 0x0044
+#define MAX98927_R0045_MEAS_ADC_BASE_LSB 0x0045
+#define MAX98927_R0046_ADC_CH0_DIVIDE 0x0046
+#define MAX98927_R0047_ADC_CH1_DIVIDE 0x0047
+#define MAX98927_R0048_ADC_CH2_DIVIDE 0x0048
+#define MAX98927_R0049_ADC_CH0_FILT_CFG 0x0049
+#define MAX98927_R004A_ADC_CH1_FILT_CFG 0x004A
+#define MAX98927_R004B_ADC_CH2_FILT_CFG 0x004B
+#define MAX98927_R004C_MEAS_ADC_CH0_READ 0x004C
+#define MAX98927_R004D_MEAS_ADC_CH1_READ 0x004D
+#define MAX98927_R004E_MEAS_ADC_CH2_READ 0x004E
+#define MAX98927_R0051_BROWNOUT_STATUS 0x0051
+#define MAX98927_R0052_BROWNOUT_EN 0x0052
+#define MAX98927_R0053_BROWNOUT_INFINITE_HOLD 0x0053
+#define MAX98927_R0054_BROWNOUT_INFINITE_HOLD_CLR 0x0054
+#define MAX98927_R0055_BROWNOUT_LVL_HOLD 0x0055
+#define MAX98927_R005A_BROWNOUT_LVL1_THRESH 0x005A
+#define MAX98927_R005B_BROWNOUT_LVL2_THRESH 0x005B
+#define MAX98927_R005C_BROWNOUT_LVL3_THRESH 0x005C
+#define MAX98927_R005D_BROWNOUT_LVL4_THRESH 0x005D
+#define MAX98927_R005E_BROWNOUT_THRESH_HYSTERYSIS 0x005E
+#define MAX98927_R005F_BROWNOUT_AMP_LIMITER_ATK_REL 0x005F
+#define MAX98927_R0060_BROWNOUT_AMP_GAIN_ATK_REL 0x0060
+#define MAX98927_R0061_BROWNOUT_AMP1_CLIP_MODE 0x0061
+#define MAX98927_R0072_BROWNOUT_LVL1_CUR_LIMIT 0x0072
+#define MAX98927_R0073_BROWNOUT_LVL1_AMP1_CTRL1 0x0073
+#define MAX98927_R0074_BROWNOUT_LVL1_AMP1_CTRL2 0x0074
+#define MAX98927_R0075_BROWNOUT_LVL1_AMP1_CTRL3 0x0075
+#define MAX98927_R0076_BROWNOUT_LVL2_CUR_LIMIT 0x0076
+#define MAX98927_R0077_BROWNOUT_LVL2_AMP1_CTRL1 0x0077
+#define MAX98927_R0078_BROWNOUT_LVL2_AMP1_CTRL2 0x0078
+#define MAX98927_R0079_BROWNOUT_LVL2_AMP1_CTRL3 0x0079
+#define MAX98927_R007A_BROWNOUT_LVL3_CUR_LIMIT 0x007A
+#define MAX98927_R007B_BROWNOUT_LVL3_AMP1_CTRL1 0x007B
+#define MAX98927_R007C_BROWNOUT_LVL3_AMP1_CTRL2 0x007C
+#define MAX98927_R007D_BROWNOUT_LVL3_AMP1_CTRL3 0x007D
+#define MAX98927_R007E_BROWNOUT_LVL4_CUR_LIMIT 0x007E
+#define MAX98927_R007F_BROWNOUT_LVL4_AMP1_CTRL1 0x007F
+#define MAX98927_R0080_BROWNOUT_LVL4_AMP1_CTRL2 0x0080
+#define MAX98927_R0081_BROWNOUT_LVL4_AMP1_CTRL3 0x0081
+#define MAX98927_R0082_ENV_TRACK_VOUT_HEADROOM 0x0082
+#define MAX98927_R0083_ENV_TRACK_BOOST_VOUT_DELAY 0x0083
+#define MAX98927_R0084_ENV_TRACK_REL_RATE 0x0084
+#define MAX98927_R0085_ENV_TRACK_HOLD_RATE 0x0085
+#define MAX98927_R0086_ENV_TRACK_CTRL 0x0086
+#define MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ 0x0087
+#define MAX98927_R00FF_GLOBAL_SHDN 0x00FF
+#define MAX98927_R0100_SOFT_RESET 0x0100
+#define MAX98927_R01FF_REV_ID 0x01FF
+
+/* MAX98927_R0018_PCM_RX_EN_A */
+#define MAX98927_PCM_RX_CH0_EN (0x1 << 0)
+#define MAX98927_PCM_RX_CH1_EN (0x1 << 1)
+#define MAX98927_PCM_RX_CH2_EN (0x1 << 2)
+#define MAX98927_PCM_RX_CH3_EN (0x1 << 3)
+#define MAX98927_PCM_RX_CH4_EN (0x1 << 4)
+#define MAX98927_PCM_RX_CH5_EN (0x1 << 5)
+#define MAX98927_PCM_RX_CH6_EN (0x1 << 6)
+#define MAX98927_PCM_RX_CH7_EN (0x1 << 7)
+
+/* MAX98927_R001A_PCM_TX_EN_A */
+#define MAX98927_PCM_TX_CH0_EN (0x1 << 0)
+#define MAX98927_PCM_TX_CH1_EN (0x1 << 1)
+#define MAX98927_PCM_TX_CH2_EN (0x1 << 2)
+#define MAX98927_PCM_TX_CH3_EN (0x1 << 3)
+#define MAX98927_PCM_TX_CH4_EN (0x1 << 4)
+#define MAX98927_PCM_TX_CH5_EN (0x1 << 5)
+#define MAX98927_PCM_TX_CH6_EN (0x1 << 6)
+#define MAX98927_PCM_TX_CH7_EN (0x1 << 7)
+
+/* MAX98927_R001E_PCM_TX_CH_SRC_A */
+#define MAX98927_PCM_TX_CH_SRC_A_V_SHIFT (0)
+#define MAX98927_PCM_TX_CH_SRC_A_I_SHIFT (4)
+
+/* MAX98927_R001F_PCM_TX_CH_SRC_B */
+#define MAX98927_PCM_TX_CH_INTERLEAVE_MASK (0x1 << 5)
+
+/* MAX98927_R0020_PCM_MODE_CFG */
+#define MAX98927_PCM_MODE_CFG_PCM_BCLKEDGE (0x1 << 2)
+#define MAX98927_PCM_MODE_CFG_FORMAT_MASK (0x7 << 3)
+
+#define MAX98927_PCM_MODE_CFG_CHANSZ_16 (0x1 << 6)
+#define MAX98927_PCM_MODE_CFG_CHANSZ_24 (0x2 << 6)
+#define MAX98927_PCM_MODE_CFG_CHANSZ_32 (0x3 << 6)
+
+/* MAX98927_R0021_PCM_MASTER_MODE */
+#define MAX98927_PCM_MASTER_MODE_MASK (0x3 << 0)
+#define MAX98927_PCM_MASTER_MODE_SLAVE (0x0 << 0)
+#define MAX98927_PCM_MASTER_MODE_MASTER (0x3 << 0)
+#define MAX98927_PCM_MASTER_MODE_HYBRID (0x1 << 0)
+
+#define MAX98927_PCM_MASTER_MODE_MCLK_MASK (0xF << 2)
+#define MAX98927_PCM_MASTER_MODE_MCLK_RATE_SHIFT (2)
+
+/* MAX98927_R0022_PCM_CLK_SETUP */
+#define MAX98927_PCM_CLK_SETUP_BSEL_MASK (0xF << 0)
+
+/* MAX98927_R0023_PCM_SR_SETUP1 */
+#define MAX98927_PCM_SR_SET1_SR_MASK (0xF << 0)
+
+#define MAX98927_PCM_SR_SET1_SR_8000 (0x0 << 0)
+#define MAX98927_PCM_SR_SET1_SR_11025 (0x1 << 0)
+#define MAX98927_PCM_SR_SET1_SR_12000 (0x2 << 0)
+#define MAX98927_PCM_SR_SET1_SR_16000 (0x3 << 0)
+#define MAX98927_PCM_SR_SET1_SR_22050 (0x4 << 0)
+#define MAX98927_PCM_SR_SET1_SR_24000 (0x5 << 0)
+#define MAX98927_PCM_SR_SET1_SR_32000 (0x6 << 0)
+#define MAX98927_PCM_SR_SET1_SR_44100 (0x7 << 0)
+#define MAX98927_PCM_SR_SET1_SR_48000 (0x8 << 0)
+
+/* MAX98927_R0024_PCM_SR_SETUP2 */
+#define MAX98927_PCM_SR_SET2_SR_MASK (0xF << 4)
+#define MAX98927_PCM_SR_SET2_SR_SHIFT (4)
+#define MAX98927_PCM_SR_SET2_IVADC_SR_MASK (0xf << 0)
+
+/* MAX98927_R0025_PCM_TO_SPK_MONOMIX_A */
+#define MAX98927_PCM_TO_SPK_MONOMIX_CFG_MASK (0x3 << 6)
+#define MAX98927_PCM_TO_SPK_MONOMIX_CFG_SHIFT (6)
+
+/* MAX98927_R0036_AMP_VOL_CTRL */
+#define MAX98927_AMP_VOL_MASK (0x7f << 0)
+#define MAX98927_AMP_VOL_SEL (0x1 << 7)
+#define MAX98927_AMP_VOL_WIDTH (3)
+#define MAX98927_AMP_VOL_SHIFT (7)
+
+/* MAX98927_R0037_AMP_DSP_CFG */
+#define MAX98927_AMP_DSP_CFG_DCBLK_EN (0x1 << 0)
+#define MAX98927_AMP_DSP_CFG_DITH_EN (0x1 << 1)
+#define MAX98927_AMP_DSP_CFG_RMP_BYPASS (0x1 << 4)
+#define MAX98927_AMP_DSP_CFG_DAC_INV (0x1 << 5)
+#define MAX98927_AMP_DSP_CFG_RMP_SHIFT (4)
+
+/* MAX98927_R0039_DRE_CTRL */
+#define MAX98927_DRE_CTRL_DRE_EN	(0x1 << 0)
+#define MAX98927_DRE_EN_SHIFT 0x1
+
+/* MAX98927_R003A_AMP_EN */
+#define MAX98927_AMP_EN_MASK (0x1 << 0)
+
+/* MAX98927_R003B_SPK_SRC_SEL */
+#define MAX98927_SPK_SRC_MASK (0x3 << 0)
+
+/* MAX98927_R003C_SPK_GAIN */
+#define MAX98927_SPK_PCM_GAIN_MASK (0x7 << 0)
+#define MAX98927_SPK_PDM_GAIN_MASK (0x7 << 4)
+#define MAX98927_SPK_GAIN_WIDTH (3)
+
+/* MAX98927_R003E_MEAS_EN */
+#define MAX98927_MEAS_V_EN (0x1 << 0)
+#define MAX98927_MEAS_I_EN (0x1 << 1)
+
+/* MAX98927_R0040_BOOST_CTRL0 */
+#define MAX98927_BOOST_CTRL0_VOUT_MASK (0x1f << 0)
+#define MAX98927_BOOST_CTRL0_PVDD_MASK (0x1 << 7)
+#define MAX98927_BOOST_CTRL0_PVDD_EN_SHIFT (7)
+
+/* MAX98927_R0052_BROWNOUT_EN */
+#define MAX98927_BROWNOUT_BDE_EN (0x1 << 0)
+#define MAX98927_BROWNOUT_AMP_EN (0x1 << 1)
+#define MAX98927_BROWNOUT_DSP_EN (0x1 << 2)
+#define MAX98927_BROWNOUT_DSP_SHIFT (2)
+
+/* MAX98927_R0100_SOFT_RESET */
+#define MAX98927_SOFT_RESET (0x1 << 0)
+
+/* MAX98927_R00FF_GLOBAL_SHDN */
+#define MAX98927_GLOBAL_EN_MASK (0x1 << 0)
 
-enum {
-	PRI_MAX98927 = 0,
-	SEC_MAX98927 = 1,
-	MAX_DEV_ID_MAX98927,
-} MAX98927deviceID;
-
-enum {
-	/*Interrupt Raw 1 (Address 0x0001)*/
-	MAX98927_Interrupt_Raw_1 = 0x0001,
-	MAX98927_Interrupt_Raw_1_BDE_ACTIVE_END_RAW = (0x1 << 0),
-	MAX98927_Interrupt_Raw_1_BDE_ACTIVE_BGN_RAW = (0x1 << 1),
-	MAX98927_Interrupt_Raw_1_BDE_LEVEL_CHANGE_RAW = (0x1 << 2),
-	MAX98927_Interrupt_Raw_1_BDE_L8_RAW = (0x1 << 3),
-	MAX98927_Interrupt_Raw_1_THERMWARN_END_RAW = (0x1 << 4),
-	MAX98927_Interrupt_Raw_1_THERMWARN_START_RAW = (0x1 << 5),
-	MAX98927_Interrupt_Raw_1_THERMSHDN_END_RAW = (0x1 << 6),
-	MAX98927_Interrupt_Raw_1_THERMSHDN_START_RAW = (0x1 << 7),
-
-	/* Interrupt Raw 2 (Address 0x0002)*/
-	MAX98927_Interrupt_Raw_2 = 0x0002,
-	MAX98927_Interrupt_Raw_2_WATCHDOGWARN_RAW = (0x1 << 0),
-	MAX98927_Interrupt_Raw_2_WATCHDOGFAIL_RAW = (0x1 << 1),
-	MAX98927_Interrupt_Raw_2_BOOSTCURRLIM_RAW = (0x1 << 2),
-	MAX98927_Interrupt_Raw_2_CLKSTOP_RAW = (0x1 << 3),
-	MAX98927_Interrupt_Raw_2_CLKSTART_RAW = (0x1 << 4),
-	MAX98927_Interrupt_Raw_2_MEASADC_END_RAW = (0x1 << 5),
-	MAX98927_Interrupt_Raw_2_PWRDN_DONE_RAW = (0x1 << 6),
-	MAX98927_Interrupt_Raw_2_PWRUP_DONE_RAW = (0x1 << 7),
-
-	/* Interrupt Raw 3 (Address 0x0003)*/
-	MAX98927_Interrupt_Raw_3  = 0x0003,
-	MAX98927_Interrupt_Raw_3_PWRUP_FAIL_RAW = (0x1 << 0),
-	MAX98927_Interrupt_Raw_3_AUTH_DONE_RAW  = (0x1 << 1),
-	MAX98927_Interrupt_Raw_3_SPK_OVC_RAW = (0x1 << 2),
-	MAX98927_Interrupt_Raw_3_BST_UVLO_RAW = (0x1 << 3),
-
-	/* Interrupt State 1 (Address 0x0004)*/
-	MAX98927_Interrupt_State_1  = 0x0004,
-	MAX98927_Interrupt_State_1_BDE_ACTIVE_END_STATE  = (0x1 << 0),
-	MAX98927_Interrupt_State_1_BDE_ACTIVE_BGN_STATE  = (0x1 << 1),
-	MAX98927_Interrupt_State_1_BDE_LEVEL_CHANGE_STATE  = (0x1 << 2),
-	MAX98927_Interrupt_State_1_BDE_L8_STATE = (0x1 << 3),
-	MAX98927_Interrupt_State_1_THERMWARN_END_STATE   = (0x1 << 4),
-	MAX98927_Interrupt_State_1_THERMWARN_START_STATE = (0x1 << 5),
-	MAX98927_Interrupt_State_1_THERMSHDN_END_STATE   = (0x1 << 6),
-	MAX98927_Interrupt_State_1_THERMSHDN_START_STATE = (0x1 << 7),
-
-	/* Interrupt State 2 (Address 0x0005)*/
-	MAX98927_Interrupt_State_2  = 0x0005,
-	MAX98927_Interrupt_State_2_WATCHDOGWARN_STATE = (0x1 << 0),
-	MAX98927_Interrupt_State_2_WATCHDOGFAIL_STATE = (0x1 << 1),
-	MAX98927_Interrupt_State_2_BOOSTCURRLIM_STATE = (0x1 << 2),
-	MAX98927_Interrupt_State_2_CLKSTOP_STATE  = (0x1 << 3),
-	MAX98927_Interrupt_State_2_CLKSTART_STATE = (0x1 << 4),
-	MAX98927_Interrupt_State_2_MEASADC_END_STATE = (0x1 << 5),
-	MAX98927_Interrupt_State_2_PWRDN_DONE_STATE  = (0x1 << 6),
-	MAX98927_Interrupt_State_2_PWRUP_DONE_STATE  = (0x1 << 7),
-
-	/* Interrupt State 3 (Address 0x0006)*/
-	MAX98927_Interrupt_State_3  = 0x0006,
-	MAX98927_Interrupt_State_3_PWRUP_FAIL_STATE  = (0x1 << 0),
-	MAX98927_Interrupt_State_3_AUTH_DONE_STATE = (0x1 << 1),
-	MAX98927_Interrupt_State_3_SPK_OVC_STATE  = (0x1 << 2),
-	MAX98927_Interrupt_State_3_BST_UVLO_STATE = (0x1 << 3),
-
-	/* Interrupt Flag 1 (Address 0x0007)*/
-	MAX98927_Interrupt_Flag_1 = 0x0007,
-	MAX98927_Interrupt_Flag_1_BDE_ACTIVE_END_FLAG = (0x1 << 0),
-	MAX98927_Interrupt_Flag_1_BDE_ACTIVE_BGN_FLAG = (0x1 << 1),
-	MAX98927_Interrupt_Flag_1_BDE_LEVEL_CHANGE_FLAG  = (0x1 << 2),
-	MAX98927_Interrupt_Flag_1_BDE_L8_FLAG = (0x1 << 3),
-	MAX98927_Interrupt_Flag_1_THERMWARN_END_FLAG = (0x1 << 4),
-	MAX98927_Interrupt_Flag_1_THERMWARN_START_FLAG   = (0x1 << 5),
-	MAX98927_Interrupt_Flag_1_THERMSHDN_END_FLAG = (0x1 << 6),
-	MAX98927_Interrupt_Flag_1_THERMSHDN_START_FLAG   = (0x1 << 7),
-
-	/* Interrupt Flag 2 (Address 0x0008)*/
-	MAX98927_Interrupt_Flag_2 = 0x0008,
-	MAX98927_Interrupt_Flag_2_WATCHDOGWARN_FLAG  = (0x1 << 0),
-	MAX98927_Interrupt_Flag_2_WATCHDOGFAIL_FLAG  = (0x1 << 1),
-	MAX98927_Interrupt_Flag_2_BOOSTCURRLIM_FLAG  = (0x1 << 2),
-	MAX98927_Interrupt_Flag_2_CLKSTOP_FLAG  = (0x1 << 3),
-	MAX98927_Interrupt_Flag_2_CLKSTART_FLAG = (0x1 << 4),
-	MAX98927_Interrupt_Flag_2_MEASADC_END_FLAG = (0x1 << 5),
-	MAX98927_Interrupt_Flag_2_PWRDN_DONE_FLAG = (0x1 << 6),
-	MAX98927_Interrupt_Flag_2_PWRUP_DONE_FLAG = (0x1 << 7),
-
-	/* Interrupt Flag 3 (Address 0x0009)*/
-	MAX98927_Interrupt_Flag_3 = 0x0009,
-	MAX98927_Interrupt_Flag_3_PWRUP_FAIL_FLAG = (0x1 << 0),
-	MAX98927_Interrupt_Flag_3_AUTH_DONE_FLAG  = (0x1 << 1),
-	MAX98927_Interrupt_Flag_3_SPK_OVC_FLAG  = (0x1 << 2),
-	MAX98927_Interrupt_Flag_3_BST_UVLO_FLAG = (0x1 << 3),
-
-	/* Interrupt Enable 1 (Address 0x000a)*/
-	MAX98927_Interrupt_Enable_1 = 0x000a,
-	MAX98927_Interrupt_Enable_1_BDE_ACTIVE_END_EN = (0x1 << 0),
-	MAX98927_Interrupt_Enable_1_BDE_ACTIVE_BGN_EN = (0x1 << 1),
-	MAX98927_Interrupt_Enable_1_BDE_LEVEL_CHANGE_EN  = (0x1 << 2),
-	MAX98927_Interrupt_Enable_1_BDE_L8_EN = (0x1 << 3),
-	MAX98927_Interrupt_Enable_1_THERMWARN_END_EN = (0x1 << 4),
-	MAX98927_Interrupt_Enable_1_THERMWARN_START_EN   = (0x1 << 5),
-	MAX98927_Interrupt_Enable_1_THERMSHDN_END_EN = (0x1 << 6),
-	MAX98927_Interrupt_Enable_1_THERMSHDN_START_EN   = (0x1 << 7),
-
-	/* Interrupt Enable 2 (Address 0x000b)*/
-	MAX98927_Interrupt_Enable_2 = 0x000b,
-	MAX98927_Interrupt_Enable_2_WATCHDOGWARN_EN  = (0x1 << 0),
-	MAX98927_Interrupt_Enable_2_WATCHDOGFAIL_EN  = (0x1 << 1),
-	MAX98927_Interrupt_Enable_2_BOOSTCURRLIM_EN  = (0x1 << 2),
-	MAX98927_Interrupt_Enable_2_CLKSTOP_EN  = (0x1 << 3),
-	MAX98927_Interrupt_Enable_2_CLKSTART_EN = (0x1 << 4),
-	MAX98927_Interrupt_Enable_2_MEASADC_END_EN = (0x1 << 5),
-	MAX98927_Interrupt_Enable_2_PWRDN_DONE_EN = (0x1 << 6),
-	MAX98927_Interrupt_Enable_2_PWRUP_DONE_EN = (0x1 << 7),
-
-	/* Interrupt Enable 3 (Address 0x000c)*/
-	MAX98927_Interrupt_Enable_3 = 0x000c,
-	MAX98927_Interrupt_Enable_3_PWRUP_FAIL_EN = (0x1 << 0),
-	MAX98927_Interrupt_Enable_3_AUTH_DONE_EN  = (0x1 << 1),
-	MAX98927_Interrupt_Enable_3_SPK_OVC_EN  = (0x1 << 2),
-	MAX98927_Interrupt_Enable_3_BST_UVLO_EN = (0x1 << 3),
-
-	/* Interrupt Flag Clear 1 (Address 0x000d)*/
-	MAX98927_Interrupt_Flag_Clear_1  = 0x000d,
-	MAX98927_Interrupt_Flag_Clear_1_BDE_ACTIVE_END_CLR = (0x1 << 0),
-	MAX98927_Interrupt_Flag_Clear_1_BDE_ACTIVE_BGN_CLR = (0x1 << 1),
-	MAX98927_Interrupt_Flag_Clear_1_BDE_LEVEL_CHANGE_CLR = (0x1 << 2),
-	MAX98927_Interrupt_Flag_Clear_1_BDE_L8_CLR = (0x1 << 3),
-	MAX98927_Interrupt_Flag_Clear_1_THERMWARN_END_CLR  = (0x1 << 4),
-	MAX98927_Interrupt_Flag_Clear_1_THERMWARN_START_CLR  = (0x1 << 5),
-	MAX98927_Interrupt_Flag_Clear_1_THERMSHDN_END_CLR  = (0x1 << 6),
-	MAX98927_Interrupt_Flag_Clear_1_THERMSHDN_START_CLR  = (0x1 << 7),
-
-	/* Interrupt Flag Clear 2 (Address 0x000e)*/
-	MAX98927_Interrupt_Flag_Clear_2  = 0x000e,
-	MAX98927_Interrupt_Flag_Clear_2_WATCHDOGWARN_CLR = (0x1 << 0),
-	MAX98927_Interrupt_Flag_Clear_2_WATCHDOGFAIL_CLR = (0x1 << 1),
-	MAX98927_Interrupt_Flag_Clear_2_BOOSTCURRLIM_CLR = (0x1 << 2),
-	MAX98927_Interrupt_Flag_Clear_2_CLKSTOP_CLR  = (0x1 << 3),
-	MAX98927_Interrupt_Flag_Clear_2_CLKSTART_CLR = (0x1 << 4),
-	MAX98927_Interrupt_Flag_Clear_2_MEASADC_END_CLR  = (0x1 << 5),
-	MAX98927_Interrupt_Flag_Clear_2_PWRDN_DONE_CLR   = (0x1 << 6),
-	MAX98927_Interrupt_Flag_Clear_2_PWRUP_DONE_CLR   = (0x1 << 7),
-
-	/* Interrupt Flag Clear 3 (Address 0x000f)*/
-	MAX98927_Interrupt_Flag_Clear_3  = 0x000f,
-	MAX98927_Interrupt_Flag_Clear_3_PWRUP_FAIL_CLR   = (0x1 << 0),
-	MAX98927_Interrupt_Flag_Clear_3_AUTH_DONE_CLR = (0x1 << 1),
-	MAX98927_Interrupt_Flag_Clear_3_SPK_OVC_CLR  = (0x1 << 2),
-	MAX98927_Interrupt_Flag_Clear_3_BST_UVLO_CLR = (0x1 << 3),
-
-	/* IRQ Control (Address 0x0010)*/
-	MAX98927_IRQ_Control  = 0x0010,
-	MAX98927_IRQ_Control_IRQ_EN = (0x1 << 0),
-	MAX98927_IRQ_Control_IRQ_POL  = (0x1 << 1),
-	MAX98927_IRQ_Control_IRQ_MODE = (0x1 << 2),
-
-	/* Clock monitor enable (Address 0x0011)*/
-	MAX98927_Clock_monitor_enable = 0x0011,
-	MAX98927_Clock_monitor_enable_CMON_ENA  = (0x1 << 0),
-	MAX98927_Clock_monitor_enable_CMON_AUTORESTART_ENA = (0x1 << 1),
-
-	/* Watchdog Control (Address 0x0012)*/
-	MAX98927_Watchdog_Control = 0x0012,
-	MAX98927_Watchdog_Control_WDT_ENA  = (0x1 << 0),
-	MAX98927_Watchdog_Control_WDT_MODE = (0x1 << 1),
-	MAX98927_Watchdog_Control_WDT_TO_SEL_Mask = (0x3 << 2),
-	MAX98927_Watchdog_Control_WDT_TO_SEL_5  = (0x0 << 2),
-	MAX98927_Watchdog_Control_WDT_TO_SEL_10 = (0x1 << 2),
-	MAX98927_Watchdog_Control_WDT_TO_SEL_35 = (0x2 << 2),
-	MAX98927_Watchdog_Control_WDT_TO_SEL_50 = (0x3 << 2),
-	MAX98927_Watchdog_Control_WDT_HW_SOURCE = (0x1 << 4),
-
-	/* Watchdog SW Reset (Address 0x0013)*/
-	MAX98927_Watchdog_SW_Reset  = 0x0013,
-	MAX98927_Watchdog_SW_Reset_WDT_SW_RST_Mask = (0xff << 0),
-
-	/* Meas ADC Thermal Warning Threshhold (Address 0x0014)*/
-	MAX98927_Meas_ADC_TW_Threshhold = 0x0014,
-	MAX98927_Meas_ADC_TW_Threshhold_MEAS_ADC_WARN_THRESH_Mask
-		= (0xff << 0),
-
-	/* Meas ADC Thermal Shutdown Threshhold (Address 0x0015)*/
-	MAX98927_Meas_ADC_TS_Threshhold = 0x0015,
-	MAX98927_Meas_ADC_TS_Threshhold_MEAS_ADC_SHDN_THRESH_Mask
-		= (0xff << 0),
-
-	/* Meas ADC Thermal Hysteresis (Address 0x0016)*/
-	MAX98927_Meas_ADC_Thermal_Hysteresis = 0x0016,
-	MAX98927_Meas_ADC_TH_MEAS_ADC_THERM_HYST_Mask  = (0x1f << 0),
-
-	/* Pin Config (Address 0x0017)*/
-	MAX98927_Pin_Config = 0x0017,
-	MAX98927_Pin_Config_DOUT_DRV_Mask  = (0x3 << 0),
-	MAX98927_Pin_Config_DOUT_DRV_01  = (0x0 << 0),
-	MAX98927_Pin_Config_DOUT_DRV_11  = (0x2 << 0),
-	MAX98927_Pin_Config_BCLK_DRV_Mask  = (0x3 << 2),
-	MAX98927_Pin_Config_BCLK_DRV_01  = (0x0 << 2),
-	MAX98927_Pin_Config_BCLK_DRV_11  = (0x2 << 2),
-	MAX98927_Pin_Config_LRCLK_DRV_Mask = (0x3 << 4),
-	MAX98927_Pin_Config_LRCLK_DRV_01 = (0x0 << 4),
-	MAX98927_Pin_Config_LRCLK_DRV_11 = (0x2 << 4),
-	MAX98927_Pin_Config_ICC_DRV_Mask = (0x3 << 6),
-	MAX98927_Pin_Config_ICC_DRV_01 = (0x0 << 6),
-	MAX98927_Pin_Config_ICC_DRV_11 = (0x2 << 6),
-
-	/* PCM Rx Enables A (Address 0x0018)*/
-	MAX98927_PCM_Rx_Enables_A = 0x0018,
-	MAX98927_PCM_Rx_Enables_A_PCM_RX_CH0_EN = (0x1 << 0),
-	MAX98927_PCM_Rx_Enables_A_PCM_RX_CH1_EN = (0x1 << 1),
-	MAX98927_PCM_Rx_Enables_A_PCM_RX_CH2_EN = (0x1 << 2),
-	MAX98927_PCM_Rx_Enables_A_PCM_RX_CH3_EN = (0x1 << 3),
-	MAX98927_PCM_Rx_Enables_A_PCM_RX_CH4_EN = (0x1 << 4),
-	MAX98927_PCM_Rx_Enables_A_PCM_RX_CH5_EN = (0x1 << 5),
-	MAX98927_PCM_Rx_Enables_A_PCM_RX_CH6_EN = (0x1 << 6),
-	MAX98927_PCM_Rx_Enables_A_PCM_RX_CH7_EN = (0x1 << 7),
-
-	/* PCM Rx Enables B (Address 0x0019)*/
-	MAX98927_PCM_Rx_Enables_B = 0x0019,
-	MAX98927_PCM_Rx_Enables_B_PCM_RX_CH8_EN = (0x1 << 0),
-	MAX98927_PCM_Rx_Enables_B_PCM_RX_CH9_EN = (0x1 << 1),
-	MAX98927_PCM_Rx_Enables_B_PCM_RX_CH10_EN  = (0x1 << 2),
-	MAX98927_PCM_Rx_Enables_B_PCM_RX_CH11_EN  = (0x1 << 3),
-	MAX98927_PCM_Rx_Enables_B_PCM_RX_CH12_EN  = (0x1 << 4),
-	MAX98927_PCM_Rx_Enables_B_PCM_RX_CH13_EN  = (0x1 << 5),
-	MAX98927_PCM_Rx_Enables_B_PCM_RX_CH14_EN  = (0x1 << 6),
-	MAX98927_PCM_Rx_Enables_B_PCM_RX_CH15_EN  = (0x1 << 7),
-
-	/* PCM Tx Enables A (Address 0x001a)*/
-	MAX98927_PCM_Tx_Enables_A = 0x001a,
-	MAX98927_PCM_Tx_Enables_A_PCM_TX_CH0_EN = (0x1 << 0),
-	MAX98927_PCM_Tx_Enables_A_PCM_TX_CH1_EN = (0x1 << 1),
-	MAX98927_PCM_Tx_Enables_A_PCM_TX_CH2_EN = (0x1 << 2),
-	MAX98927_PCM_Tx_Enables_A_PCM_TX_CH3_EN = (0x1 << 3),
-	MAX98927_PCM_Tx_Enables_A_PCM_TX_CH4_EN = (0x1 << 4),
-	MAX98927_PCM_Tx_Enables_A_PCM_TX_CH5_EN = (0x1 << 5),
-	MAX98927_PCM_Tx_Enables_A_PCM_TX_CH6_EN = (0x1 << 6),
-	MAX98927_PCM_Tx_Enables_A_PCM_TX_CH7_EN = (0x1 << 7),
-
-	/* PCM Tx Enables B (Address 0x001b)*/
-	MAX98927_PCM_Tx_Enables_B = 0x001b,
-	MAX98927_PCM_Tx_Enables_B_PCM_TX_CH8_EN = (0x1 << 0),
-	MAX98927_PCM_Tx_Enables_B_PCM_TX_CH9_EN = (0x1 << 1),
-	MAX98927_PCM_Tx_Enables_B_PCM_TX_CH10_EN  = (0x1 << 2),
-	MAX98927_PCM_Tx_Enables_B_PCM_TX_CH11_EN  = (0x1 << 3),
-	MAX98927_PCM_Tx_Enables_B_PCM_TX_CH12_EN  = (0x1 << 4),
-	MAX98927_PCM_Tx_Enables_B_PCM_TX_CH13_EN  = (0x1 << 5),
-	MAX98927_PCM_Tx_Enables_B_PCM_TX_CH14_EN  = (0x1 << 6),
-	MAX98927_PCM_Tx_Enables_B_PCM_TX_CH15_EN  = (0x1 << 7),
-
-	/* PCM Tx HiZ Control A (Address 0x001c)*/
-	MAX98927_PCM_Tx_HiZ_Control_A = 0x001c,
-	MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH0_HIZ = (0x1 << 0),
-	MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH1_HIZ = (0x1 << 1),
-	MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH2_HIZ = (0x1 << 2),
-	MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH3_HIZ = (0x1 << 3),
-	MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH4_HIZ = (0x1 << 4),
-	MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH5_HIZ = (0x1 << 5),
-	MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH6_HIZ = (0x1 << 6),
-	MAX98927_PCM_Tx_HiZ_Control_A_PCM_TX_CH7_HIZ = (0x1 << 7),
-
-	/* PCM Tx HiZ Control B (Address 0x001d)*/
-	MAX98927_PCM_Tx_HiZ_Control_B = 0x001d,
-	MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH8_HIZ = (0x1 << 0),
-	MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH9_HIZ = (0x1 << 1),
-	MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH10_HIZ = (0x1 << 2),
-	MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH11_HIZ = (0x1 << 3),
-	MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH12_HIZ = (0x1 << 4),
-	MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH13_HIZ = (0x1 << 5),
-	MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH14_HIZ = (0x1 << 6),
-	MAX98927_PCM_Tx_HiZ_Control_B_PCM_TX_CH15_HIZ = (0x1 << 7),
-
-	/* PCM Tx Channel Sources A (Address 0x001e)*/
-	MAX98927_PCM_Tx_Channel_Sources_A  = 0x001e,
-	MAX98927_PCM_Tx_Channel_Sources_A_PCM_IVADC_V_DEST_Mask = (0xf << 0),
-	MAX98927_PCM_Tx_Channel_Sources_A_PCM_IVADC_I_DEST_Mask = (0xf << 4),
-
-	/* PCM Tx Channel Sources B (Address 0x001f)*/
-	MAX98927_PCM_Tx_Channel_Sources_B  = 0x001f,
-	MAX98927_PCM_Tx_Channel_Sources_B_PCM_AMP_DSP_DEST_Mask = (0xf << 0),
-	MAX98927_PCM_Tx_Channel_Src_INTERLEAVE_Mask = (0x1 << 5),
-
-	/* PCM Mode Config (Address 0x0020)*/
-	MAX98927_PCM_Mode_Config  = 0x0020,
-	MAX98927_PCM_Mode_Config_PCM_TX_EXTRA_HIZ = (0x1 << 0),
-	MAX98927_PCM_Mode_Config_PCM_CHANSEL = (0x1 << 1),
-	MAX98927_PCM_Mode_Config_PCM_BCLKEDGE = (0x1 << 2),
-	MAX98927_PCM_Mode_Config_PCM_FORMAT_Mask  = (0x7 << 3),
-	MAX98927_PCM_Mode_Config_PCM_FORMAT_I2S = (0x0 << 3),
-	MAX98927_PCM_Mode_Config_PCM_FORMAT_LEFT  = (0x1 << 3),
-	MAX98927_PCM_Mode_Config_PCM_FORMAT_TDM_0 = (0x3 << 3),
-	MAX98927_PCM_Mode_Config_PCM_FORMAT_TDM_1 = (0x4 << 3),
-	MAX98927_PCM_Mode_Config_PCM_FORMAT_TDM_2 = (0x5 << 3),
-	MAX98927_PCM_Mode_Config_PCM_FORMAT_ = (0x6 << 3),
-	MAX98927_PCM_Mode_Config_PCM_CHANSZ_Mask  = (0x3 << 6),
-	MAX98927_PCM_Mode_Config_PCM_CHANSZ_16  = (0x1 << 6),
-	MAX98927_PCM_Mode_Config_PCM_CHANSZ_24  = (0x2 << 6),
-	MAX98927_PCM_Mode_Config_PCM_CHANSZ_32  = (0x3 << 6),
-
-	/* PCM Master Mode (Address 0x0021)*/
-	MAX98927_PCM_Master_Mode  = 0x0021,
-	MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_Mask  = (0x3 << 0),
-	MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_SLAVE = (0x0 << 0),
-	MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_MASTER = (0x3 << 0),
-	MAX98927_PCM_Master_Mode_PCM_MSTR_MODE_HYBRID = (0x1 << 0),
-	MAX98927_PCM_Master_Mode_PCM_MCLK_RATE_Mask  = (0xf << 2),
-	MAX98927_PCM_Master_Mode_PCM_CLK_SOURCE = (0x1 << 6),
-
-	/* PCM Clock setup (Address 0x0022)*/
-	MAX98927_PCM_Clock_setup  = 0x0022,
-	MAX98927_PCM_Clock_setup_PCM_BSEL_Mask  = (0xf << 0),
-	MAX98927_PCM_Clock_setup_PCM_MSEL_Mask  = (0xf << 4),
-
-	/* PCM Sample rate setup 1 (Address 0x0023)*/
-	MAX98927_PCM_Sample_rate_setup_1 = 0x0023,
-	MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_Mask  = (0xf << 0),
-	MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_8000  = (0x0 << 0),
-	MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_11025  = (0x1 << 0),
-	MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_12000  = (0x2 << 0),
-	MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_16000  = (0x3 << 0),
-	MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_22050  = (0x4 << 0),
-	MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_24000  = (0x5 << 0),
-	MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_32000  = (0x6 << 0),
-	MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_44100  = (0x7 << 0),
-	MAX98927_PCM_Sample_rate_setup_1_DIG_IF_SR_48000  = (0x8 << 0),
-
-	/* PCM Sample rate setup 1 (Address 0x0024)*/
-	MAX98927_PCM_Sample_rate_setup_2 = 0x0024,
-	MAX98927_PCM_Sample_rate_setup_2_IVADC_SR_Mask   = (0xf << 0),
-	MAX98927_PCM_Sample_rate_setup_2_SPK_SR_Mask = (0xf << 4),
-	MAX98927_PCM_Sample_rate_setup_2_SPK_SR_0001 = (0x0 << 4),
-	MAX98927_PCM_Sample_rate_setup_2_SPK_SR_0011 = (0x2 << 4),
-	MAX98927_PCM_Sample_rate_setup_2_SPK_SR_0101 = (0x4 << 4),
-	MAX98927_PCM_Sample_rate_setup_2_SPK_SR_0111 = (0x6 << 4),
-	MAX98927_PCM_Sample_rate_setup_2_SPK_SR_1001 = (0x8 << 4),
-	MAX98927_PCM_Sample_rate_setup_2_SPK_SR_1011 = (0xa << 4),
-	MAX98927_PCM_Sample_rate_setup_2_SPK_SR_1101 = (0xc << 4),
-	MAX98927_PCM_Sample_rate_setup_2_SPK_SR_  = (0xf << 4),
-
-	/* PCM to speaker monomix A (Address 0x0025)*/
-	MAX98927_PCM_to_speaker_monomix_A  = 0x0025,
-	MAX98927_PCM_to_spkmonomix_A_DMONOMIX_CH0_SOURCE_Mask  = (0xf << 0),
-	MAX98927_PCM_to_spkmonomix_A_DMONOMIX_CFG_Mask  = (0x3 << 6),
-	MAX98927_PCM_to_spkmonomix_A_DMONOMIX_CFG_1 = (0x0 << 6),
-	MAX98927_PCM_to_spkmonomix_A_DMONOMIX_CFG_3 = (0x0 << 6),
-
-	/* PCM to speaker monomix B (Address 0x0026)*/
-	MAX98927_PCM_to_spkmonomix_B  = 0x0026,
-	MAX98927_PCM_to_spkmonomix_B_DMONOMIX_CH1_SOURCE_Mask  = (0xf << 0),
-
-	/* ICC RX Enables A (Address 0x0027)*/
-	MAX98927_ICC_RX_Enables_A = 0x0027,
-	MAX98927_ICC_RX_Enables_A_ICC_RX_CH0_EN = (0x1 << 0),
-	MAX98927_ICC_RX_Enables_A_ICC_RX_CH1_EN = (0x1 << 1),
-	MAX98927_ICC_RX_Enables_A_ICC_RX_CH2_EN = (0x1 << 2),
-	MAX98927_ICC_RX_Enables_A_ICC_RX_CH3_EN = (0x1 << 3),
-	MAX98927_ICC_RX_Enables_A_ICC_RX_CH4_EN = (0x1 << 4),
-	MAX98927_ICC_RX_Enables_A_ICC_RX_CH5_EN = (0x1 << 5),
-	MAX98927_ICC_RX_Enables_A_ICC_RX_CH6_EN = (0x1 << 6),
-	MAX98927_ICC_RX_Enables_A_ICC_RX_CH7_EN = (0x1 << 7),
-
-	/* ICC RX Enables B (Address 0x0028)*/
-	MAX98927_ICC_RX_Enables_B = 0x0028,
-	MAX98927_ICC_RX_Enables_B_ICC_RX_CH8_EN = (0x1 << 0),
-	MAX98927_ICC_RX_Enables_B_ICC_RX_CH9_EN = (0x1 << 1),
-	MAX98927_ICC_RX_Enables_B_ICC_RX_CH10_EN  = (0x1 << 2),
-	MAX98927_ICC_RX_Enables_B_ICC_RX_CH11_EN  = (0x1 << 3),
-	MAX98927_ICC_RX_Enables_B_ICC_RX_CH12_EN  = (0x1 << 4),
-	MAX98927_ICC_RX_Enables_B_ICC_RX_CH13_EN  = (0x1 << 5),
-	MAX98927_ICC_RX_Enables_B_ICC_RX_CH14_EN  = (0x1 << 6),
-	MAX98927_ICC_RX_Enables_B_ICC_RX_CH15_EN  = (0x1 << 7),
-
-	/* ICC TX Enables A (Address 0x002b)*/
-	MAX98927_ICC_TX_Enables_A = 0x002b,
-	MAX98927_ICC_TX_Enables_A_ICC_TX_CH0_EN = (0x1 << 0),
-	MAX98927_ICC_TX_Enables_A_ICC_TX_CH1_EN = (0x1 << 1),
-	MAX98927_ICC_TX_Enables_A_ICC_TX_CH2_EN = (0x1 << 2),
-	MAX98927_ICC_TX_Enables_A_ICC_TX_CH3_EN = (0x1 << 3),
-	MAX98927_ICC_TX_Enables_A_ICC_TX_CH4_EN = (0x1 << 4),
-	MAX98927_ICC_TX_Enables_A_ICC_TX_CH5_EN = (0x1 << 5),
-	MAX98927_ICC_TX_Enables_A_ICC_TX_CH6_EN = (0x1 << 6),
-	MAX98927_ICC_TX_Enables_A_ICC_TX_CH7_EN = (0x1 << 7),
-
-	/* ICC TX Enables B (Address 0x002c)*/
-	MAX98927_ICC_TX_Enables_B = 0x002c,
-	MAX98927_ICC_TX_Enables_B_ICC_TX_CH8_EN = (0x1 << 0),
-	MAX98927_ICC_TX_Enables_B_ICC_TX_CH9_EN = (0x1 << 1),
-	MAX98927_ICC_TX_Enables_B_ICC_TX_CH10_EN  = (0x1 << 2),
-	MAX98927_ICC_TX_Enables_B_ICC_TX_CH11_EN  = (0x1 << 3),
-	MAX98927_ICC_TX_Enables_B_ICC_TX_CH12_EN  = (0x1 << 4),
-	MAX98927_ICC_TX_Enables_B_ICC_TX_CH13_EN  = (0x1 << 5),
-	MAX98927_ICC_TX_Enables_B_ICC_TX_CH14_EN  = (0x1 << 6),
-	MAX98927_ICC_TX_Enables_B_ICC_TX_CH15_EN  = (0x1 << 7),
-
-	/* ICC Data Order Select (Address 0x002d)*/
-	MAX98927_ICC_Data_Order_Select = 0x002d,
-	MAX98927_ICC_Data_Order_Select_ICC_DRIVE_MODE = (0x1 << 3),
-
-	/* ICC HiZ Manual Mode (Address 0x002e)*/
-	MAX98927_ICC_HiZ_Manual_Mode  = 0x002e,
-	MAX98927_ICC_HiZ_Manual_Mode_ICC_TX_HIZ_MANUAL   = (0x1 << 0),
-	MAX98927_ICC_HiZ_Manual_Mode_ICC_TX_EXTRA_HIZ = (0x1 << 1),
-
-	/* ICC TX HiZ Enables A (Address 0x002f)*/
-	MAX98927_ICC_TX_HiZ_Enables_A = 0x002f,
-	MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH0_HIZ = (0x1 << 0),
-	MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH1_HIZ = (0x1 << 1),
-	MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH2_HIZ = (0x1 << 2),
-	MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH3_HIZ = (0x1 << 3),
-	MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH4_HIZ = (0x1 << 4),
-	MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH5_HIZ = (0x1 << 5),
-	MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH6_HIZ = (0x1 << 6),
-	MAX98927_ICC_TX_HiZ_Enables_A_ICC_TX_CH7_HIZ = (0x1 << 7),
-
-	/* ICC TX HiZ Enables B (Address 0x0030)*/
-	MAX98927_ICC_TX_HiZ_Enables_B = 0x0030,
-	MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH8_HIZ = (0x1 << 0),
-	MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH9_HIZ = (0x1 << 1),
-	MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH10_HIZ = (0x1 << 2),
-	MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH11_HIZ = (0x1 << 3),
-	MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH12_HIZ = (0x1 << 4),
-	MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH13_HIZ = (0x1 << 5),
-	MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH14_HIZ = (0x1 << 6),
-	MAX98927_ICC_TX_HiZ_Enables_B_ICC_TX_CH15_HIZ = (0x1 << 7),
-
-	/* ICC Link Enables (Address 0x0031)*/
-	MAX98927_ICC_Link_Enables = 0x0031,
-	MAX98927_ICC_Link_Enables_ICC_LINK_EN = (0x1 << 1),
-
-	/* PDM Tx Enables (Address 0x0032)*/
-	MAX98927_PDM_Tx_Enables   = 0x0032,
-	MAX98927_PDM_Tx_Enables_PDM_TX_EN  = (0x1 << 0),
-	MAX98927_PDM_Tx_Enables_PDM_TX_CLK_DIV2 = (0x1 << 1),
-
-	/* PDM Tx HiZ Control (Address 0x0033)*/
-	MAX98927_PDM_Tx_HiZ_Control = 0x0033,
-	MAX98927_PDM_Tx_HiZ_Control_PDM_TX_HIZ  = (0x1 << 0),
-
-	/* PDM Tx Control (Address 0x0034)*/
-	MAX98927_PDM_Tx_Control   = 0x0034,
-	MAX98927_PDM_Tx_Control_PDM_TX_CH0_SOURCE = (0x1 << 0),
-	MAX98927_PDM_Tx_Control_PDM_TX_CH1_SOURCE = (0x1 << 1),
-
-	/* PDM Rx Enable (Address 0x0034)*/
-	MAX98927_PDM_Rx_Enable = 0x0035,
-	MAX98927_PDM_Rx_Enable_PDM_RX_EN = (0x1 << 0),
-	MAX98927_PDM_Rx_Enable_PDM_DSP_EN  = (0x1 << 1),
-	MAX98927_PDM_Rx_Enable_PDM_DITH_EN = (0x1 << 2),
-	MAX98927_PDM_Rx_Enable_PDM_RX_CH_SEL = (0x1 << 3),
-	MAX98927_PDM_Rx_Enable_PDM_FIFO_RDY_LVL_Mask = (0xf << 4),
-
-	/* AMP volume control (Address 0x0036)*/
-	MAX98927_AMP_volume_control = 0x0036,
-	MAX98927_AMP_volume_control_AMP_VOL_Mask  = (0x7f << 0),
-	MAX98927_AMP_volume_control_AMP_VOL_SEL = (0x1 << 7),
-
-	/* AMP DSP Config (Address 0x0037)*/
-	MAX98927_AMP_DSP_Config   = 0x0037,
-	MAX98927_AMP_DSP_Config_AMP_DCBLK_EN = (0x1 << 0),
-	MAX98927_AMP_DSP_Config_AMP_DITH_EN  = (0x1 << 1),
-	MAX98927_AMP_DSP_Config_DAC_HALF_REF_CURRENT = (0x1 << 2),
-	MAX98927_AMP_DSP_Config_DAC_DOUBLE_RFB  = (0x1 << 3),
-	MAX98927_AMP_DSP_Config_AMP_VOL_RMP_BYPASS = (0x1 << 4),
-	MAX98927_AMP_DSP_Config_DAC_INVERT = (0x1 << 5),
-
-	/* Tone Generator and DC Config (Address 0x0038)*/
-	MAX98927_Tone_Generator_and_DC_Config = 0x0038,
-	MAX98927_Tone_Generator_and_DC_Config_TONE_CONFIG_Mask  = (0xf << 0),
-
-	/* DRE Control (Address 0x0039)*/
-	MAX98927_DRE_Control  = 0x0039,
-	MAX98927_DRE_Control_DRE_EN = (0x1 << 0),
-
-	/* AMP enables (Address 0x003a)*/
-	MAX98927_AMP_enables  = 0x003a,
-	MAX98927_AMP_enables_SPK_EN = (0x1 << 0),
-
-	/* Speaker source select (Address 0x003b)*/
-	MAX98927_Speaker_source_select = 0x003b,
-	MAX98927_Speaker_source_select_SPK_SOURCE_Mask   = (0x3 << 0),
-	MAX98927_Speaker_source_select_SPK_SOURCE_01 = (0x0 << 0),
-	MAX98927_Speaker_source_select_SPK_SOURCE_11 = (0x2 << 0),
-
-	/* Speaker Gain (Address 0x003c)*/
-	MAX98927_Speaker_Gain = 0x003c,
-	MAX98927_Speaker_Gain_SPK_PCM_GAIN_Mask = (0x7 << 0),
-	MAX98927_Speaker_Gain_SPK_PCM_GAIN_001  = (0x0 << 0),
-	MAX98927_Speaker_Gain_SPK_PCM_GAIN_011  = (0x2 << 0),
-	MAX98927_Speaker_Gain_SPK_PCM_GAIN_101  = (0x4 << 0),
-	MAX98927_Speaker_Gain_SPK_PCM_GAIN_111  = (0x6 << 0),
-	MAX98927_Speaker_Gain_SPK_PDM_GAIN_Mask = (0x7 << 4),
-	MAX98927_Speaker_Gain_SPK_PDM_GAIN_001  = (0x0 << 4),
-	MAX98927_Speaker_Gain_SPK_PDM_GAIN_011  = (0x2 << 4),
-	MAX98927_Speaker_Gain_SPK_PDM_GAIN_101  = (0x4 << 4),
-	MAX98927_Speaker_Gain_SPK_PDM_GAIN_111  = (0x6 << 4),
-
-	/* SSM Configuration (Address 0x003d)*/
-	MAX98927_SSM_Configuration  = 0x003d,
-	MAX98927_SSM_Configuration_SSM_MOD_INDEX_Mask = (0x7 << 0),
-	MAX98927_SSM_Configuration_SSM_MOD_INDEX_001 = (0x0 << 0),
-	MAX98927_SSM_Configuration_SSM_MOD_INDEX_011 = (0x2 << 0),
-	MAX98927_SSM_Configuration_SSM_MOD_INDEX_101 = (0x4 << 0),
-	MAX98927_SSM_Configuration_SSM_MOD_INDEX_ = (0x6 << 0),
-	MAX98927_SSM_Configuration_SPK_FSW_SEL  = (0x1 << 3),
-	MAX98927_SSM_Configuration_SSM_ENA = (0x1 << 7),
-
-	/* Measurement enables (Address 0x003e)*/
-	MAX98927_Measurement_enables  = 0x003e,
-	MAX98927_Measurement_enables_IVADC_V_EN = (0x1 << 0),
-	MAX98927_Measurement_enables_IVADC_I_EN = (0x1 << 1),
-
-	/* Measurement DSP Config (Address 0x003f)*/
-	MAX98927_Measurement_DSP_Config  = 0x003f,
-	MAX98927_Measurement_DSP_Config_MEAS_V_DCBLK_EN  = (0x1 << 0),
-	MAX98927_Measurement_DSP_Config_MEAS_I_DCBLK_EN  = (0x1 << 1),
-	MAX98927_Measurement_DSP_Config_MEAS_DITH_EN = (0x1 << 2),
-	MAX98927_Measurement_DSP_Config_MEAS_V_DCBLK_Mask  = (0x3 << 4),
-	MAX98927_Measurement_DSP_Config_MEAS_V_DCBLK_01  = (0x0 << 4),
-	MAX98927_Measurement_DSP_Config_MEAS_V_DCBLK_11  = (0x2 << 4),
-	MAX98927_Measurement_DSP_Config_MEAS_I_DCBLK_Mask  = (0x3 << 6),
-	MAX98927_Measurement_DSP_Config_MEAS_I_DCBLK_01  = (0x0 << 6),
-	MAX98927_Measurement_DSP_Config_MEAS_I_DCBLK_11  = (0x2 << 6),
-
-	/* Boost Control 0 (Address 0x0040)*/
-	MAX98927_Boost_Control_0  = 0x0040,
-	MAX98927_Boost_Control_0_BST_VOUT_Mask  = (0x1f << 0),
-	MAX98927_Boost_Control_0_EXT_PVDD_EN = (0x1 << 7),
-
-	/* Boost Control 3 (Address 0x0041)*/
-	MAX98927_Boost_Control_3  = 0x0041,
-	MAX98927_Boost_Control_3_BST_SKIPLOAD_Mask = (0x3 << 0),
-	MAX98927_Boost_Control_3_BST_SKIPLOAD_01  = (0x0 << 0),
-	MAX98927_Boost_Control_3_BST_SKIPLOAD_11  = (0x2 << 0),
-	MAX98927_Boost_Control_3_BST_PHASE_Mask = (0x7 << 2),
-	MAX98927_Boost_Control_3_BST_PHASE_001  = (0x0 << 2),
-	MAX98927_Boost_Control_3_BST_PHASE_011  = (0x2 << 2),
-	MAX98927_Boost_Control_3_BST_PHASE_  = (0x1 << 2),
-	MAX98927_Boost_Control_3_BST_SLOWSTART  = (0x1 << 5),
-
-	/* Boost Control 1 (Address 0x0042)*/
-	MAX98927_Boost_Control_1  = 0x0042,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Boost_Control_1_BST_ILIM_Mask  = (0x3f << 0),
-
-	/* Meas ADC Config (Address 0x0043)*/
-	MAX98927_Meas_ADC_Config  = 0x0043,
-	MAX98927_Meas_ADC_Config_MEAS_ADC_CH0_EN  = (0x1 << 0),
-	MAX98927_Meas_ADC_Config_MEAS_ADC_CH1_EN  = (0x1 << 1),
-	MAX98927_Meas_ADC_Config_MEAS_ADC_CH2_EN  = (0x1 << 2),
-
-	/* Meas ADC Base Divide MSByte (Address 0x0044)*/
-	MAX98927_Meas_ADC_Base_Divide_MSByte = 0x0044,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Meas_ADC_Base_Divide_MSByte_MEAS_ADC_BASE_DIV_Mask
-		= (0xff << 0),
-
-	/* Meas ADC Base Divide LSByte (Address 0x0045)*/
-	MAX98927_Meas_ADC_Base_Divide_LSByte = 0x0045,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Meas_ADC_Base_Divide_LSByte_MEAS_ADC_BASE_DIV_Mask
-		= (0xff << 0),
-
-	/* Meas ADC Chan 0 Divide (Address 0x0046)*/
-	MAX98927_Meas_ADC_Chan_0_Divide  = 0x0046,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Meas_ADC_Chan_0_Divide_MEAS_ADC_CH0_DIV_Mask = (0xff << 0),
-
-	/* Meas ADC Chan 1 Divide (Address 0x0047)*/
-	MAX98927_Meas_ADC_Chan_1_Divide  = 0x0047,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Meas_ADC_Chan_1_Divide_MEAS_ADC_CH1_DIV_Mask = (0xff << 0),
-
-	/* Meas ADC Chan 2 Divide (Address 0x0048)*/
-	MAX98927_Meas_ADC_Chan_2_Divide  = 0x0048,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Meas_ADC_Chan_2_Divide_MEAS_ADC_CH2_DIV_Mask = (0xff << 0),
-
-	/* Meas ADC Chan 0 Filt Config (Address 0x0049)*/
-	MAX98927_Meas_ADC_Chan_0_Filt_Config = 0x0049,
-	MAX98927_Meas_ADC_Chan_0_Filt_Config_MEAS_ADC_CH0_FILT_AVG_Mask
-		= (0x7 << 0),
-	MAX98927_Meas_ADC_Chan_0_Filt_Config_MEAS_ADC_CH0_FILT_AVG_001
-		= (0x0 << 0),
-	MAX98927_Meas_ADC_Chan_0_Filt_Config_MEAS_ADC_CH0_FILT_AVG_011
-		= (0x2 << 0),
-	MAX98927_Meas_ADC_Chan_0_Filt_Config_MEAS_ADC_CH0_FILT_AVG_101
-		= (0x4 << 0),
-	MAX98927_Meas_ADC_Chan_0_Filt_Config_MEAS_ADC_CH0_FILT_EN
-		= (0x1 << 3),
-
-	/* Meas ADC Chan 1 Filt Config (Address 0x004a)*/
-	MAX98927_Meas_ADC_Chan_1_Filt_Config = 0x004a,
-	MAX98927_Meas_ADC_Chan_1_Filt_Config_MEAS_ADC_CH1_FILT_AVG_Mask
-		= (0x7 << 0),
-	MAX98927_Meas_ADC_Chan_1_Filt_Config_MEAS_ADC_CH1_FILT_AVG_001
-		= (0x0 << 0),
-	MAX98927_Meas_ADC_Chan_1_Filt_Config_MEAS_ADC_CH1_FILT_AVG_011
-		= (0x2 << 0),
-	MAX98927_Meas_ADC_Chan_1_Filt_Config_MEAS_ADC_CH1_FILT_AVG_101
-		= (0x4 << 0),
-	MAX98927_Meas_ADC_Chan_1_Filt_Config_MEAS_ADC_CH1_FILT_EN
-		= (0x1 << 3),
-
-	/* Meas ADC Chan 2 Filt Config (Address 0x004b)*/
-	MAX98927_Meas_ADC_Chan_2_Filt_Config = 0x004b,
-	MAX98927_Meas_ADC_Chan_2_Filt_Config_MEAS_ADC_CH2_FILT_AVG_Mask
-		= (0x7 << 0),
-	MAX98927_Meas_ADC_Chan_2_Filt_Config_MEAS_ADC_CH2_FILT_AVG_001
-		= (0x0 << 0),
-	MAX98927_Meas_ADC_Chan_2_Filt_Config_MEAS_ADC_CH2_FILT_AVG_011
-		= (0x2 << 0),
-	MAX98927_Meas_ADC_Chan_2_Filt_Config_MEAS_ADC_CH2_FILT_AVG_101
-		= (0x4 << 0),
-	MAX98927_Meas_ADC_Chan_2_Filt_Config_MEAS_ADC_CH2_FILT_EN
-		= (0x1 << 3),
-
-	/* Meas ADC Chan 0 Readback (Address 0x004c)*/
-	MAX98927_Meas_ADC_Chan_0_Readback  = 0x004c,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Meas_ADC_Chan_0_Readback_MEAS_ADC_CH0_DATA_Mask
-		= (0xff << 0),
-
-	/* Meas ADC Chan 1 Readback (Address 0x004d)*/
-	MAX98927_Meas_ADC_Chan_1_Readback  = 0x004d,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Meas_ADC_Chan_1_Readback_MEAS_ADC_CH1_DATA_Mask
-		= (0xff << 0),
-
-	/* Meas ADC Chan 2 Readback (Address 0x004e)*/
-	MAX98927_Meas_ADC_Chan_2_Readback  = 0x004e,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Meas_ADC_Chan_2_Readback_MEAS_ADC_CH2_DATA_Mask
-		= (0xff << 0),
-
-	/* Brownout status (Address 0x0051)*/
-	MAX98927_Brownout_status  = 0x0051,
-	MAX98927_Brownout_status_BDE_STATE_Mask = (0xf << 0),
-
-	/* Brownout enables (Address 0x0052)*/
-	MAX98927_Brownout_enables = 0x0052,
-	MAX98927_Brownout_enables_BDE_EN = (0x1 << 0),
-	MAX98927_Brownout_enables_BDE_AMP_EN = (0x1 << 1),
-	MAX98927_Brownout_enables_AMP_DSP_EN = (0x1 << 2),
-
-	/* Brownout level infinite hold (Address 0x0053)*/
-	MAX98927_Brownout_level_infinite_hold = 0x0053,
-	MAX98927_Brownout_level_infinite_hold_BDE_L8_INF_HLD = (0x1 << 1),
-
-	/* Brownout level infinite hold clear (Address 0x0054)*/
-	MAX98927_Brownout_level_infinite_hold_clear  = 0x0054,
-	MAX98927_Brownout_level_infinite_hold_clear_BDE_L8_HLD_RLS
-		= (0x1 << 1),
-
-	/* Brownout level hold (Address 0x0055)*/
-	MAX98927_Brownout_level_hold  = 0x0055,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout_level_hold_BDE_HLD_Mask = (0xff << 0),
-
-	/* Brownout  level 1 threshold (Address 0x0056)*/
-	MAX98927_Brownout__level_1_threshold = 0x0056,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_1_threshold_BDE_L1_VTHRESH_Mask  = (0xff << 0),
-
-	/* Brownout  level 2 threshold (Address 0x0057)*/
-	MAX98927_Brownout__level_2_threshold = 0x0057,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_2_threshold_BDE_L2_VTHRESH_Mask  = (0xff << 0),
-
-	/* Brownout  level 3 threshold (Address 0x0058)*/
-	MAX98927_Brownout__level_3_threshold = 0x0058,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_3_threshold_BDE_L3_VTHRESH_Mask  = (0xff << 0),
-
-	/* Brownout  level 4 threshold (Address 0x0059)*/
-	MAX98927_Brownout__level_4_threshold = 0x0059,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_4_threshold_BDE_L4_VTHRESH_Mask  = (0xff << 0),
-
-	/* Brownout  level 5 threshold (Address 0x005a)*/
-	MAX98927_Brownout__level_5_threshold = 0x005a,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_5_threshold_BDE_L5_VTHRESH_Mask  = (0xff << 0),
-
-	/* Brownout  level 6 threshold (Address 0x005b)*/
-	MAX98927_Brownout__level_6_threshold = 0x005b,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_6_threshold_BDE_L6_VTHRESH_Mask  = (0xff << 0),
-
-	/* Brownout  level 7 threshold (Address 0x005c)*/
-	MAX98927_Brownout__level_7_threshold = 0x005c,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_7_threshold_BDE_L7_VTHRESH_Mask  = (0xff << 0),
-
-	/* Brownout  level 8 threshold (Address 0x005d)*/
-	MAX98927_Brownout__level_8_threshold = 0x005d,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_8_threshold_BDE_L8_VTHRESH_Mask  = (0xff << 0),
-
-	/* Brownout threshold hysterysis (Address 0x005e)*/
-	MAX98927_Brownout_threshold_hysterysis  = 0x005e,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout_threshold_hysterysis_BDE_VTHRESH_HYST_Mask
-		= (0xff << 0),
-	/* Brownout AMP limiter attack/release (Address 0x005f)*/
-	MAX98927_Brownout_AMP_limiter_attack_release = 0x005f,
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_Mask
-		= (0xf << 0),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_0001
-		= (0x0 << 0),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_0011
-		= (0x2 << 0),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_0101
-		= (0x4 << 0),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_0111
-		= (0x6 << 0),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_1001
-		= (0x8 << 0),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_1011
-		= (0xa << 0),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_1101
-		= (0xc << 0),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_RLS_1111
-		= (0xe << 0),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_Mask
-		= (0xf << 4),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_0001
-		= (0x0 << 4),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_0011
-		= (0x2 << 4),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_0101
-		= (0x4 << 4),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_0111
-		= (0x6 << 4),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_1001
-		= (0x8 << 4),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_1011
-		= (0xa << 4),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_1101
-		= (0xc << 4),
-	MAX98927_Brownout_AMP_limiter_attack_release_AMP_LIM_ATK_1111
-		= (0xe << 4),
-
-	/* Brownout AMP gain attack/release (Address 0x0060)*/
-	MAX98927_Brownout_AMP_gain_attack_release = 0x0060,
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_Mask
-		= (0xf << 0),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_0001
-		= (0x0 << 0),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_0011
-		= (0x2 << 0),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_0101
-		= (0x4 << 0),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_0111
-		= (0x6 << 0),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_1001
-		= (0x8 << 0),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_1011
-		= (0xa << 0),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_1101
-		= (0xc << 0),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_RLS_1111
-		= (0xe << 0),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_Mask
-		= (0xf << 4),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_0001
-		= (0x0 << 4),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_0011
-		= (0x2 << 4),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_0101
-		= (0x4 << 4),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_0111
-		= (0x6 << 4),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_1001
-		= (0x8 << 4),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_1011
-		= (0xa << 4),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_1101
-		= (0xc << 4),
-	MAX98927_Brownout_AMP_gain_attack_release_AMP_GAIN_ATK_1111
-		= (0xe << 4),
-
-	/* Brownout AMP1 clip mode (Address 0x0061)*/
-	MAX98927_Brownout_AMP1_clip_mode = 0x0061,
-	MAX98927_Brownout_AMP1_clip_mode_AMP_CLIP_MODE   = (0x1 << 0),
-
-	/* Brownout  level 1 current limit (Address 0x0062)*/
-	MAX98927_Brownout__level_1_current_limit  = 0x0062,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_1_current_limit_BDE_L1_ILIM_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 1 amp 1 control 1 (Address 0x0063)*/
-	MAX98927_Brownout__level_1_amp_1_control_1 = 0x0063,
-	MAX98927_Brownout__level_1_amp_1_control_1_BDE_L1_AMP1_LIM_Mask
-		= (0xf << 0),
-
-	/* Brownout  level 1 amp 1 control 2 (Address 0x0064)*/
-	MAX98927_Brownout__level_1_amp_1_control_2 = 0x0064,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_1_amp_1_control_2_BDE_L1_AMP1_CLIP_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 1 amp 1 control 3 (Address 0x0065)*/
-	MAX98927_Brownout__level_1_amp_1_control_3 = 0x0065,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_1_amp_1_control_3_BDE_L1_AMP1_GAIN_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 2 current limit (Address 0x0066)*/
-	MAX98927_Brownout__level_2_current_limit  = 0x0066,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_2_current_limit_BDE_L2_ILIM_Mask = (0x3f << 0),
-
-	/* Brownout  level 2 amp 1 control 1 (Address 0x0067)*/
-	MAX98927_Brownout__level_2_amp_1_control_1 = 0x0067,
-	MAX98927_Brownout__level_2_amp_1_control_1_BDE_L2_AMP1_LIM_Mask
-		= (0xf << 0),
-
-	/* Brownout  level 2 amp 1 control 2 (Address 0x0068)*/
-	MAX98927_Brownout__level_2_amp_1_control_2 = 0x0068,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_2_amp_1_control_2_BDE_L2_AMP1_CLIP_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 2 amp 1 control 3 (Address 0x0069)*/
-	MAX98927_Brownout__level_2_amp_1_control_3 = 0x0069,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_2_amp_1_control_3_BDE_L2_AMP1_GAIN_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 3 current limit (Address 0x006a)*/
-	MAX98927_Brownout__level_3_current_limit  = 0x006a,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_3_current_limit_BDE_L3_ILIM_Mask = (0x3f << 0),
-
-	/* Brownout  level 3 amp 1 control 1 (Address 0x006b)*/
-	MAX98927_Brownout__level_3_amp_1_control_1 = 0x006b,
-	MAX98927_Brownout__level_3_amp_1_control_1_BDE_L3_AMP1_LIM_Mask
-		= (0xf << 0),
-
-	/* Brownout  level 3 amp 1 control 2 (Address 0x006c)*/
-	MAX98927_Brownout__level_3_amp_1_control_2 = 0x006c,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_3_amp_1_control_2_BDE_L3_AMP1_CLIP_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 3 amp 1 control 3 (Address 0x006d)*/
-	MAX98927_Brownout__level_3_amp_1_control_3 = 0x006d,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_3_amp_1_control_3_BDE_L3_AMP1_GAIN_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 4 current limit (Address 0x006e)*/
-	MAX98927_Brownout__level_4_current_limit  = 0x006e,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_4_current_limit_BDE_L4_ILIM_Mask = (0x3f << 0),
-
-	/* Brownout  level 4 amp 1 control 1 (Address 0x006f)*/
-	MAX98927_Brownout__level_4_amp_1_control_1 = 0x006f,
-	MAX98927_Brownout__level_4_amp_1_control_1_BDE_L4_AMP1_LIM_Mask
-		= (0xf << 0),
-
-	/* Brownout  level 4 amp 1 control 2 (Address 0x0070)*/
-	MAX98927_Brownout__level_4_amp_1_control_2 = 0x0070,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_4_amp_1_control_2_BDE_L4_AMP1_CLIP_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 4 amp 1 control 3 (Address 0x0071)*/
-	MAX98927_Brownout__level_4_amp_1_control_3 = 0x0071,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_4_amp_1_control_3_BDE_L4_AMP1_GAIN_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 5 current limit (Address 0x0072)*/
-	MAX98927_Brownout__level_5_current_limit  = 0x0072,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_5_current_limit_BDE_L5_ILIM_Mask = (0x3f << 0),
-
-	/* Brownout  level 5 amp 1 control 1 (Address 0x0073)*/
-	MAX98927_Brownout__level_5_amp_1_control_1 = 0x0073,
-	MAX98927_Brownout__level_5_amp_1_control_1_BDE_L5_AMP1_LIM_Mask
-		= (0xf << 0),
-
-	/* Brownout  level 5 amp 1 control 2 (Address 0x0074)*/
-	MAX98927_Brownout__level_5_amp_1_control_2 = 0x0074,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_5_amp_1_control_2_BDE_L5_AMP1_CLIP_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 5 amp 1 control 3 (Address 0x0075)*/
-	MAX98927_Brownout__level_5_amp_1_control_3 = 0x0075,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_5_amp_1_control_3_BDE_L5_AMP1_GAIN_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 6 current limit (Address 0x0076)*/
-	MAX98927_Brownout__level_6_current_limit  = 0x0076,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_6_current_limit_BDE_L6_ILIM_Mask = (0x3f << 0),
-
-	/* Brownout  level 6 amp 1 control 1 (Address 0x0077)*/
-	MAX98927_Brownout__level_6_amp_1_control_1 = 0x0077,
-	MAX98927_Brownout__level_6_amp_1_control_1_BDE_L6_AMP1_LIM_Mask
-		= (0xf << 0),
-
-	/* Brownout  level 6 amp 1 control 2 (Address 0x0078)*/
-	MAX98927_Brownout__level_6_amp_1_control_2 = 0x0078,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_6_amp_1_control_2_BDE_L6_AMP1_CLIP_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 6 amp 1 control 3 (Address 0x0079)*/
-	MAX98927_Brownout__level_6_amp_1_control_3 = 0x0079,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_6_amp_1_control_3_BDE_L6_AMP1_GAIN_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 7 current limit (Address 0x007a)*/
-	MAX98927_Brownout__level_7_current_limit  = 0x007a,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_7_current_limit_BDE_L7_ILIM_Mask = (0x3f << 0),
-
-	/* Brownout  level 7 amp 1 control 1 (Address 0x007b)*/
-	MAX98927_Brownout__level_7_amp_1_control_1 = 0x007b,
-	MAX98927_Brownout__level_7_amp_1_control_1_BDE_L7_AMP1_LIM_Mask
-		= (0xf << 0),
-
-	/* Brownout  level 7 amp 1 control 2 (Address 0x007c)*/
-	MAX98927_Brownout__level_7_amp_1_control_2 = 0x007c,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_7_amp_1_control_2_BDE_L7_AMP1_CLIP_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 7 amp 1 control 3 (Address 0x007d)*/
-	MAX98927_Brownout__level_7_amp_1_control_3 = 0x007d,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_7_amp_1_control_3_BDE_L7_AMP1_GAIN_Mask
-		= (0x3f << 0),
-
-	/* Brownout  level 8 current limit (Address 0x007e)*/
-	MAX98927_Brownout__level_8_current_limit  = 0x007e,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_8_current_limit_BDE_L8_ILIM_Mask = (0x3f << 0),
-
-	/* Brownout  level 8 amp 1 control 1 (Address 0x007f)*/
-	MAX98927_Brownout__level_8_amp_1_control_1 = 0x007f,
-	MAX98927_Brownout__level_8_amp_1_control_1_BDE_L8_AMP1_LIM_Mask
-		= (0xf << 0),
-
-	/* Brownout  level 8 amp 1 control 2 (Address 0x0080)*/
-	MAX98927_Brownout__lvl_8_amp_1_control_2 = 0x0080,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__lvl_8_amp_1_control_2_BDE_L8_AMP1_CLIP_Mask
-		= (0x3f << 0),
-	MAX98927_Brownout__lvl_8_amp_1_control_2_BDE_L8_AMP1_MUTE
-		= (0x1 << 7),
-
-	/* Brownout  level 8 amp 1 control 3 (Address 0x0081)*/
-	MAX98927_Brownout__level_8_amp_1_control_3 = 0x0081,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Brownout__level_8_amp_1_control_3_BDE_L8_AMP1_GAIN_Mask
-		= (0x3f << 0),
-
-	/* Env Tracker Vout Headroom (Address 0x0082)*/
-	MAX98927_Env_Tracker_Vout_Headroom = 0x0082,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Env_Tracker_Vout_Head_ENV_TRACKER_BST_VOUT_HEADROOM_Mask
-		= (0x1f << 0),
-
-	/* Env Tracker Boost Vout Delay (Address 0x0083)*/
-	MAX98927_Env_Tracker_Boost_Vout_Delay = 0x0083,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Env_Tracker_Boost_V_Delay_ENV_TRACKER_BST_VOUT_DELAY_Mask
-		= (0x1f << 0),
-	MAX98927_Env_Tracker_Boost_Vout_Delay_ENV_TRACKER_BDE_MODE
-		= (0x1 << 7),
-
-	/* Env Tracker Release Rate (Address 0x0084)*/
-	MAX98927_Env_Tracker_Release_Rate  = 0x0084,
-	MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_Mask
-		= (0x7 << 0),
-	MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_001
-		= (0x0 << 0),
-	MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_011
-		= (0x2 << 0),
-	MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_101
-		= (0x4 << 0),
-	MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_111
-		= (0x6 << 0),
-	MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_PEAK_DET_LPF_BYP_EN
-		= (0x1 << 3),
-	MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_SCALE_Mask
-		= (0x3 << 4),
-	MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_SCALE_01
-		= (0x0 << 4),
-	MAX98927_Env_Tracker_Release_Rate_ENV_TRACKER_RLS_RATE_SCALE_11
-		= (0x2 << 4),
-
-	/* Env Tracker Hold Rate (Address 0x0085)*/
-	MAX98927_Env_Tracker_Hold_Rate = 0x0085,
-	MAX98927_Env_Tracker_Hold_Rate_ENV_TRACKER_HOLD_RATE_Mask
-		= (0x7 << 0),
-	MAX98927_Env_Tracker_Hold_Rate_ENV_TRACKER_HOLD_RATE_001
-		= (0x0 << 0),
-	MAX98927_Env_Tracker_Hold_Rate_ENV_TRACKER_HOLD_RATE_011
-		= (0x2 << 0),
-	MAX98927_Env_Tracker_Hold_Rate_ENV_TRACKER_HOLD_RATE_101
-		= (0x4 << 0),
-	MAX98927_Env_Tracker_Hold_Rate_ENV_TRACKER_HOLD_RATE_111
-		= (0x6 << 0),
-
-	/* Env Tracker Control (Address 0x0086)*/
-	MAX98927_Env_Tracker_Control  = 0x0086,
-	MAX98927_Env_Tracker_Control_ENV_TRACKER_EN  = (0x1 << 0),
-
-	/* Env Tracker  Boost Vout ReadBack (Address 0x0087)*/
-	MAX98927_Env_Tracker__Boost_Vout_ReadBack = 0x0087,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Env_Tracker__Boost_Vout_RB_ENV_TRACKER_BST_VOUT_RD_Mask
-		= (0x1f << 0),
-
-	/* Advanced Settings (Address 0x0089)*/
-	MAX98927_Advanced_Settings  = 0x0089,
-	MAX98927_Advanced_Settings_DAC_HALF_FIR = (0x1 << 0),
-	MAX98927_Advanced_Settings_PDM_MOD_SEL  = (0x1 << 1),
-	MAX98927_Advanced_Settings_ISOCH_EN  = (0x1 << 2),
-
-	/* DAC Test 1 (Address 0x009f)*/
-	MAX98927_DAC_Test_1 = 0x009f,
-	MAX98927_DAC_Test_1_DAC_PCM_TIMING = (0x1 << 0),
-	MAX98927_DAC_Test_1_DAC_HALFI_AMP  = (0x1 << 1),
-	MAX98927_DAC_Test_1_DAC_LONG_HOLD  = (0x1 << 3),
-	MAX98927_DAC_Test_1_DAC_DISABLE_CHOP = (0x1 << 4),
-	MAX98927_DAC_Test_1_DAC_TM  = (0x1 << 5),
-	MAX98927_DAC_Test_1_DAC_INVERT_DACCLK = (0x1 << 6),
-
-	/* Authentication key 0 (Address 0x00ea)*/
-	MAX98927_Authentication_key_0 = 0x00ea,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_key_0_AUTH_KEY_Mask  = (0xff << 0),
-
-	/* Authentication key 1 (Address 0x00eb)*/
-	MAX98927_Authentication_key_1 = 0x00eb,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_key_1_AUTH_KEY_Mask  = (0xff << 0),
-
-	/* Authentication key 2 (Address 0x00ec)*/
-	MAX98927_Authentication_key_2 = 0x00ec,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_key_2_AUTH_KEY_Mask  = (0xff << 0),
-
-	/* Authentication key 3 (Address 0x00ed)*/
-	MAX98927_Authentication_key_3 = 0x00ed,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_key_3_AUTH_KEY_Mask  = (0xff << 0),
-
-	/* Authentication enable (Address 0x00ee)*/
-	MAX98927_Authentication_enable = 0x00ee,
-	MAX98927_Authentication_enable_AUTH_EN  = (0x1 << 0),
-
-	/* Authentication result 0 (Address 0x00ef)*/
-	MAX98927_Authentication_result_0 = 0x00ef,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_0_AUTH_RESULT_Mask  = (0xff << 0),
-
-	/* Authentication result 1 (Address 0x00f0)*/
-	MAX98927_Authentication_result_1 = 0x00f0,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_1_AUTH_RESULT_Mask  = (0xff << 0),
-
-	/* Authentication result 2 (Address 0x00f1)*/
-	MAX98927_Authentication_result_2 = 0x00f1,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_2_AUTH_RESULT_Mask  = (0xff << 0),
-
-	/* Authentication result 3 (Address 0x00f2)*/
-	MAX98927_Authentication_result_3 = 0x00f2,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_3_AUTH_RESULT_Mask  = (0xff << 0),
-
-	/* Authentication result 4 (Address 0x00f3)*/
-	MAX98927_Authentication_result_4 = 0x00f3,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_4_AUTH_RESULT_Mask  = (0xff << 0),
-
-	/* Authentication result 5 (Address 0x00f4)*/
-	MAX98927_Authentication_result_5 = 0x00f4,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_5_AUTH_RESULT_Mask  = (0xff << 0),
-
-	/* Authentication result 6 (Address 0x00f5)*/
-	MAX98927_Authentication_result_6 = 0x00f5,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_6_AUTH_RESULT_Mask  = (0xff << 0),
-
-	/* Authentication result 7 (Address 0x00f6)*/
-	MAX98927_Authentication_result_7 = 0x00f6,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_7_AUTH_RESULT_Mask  = (0xff << 0),
-
-	/* Authentication result 8 (Address 0x00f7)*/
-	MAX98927_Authentication_result_8 = 0x00f7,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_8_AUTH_RESULT_Mask  = (0xff << 0),
-
-	/* Authentication result 9 (Address 0x00f8)*/
-	MAX98927_Authentication_result_9 = 0x00f8,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_9_AUTH_RESULT_Mask  = (0xff << 0),
-
-	/* Authentication result 10 (Address 0x00f9)*/
-	MAX98927_Authentication_result_10  = 0x00f9,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_10_AUTH_RESULT_Mask = (0xff << 0),
-
-	/* Authentication result 11 (Address 0x00fa)*/
-	MAX98927_Authentication_result_11  = 0x00fa,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_11_AUTH_RESULT_Mask = (0xff << 0),
-
-	/* Authentication result 12 (Address 0x00fb)*/
-	MAX98927_Authentication_result_12  = 0x00fb,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_12_AUTH_RESULT_Mask = (0xff << 0),
-
-	/* Authentication result 13 (Address 0x00fc)*/
-	MAX98927_Authentication_result_13  = 0x00fc,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_13_AUTH_RESULT_Mask = (0xff << 0),
-
-	/* Authentication result 14 (Address 0x00fd)*/
-	MAX98927_Authentication_result_14  = 0x00fd,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_14_AUTH_RESULT_Mask = (0xff << 0),
-
-	/* Authentication result 15 (Address 0x00fe)*/
-	MAX98927_Authentication_result_15  = 0x00fe,
-	/*#BYHAND width >= 5:*/
-	MAX98927_Authentication_result_15_AUTH_RESULT_Mask = (0xff << 0),
-
-	/* Global Enable (Address 0x00ff)*/
-	MAX98927_Global_Enable = 0x00ff,
-	MAX98927_Global_Enable_EN = (0x1 << 0),
-	/* Software Reset (Address 0x0100)*/
-	MAX98927_Software_Reset   = 0x0100,
-	MAX98927_Software_Reset_RST = (0x1 << 0),
-
-	/* REV ID (Address 0x01ff)*/
-	MAX98927_REV_ID  = 0x01ff,
-	/*#BYHAND width >= 5:*/
-	MAX98927_REV_ID_REV_ID_Mask = (0xff << 0),
-} MAX98927Registers;
-
-struct max98927_reg_default {
-	unsigned int ch;
-	unsigned int reg;
-	unsigned int def;
-};
 struct max98927_priv {
 	struct regmap *regmap;
-	struct regmap *sub_regmap;
 	struct snd_soc_codec *codec;
 	struct max98927_pdata *pdata;
-	const uint32_t *regcfg;
-	uint32_t regcfg_sz;
 	unsigned int spk_gain;
 	unsigned int sysclk;
 	unsigned int v_l_slot;
 	unsigned int i_l_slot;
-	unsigned int v_r_slot;
-	unsigned int i_r_slot;
 	bool interleave_mode;
 	unsigned int ch_size;
 	unsigned int rate;
 	unsigned int iface;
 	unsigned int master;
-	unsigned int thres_hyste;
-	unsigned int level5_hold;
-	unsigned int level6_hold;
-	unsigned int level7_hold;
-	unsigned int level8_hold;
-	unsigned int amp_limit;
-	unsigned int amp_limit_rel;
-	unsigned int amp1_level;
-	unsigned int amp2_level;
-	unsigned int amp3_level;
-	unsigned int amp1_level8;
-	unsigned int amp2_level8;
-	unsigned int amp3_level8;
-	unsigned int amp1_level7;
-	unsigned int amp2_level7;
-	unsigned int amp3_level7;
-	unsigned int amp1_level6;
-	unsigned int amp2_level6;
-	unsigned int amp3_level6;
-	unsigned int amp1_level5;
-	unsigned int amp2_level5;
-	unsigned int amp3_level5;
 	unsigned int digital_gain;
-	unsigned int pdm_gain;
-	unsigned int level_hold;
-	struct i2c_client *sub_i2c;
-	int sub_reg;
-	int sub_bus;
 };
-
-#define MAX98927_GLOBAL_SHIFT 0
-#define M98927_DAI_MSEL_SHIFT 4
-#define M98927_DAI_BSEL_SHIFT 0
-#define M98927_DAI_BSEL_32 (2 << M98927_DAI_BSEL_SHIFT)
-#define M98927_DAI_BSEL_48 (3 << M98927_DAI_BSEL_SHIFT)
-#define M98927_DAI_BSEL_64 (4 << M98927_DAI_BSEL_SHIFT)
-#define M98927_DAI_MSEL_32 (2 << M98927_DAI_MSEL_SHIFT)
-#define M98927_DAI_MSEL_48 (3 << M98927_DAI_MSEL_SHIFT)
-#define M98927_DAI_MSEL_64 (4 << M98927_DAI_MSEL_SHIFT)
-#define MAX98927_Speaker_Gain_Width 3
-#define MAX98927_SPK_RMP_EN_SHIFT 4
-#define MAX98927_PDM_GAIN_SHIFT 4
-#define MAX98927_pdm_Gain_Width 3
-#define MAX98927_AMP_VOL_WIDTH 7
-#define MAX98927_AMP_VOL_LOCATION_SHIFT 7
-#define MAX98927_PDM_Rx_Enable_PDM_CH_SHIFT 3
-#define MAX98927_PCM_to_speaker_monomix_A_SHIFT 6
-#define MAX98927_PCM_Sample_rate_setup_2_DIG_IF_SR_48000    (0x8 << 4)
-#define MAX98927_PCM_FORMAT_DSP_A    (0x3 << 3)
-#define MAX98927_DRE_Control_DRE_SHIFT   0x1
-#define MAX98927_PCM_Master_Mode_PCM_MCLK_RATE_SHIFT    (2)
-#define MAX98927_Brownout_AMP_limiter_attack_release_shift 4
-#define MAX98927_BDE_DSP_SHIFT 2
-#define MAX98927_Speaker_Gain_SPK_PDM_GAIN_SHIFT (4)
-#define MAX98927_BDE_AMP_SHIFT (1)
-#define MAX98927_PCM_Tx_Ch_Sources_A_I_SHIFT (4)
 #endif
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
