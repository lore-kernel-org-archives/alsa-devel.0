From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] WM8580 DAI: Debugged
Date: Mon, 14 Sep 2009 20:28:15 +0100
Message-ID: <20090914192814.GA27248@rakim.wolfsonmicro.main>
References: <1252742737-21925-1-git-send-email-jassisinghbrar@gmail.com>
	<20090914120647.GB1260@rakim.wolfsonmicro.main>
	<1b68c6790909140527sad5f470i38daa057c58bff67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 927C524362
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Sep 2009 21:28:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1b68c6790909140527sad5f470i38daa057c58bff67@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi <jassi.brar@samsung.com>, jsgood.yang@samsung.com, ilho215.lee@samsung.com, thomas.ab@samsung.com, ki0351.kim@samsung.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 14, 2009 at 09:27:25PM +0900, jassi brar wrote:

> Thanks for the feedback.
> I will take care of that and send the patch again.

Please also see the patch below which implements some of the clocking
improvements I was mentioning previously.  This is completely untested
at the moment and I'd fully expect it to be buggy as-is but if you wish
to make changes to the clocking in the driver this is the sort of style
which should be used.

I'll try to test and merge this soon.

>From c28ed0d241cdcd8366f6d61a9a8b87524660a2ad Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 14 Sep 2009 20:21:53 +0100
Subject: [PATCH] ASoC: Make WM8580 DAI clocking more standard

Move the WM8580 driver over to more of a standard clocking setup
method, specifying the master clock rate for the DAI using the
set_sysclk() API and configuring the LRCLK automatically using that.

This is an initial update only to present external APIs, further work
that needs doing includes enforcing the constraints flowing from
the SYSCLK selection, automatic tie in with PLL configuration and
BCLK configuration (the current BCLK configuration is compatible with
all sample rates).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |  121 +++++++++++++++++++++++++++++++--------------
 sound/soc/codecs/wm8580.h |    4 +-
 2 files changed, 85 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 6bded8c..dffc093 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -105,19 +105,18 @@
 #define WM8580_PLLB4_CLKOUTSRC_OSCCLK  0x180
 
 /* CLKSEL (register 8h) */
-#define WM8580_CLKSEL_DAC_CLKSEL_MASK 0x03
-#define WM8580_CLKSEL_DAC_CLKSEL_PLLA 0x01
-#define WM8580_CLKSEL_DAC_CLKSEL_PLLB 0x02
+#define WM8580_CLKSEL_DAC_CLKSEL_MASK  0x03
+#define WM8580_CLKSEL_DAC_CLKSEL_SHIFT 0
+#define WM8580_CLKSEL_ADC_CLKSEL_MASK  0x0c
+#define WM8580_CLKSEL_ADC_CLKSEL_SHIFT 2
+
+#define WM8580_CLKSEL_PLLA 0x01
+#define WM8580_CLKSEL_PLLB 0x02
+#define WM8580_CLKSEL_MCLK 0x03
 
 /* AIF control 1 (registers 9h-bh) */
 #define WM8580_AIF_RATE_MASK       0x7
-#define WM8580_AIF_RATE_128        0x0
-#define WM8580_AIF_RATE_192        0x1
-#define WM8580_AIF_RATE_256        0x2
-#define WM8580_AIF_RATE_384        0x3
-#define WM8580_AIF_RATE_512        0x4
-#define WM8580_AIF_RATE_768        0x5
-#define WM8580_AIF_RATE_1152       0x6
+#define WM8580_AIF_RATE_SHIFT      0x2
 
 #define WM8580_AIF_BCLKSEL_MASK   0x18
 #define WM8580_AIF_BCLKSEL_64     0x00
@@ -203,6 +202,7 @@ struct wm8580_priv {
 	u16 reg_cache[WM8580_MAX_REGISTER + 1];
 	struct pll_state a;
 	struct pll_state b;
+	int sysclk[WM8580_NUM_DAI];
 };
 
 static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
