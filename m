From: Ian Lartey <ian@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Complete supported clock ratios and rate
 constraints for wm8741.
Date: Mon, 30 Aug 2010 09:05:00 +0100
Message-ID: <1283155501.1880.8.camel@Tapajos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C184324380
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 10:05:03 +0200 (CEST)
Received: from [172.20.11.33] (lumison.wolfsonmicro.com [87.246.78.27])
	by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id CBB04114613
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 09:05:02 +0100 (BST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8741.c |  175 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 124 insertions(+), 51 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index fdd24da..c8e7a26 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -36,7 +36,7 @@ static const char *wm8741_supply_names[WM8741_NUM_SUPPLIES] = {
 	"DVDD",
 };
 
-#define WM8741_NUM_RATES 4
+#define WM8741_NUM_RATES 6
 
 /* codec private data */
 struct wm8741_priv {
@@ -44,8 +44,7 @@ struct wm8741_priv {
 	u16 reg_cache[WM8741_REGISTER_COUNT];
 	struct regulator_bulk_data supplies[WM8741_NUM_SUPPLIES];
 	unsigned int sysclk;
-	unsigned int rate_constraint_list[WM8741_NUM_RATES];
-	struct snd_pcm_hw_constraint_list rate_constraint;
+	struct snd_pcm_hw_constraint_list *sysclk_constraints;
 };
 
 static const u16 wm8741_reg_defaults[WM8741_REGISTER_COUNT] = {
@@ -108,10 +107,84 @@ static struct {
 	int value;
 	int ratio;
 } lrclk_ratios[WM8741_NUM_RATES] = {
-	{ 1, 256 },
-	{ 2, 384 },
-	{ 3, 512 },
-	{ 4, 768 },
+	{ 1, 128 },
+	{ 2, 192 },
+	{ 3, 256 },
+	{ 4, 384 },
+	{ 5, 512 },
+	{ 6, 768 },
+};
+
+static unsigned int rates_11289[] = {
+	44100, 88235,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_11289 = {
+	.count	= ARRAY_SIZE(rates_11289),
+	.list	= rates_11289,
+};
+
+static unsigned int rates_12288[] = {
+	32000, 48000, 96000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_12288 = {
+	.count	= ARRAY_SIZE(rates_12288),
+	.list	= rates_12288,
+};
+
+static unsigned int rates_16384[] = {
+	32000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_16384 = {
+	.count	= ARRAY_SIZE(rates_16384),
+	.list	= rates_16384,
+};
+
+static unsigned int rates_16934[] = {
+	44100, 88235,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_16934 = {
+	.count	= ARRAY_SIZE(rates_16934),
+	.list	= rates_16934,
+};
+
+static unsigned int rates_18432[] = {
+	48000, 96000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_18432 = {
+	.count	= ARRAY_SIZE(rates_18432),
+	.list	= rates_18432,
+};
+
+static unsigned int rates_22579[] = {
+	44100, 88235, 1764000
+};
+
+static struct snd_pcm_hw_constraint_list constraints_22579 = {
+	.count	= ARRAY_SIZE(rates_22579),
+	.list	= rates_22579,
+};
+
+static unsigned int rates_24576[] = {
+	32000, 48000, 96000, 192000
+};
+
+static struct snd_pcm_hw_constraint_list constraints_24576 = {
+	.count	= ARRAY_SIZE(rates_24576),
+	.list	= rates_24576,
+};
+
+static unsigned int rates_36864[] = {
+	48000, 96000, 19200
+};
+
+static struct snd_pcm_hw_constraint_list constraints_36864 = {
+	.count	= ARRAY_SIZE(rates_36864),
+	.list	= rates_36864,
 };
 
 
@@ -132,7 +205,7 @@ static int wm8741_startup(struct snd_pcm_substream *substream,
 
 	snd_pcm_hw_constraint_list(substream->runtime, 0,
 				   SNDRV_PCM_HW_PARAM_RATE,
-				   &wm8741->rate_constraint);
+				   wm8741->sysclk_constraints);
 
 	return 0;
 }
@@ -192,47 +265,52 @@ static int wm8741_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
-	unsigned int val;
-	int i;
 
 	dev_dbg(codec->dev, "wm8741_set_dai_sysclk info: freq=%dHz\n", freq);
 
-	wm8741->sysclk = freq;
-
-	wm8741->rate_constraint.count = 0;
-
-	for (i = 0; i < ARRAY_SIZE(lrclk_ratios); i++) {
-		dev_dbg(codec->dev, "index = %d, ratio = %d, freq = %d",
-				i, lrclk_ratios[i].ratio, freq);
-
-		val = freq / lrclk_ratios[i].ratio;
-		/* Check that it's a standard rate since core can't
-		 * cope with others and having the odd rates confuses
-		 * constraint matching.
-		 */
-		switch (val) {
-		case 32000:
-		case 44100:
-		case 48000:
-		case 64000:
-		case 88200:
-		case 96000:
-			dev_dbg(codec->dev, "Supported sample rate: %dHz\n",
-				val);
-			wm8741->rate_constraint_list[i] = val;
-			wm8741->rate_constraint.count++;
-			break;
-		default:
-			dev_dbg(codec->dev, "Skipping sample rate: %dHz\n",
-				val);
-		}
+	switch (freq) {
+	case 11289600:
+		wm8741->sysclk_constraints = &constraints_11289;
+		wm8741->sysclk = freq;
+		return 0;
+
+	case 12288000:
+		wm8741->sysclk_constraints = &constraints_12288;
+		wm8741->sysclk = freq;
+		return 0;
+
+	case 16384000:
+		wm8741->sysclk_constraints = &constraints_16384;
+		wm8741->sysclk = freq;
+		return 0;
+
+	case 16934400:
+		wm8741->sysclk_constraints = &constraints_16934;
+		wm8741->sysclk = freq;
+		return 0;
+
+	case 18432000:
+		wm8741->sysclk_constraints = &constraints_18432;
+		wm8741->sysclk = freq;
+		return 0;
+
+	case 22579200:
+	case 33868800:
+		wm8741->sysclk_constraints = &constraints_22579;
+		wm8741->sysclk = freq;
+		return 0;
+
+	case 24576000:
+		wm8741->sysclk_constraints = &constraints_24576;
+		wm8741->sysclk = freq;
+		return 0;
+
+	case 36864000:
+		wm8741->sysclk_constraints = &constraints_36864;
+		wm8741->sysclk = freq;
+		return 0;
 	}
-
-	/* Need at least one supported rate... */
-	if (wm8741->rate_constraint.count == 0)
-		return -EINVAL;
-
-	return 0;
+	return -EINVAL;
 }
 
 static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
@@ -391,10 +469,6 @@ static int wm8741_i2c_probe(struct i2c_client *i2c,
 	if (wm8741 == NULL)
 		return -ENOMEM;
 
-	wm8741->rate_constraint.list = &wm8741->rate_constraint_list[0];
-	wm8741->rate_constraint.count =
-		ARRAY_SIZE(wm8741->rate_constraint_list);
-
 	for (i = 0; i < ARRAY_SIZE(wm8741->supplies); i++)
 		wm8741->supplies[i].supply = wm8741_supply_names[i];
 
@@ -464,9 +538,8 @@ static int __init wm8741_modinit(void)
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8741_i2c_driver);
-	if (ret != 0) {
+	if (ret != 0)
 		pr_err("Failed to register WM8741 I2C driver: %d\n", ret);
-	}
 #endif
 
 	return ret;
-- 
1.7.0.4
