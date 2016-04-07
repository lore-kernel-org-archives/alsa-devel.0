From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH 2/5 v4] drm/i2c/adv7511: Add audio support
Date: Thu,  7 Apr 2016 17:53:56 +0100
Message-ID: <d56087fae14074198f6c1bc749ce4da3cab62324.1460047238.git.joabreu@synopsys.com>
References: <cover.1460047238.git.joabreu@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1460047238.git.joabreu@synopsys.com>
In-Reply-To: <cover.1460047238.git.joabreu@synopsys.com>
References: <cover.1460047238.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, CARLOS.PALMINHA@synopsys.com, Alexey.Brodkin@synopsys.com, Vineet.Gupta1@synopsys.com, architt@codeaurora.org, airlied@linux.ie, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, Jose Abreu <Jose.Abreu@synopsys.com>
List-Id: alsa-devel@alsa-project.org

This patch adds audio support for the ADV7511 HDMI transmitter
using ALSA SoC.

The code was ported from Analog Devices linux tree from
commit 1770c4a1e32b ("Merge remote-tracking branch
'xilinx/master' into xcomm_zynq"), which is available at:
	- https://github.com/analogdevicesinc/linux/

The audio can be disabled using menu-config and/or device tree
so it is possible to use only video mode. The audio
(when enabled) registers as a codec into ALSA.

SPDIF DAI format was also added to ASoC as it is required
by adv7511 audio.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
---

No changes v3 -> v4.

Changes v2 -> v3:
* Removed HDMI start at adv7511_core (as suggested by Archit Taneja)
* Use NOP functions for adv7511_audio (as suggested by Archit Taneja)
* Added adv7511_audio_exit() function (as suggested by Archit Taneja)
* Moved adv7511 to its own folder (as suggested by Archit Taneja)
* Compile adv7511 as module if ALSA SoC is compiled as module
* Load adv7511 audio only if declared in device tree (as suggested by Laurent Pinchart)

No changes v1 -> v2.

 .../bindings/display/bridge/adi,adv7511.txt        |   3 +
 drivers/gpu/drm/i2c/adv7511/Kconfig                |  12 +
 drivers/gpu/drm/i2c/adv7511/Makefile               |   1 +
 drivers/gpu/drm/i2c/adv7511/adv7511.h              |  22 ++
 drivers/gpu/drm/i2c/adv7511/adv7511_audio.c        | 310 +++++++++++++++++++++
 drivers/gpu/drm/i2c/adv7511/adv7511_core.c         |  11 +
 include/sound/soc-dai.h                            |   1 +
 7 files changed, 360 insertions(+)
 create mode 100644 drivers/gpu/drm/i2c/adv7511/adv7511_audio.c

diff --git a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
index 96c25ee..920e542 100644
--- a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
+++ b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
@@ -43,6 +43,9 @@ Optional properties:
   data stream (similar to BT.656). Defaults to separate H/V synchronization
   signals.
 
+- adi,enable-audio: If set the ADV7511 driver will register a codec interface
+  into ALSA SoC.
+
 Required nodes:
 
 The ADV7511 has two video ports. Their connections are modelled using the OF
diff --git a/drivers/gpu/drm/i2c/adv7511/Kconfig b/drivers/gpu/drm/i2c/adv7511/Kconfig
index 302c8e34..900f3e9 100644
--- a/drivers/gpu/drm/i2c/adv7511/Kconfig
+++ b/drivers/gpu/drm/i2c/adv7511/Kconfig
@@ -4,3 +4,15 @@ config DRM_I2C_ADV7511
 	help
 	  Support for the Analog Device ADV7511(W) and ADV7513 HDMI encoders.
 
+config DRM_I2C_ADV7511_AUDIO
+	bool "ADV7511 audio"
+	depends on DRM_I2C_ADV7511
+	depends on SND_SOC=y || (SND_SOC && DRM_I2C_ADV7511=m)
+	default y
+	help
+	  This adds support for audio on the ADV7511(W) and ADV7513 HDMI
+	  encoders.
+
+	  By selecting this option the ADV7511 will register a codec interface
+	  into ALSA.
+
diff --git a/drivers/gpu/drm/i2c/adv7511/Makefile b/drivers/gpu/drm/i2c/adv7511/Makefile
index c13f5a1..d68773a 100644
--- a/drivers/gpu/drm/i2c/adv7511/Makefile
+++ b/drivers/gpu/drm/i2c/adv7511/Makefile
@@ -1,2 +1,3 @@
 adv7511-y := adv7511_core.o
+adv7511-$(CONFIG_DRM_I2C_ADV7511_AUDIO) += adv7511_audio.o
 obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511.o
diff --git a/drivers/gpu/drm/i2c/adv7511/adv7511.h b/drivers/gpu/drm/i2c/adv7511/adv7511.h
index fcae1ee..35828f0 100644
--- a/drivers/gpu/drm/i2c/adv7511/adv7511.h
+++ b/drivers/gpu/drm/i2c/adv7511/adv7511.h
@@ -10,6 +10,7 @@
 #define __DRM_I2C_ADV7511_H__
 
 #include <linux/hdmi.h>
+#include <drm/drmP.h>
 
 #define ADV7511_REG_CHIP_REVISION		0x00
 #define ADV7511_REG_N0				0x01
@@ -241,6 +242,7 @@ enum adv7511_sync_polarity {
  * @sync_pulse:			Select the sync pulse
  * @vsync_polarity:		vsync input signal configuration
  * @hsync_polarity:		hsync input signal configuration
+ * @enable_audio		True if audio is enabled
  */
 struct adv7511_link_config {
 	unsigned int input_color_depth;
@@ -255,6 +257,8 @@ struct adv7511_link_config {
 	enum adv7511_input_sync_pulse sync_pulse;
 	enum adv7511_sync_polarity vsync_polarity;
 	enum adv7511_sync_polarity hsync_polarity;
+
+	bool enable_audio;
 };
 
 /**
@@ -296,6 +300,10 @@ struct adv7511 {
 	bool powered;
 
 	unsigned int f_tmds;
+	unsigned int f_audio;
+
+	unsigned int audio_source;
+	bool enable_audio;
 
 	unsigned int current_edid_segment;
 	uint8_t edid_buf[256];
@@ -317,4 +325,18 @@ struct adv7511 {
 int adv7511_packet_enable(struct adv7511 *adv7511, unsigned int packet);
 int adv7511_packet_disable(struct adv7511 *adv7511, unsigned int packet);
 
+#ifdef CONFIG_DRM_I2C_ADV7511_AUDIO
+int adv7511_audio_init(struct device *dev);
+void adv7511_audio_exit(struct device *dev);
+#else
+int adv7511_audio_init(struct device *dev)
+{
+	return 0;
+}
+void adv7511_audio_exit(struct device *dev)
+{
+
+}
+#endif
+
 #endif /* __DRM_I2C_ADV7511_H__ */
diff --git a/drivers/gpu/drm/i2c/adv7511/adv7511_audio.c b/drivers/gpu/drm/i2c/adv7511/adv7511_audio.c
new file mode 100644
index 0000000..5562ed5
--- /dev/null
+++ b/drivers/gpu/drm/i2c/adv7511/adv7511_audio.c
@@ -0,0 +1,310 @@
+/*
+ * Analog Devices ADV7511 HDMI transmitter driver
+ *
+ * Copyright 2012 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "adv7511.h"
+
+static const struct snd_soc_dapm_widget adv7511_dapm_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("TMDS"),
+	SND_SOC_DAPM_AIF_IN("AIFIN", "Playback", 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route adv7511_routes[] = {
+	{ "TMDS", NULL, "AIFIN" },
+};
+
+static void adv7511_calc_cts_n(unsigned int f_tmds, unsigned int fs,
+			       unsigned int *cts, unsigned int *n)
+{
+	switch (fs) {
+	case 32000:
+		*n = 4096;
+		break;
+	case 44100:
+		*n = 6272;
+		break;
+	case 48000:
+		*n = 6144;
+		break;
+	}
+
+	*cts = ((f_tmds * *n) / (128 * fs)) * 1000;
+}
+
+static int adv7511_update_cts_n(struct adv7511 *adv7511)
+{
+	unsigned int cts = 0;
+	unsigned int n = 0;
+
+	adv7511_calc_cts_n(adv7511->f_tmds, adv7511->f_audio, &cts, &n);
+
+	regmap_write(adv7511->regmap, ADV7511_REG_N0, (n >> 16) & 0xf);
+	regmap_write(adv7511->regmap, ADV7511_REG_N1, (n >> 8) & 0xff);
+	regmap_write(adv7511->regmap, ADV7511_REG_N2, n & 0xff);
+
+	regmap_write(adv7511->regmap, ADV7511_REG_CTS_MANUAL0,
+		     (cts >> 16) & 0xf);
+	regmap_write(adv7511->regmap, ADV7511_REG_CTS_MANUAL1,
+		     (cts >> 8) & 0xff);
+	regmap_write(adv7511->regmap, ADV7511_REG_CTS_MANUAL2,
+		     cts & 0xff);
+
+	return 0;
+}
+
+static int adv7511_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct adv7511 *adv7511 = snd_soc_codec_get_drvdata(codec);
+	unsigned int rate;
+	unsigned int len;
+
+	switch (params_rate(params)) {
+	case 32000:
+		rate = ADV7511_SAMPLE_FREQ_32000;
+		break;
+	case 44100:
+		rate = ADV7511_SAMPLE_FREQ_44100;
+		break;
+	case 48000:
+		rate = ADV7511_SAMPLE_FREQ_48000;
+		break;
+	case 88200:
+		rate = ADV7511_SAMPLE_FREQ_88200;
+		break;
+	case 96000:
+		rate = ADV7511_SAMPLE_FREQ_96000;
+		break;
+	case 176400:
+		rate = ADV7511_SAMPLE_FREQ_176400;
+		break;
+	case 192000:
+		rate = ADV7511_SAMPLE_FREQ_192000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		len = ADV7511_I2S_SAMPLE_LEN_16;
+		break;
+	case SNDRV_PCM_FORMAT_S18_3LE:
+		len = ADV7511_I2S_SAMPLE_LEN_18;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		len = ADV7511_I2S_SAMPLE_LEN_20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		len = ADV7511_I2S_SAMPLE_LEN_24;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	adv7511->f_audio = params_rate(params);
+
+	adv7511_update_cts_n(adv7511);
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CFG3,
+			   ADV7511_AUDIO_CFG3_LEN_MASK, len);
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_I2C_FREQ_ID_CFG,
+			   ADV7511_I2C_FREQ_ID_CFG_RATE_MASK, rate << 4);
+
+	return 0;
+}
+
+static int adv7511_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			       unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct adv7511 *adv7511 = snd_soc_codec_get_drvdata(codec);
+	unsigned int audio_source, i2s_format = 0;
+	unsigned int invert_clock;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		audio_source = ADV7511_AUDIO_SOURCE_I2S;
+		i2s_format = ADV7511_I2S_FORMAT_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		audio_source = ADV7511_AUDIO_SOURCE_I2S;
+		i2s_format = ADV7511_I2S_FORMAT_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		audio_source = ADV7511_AUDIO_SOURCE_I2S;
+		i2s_format = ADV7511_I2S_FORMAT_LEFT_J;
+		break;
+	case SND_SOC_DAIFMT_SPDIF:
+		audio_source = ADV7511_AUDIO_SOURCE_SPDIF;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		invert_clock = 0;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		invert_clock = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_SOURCE, 0x70,
+			   audio_source << 4);
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG, BIT(6),
+			   invert_clock << 6);
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_I2S_CONFIG, 0x03,
+			   i2s_format);
+
+	adv7511->audio_source = audio_source;
+
+	return 0;
+}
+
+static int adv7511_set_bias_level(struct snd_soc_codec *codec,
+				  enum snd_soc_bias_level level)
+{
+	struct adv7511 *adv7511 = snd_soc_codec_get_drvdata(codec);
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		switch (adv7511->audio_source) {
+		case ADV7511_AUDIO_SOURCE_I2S:
+			break;
+		case ADV7511_AUDIO_SOURCE_SPDIF:
+			regmap_update_bits(adv7511->regmap,
+					   ADV7511_REG_AUDIO_CONFIG, BIT(7),
+					   BIT(7));
+			break;
+		}
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY) {
+			adv7511_packet_enable(adv7511,
+					ADV7511_PACKET_ENABLE_AUDIO_SAMPLE);
+			adv7511_packet_enable(adv7511,
+					ADV7511_PACKET_ENABLE_AUDIO_INFOFRAME);
+			adv7511_packet_enable(adv7511,
+					ADV7511_PACKET_ENABLE_N_CTS);
+		} else {
+			adv7511_packet_disable(adv7511,
+					ADV7511_PACKET_ENABLE_AUDIO_SAMPLE);
+			adv7511_packet_disable(adv7511,
+					ADV7511_PACKET_ENABLE_AUDIO_INFOFRAME);
+			adv7511_packet_disable(adv7511,
+					ADV7511_PACKET_ENABLE_N_CTS);
+		}
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG,
+				   BIT(7), 0);
+		break;
+	case SND_SOC_BIAS_OFF:
+		break;
+	}
+	return 0;
+}
+
+#define ADV7511_RATES (SNDRV_PCM_RATE_32000 |\
+		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
+		SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |\
+		SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000)
+
+#define ADV7511_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE |\
+		SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE)
+
+static const struct snd_soc_dai_ops adv7511_dai_ops = {
+	.hw_params	= adv7511_hw_params,
+	/*.set_sysclk	= adv7511_set_dai_sysclk,*/
+	.set_fmt	= adv7511_set_dai_fmt,
+};
+
+static struct snd_soc_dai_driver adv7511_dai = {
+	.name = "adv7511",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = ADV7511_RATES,
+		.formats = ADV7511_FORMATS,
+	},
+	.ops = &adv7511_dai_ops,
+};
+
+static int adv7511_suspend(struct snd_soc_codec *codec)
+{
+	return adv7511_set_bias_level(codec, SND_SOC_BIAS_OFF);
+}
+
+static int adv7511_resume(struct snd_soc_codec *codec)
+{
+	return adv7511_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+}
+
+static int adv7511_probe(struct snd_soc_codec *codec)
+{
+	return adv7511_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+}
+
+static int adv7511_remove(struct snd_soc_codec *codec)
+{
+	adv7511_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static struct snd_soc_codec_driver adv7511_codec_driver = {
+	.probe		    = adv7511_probe,
+	.remove		    = adv7511_remove,
+	.suspend	    = adv7511_suspend,
+	.resume		    = adv7511_resume,
+	.set_bias_level	    = adv7511_set_bias_level,
+
+	.dapm_widgets	    = adv7511_dapm_widgets,
+	.num_dapm_widgets   = ARRAY_SIZE(adv7511_dapm_widgets),
+	.dapm_routes	    = adv7511_routes,
+	.num_dapm_routes    = ARRAY_SIZE(adv7511_routes),
+};
+
+int adv7511_audio_init(struct device *dev)
+{
+	return snd_soc_register_codec(dev, &adv7511_codec_driver,
+			&adv7511_dai, 1);
+}
+
+void adv7511_audio_exit(struct device *dev)
+{
+	snd_soc_unregister_codec(dev);
+}
diff --git a/drivers/gpu/drm/i2c/adv7511/adv7511_core.c b/drivers/gpu/drm/i2c/adv7511/adv7511_core.c
index 2b00581..140a64b 100644
--- a/drivers/gpu/drm/i2c/adv7511/adv7511_core.c
+++ b/drivers/gpu/drm/i2c/adv7511/adv7511_core.c
@@ -329,6 +329,7 @@ static void adv7511_set_link_config(struct adv7511 *adv7511,
 	adv7511->hsync_polarity = config->hsync_polarity;
 	adv7511->vsync_polarity = config->vsync_polarity;
 	adv7511->rgb = config->input_colorspace == HDMI_COLORSPACE_RGB;
+	adv7511->enable_audio = config->enable_audio;
 }
 
 static void adv7511_power_on(struct adv7511 *adv7511)
@@ -822,6 +823,7 @@ static int adv7511_parse_dt(struct device_node *np,
 		return -EINVAL;
 
 	config->embedded_sync = of_property_read_bool(np, "adi,embedded-sync");
+	config->enable_audio = of_property_read_bool(np, "adi,enable-audio");
 
 	/* Hardcode the sync pulse configurations for now. */
 	config->sync_pulse = ADV7511_INPUT_SYNC_PULSE_NONE;
@@ -916,6 +918,12 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 
 	adv7511_set_link_config(adv7511, &link_config);
 
+	if (link_config.enable_audio) {
+		ret = adv7511_audio_init(&i2c->dev);
+		if (ret)
+			goto err_i2c_unregister_device;
+	}
+
 	return 0;
 
 err_i2c_unregister_device:
@@ -930,6 +938,9 @@ static int adv7511_remove(struct i2c_client *i2c)
 
 	i2c_unregister_device(adv7511->i2c_edid);
 
+	if (adv7511->enable_audio)
+		adv7511_audio_exit(&i2c->dev);
+
 	kfree(adv7511->edid);
 
 	return 0;
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 964b7de..539c091 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -33,6 +33,7 @@ struct snd_compr_stream;
 #define SND_SOC_DAIFMT_DSP_B		5 /* L data MSB during FRM LRC */
 #define SND_SOC_DAIFMT_AC97		6 /* AC97 */
 #define SND_SOC_DAIFMT_PDM		7 /* Pulse density modulation */
+#define SND_SOC_DAIFMT_SPDIF		8 /* SPDIF */
 
 /* left and right justified also known as MSB and LSB respectively */
 #define SND_SOC_DAIFMT_MSB		SND_SOC_DAIFMT_LEFT_J
-- 
1.9.1
