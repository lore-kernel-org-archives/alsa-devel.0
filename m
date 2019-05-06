From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 1/4] ASoC: hdmi-codec: remove function name debug traces
Date: Mon,  6 May 2019 11:58:12 +0200
Message-ID: <20190506095815.24578-2-jbrunet@baylibre.com>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190506095815.24578-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org

Remove the debug traces only showing the function name on entry.
The same can be obtained using ftrace.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 39caf19abb0b..eb31d7eddcbf 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -416,8 +416,6 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	int ret = 0;
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	ret = hdmi_codec_new_stream(substream, dai);
 	if (ret)
 		return ret;
@@ -457,8 +455,6 @@ static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	WARN_ON(hcp->current_stream != substream);
 
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
@@ -527,8 +523,6 @@ static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	struct hdmi_codec_daifmt cf = { 0 };
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	if (dai->id == DAI_ID_SPDIF)
 		return 0;
 
@@ -597,8 +591,6 @@ static int hdmi_codec_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	if (hcp->hcd.ops->digital_mute)
 		return hcp->hcd.ops->digital_mute(dai->dev->parent,
 						  hcp->hcd.data, mute);
@@ -656,8 +648,6 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	};
 	int ret;
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	ret =  snd_pcm_add_chmap_ctls(rtd->pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				      NULL, drv->playback.channels_max, 0,
 				      &hcp->chmap_info);
@@ -754,8 +744,6 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	int dai_count, i = 0;
 	int ret;
 
-	dev_dbg(dev, "%s()\n", __func__);
-
 	if (!hcd) {
 		dev_err(dev, "%s: No platform data\n", __func__);
 		return -EINVAL;
-- 
2.20.1
