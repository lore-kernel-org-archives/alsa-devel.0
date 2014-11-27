From: Zidan Wang <b50113@freescale.com>
Subject: [PATCH] ASoC: wm8960: Move register initialisation to
	I2C driver probe()
Date: Thu, 27 Nov 2014 16:53:08 +0800
Message-ID: <1417078388-1289-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0114.outbound.protection.outlook.com [157.56.111.114])
 by alsa0.perex.cz (Postfix) with ESMTP id D2F0126592A
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 09:52:25 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Li.Xiubo@freescale.com, Zidan Wang <b50113@freescale.com>, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

We must ensure that the clocking configuration is valid as rapidly as possible.
And do software reset before the others registers updates, or the registers
will be reset to the default state.

Signed-off-by: Zidan Wang <b50113@freescale.com>
---
 sound/soc/codecs/wm8960.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index bc8793cd..031a1ae 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -128,7 +128,7 @@ struct wm8960_priv {
 	struct wm8960_data pdata;
 };
 
-#define wm8960_reset(c)	snd_soc_write(c, WM8960_RESET, 0)
+#define wm8960_reset(c)	regmap_write(c, WM8960_RESET, 0)
 
 /* enumerated controls */
 static const char *wm8960_polarity[] = {"No Inversion", "Left Inverted",
@@ -947,31 +947,12 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	struct wm8960_data *pdata = &wm8960->pdata;
-	int ret;
 
 	if (pdata->capless)
 		wm8960->set_bias_level = wm8960_set_bias_level_capless;
 	else
 		wm8960->set_bias_level = wm8960_set_bias_level_out3;
 
-	ret = wm8960_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		return ret;
-	}
-
-	/* Latch the update bits */
-	snd_soc_update_bits(codec, WM8960_LINVOL, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8960_RINVOL, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8960_LADC, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8960_RADC, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8960_LDAC, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8960_RDAC, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8960_LOUT1, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8960_ROUT1, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8960_LOUT2, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8960_ROUT2, 0x100, 0x100);
-
 	snd_soc_add_codec_controls(codec, wm8960_snd_controls,
 				     ARRAY_SIZE(wm8960_snd_controls));
 	wm8960_add_widgets(codec);
@@ -1030,7 +1011,13 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 	else if (i2c->dev.of_node)
 		wm8960_set_pdata_from_of(i2c, &wm8960->pdata);
 
-	if (pdata && pdata->shared_lrclk) {
+	ret = wm8960_reset(wm8960->regmap);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to issue reset\n");
+		return ret;
+	}
+
+	if (wm8960->pdata.shared_lrclk) {
 		ret = regmap_update_bits(wm8960->regmap, WM8960_ADDCTL2,
 					 0x4, 0x4);
 		if (ret != 0) {
@@ -1040,6 +1027,18 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
+	/* Latch the update bits */
+	regmap_update_bits(wm8960->regmap, WM8960_LINVOL, 0x100, 0x100);
+	regmap_update_bits(wm8960->regmap, WM8960_RINVOL, 0x100, 0x100);
+	regmap_update_bits(wm8960->regmap, WM8960_LADC, 0x100, 0x100);
+	regmap_update_bits(wm8960->regmap, WM8960_RADC, 0x100, 0x100);
+	regmap_update_bits(wm8960->regmap, WM8960_LDAC, 0x100, 0x100);
+	regmap_update_bits(wm8960->regmap, WM8960_RDAC, 0x100, 0x100);
+	regmap_update_bits(wm8960->regmap, WM8960_LOUT1, 0x100, 0x100);
+	regmap_update_bits(wm8960->regmap, WM8960_ROUT1, 0x100, 0x100);
+	regmap_update_bits(wm8960->regmap, WM8960_LOUT2, 0x100, 0x100);
+	regmap_update_bits(wm8960->regmap, WM8960_ROUT2, 0x100, 0x100);
+
 	i2c_set_clientdata(i2c, wm8960);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.9.1
