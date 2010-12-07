From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Support WM8994 mono AIF configurations
Date: Tue,  7 Dec 2010 17:21:01 +0000
Message-ID: <1291742461-32052-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D95A4103A3C
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 18:21:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM8994 supports mono signals - enable this in the driver. With DSP
mode an automatic data channel selector is available, activate this
when in mono mode.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 78b96f6..da48802 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2121,10 +2121,12 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 	struct wm8994 *control = codec->control_data;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int aif1_reg;
+	int aif2_reg;
 	int bclk_reg;
 	int lrclk_reg;
 	int rate_reg;
 	int aif1 = 0;
+	int aif2 = 0;
 	int bclk = 0;
 	int lrclk = 0;
 	int rate_val = 0;
@@ -2135,6 +2137,7 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 	switch (dai->id) {
 	case 1:
 		aif1_reg = WM8994_AIF1_CONTROL_1;
+		aif2_reg = WM8994_AIF1_CONTROL_2;
 		bclk_reg = WM8994_AIF1_BCLK;
 		rate_reg = WM8994_AIF1_RATE;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK ||
@@ -2147,6 +2150,7 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case 2:
 		aif1_reg = WM8994_AIF2_CONTROL_1;
+		aif2_reg = WM8994_AIF2_CONTROL_2;
 		bclk_reg = WM8994_AIF2_BCLK;
 		rate_reg = WM8994_AIF2_RATE;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK ||
@@ -2202,6 +2206,10 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(dai->dev, "AIF%dCLK is %dHz, target BCLK %dHz\n",
 		dai->id, wm8994->aifclk[id], bclk_rate);
 
+	if (params_channels(params) == 1 &&
+	    (snd_soc_read(codec, aif1_reg) & 0x18) == 0x18)
+		aif2 |= WM8994_AIF1_MONO;
+
 	if (wm8994->aifclk[id] == 0) {
 		dev_err(dai->dev, "AIF%dCLK not configured\n", dai->id);
 		return -EINVAL;
@@ -2245,6 +2253,7 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 		lrclk, bclk_rate / lrclk);
 
 	snd_soc_update_bits(codec, aif1_reg, WM8994_AIF1_WL_MASK, aif1);
+	snd_soc_update_bits(codec, aif2_reg, WM8994_AIF1_MONO, aif2);
 	snd_soc_update_bits(codec, bclk_reg, WM8994_AIF1_BCLK_DIV_MASK, bclk);
 	snd_soc_update_bits(codec, lrclk_reg, WM8994_AIF1DAC_RATE_MASK,
 			    lrclk);
@@ -2400,14 +2409,14 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
 		.id = 1,
 		.playback = {
 			.stream_name = "AIF1 Playback",
-			.channels_min = 2,
+			.channels_min = 1,
 			.channels_max = 2,
 			.rates = WM8994_RATES,
 			.formats = WM8994_FORMATS,
 		},
 		.capture = {
 			.stream_name = "AIF1 Capture",
-			.channels_min = 2,
+			.channels_min = 1,
 			.channels_max = 2,
 			.rates = WM8994_RATES,
 			.formats = WM8994_FORMATS,
@@ -2419,14 +2428,14 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
 		.id = 2,
 		.playback = {
 			.stream_name = "AIF2 Playback",
-			.channels_min = 2,
+			.channels_min = 1,
 			.channels_max = 2,
 			.rates = WM8994_RATES,
 			.formats = WM8994_FORMATS,
 		},
 		.capture = {
 			.stream_name = "AIF2 Capture",
-			.channels_min = 2,
+			.channels_min = 1,
 			.channels_max = 2,
 			.rates = WM8994_RATES,
 			.formats = WM8994_FORMATS,
@@ -2438,14 +2447,14 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
 		.id = 3,
 		.playback = {
 			.stream_name = "AIF3 Playback",
-			.channels_min = 2,
+			.channels_min = 1,
 			.channels_max = 2,
 			.rates = WM8994_RATES,
 			.formats = WM8994_FORMATS,
 		},
 		.capture = {
 			.stream_name = "AIF3 Capture",
-			.channels_min = 2,
+			.channels_min = 1,
 			.channels_max = 2,
 			.rates = WM8994_RATES,
 			.formats = WM8994_FORMATS,
-- 
1.7.1
