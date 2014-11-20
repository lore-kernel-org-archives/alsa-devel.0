From: Zidan Wang <b50113@freescale.com>
Subject: [PATCH v2 1/2] ASoC: wm8960: Add device tree support
Date: Thu, 20 Nov 2014 16:41:17 +0800
Message-ID: <1416472878-12108-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0141.outbound.protection.outlook.com [157.56.110.141])
 by alsa0.perex.cz (Postfix) with ESMTP id F1C432605F5
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 09:40:48 +0100 (CET)
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

Document the device tree binding for the WM8960 codec, and modify the
driver to extract the platform data from device tree, if present.

Signed-off-by: Zidan Wang <b50113@freescale.com>
---
 Documentation/devicetree/bindings/sound/wm8960.txt | 27 ++++++++++++++
 sound/soc/codecs/wm8960.c                          | 41 ++++++++++++++++------
 2 files changed, 58 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8960.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8960.txt b/Documentation/devicetree/bindings/sound/wm8960.txt
new file mode 100644
index 0000000..1a9ad07
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8960.txt
@@ -0,0 +1,27 @@
+WM8960 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+  - compatible : "wlf,wm8960"
+
+  - reg : the I2C address of the device.
+
+Optional properties:
+  - shared_lrclk: This is a boolean property. If present, the LRCM bit of
+	R24 (Additional control 2 ) gets set, indicating that ADCLRC and DACLRC
+	will be disabled only when ADC (Left and Right) and DAC (Left and Right)
+	are disabled.
+
+  - capless: This is a boolean property. If present, OUT3 will be enabled
+	and disabled together with HP_L and HP_R in response to jack detect events.
+
+Example:
+
+codec: wm8960@1a {
+	compatible = "wlf,wm8960";
+	reg = <0x1a>;
+
+	shared_lrclk;
+};
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 4dc4e85..e5d89a2 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -125,6 +125,7 @@ struct wm8960_priv {
 	struct snd_soc_dapm_widget *out3;
 	bool deemph;
 	int playback_fs;
+	struct wm8960_data pdata;
 };
 
 #define wm8960_reset(c)	snd_soc_write(c, WM8960_RESET, 0)
@@ -440,8 +441,8 @@ static const struct snd_soc_dapm_route audio_paths_capless[] = {
 
 static int wm8960_add_widgets(struct snd_soc_codec *codec)
 {
-	struct wm8960_data *pdata = codec->dev->platform_data;
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+	struct wm8960_data *pdata = &wm8960->pdata;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct snd_soc_dapm_widget *w;
 
@@ -961,17 +962,13 @@ static int wm8960_resume(struct snd_soc_codec *codec)
 static int wm8960_probe(struct snd_soc_codec *codec)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
-	struct wm8960_data *pdata = dev_get_platdata(codec->dev);
+	struct wm8960_data *pdata = &wm8960->pdata;
 	int ret;
 
-	wm8960->set_bias_level = wm8960_set_bias_level_out3;
-
-	if (!pdata) {
-		dev_warn(codec->dev, "No platform data supplied\n");
-	} else {
-		if (pdata->capless)
-			wm8960->set_bias_level = wm8960_set_bias_level_capless;
-	}
+	if (pdata->capless)
+		wm8960->set_bias_level = wm8960_set_bias_level_capless;
+	else
+		wm8960->set_bias_level = wm8960_set_bias_level_out3;
 
 	ret = wm8960_reset(codec);
 	if (ret < 0) {
@@ -1029,6 +1026,18 @@ static const struct regmap_config wm8960_regmap = {
 	.volatile_reg = wm8960_volatile,
 };
 
+static void wm8960_set_pdata_from_of(struct i2c_client *i2c,
+				struct wm8960_data *pdata)
+{
+	const struct device_node *np = i2c->dev.of_node;
+
+	if (of_property_read_bool(np, "capless"))
+		pdata->capless = true;
+
+	if (of_property_read_bool(np, "shared_lrclk"))
+		pdata->shared_lrclk = true;
+}
+
 static int wm8960_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -1045,6 +1054,11 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(wm8960->regmap))
 		return PTR_ERR(wm8960->regmap);
 
+	if (pdata)
+		memcpy(&wm8960->pdata, pdata, sizeof(struct wm8960_data));
+	else if (i2c->dev.of_node)
+		wm8960_set_pdata_from_of(i2c, &wm8960->pdata);
+
 	if (pdata && pdata->shared_lrclk) {
 		ret = regmap_update_bits(wm8960->regmap, WM8960_ADDCTL2,
 					 0x4, 0x4);
@@ -1075,10 +1089,17 @@ static const struct i2c_device_id wm8960_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, wm8960_i2c_id);
 
+static const struct of_device_id wm8960_of_match[] = {
+       { .compatible = "wlf,wm8960", },
+       { }
+};
+MODULE_DEVICE_TABLE(of, wm8960_of_match);
+
 static struct i2c_driver wm8960_i2c_driver = {
 	.driver = {
 		.name = "wm8960",
 		.owner = THIS_MODULE,
+		.of_match_table = wm8960_of_match,
 	},
 	.probe =    wm8960_i2c_probe,
 	.remove =   wm8960_i2c_remove,
-- 
1.9.1
