From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/6] ASoC: hdmi-codec: remove function name debug traces
Date: Mon, 29 Apr 2019 15:29:38 +0200
Message-ID: <20190429132943.16269-2-jbrunet@baylibre.com>
References: <20190429132943.16269-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429132943.16269-1-jbrunet@baylibre.com>
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
index e5b6769b9797..9dca24732069 100644
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
@@ -453,8 +451,6 @@ static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	WARN_ON(hcp->current_stream != substream);
 
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
@@ -531,8 +527,6 @@ static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
 	struct hdmi_codec_daifmt cf = { 0 };
 	int ret = 0;
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	if (dai->id == DAI_ID_SPDIF) {
 		cf.fmt = HDMI_SPDIF;
 	} else {
@@ -602,8 +596,6 @@ static int hdmi_codec_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	if (hcp->hcd.ops->digital_mute)
 		return hcp->hcd.ops->digital_mute(dai->dev->parent,
 						  hcp->hcd.data, mute);
@@ -661,8 +653,6 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	};
 	int ret;
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	ret =  snd_pcm_add_chmap_ctls(rtd->pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				      NULL, drv->playback.channels_max, 0,
 				      &hcp->chmap_info);
@@ -759,8 +749,6 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	int dai_count, i = 0;
 	int ret;
 
-	dev_dbg(dev, "%s()\n", __func__);
-
 	if (!hcd) {
 		dev_err(dev, "%s: No plalform data\n", __func__);
 		return -EINVAL;
-- 
2.20.1
