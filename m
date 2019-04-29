From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 6/6] ASoC: hdmi-codec: remove ops dependency on the dai id
Date: Mon, 29 Apr 2019 15:29:43 +0200
Message-ID: <20190429132943.16269-7-jbrunet@baylibre.com>
References: <20190429132943.16269-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429132943.16269-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org

The dependency on the dai_id can be removed by setting different ops
for the i2s and spdif dai and storing the dai format information in
each dai structure. It simplies the code a bit.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 173 ++++++++++++++++++++--------------
 1 file changed, 102 insertions(+), 71 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index bcc2e5c3bf43..4b56fc92a80d 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -278,7 +278,6 @@ static const struct hdmi_codec_cea_spk_alloc hdmi_codec_channel_alloc[] = {
 
 struct hdmi_codec_priv {
 	struct hdmi_codec_pdata hcd;
-	struct hdmi_codec_daifmt daifmt[2];
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
 	unsigned int chmap_idx;
@@ -445,6 +444,7 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
+	struct hdmi_codec_daifmt *cf = dai->playback_dma_data;
 	struct hdmi_codec_params hp = {
 		.iec = {
 			.status = { 0 },
@@ -492,79 +492,85 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 	hp.channels = params_channels(params);
 
 	return hcp->hcd.ops->hw_params(dai->dev->parent, hcp->hcd.data,
-				       &hcp->daifmt[dai->id], &hp);
+				       cf, &hp);
 }
 
-static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
-			      unsigned int fmt)
+static int hdmi_codec_i2s_set_fmt(struct snd_soc_dai *dai,
+				  unsigned int fmt)
 {
-	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
-	struct hdmi_codec_daifmt cf = { 0 };
-	int ret = 0;
-
-	if (dai->id == DAI_ID_SPDIF) {
-		cf.fmt = HDMI_SPDIF;
-	} else {
-		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-		case SND_SOC_DAIFMT_CBM_CFM:
-			cf.bit_clk_master = 1;
-			cf.frame_clk_master = 1;
-			break;
-		case SND_SOC_DAIFMT_CBS_CFM:
-			cf.frame_clk_master = 1;
-			break;
-		case SND_SOC_DAIFMT_CBM_CFS:
-			cf.bit_clk_master = 1;
-			break;
-		case SND_SOC_DAIFMT_CBS_CFS:
-			break;
-		default:
-			return -EINVAL;
-		}
+	struct hdmi_codec_daifmt *cf = dai->playback_dma_data;
+
+	/* Reset daifmt */
+	memset(cf, 0, sizeof(*cf));
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		cf->bit_clk_master = 1;
+		cf->frame_clk_master = 1;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+		cf->frame_clk_master = 1;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		cf->bit_clk_master = 1;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
 
-		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-		case SND_SOC_DAIFMT_NB_NF:
-			break;
-		case SND_SOC_DAIFMT_NB_IF:
-			cf.frame_clk_inv = 1;
-			break;
-		case SND_SOC_DAIFMT_IB_NF:
-			cf.bit_clk_inv = 1;
-			break;
-		case SND_SOC_DAIFMT_IB_IF:
-			cf.frame_clk_inv = 1;
-			cf.bit_clk_inv = 1;
-			break;
-		}
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		cf->frame_clk_inv = 1;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		cf->bit_clk_inv = 1;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		cf->frame_clk_inv = 1;
+		cf->bit_clk_inv = 1;
+		break;
+	}
 
-		switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-		case SND_SOC_DAIFMT_I2S:
-			cf.fmt = HDMI_I2S;
-			break;
-		case SND_SOC_DAIFMT_DSP_A:
-			cf.fmt = HDMI_DSP_A;
-			break;
-		case SND_SOC_DAIFMT_DSP_B:
-			cf.fmt = HDMI_DSP_B;
-			break;
-		case SND_SOC_DAIFMT_RIGHT_J:
-			cf.fmt = HDMI_RIGHT_J;
-			break;
-		case SND_SOC_DAIFMT_LEFT_J:
-			cf.fmt = HDMI_LEFT_J;
-			break;
-		case SND_SOC_DAIFMT_AC97:
-			cf.fmt = HDMI_AC97;
-			break;
-		default:
-			dev_err(dai->dev, "Invalid DAI interface format\n");
-			return -EINVAL;
-		}
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		cf->fmt = HDMI_I2S;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		cf->fmt = HDMI_DSP_A;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		cf->fmt = HDMI_DSP_B;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		cf->fmt = HDMI_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		cf->fmt = HDMI_LEFT_J;
+		break;
+	case SND_SOC_DAIFMT_AC97:
+		cf->fmt = HDMI_AC97;
+		break;
+	default:
+		dev_err(dai->dev, "Invalid DAI interface format\n");
+		return -EINVAL;
 	}
 