@@ -476,6 +476,10 @@ static int wm8580_set_dai_pll(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int lrclk_ratios[] = {
+	128, 192, 256, 384, 512, 768, 1152
+};
+
 /*
  * Set PCM DAI bit size and sample rate.
  */
@@ -483,12 +487,31 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8580_priv *priv = codec->private_data;
 	u16 paifb = snd_soc_read(codec, WM8580_PAIF3 + dai->id);
+	int sysclk, i;
+
+	/* SYSCLK needs to be configured prior to this being called. */
+	if (!priv->sysclk[dai->id]) {
+		dev_err(dai->dev, "SYSCLK not configured\n");
+		return -EINVAL;
+	}
+	sysclk = priv->sysclk[dai->id];
+	dev_dbg(dai->dev, "SYSCLK is %dHz\n", sysclk);
+
+	paifb &= ~(WM8580_AIF_LENGTH_MASK | WM8580_AIF_RATE_MASK);
+
+	/* Look for an exact match; the steps are too big otherwise */
+	for (i = 0; i < ARRAY_SIZE(lrclk_ratios); i++) {
+		if (params_rate(params) == sysclk / lrclk_ratios[i])
+			break;
+	}
+	if (i == ARRAY_SIZE(lrclk_ratios))
+		return -EINVAL;
+	dev_dbg(dai->dev, "LRCLK ratio %d\n", lrclk_ratios[i]);
+	paifb |= i << WM8580_AIF_RATE_SHIFT;
 
-	paifb &= ~WM8580_AIF_LENGTH_MASK;
 	/* bit size */
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -624,28 +647,6 @@ static int wm8580_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		snd_soc_write(codec, WM8580_PLLB4, reg);
 		break;
 
-	case WM8580_DAC_CLKSEL:
-		reg = snd_soc_read(codec, WM8580_CLKSEL);
-		reg &= ~WM8580_CLKSEL_DAC_CLKSEL_MASK;
-
-		switch (div) {
-		case WM8580_CLKSRC_MCLK:
-			break;
-
-		case WM8580_CLKSRC_PLLA:
-			reg |= WM8580_CLKSEL_DAC_CLKSEL_PLLA;
-			break;
-
-		case WM8580_CLKSRC_PLLB:
-			reg |= WM8580_CLKSEL_DAC_CLKSEL_PLLB;
-			break;
-
-		default:
-			return -EINVAL;
-		}
-		snd_soc_write(codec, WM8580_CLKSEL, reg);
-		break;
-
 	case WM8580_CLKOUTSRC:
 		reg = snd_soc_read(codec, WM8580_PLLB4);
 		reg &= ~WM8580_PLLB4_CLKOUTSRC_MASK;
@@ -679,6 +680,48 @@ static int wm8580_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int wm8580_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+				 unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8580_priv *priv = codec->private_data;
+	int mask, val, ret;
+
+	switch (clk_id) {
+	case WM8580_CLKSRC_MCLK:
+		val = WM8580_CLKSEL_MCLK;
+		break;
+	case WM8580_CLKSRC_PLLA:
+		val = WM8580_CLKSEL_PLLA;
+		break;
+	case WM8580_CLKSRC_PLLB:
+		val = WM8580_CLKSEL_PLLB;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (dai->id) {
+	case WM8580_DAI_PAIFRX:
+		mask = WM8580_CLKSEL_DAC_CLKSEL_MASK;
+		break;
+
+	case WM8580_DAI_PAIFTX:
+		mask = WM8580_CLKSEL_ADC_CLKSEL_MASK;
+		val <<= WM8580_CLKSEL_ADC_CLKSEL_SHIFT;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_update_bits(codec, WM8580_CLKSEL, mask, val);
+	if (ret == 0)
+		priv->sysclk[dai->id] = freq;
+
+	return ret;
+}
+
 static int wm8580_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -736,6 +779,7 @@ static struct snd_soc_dai_ops wm8580_dai_ops_playback = {
 	.set_fmt	= wm8580_set_paif_dai_fmt,
 	.set_clkdiv	= wm8580_set_dai_clkdiv,
 	.set_pll	= wm8580_set_dai_pll,
+	.set_sysclk	= wm8580_set_dai_sysclk,
 	.digital_mute	= wm8580_digital_mute,
 };
 
@@ -743,13 +787,14 @@ static struct snd_soc_dai_ops wm8580_dai_ops_capture = {
 	.hw_params	= wm8580_paif_hw_params,
 	.set_fmt	= wm8580_set_paif_dai_fmt,
 	.set_clkdiv	= wm8580_set_dai_clkdiv,
+	.set_sysclk	= wm8580_set_dai_sysclk,
 	.set_pll	= wm8580_set_dai_pll,
 };
 
 struct snd_soc_dai wm8580_dai[] = {
 	{
 		.name = "WM8580 PAIFRX",
-		.id = 0,
+		.id = WM8580_DAI_PAIFRX,
 		.playback = {
 			.stream_name = "Playback",
 			.channels_min = 1,
@@ -761,7 +806,7 @@ struct snd_soc_dai wm8580_dai[] = {
 	},
 	{
 		.name = "WM8580 PAIFTX",
-		.id = 1,
+		.id = WM8580_DAI_PAIFTX,
 		.capture = {
 			.stream_name = "Capture",
 			.channels_min = 2,
diff --git a/sound/soc/codecs/wm8580.h b/sound/soc/codecs/wm8580.h
index 0dfb5dd..f03ae9e 100644
--- a/sound/soc/codecs/wm8580.h
+++ b/sound/soc/codecs/wm8580.h
@@ -19,8 +19,7 @@
 #define WM8580_PLLB  2
 
 #define WM8580_MCLK       1
-#define WM8580_DAC_CLKSEL 2
-#define WM8580_CLKOUTSRC  3
+#define WM8580_CLKOUTSRC  2
 
 #define WM8580_CLKSRC_MCLK 1
 #define WM8580_CLKSRC_PLLA 2
@@ -30,6 +29,7 @@
 
 #define WM8580_DAI_PAIFRX 0
 #define WM8580_DAI_PAIFTX 1
+#define WM8580_NUM_DAI    2
 
 extern struct snd_soc_dai wm8580_dai[];
 extern struct snd_soc_codec_device soc_codec_dev_wm8580;
-- 
1.6.3.3
