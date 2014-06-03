From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Implement TDM support for
	Arizona devices
Date: Tue,  3 Jun 2014 20:06:10 +0100
Message-ID: <1401822370-5324-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 908F5261A60
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 21:13:42 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/linux/mfd/arizona/core.h |    3 +
 sound/soc/codecs/arizona.c       |   81 +++++++++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/include/linux/mfd/arizona/core.h b/include/linux/mfd/arizona/core.h
index 5cf8b91..11783b5 100644
--- a/include/linux/mfd/arizona/core.h
+++ b/include/linux/mfd/arizona/core.h
@@ -110,6 +110,9 @@ struct arizona {
 	int clk32k_ref;
 
 	struct snd_soc_dapm_context *dapm;
+
+	int tdm_width[ARIZONA_MAX_AIF];
+	int tdm_slots[ARIZONA_MAX_AIF];
 };
 
 int arizona_clk32k_enable(struct arizona *arizona);
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 29e198f..d98bd77 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1185,7 +1185,10 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	int base = dai->driver->base;
 	const int *rates;
 	int i, ret, val;
+	int channels = params_channels(params);
 	int chan_limit = arizona->pdata.max_channels_clocked[dai->id - 1];
+	int tdm_width = arizona->tdm_width[dai->id - 1];
+	int tdm_slots = arizona->tdm_slots[dai->id - 1];
 	int bclk, lrclk, wl, frame, bclk_target;
 
 	if (params_rate(params) % 8000)
@@ -1193,18 +1196,27 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	else
 		rates = &arizona_48k_bclk_rates[0];
 
-	bclk_target = snd_soc_params_to_bclk(params);
-	if (chan_limit && chan_limit < params_channels(params)) {
+	if (tdm_slots) {
+		arizona_aif_dbg(dai, "Configuring for %d %d bit TDM slots\n",
+				tdm_slots, tdm_width);
+		bclk_target = tdm_slots * tdm_width * params_rate(params);
+		channels = tdm_slots;
+	} else {
+		bclk_target = snd_soc_params_to_bclk(params);
+	}
+
+	if (chan_limit && chan_limit < channels) {
 		arizona_aif_dbg(dai, "Limiting to %d channels\n", chan_limit);
-		bclk_target /= params_channels(params);
+		bclk_target /= channels;
 		bclk_target *= chan_limit;
 	}
 
-	/* Force stereo for I2S mode */
+	/* Force multiple of 2 channels for I2S mode */
 	val = snd_soc_read(codec, base + ARIZONA_AIF_FORMAT);
-	if (params_channels(params) == 1 && (val & ARIZONA_AIF1_FMT_MASK)) {
+	if ((channels & 1) && (val & ARIZONA_AIF1_FMT_MASK)) {
 		arizona_aif_dbg(dai, "Forcing stereo mode\n");
-		bclk_target *= 2;
+		bclk_target /= channels;
+		bclk_target *= channels + 1;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(arizona_44k1_bclk_rates); i++) {
@@ -1228,6 +1240,9 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	wl = snd_pcm_format_width(params_format(params));
 	frame = wl << ARIZONA_AIF1TX_WL_SHIFT | wl;
 
+	if (tdm_width && wl != tdm_width)
+		arizona_aif_warn(dai, "Word length not equal to TDM width\n");
+
 	ret = arizona_hw_params_rate(substream, params, dai);
 	if (ret != 0)
 		return ret;
@@ -1324,9 +1339,63 @@ static int arizona_set_tristate(struct snd_soc_dai *dai, int tristate)
 				   ARIZONA_AIF1_TRI, reg);
 }
 
+static void arizona_set_channels_to_mask(struct snd_soc_dai *dai,
+					 unsigned int base,
+					 int channels, unsigned int mask)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+	int slot, i;
+
+	for (i = 0; i < channels; ++i) {
+		slot = ffs(mask) - 1;
+		if (slot < 0)
+			return;
+
+		regmap_write(arizona->regmap, base + i, slot);
+
+		mask &= ~(1 << slot);
+	}
+
+	if (mask)
+		arizona_aif_warn(dai, "Too many channels in TDM mask\n");
+}
+
+static int arizona_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+				unsigned int rx_mask, int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+	int base = dai->driver->base;
+	int rx_max_chan = dai->driver->playback.channels_max;
+	int tx_max_chan = dai->driver->capture.channels_max;
+
+	/* Only support TDM for the physical AIFs */
+	if (dai->id > ARIZONA_MAX_AIF)
+		return -ENOTSUPP;
+
+	if (slots == 0) {
+		tx_mask = (1 << tx_max_chan) - 1;
+		rx_mask = (1 << rx_max_chan) - 1;
+	}
+
+	arizona_set_channels_to_mask(dai, base + ARIZONA_AIF_FRAME_CTRL_3,
+				     tx_max_chan, tx_mask);
+	arizona_set_channels_to_mask(dai, base + ARIZONA_AIF_FRAME_CTRL_11,
+				     rx_max_chan, rx_mask);
+
+	arizona->tdm_width[dai->id - 1] = slot_width;
+	arizona->tdm_slots[dai->id - 1] = slots;
+
+	return 0;
+}
+
 const struct snd_soc_dai_ops arizona_dai_ops = {
 	.startup = arizona_startup,
 	.set_fmt = arizona_set_fmt,
+	.set_tdm_slot = arizona_set_tdm_slot,
 	.hw_params = arizona_hw_params,
 	.set_sysclk = arizona_dai_set_sysclk,
 	.set_tristate = arizona_set_tristate,
-- 
1.7.2.5
