From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC v1 6/9] ASoC: msm8x16: add codec dais
Date: Tue, 16 Feb 2016 17:33:10 +0000
Message-ID: <1455643990-1870-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds two codec DAI's one Playback and other capture on the
i2s bus.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/dt-bindings/sound/msm8x16-wcd.h |   7 ++
 sound/soc/codecs/msm8x16-wcd.c          | 180 ++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100644 include/dt-bindings/sound/msm8x16-wcd.h

diff --git a/include/dt-bindings/sound/msm8x16-wcd.h b/include/dt-bindings/sound/msm8x16-wcd.h
new file mode 100644
index 0000000..f3257ab
--- /dev/null
+++ b/include/dt-bindings/sound/msm8x16-wcd.h
@@ -0,0 +1,7 @@
+#ifndef __DT_MSM8x16_WCD_H
+#define __DT_MSM8x16_WCD_H
+
+#define MSM8x16_WCD_PLAYBACK_DAI	0
+#define MSM8x16_WCD_CAPTURE_DAI		1
+
+#endif /* __DT_MSM8x16_WCD_H */
diff --git a/sound/soc/codecs/msm8x16-wcd.c b/sound/soc/codecs/msm8x16-wcd.c
index bc8b38a..4bc8274 100644
--- a/sound/soc/codecs/msm8x16-wcd.c
+++ b/sound/soc/codecs/msm8x16-wcd.c
@@ -11,9 +11,17 @@
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <sound/soc.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
 
 #include "msm8x16-wcd-registers.h"
 #include "msm8x16-wcd.h"
+#include "dt-bindings/sound/msm8x16-wcd.h"
+
+#define MSM8X16_WCD_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000)
+#define MSM8X16_WCD_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+		SNDRV_PCM_FMTBIT_S24_LE)
 
 /* Cap mode for micbias */
 #define MICBIAS_EXT_BYP_CAP 0x00
@@ -282,6 +290,19 @@ static const struct msm8x16_wcd_reg_mask_val
 	{MSM8X16_WCD_A_ANALOG_RX_COM_OCP_COUNT, 0xFF, 0xFF},
 };
 
+static int msm8x16_wcd_set_interpolator_rate(struct snd_soc_dai *dai,
+	u8 rx_fs_rate_reg_val, u32 sample_rate)
+{
+	return 0;
+}
+
+static int msm8x16_wcd_set_decimator_rate(struct snd_soc_dai *dai,
+	u8 tx_fs_rate_reg_val, u32 sample_rate)
+{
+
+	return 0;
+}
+
 static int msm8x16_wcd_device_up(struct snd_soc_codec *codec)
 {
 	struct msm8x16_wcd_chip *msm8x16_wcd = snd_soc_codec_get_drvdata(codec);
@@ -360,7 +381,166 @@ static int msm8x16_wcd_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 };
 