-	hcp->daifmt[dai->id] = cf;
+	return 0;
+}
+
+static int hdmi_codec_spdif_set_fmt(struct snd_soc_dai *dai,
+				    unsigned int fmt)
+{
+	struct hdmi_codec_daifmt *cf = dai->playback_dma_data;
+
+	/* No need to reset the format, it is always the same for spdif */
+	cf->fmt = HDMI_SPDIF;
 
-	return ret;
+	return 0;
 }
 
 static int hdmi_codec_digital_mute(struct snd_soc_dai *dai, int mute)
@@ -578,14 +584,21 @@ static int hdmi_codec_digital_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
-static const struct snd_soc_dai_ops hdmi_dai_ops = {
+static const struct snd_soc_dai_ops hdmi_codec_i2s_dai_ops = {
 	.startup	= hdmi_codec_startup,
 	.shutdown	= hdmi_codec_shutdown,
 	.hw_params	= hdmi_codec_hw_params,
-	.set_fmt	= hdmi_codec_set_fmt,
+	.set_fmt	= hdmi_codec_i2s_set_fmt,
 	.digital_mute	= hdmi_codec_digital_mute,
 };
 
+static const struct snd_soc_dai_ops hdmi_codec_spdif_dai_ops = {
+	.startup	= hdmi_codec_startup,
+	.shutdown	= hdmi_codec_shutdown,
+	.hw_params	= hdmi_codec_hw_params,
+	.set_fmt	= hdmi_codec_spdif_set_fmt,
+	.digital_mute	= hdmi_codec_digital_mute,
+};
 
 #define HDMI_RATES	(SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
 			 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
@@ -653,20 +666,37 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 static int hdmi_dai_probe(struct snd_soc_dai *dai)
 {
 	struct snd_soc_dapm_context *dapm;
+	struct hdmi_codec_daifmt *daifmt;
 	struct snd_soc_dapm_route route = {
 		.sink = "TX",
 		.source = dai->driver->playback.stream_name,
 	};
+	int ret;
 
 	dapm = snd_soc_component_get_dapm(dai->component);
+	ret = snd_soc_dapm_add_routes(dapm, &route, 1);
+	if (ret)
+		return ret;
 
-	return snd_soc_dapm_add_routes(dapm, &route, 1);
+	daifmt = kzalloc(sizeof(*daifmt), GFP_KERNEL);
+	if (!daifmt)
+		return -ENOMEM;
+
+	dai->playback_dma_data = daifmt;
+	return 0;
+}
+
+static int hdmi_codec_dai_remove(struct snd_soc_dai *dai)
+{
+	kfree(dai->playback_dma_data);
+	return 0;
 }
 
 static const struct snd_soc_dai_driver hdmi_i2s_dai = {
 	.name = "i2s-hifi",
 	.id = DAI_ID_I2S,
 	.probe = hdmi_dai_probe,
+	.remove = hdmi_codec_dai_remove,
 	.playback = {
 		.stream_name = "I2S Playback",
 		.channels_min = 2,
@@ -675,7 +705,7 @@ static const struct snd_soc_dai_driver hdmi_i2s_dai = {
 		.formats = I2S_FORMATS,
 		.sig_bits = 24,
 	},
-	.ops = &hdmi_dai_ops,
+	.ops = &hdmi_codec_i2s_dai_ops,
 	.pcm_new = hdmi_codec_pcm_new,
 };
 
@@ -683,6 +713,7 @@ static const struct snd_soc_dai_driver hdmi_spdif_dai = {
 	.name = "spdif-hifi",
 	.id = DAI_ID_SPDIF,
 	.probe = hdmi_dai_probe,
+	.remove = hdmi_codec_dai_remove,
 	.playback = {
 		.stream_name = "SPDIF Playback",
 		.channels_min = 2,
@@ -690,7 +721,7 @@ static const struct snd_soc_dai_driver hdmi_spdif_dai = {
 		.rates = HDMI_RATES,
 		.formats = SPDIF_FORMATS,
 	},
-	.ops = &hdmi_dai_ops,
+	.ops = &hdmi_codec_spdif_dai_ops,
 	.pcm_new = hdmi_codec_pcm_new,
 };
 
-- 
2.20.1
