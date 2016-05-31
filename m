From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: add programmable biquad filter
	control
Date: Tue, 31 May 2016 11:57:41 +0800
Message-ID: <1464667061-32646-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6ADA8265DA7
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 05:56:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Add programmable biquad filter configuration control for user space.
The filter is configurable for low pass filters, high pass filters,
Notch filter, etc in the ADC and DAC path.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/nau8825.h |  8 +++++++
 2 files changed, 61 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index e988f89..88e01f9 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -217,6 +217,7 @@ static bool nau8825_volatile_reg(struct device *dev, unsigned int reg)
 	case NAU8825_REG_SARDOUT_RAM_STATUS:
 	case NAU8825_REG_CHARGE_PUMP_INPUT_READ:
 	case NAU8825_REG_GENERAL_STATUS:
+	case NAU8825_REG_BIQ_CTRL ... NAU8825_REG_BIQ_COF10:
 		return true;
 	default:
 		return false;
@@ -293,6 +294,54 @@ static int nau8825_output_dac_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int nau8825_biq_coeff_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
+
+	if (!component->regmap)
+		return -EINVAL;
+
+	regmap_raw_read(component->regmap, NAU8825_REG_BIQ_COF1,
+		ucontrol->value.bytes.data, params->max);
+	return 0;
+}
+
+static int nau8825_biq_coeff_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
+	void *data;
+
+	if (!component->regmap)
+		return -EINVAL;
+
+	data = kmemdup(ucontrol->value.bytes.data,
+		params->max, GFP_KERNEL | GFP_DMA);
+	if (!data)
+		return -ENOMEM;
+
+	regmap_update_bits(component->regmap, NAU8825_REG_BIQ_CTRL,
+		NAU8825_BIQ_WRT_EN, 0);
+	regmap_raw_write(component->regmap, NAU8825_REG_BIQ_COF1,
+		data, params->max);
+	regmap_update_bits(component->regmap, NAU8825_REG_BIQ_CTRL,
+		NAU8825_BIQ_WRT_EN, NAU8825_BIQ_WRT_EN);
+
+	kfree(data);
+	return 0;
+}
+
+static const char * const nau8825_biq_path[] = {
+	"ADC", "DAC"
+};
+
+static const struct soc_enum nau8825_biq_path_enum =
+	SOC_ENUM_SINGLE(NAU8825_REG_BIQ_CTRL, NAU8825_BIQ_PATH_SFT,
+		ARRAY_SIZE(nau8825_biq_path), nau8825_biq_path);
+
 static const char * const nau8825_adc_decimation[] = {
 	"32", "64", "128", "256"
 };
@@ -329,6 +378,10 @@ static const struct snd_kcontrol_new nau8825_controls[] = {
 
 	SOC_ENUM("ADC Decimation Rate", nau8825_adc_decimation_enum),
 	SOC_ENUM("DAC Oversampling Rate", nau8825_dac_oversampl_enum),
+	/* programmable biquad filter */
+	SOC_ENUM("BIQ Path Select", nau8825_biq_path_enum),
+	SND_SOC_BYTES_EXT("BIQ Coefficeints", 20,
+		  nau8825_biq_coeff_get, nau8825_biq_coeff_put),
 };
 
 /* DAC Mux 0x33[9] and 0x34[9] */
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 9e6cb62..1293d1b 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -231,6 +231,14 @@
 #define NAU8825_I2S_MS_MASTER	(1 << NAU8825_I2S_MS_SFT)
 #define NAU8825_I2S_MS_SLAVE	(0 << NAU8825_I2S_MS_SFT)
 
+/* BIQ_CTRL (0x20) */
+#define NAU8825_BIQ_WRT_SFT   4
+#define NAU8825_BIQ_WRT_EN     (1 << NAU8825_BIQ_WRT_SFT)
+#define NAU8825_BIQ_PATH_SFT   0
+#define NAU8825_BIQ_PATH_MASK  (1 << NAU8825_BIQ_PATH_SFT)
+#define NAU8825_BIQ_PATH_ADC   (0 << NAU8825_BIQ_PATH_SFT)
+#define NAU8825_BIQ_PATH_DAC   (1 << NAU8825_BIQ_PATH_SFT)
+
 /* ADC_RATE (0x2b) */
 #define NAU8825_ADC_SYNC_DOWN_SFT	0
 #define NAU8825_ADC_SYNC_DOWN_MASK	0x3
-- 
2.6.4