+static int msm8x16_wcd_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	return 0;
+}
+
+static void msm8x16_wcd_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+}
+
+static int msm8x16_wcd_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	u8 tx_fs_rate, rx_fs_rate;
+	int ret;
+
+	switch (params_rate(params)) {
+	case 8000:
+		tx_fs_rate = 0x00;
+		rx_fs_rate = 0x00;
+		break;
+	case 16000:
+		tx_fs_rate = 0x01;
+		rx_fs_rate = 0x20;
+		break;
+	case 32000:
+		tx_fs_rate = 0x02;
+		rx_fs_rate = 0x40;
+		break;
+	case 48000:
+		tx_fs_rate = 0x03;
+		rx_fs_rate = 0x60;
+		break;
+	case 96000:
+		tx_fs_rate = 0x04;
+		rx_fs_rate = 0x80;
+		break;
+	case 192000:
+		tx_fs_rate = 0x05;
+		rx_fs_rate = 0xA0;
+		break;
+	default:
+		dev_err(dai->codec->dev,
+			"%s: Invalid sampling rate %d\n", __func__,
+			params_rate(params));
+		return -EINVAL;
+	}
+
+	switch (substream->stream) {
+	case SNDRV_PCM_STREAM_CAPTURE:
+		snd_soc_update_bits(dai->codec,
+					MSM8X16_WCD_A_CDC_CLK_TX_I2S_CTL,
+					0x07, tx_fs_rate);
+		ret = msm8x16_wcd_set_decimator_rate(dai, tx_fs_rate,
+					       params_rate(params));
+		if (ret < 0) {
+			dev_err(dai->codec->dev,
+				"%s: set decimator rate failed %d\n", __func__,
+				ret);
+			return ret;
+		}
+		break;
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		ret = msm8x16_wcd_set_interpolator_rate(dai, rx_fs_rate,
+						  params_rate(params));
+		if (ret < 0) {
+			dev_err(dai->codec->dev,
+				"%s: set decimator rate failed %d\n", __func__,
+				ret);
+			return ret;
+		}
+		break;
+	default:
+		dev_err(dai->codec->dev,
+			"%s: Invalid stream type %d\n", __func__,
+			substream->stream);
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		snd_soc_update_bits(dai->codec,
+				MSM8X16_WCD_A_CDC_CLK_TX_I2S_CTL, 0x20, 0x20);
+		snd_soc_update_bits(dai->codec,
+				MSM8X16_WCD_A_CDC_CLK_RX_I2S_CTL, 0x20, 0x20);
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		snd_soc_update_bits(dai->codec,
+				MSM8X16_WCD_A_CDC_CLK_TX_I2S_CTL, 0x20, 0x00);
+		snd_soc_update_bits(dai->codec,
+				MSM8X16_WCD_A_CDC_CLK_RX_I2S_CTL, 0x20, 0x00);
+		break;
+	default:
+		dev_err(dai->dev, "%s: wrong format selected\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int msm8x16_wcd_set_dai_sysclk(struct snd_soc_dai *dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	return 0;
+}
+
+static int msm8x16_wcd_set_channel_map(struct snd_soc_dai *dai,
+				unsigned int tx_num, unsigned int *tx_slot,
+				unsigned int rx_num, unsigned int *rx_slot)
+
+{
+	return 0;
+}
+
+static int msm8x16_wcd_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	return 0;
+}
+
+static struct snd_soc_dai_ops msm8x16_wcd_dai_ops = {
+	.startup = msm8x16_wcd_startup,
+	.shutdown = msm8x16_wcd_shutdown,
+	.hw_params = msm8x16_wcd_hw_params,
+	.set_sysclk = msm8x16_wcd_set_dai_sysclk,
+	.set_fmt = msm8x16_wcd_set_dai_fmt,
+	.set_channel_map = msm8x16_wcd_set_channel_map,
+};
+
 static struct snd_soc_dai_driver msm8x16_wcd_codec_dai[] = {
+	[0] = {
+		.name = "msm8x16_wcd_i2s_rx1",
+		.id = MSM8x16_WCD_PLAYBACK_DAI,
+		.playback = {
+			.stream_name = "AIF1 Playback",
+			.rates = MSM8X16_WCD_RATES,
+			.formats = MSM8X16_WCD_FORMATS,
+			.rate_max = 192000,
+			.rate_min = 8000,
+			.channels_min = 1,
+			.channels_max = 3,
+		},
+		.ops = &msm8x16_wcd_dai_ops,
+	},
+	[1] = {
+		.name = "msm8x16_wcd_i2s_tx1",
+		.id = MSM8x16_WCD_CAPTURE_DAI,
+		.capture = {
+			.stream_name = "AIF1 Capture",
+			.rates = MSM8X16_WCD_RATES,
+			.formats = MSM8X16_WCD_FORMATS,
+			.rate_max = 192000,
+			.rate_min = 8000,
+			.channels_min = 1,
+			.channels_max = 4,
+		},
+		.ops = &msm8x16_wcd_dai_ops,
+	},
 };
 
 static struct snd_soc_codec_driver msm8x16_wcd_codec = {
-- 
1.9.1
