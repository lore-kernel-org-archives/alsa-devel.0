From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 1/4] ASoC: wm8960: Let wm8960 driver configure
	its bit clock and frame clock
Date: Tue, 12 May 2015 14:58:08 +0800
Message-ID: <c36ecb00aeb3115e208518c5e256f35f7b1308db.1431413323.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0115.outbound.protection.outlook.com [207.46.100.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EB46B260682
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 08:56:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Zidan Wang <zidan.wang@freescale.com>, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

wm8960 codec driver missing configure its bit clock and frame clock for codec
master mode, so add support for it. It will calculate a appropriate frequency
dividing ratio according to the system clock, bit clock and frame clock, then
set the corresponding registers.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8960.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 6fa832b..b072501 100644
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
 
@@ -563,6 +565,72 @@ static struct {
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
+		bool tx, int lrclk)
+{
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+	u16 iface1 = snd_soc_read(codec, WM8960_IFACE1);
+	u16 iface2 = snd_soc_read(codec, WM8960_IFACE2);
+	u32 sysclk;
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
+				sysclk = wm8960->bclk * bclk_divs[j] / 10;
+				if (wm8960->sysclk == sysclk)
+					break;
+			}
+			if(j != ARRAY_SIZE(bclk_divs))
+				break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(dac_divs)) {
+		dev_err(codec->dev, "Unsupported sysclk %d\n", wm8960->sysclk);
+		return;
+	}
+
+	/*
+	 * configure frame clock. If ADCLRC configure as GPIO pin, DACLRC
+	 * pin is used as a frame clock for ADCs and DACs.
+	 */
+	if (iface2 & (1<<6))
+		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 3, i << 3);
+	else if (tx)
+		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 3, i << 3);
+	else if (!tx)
+		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 6, i << 6);
+
+	/* configure bit clock */
+	snd_soc_update_bits(codec, WM8960_CLOCK2, 0xf, j);
+}
+
 static int wm8960_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
@@ -570,8 +638,13 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8960_IFACE1) & 0xfff3;
+	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	int i;
 
+	wm8960->bclk = snd_soc_params_to_bclk(params);
+	if (params_channels(params) == 1)
+		wm8960->bclk *= 2;
+
 	/* bit size */
 	switch (params_width(params)) {
 	case 16:
@@ -602,6 +675,9 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 
 	/* set iface */
 	snd_soc_write(codec, WM8960_IFACE1, iface);
+
+	wm8960_configure_clocking(codec, tx, params_rate(params));
+
 	return 0;
 }
 
@@ -946,6 +1022,30 @@ static int wm8960_set_bias_level(struct snd_soc_codec *codec,
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
@@ -958,6 +1058,7 @@ static const struct snd_soc_dai_ops wm8960_dai_ops = {
 	.set_fmt = wm8960_set_dai_fmt,
 	.set_clkdiv = wm8960_set_dai_clkdiv,
 	.set_pll = wm8960_set_dai_pll,
+	.set_sysclk = wm8960_set_dai_sysclk,
 };
 
 static struct snd_soc_dai_driver wm8960_dai = {
-- 
1.9.1
