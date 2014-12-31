From: Zidan Wang <b50113@freescale.com>
Subject: [alsa-devel][PATCH 2/4] ASoC: wm8960: Let wm8960 driver configure its bit clock and frame clock
Date: Wed, 31 Dec 2014 11:39:12 +0800
Message-ID: <1419997154-860-2-git-send-email-b50113@freescale.com>
References: <1419997154-860-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419997154-860-1-git-send-email-b50113@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, ckeepax@opensource.wolfsonmicro.com, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Zidan Wang <b50113@freescale.com>
List-Id: alsa-devel@alsa-project.org

wm8960 codec driver missing configure its bit clock and frame clock, so add
support for it. It will calculate a appropriate frequency dividing ratio
according to the system clock, bit clock and frame clock, then set the
corresponding registers.

Signed-off-by: Zidan Wang <b50113@freescale.com>
---
 sound/soc/codecs/wm8960.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 1a5f47b..86a5489 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -127,6 +127,8 @@ struct wm8960_priv {
 	struct snd_soc_dapm_widget *out3;
 	bool deemph;
 	int playback_fs;
+	int bclk;
+	int sysclk;
 	struct wm8960_data pdata;
 };
 
@@ -563,6 +565,79 @@ static struct {
 	{  8000, 5 },
 };
 
+/* Multiply 256 for internal 256 div */
+static const int dac_divs[] = { 256, 384, 512, 768, 1024, 1408, 1536 };
+
+/* Multiply 10 to eliminate decimials */
+static const int bclk_divs[] = {
+	10, 15, 20, 30, 40, 55, 60, 80, 110,
+	120, 160, 220, 240, 320, 320, 320
+};
+
+static void wm8960_configure_clocking(struct snd_soc_codec *codec,
+		int stream, int lrclk)
+{
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+	u16 iface1 = snd_soc_read(codec, WM8960_IFACE1);
+	u16 iface2 = snd_soc_read(codec, WM8960_IFACE2);
+	int i, j;
+
+	if (!(iface1 & (1<<6))) {
+		dev_dbg(codec->dev,
+			"Codec is slave mode, no need to configure clock\n");
+		return;
+	}
+
+	if (!wm8960->sysclk) {
+		dev_dbg(codec->dev, "No SYSCLK configured\n");
+		return;
+	}
+
+	if (!wm8960->bclk || !lrclk) {
+		dev_dbg(codec->dev, "No audio clocks configured\n");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dac_divs); ++i) {
+		if (wm8960->sysclk == lrclk * dac_divs[i]) {
+			for (j = 0; j < ARRAY_SIZE(bclk_divs); ++j) {
+				if (wm8960->sysclk ==  wm8960->bclk *
+						bclk_divs[j] / 10) {
+					/* configure frame clock */
+					if (iface2 & (1<<6))
+						/* If ADCLRC configure as GPIO
+						 * pin, DACLRC pin is used as
+						 * a frame clock for ADCs and
+						 * DACs */
+						snd_soc_update_bits(codec,
+								WM8960_CLOCK1,
+								0x7 << 3,
+								i << 3);
+					else if (SNDRV_PCM_STREAM_PLAYBACK
+								== stream)
+						snd_soc_update_bits(codec,
+								WM8960_CLOCK1,
+								0x7 << 3,
+								i << 3);
+					else if (SNDRV_PCM_STREAM_CAPTURE
+								== stream)
+						snd_soc_update_bits(codec,
+								WM8960_CLOCK1,
+								0x7 << 6,
+								i << 6);
+
+					/* configure bit clock */
+					snd_soc_update_bits(codec,
+							WM8960_CLOCK2, 0xf, j);
+					return;
+				}
+			}
+		}
+	}
+
+	dev_err(codec->dev, "Unsupported sysclk %d\n", wm8960->sysclk);
+}
+
 static int wm8960_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
@@ -572,6 +647,10 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 	u16 iface = snd_soc_read(codec, WM8960_IFACE1) & 0xfff3;
 	int i;
 
+	wm8960->bclk = snd_soc_params_to_bclk(params);
+	if (params_channels(params) == 1)
+		wm8960->bclk *= 2;
+
 	/* bit size */
 	switch (params_width(params)) {
 	case 16:
@@ -602,6 +681,10 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 
 	/* set iface */
 	snd_soc_write(codec, WM8960_IFACE1, iface);
+
+	wm8960_configure_clocking(codec, substream->stream,
+			params_rate(params));
+
 	return 0;
 }
 
@@ -943,6 +1026,30 @@ static int wm8960_set_bias_level(struct snd_soc_codec *codec,
 	return wm8960->set_bias_level(codec, level);
 }
 
+static int wm8960_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+					unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+
+	switch (clk_id) {
+	case WM8960_SYSCLK_MCLK:
+		snd_soc_update_bits(codec, WM8960_CLOCK1,
+					0x1, WM8960_SYSCLK_MCLK);
+		break;
+	case WM8960_SYSCLK_PLL:
+		snd_soc_update_bits(codec, WM8960_CLOCK1,
+					0x1, WM8960_SYSCLK_PLL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	wm8960->sysclk = freq;
+
+	return 0;
+}
+
 #define WM8960_RATES SNDRV_PCM_RATE_8000_48000
 
 #define WM8960_FORMATS \
@@ -955,6 +1062,7 @@ static const struct snd_soc_dai_ops wm8960_dai_ops = {
 	.set_fmt = wm8960_set_dai_fmt,
 	.set_clkdiv = wm8960_set_dai_clkdiv,
 	.set_pll = wm8960_set_dai_pll,
+	.set_sysclk = wm8960_set_dai_sysclk,
 };
 
 static struct snd_soc_dai_driver wm8960_dai = {
-- 
1.9.1
