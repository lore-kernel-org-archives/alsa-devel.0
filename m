From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH] ASoC: wm8974: configure pll and mclk divider
	automatically
Date: Mon, 25 Jan 2016 12:36:43 +0000
Message-ID: <1453725403-6261-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
 by alsa0.perex.cz (Postfix) with ESMTP id 191A62604D6
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 13:37:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

This adds a set_sysclk() DAI op so the card driver can set the
input clock frequency.  If this is done, the pll and mclk divider
are configured to produce the required 256x fs clock when the
sample rate is set by hw_params().

These additions make the codec work with the simple-card driver.
Card drivers calling set_pll() and set_clkdiv() directly are
unaffected.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 sound/soc/codecs/wm8974.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index c284c7b6db8b..dc8c3b1ebb6f 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -28,6 +28,11 @@
 
 #include "wm8974.h"
 
+struct wm8974_priv {
+	unsigned int mclk;
+	unsigned int fs;
+};
+
 static const struct reg_default wm8974_reg_defaults[] = {
 	{  0, 0x0000 }, {  1, 0x0000 }, {  2, 0x0000 }, {  3, 0x0000 },
 	{  4, 0x0050 }, {  5, 0x0000 }, {  6, 0x0140 }, {  7, 0x0000 },
@@ -379,6 +384,79 @@ static int wm8974_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static unsigned int wm8974_get_mclkdiv(unsigned int f_in, unsigned int f_out,
+				       int *mclkdiv)
+{
+	unsigned int ratio = 2 * f_in / f_out;
+
+	if (ratio <= 2) {
+		*mclkdiv = WM8974_MCLKDIV_1;
+		ratio = 2;
+	} else if (ratio == 3) {
+		*mclkdiv = WM8974_MCLKDIV_1_5;
+	} else if (ratio == 4) {
+		*mclkdiv = WM8974_MCLKDIV_2;
+	} else if (ratio <= 6) {
+		*mclkdiv = WM8974_MCLKDIV_3;
+		ratio = 6;
+	} else if (ratio <= 8) {
+		*mclkdiv = WM8974_MCLKDIV_4;
+		ratio = 8;
+	} else if (ratio <= 12) {
+		*mclkdiv = WM8974_MCLKDIV_6;
+		ratio = 12;
+	} else if (ratio <= 16) {
+		*mclkdiv = WM8974_MCLKDIV_8;
+		ratio = 16;
+	} else {
+		*mclkdiv = WM8974_MCLKDIV_12;
+		ratio = 24;
+	}
+
+	return f_out * ratio / 2;
+}
+
+static int wm8974_update_clocks(struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8974_priv *priv = snd_soc_codec_get_drvdata(codec);
+	unsigned int fs256;
+	unsigned int fpll = 0;
+	unsigned int f;
+	int mclkdiv;
+
+	if (!priv->mclk || !priv->fs)
+		return 0;
+
+	fs256 = 256 * priv->fs;
+
+	f = wm8974_get_mclkdiv(priv->mclk, fs256, &mclkdiv);
+
+	if (f != priv->mclk) {
+		/* The PLL performs best around 90MHz */
+		fpll = wm8974_get_mclkdiv(22500000, fs256, &mclkdiv);
+	}
+
+	wm8974_set_dai_pll(dai, 0, 0, priv->mclk, fpll);
+	wm8974_set_dai_clkdiv(dai, WM8974_MCLKDIV, mclkdiv);
+
+	return 0;
+}
+
+static int wm8974_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+				 unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8974_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	if (dir != SND_SOC_CLOCK_IN)
+		return -EINVAL;
+
+	priv->mclk = freq;
+
+	return wm8974_update_clocks(dai);
+}
+
 static int wm8974_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
@@ -441,8 +519,15 @@ static int wm8974_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct wm8974_priv *priv = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8974_IFACE) & 0x19f;
 	u16 adn = snd_soc_read(codec, WM8974_ADD) & 0x1f1;
+	int err;
+
+	priv->fs = params_rate(params);
+	err = wm8974_update_clocks(dai);
+	if (err)
+		return err;
 
 	/* bit size */
 	switch (params_width(params)) {
@@ -547,6 +632,7 @@ static const struct snd_soc_dai_ops wm8974_ops = {
 	.set_fmt = wm8974_set_dai_fmt,
 	.set_clkdiv = wm8974_set_dai_clkdiv,
 	.set_pll = wm8974_set_dai_pll,
+	.set_sysclk = wm8974_set_dai_sysclk,
 };
 
 static struct snd_soc_dai_driver wm8974_dai = {
@@ -606,9 +692,16 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8974 = {
 static int wm8974_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
+	struct wm8974_priv *priv;
 	struct regmap *regmap;
 	int ret;
 
+	priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, priv);
+
 	regmap = devm_regmap_init_i2c(i2c, &wm8974_regmap);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
-- 
2.7.0
