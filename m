From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH 1/2] ASoC: WM8962: Create default platform data
	structure
Date: Wed, 5 Jun 2013 20:12:55 +0800
Message-ID: <4e85e3a9b5dfdc04899958424eb53a9cfd0f4ace.1370433363.git.b42378@freescale.com>
References: <cover.1370433363.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 by alsa0.perex.cz (Postfix) with ESMTP id E655726538A
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 14:06:33 +0200 (CEST)
In-Reply-To: <cover.1370433363.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@linaro.org, broonie@kernel.org, lgirdwood@gmail.com, rob.herring@calxeda.com
List-Id: alsa-devel@alsa-project.org

When no platform data is supplied, point pdata at a default platform
structure. This enables two future changes:

a) Defines the default platform data values in a single place.
b) There is always a valid pdata pointer, so some conditional code can
   be simplified by a later patch.

Based on work of WM8903 by Stephen Warren <swarren@nvidia.com>

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/codecs/wm8962.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index e971028..ea35396 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -51,6 +51,7 @@ static const char *wm8962_supply_names[WM8962_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct wm8962_priv {
+	struct wm8962_pdata *pdata;
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
 
@@ -2345,7 +2346,8 @@ static const struct snd_soc_dapm_route wm8962_spk_stereo_intercon[] = {
 
 static int wm8962_add_widgets(struct snd_soc_codec *codec)
 {
-	struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
+	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
+	struct wm8962_pdata *pdata = wm8962->pdata;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	snd_soc_add_codec_controls(codec, wm8962_snd_controls,
@@ -3333,7 +3335,7 @@ static struct gpio_chip wm8962_template_chip = {
 static void wm8962_init_gpio(struct snd_soc_codec *codec)
 {
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-	struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
+	struct wm8962_pdata *pdata = wm8962->pdata;
 	int ret;
 
 	wm8962->gpio_chip = wm8962_template_chip;
@@ -3373,7 +3375,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 {
 	int ret;
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-	struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
+	struct wm8962_pdata *pdata = wm8962->pdata;
 	u16 *reg_cache = codec->reg_cache;
 	int i, trigger, irq_pol;
 	bool dmicclk, dmicdat;
@@ -3603,6 +3605,19 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 	init_completion(&wm8962->fll_lock);
 	wm8962->irq = i2c->irq;
 
+	/* If no platform data was supplied, create storage for defaults */
+	if (pdata) {
+		wm8962->pdata = pdata;
+	} else {
+		wm8962->pdata = devm_kzalloc(&i2c->dev,
+					sizeof(struct wm8962_pdata),
+					GFP_KERNEL);
+		if (wm8962->pdata == NULL) {
+			dev_err(&i2c->dev, "Failed to allocate pdata\n");
+			return -ENOMEM;
+		}
+	}
+
 	for (i = 0; i < ARRAY_SIZE(wm8962->supplies); i++)
 		wm8962->supplies[i].supply = wm8962_supply_names[i];
 
@@ -3666,7 +3681,7 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 		goto err_enable;
 	}
 
-	if (pdata && pdata->in4_dc_measure) {
+	if (wm8962->pdata->in4_dc_measure) {
 		ret = regmap_register_patch(wm8962->regmap,
 					    wm8962_dc_measure,
 					    ARRAY_SIZE(wm8962_dc_measure));
-- 
1.7.1
