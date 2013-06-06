From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH V2 1/2] ASoC: WM8962: Create default platform
	data structure
Date: Thu, 6 Jun 2013 19:38:45 +0800
Message-ID: <7e99c1946386e241854a3d7659a7a6d4201a5b34.1370518627.git.b42378@freescale.com>
References: <cover.1370518627.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C52526557D
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 13:32:19 +0200 (CEST)
In-Reply-To: <cover.1370518627.git.b42378@freescale.com>
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

Embed a copy of struct wm8962_pdata in stuct wm8962_priv
so that there's no need to check validity of pdata any more.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/codecs/wm8962.c |   66 ++++++++++++++++++++++++---------------------
 1 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index e971028..d56dd86 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -51,6 +51,7 @@ static const char *wm8962_supply_names[WM8962_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct wm8962_priv {
+	struct wm8962_pdata pdata;
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
 
@@ -2345,12 +2346,13 @@ static const struct snd_soc_dapm_route wm8962_spk_stereo_intercon[] = {
 
 static int wm8962_add_widgets(struct snd_soc_codec *codec)
 {
-	struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
+	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
+	struct wm8962_pdata *pdata = &wm8962->pdata;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	snd_soc_add_codec_controls(codec, wm8962_snd_controls,
 			     ARRAY_SIZE(wm8962_snd_controls));
-	if (pdata && pdata->spk_mono)
+	if (pdata->spk_mono)
 		snd_soc_add_codec_controls(codec, wm8962_spk_mono_controls,
 				     ARRAY_SIZE(wm8962_spk_mono_controls));
 	else
@@ -2360,7 +2362,7 @@ static int wm8962_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8962_dapm_widgets,
 				  ARRAY_SIZE(wm8962_dapm_widgets));
-	if (pdata && pdata->spk_mono)
+	if (pdata->spk_mono)
 		snd_soc_dapm_new_controls(dapm, wm8962_dapm_spk_mono_widgets,
 					  ARRAY_SIZE(wm8962_dapm_spk_mono_widgets));
 	else
@@ -2369,7 +2371,7 @@ static int wm8962_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_add_routes(dapm, wm8962_intercon,
 				ARRAY_SIZE(wm8962_intercon));
-	if (pdata && pdata->spk_mono)
+	if (pdata->spk_mono)
 		snd_soc_dapm_add_routes(dapm, wm8962_spk_mono_intercon,
 					ARRAY_SIZE(wm8962_spk_mono_intercon));
 	else
@@ -3333,14 +3335,14 @@ static struct gpio_chip wm8962_template_chip = {
 static void wm8962_init_gpio(struct snd_soc_codec *codec)
 {
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-	struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
+	struct wm8962_pdata *pdata = &wm8962->pdata;
 	int ret;
 
 	wm8962->gpio_chip = wm8962_template_chip;
 	wm8962->gpio_chip.ngpio = WM8962_MAX_GPIO;
 	wm8962->gpio_chip.dev = codec->dev;
 
-	if (pdata && pdata->gpio_base)
+	if (pdata->gpio_base)
 		wm8962->gpio_chip.base = pdata->gpio_base;
 	else
 		wm8962->gpio_chip.base = -1;
@@ -3373,7 +3375,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 {
 	int ret;
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-	struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
+	struct wm8962_pdata *pdata = &wm8962->pdata;
 	u16 *reg_cache = codec->reg_cache;
 	int i, trigger, irq_pol;
 	bool dmicclk, dmicdat;
@@ -3421,30 +3423,28 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 			    WM8962_OSC_ENA | WM8962_PLL2_ENA | WM8962_PLL3_ENA,
 			    0);
 
-	if (pdata) {
-		/* Apply static configuration for GPIOs */
-		for (i = 0; i < ARRAY_SIZE(pdata->gpio_init); i++)
-			if (pdata->gpio_init[i]) {
-				wm8962_set_gpio_mode(codec, i + 1);
-				snd_soc_write(codec, 0x200 + i,
-					      pdata->gpio_init[i] & 0xffff);
-			}
+	/* Apply static configuration for GPIOs */
+	for (i = 0; i < ARRAY_SIZE(pdata->gpio_init); i++)
+		if (pdata->gpio_init[i]) {
+			wm8962_set_gpio_mode(codec, i + 1);
+			snd_soc_write(codec, 0x200 + i,
+					pdata->gpio_init[i] & 0xffff);
+		}
 
-		/* Put the speakers into mono mode? */
-		if (pdata->spk_mono)
-			reg_cache[WM8962_CLASS_D_CONTROL_2]
-				|= WM8962_SPK_MONO;
+	/* Put the speakers into mono mode? */
+	if (pdata->spk_mono)
+		reg_cache[WM8962_CLASS_D_CONTROL_2]
+			|= WM8962_SPK_MONO;
 
-		/* Micbias setup, detection enable and detection
-		 * threasholds. */
-		if (pdata->mic_cfg)
-			snd_soc_update_bits(codec, WM8962_ADDITIONAL_CONTROL_4,
-					    WM8962_MICDET_ENA |
-					    WM8962_MICDET_THR_MASK |
-					    WM8962_MICSHORT_THR_MASK |
-					    WM8962_MICBIAS_LVL,
-					    pdata->mic_cfg);
-	}
+	/* Micbias setup, detection enable and detection
+	 * threasholds. */
+	if (pdata->mic_cfg)
+		snd_soc_update_bits(codec, WM8962_ADDITIONAL_CONTROL_4,
+				    WM8962_MICDET_ENA |
+				    WM8962_MICDET_THR_MASK |
+				    WM8962_MICSHORT_THR_MASK |
+				    WM8962_MICBIAS_LVL,
+				    pdata->mic_cfg);
 
 	/* Latch volume update bits */
 	snd_soc_update_bits(codec, WM8962_LEFT_INPUT_VOLUME,
@@ -3506,7 +3506,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	wm8962_init_gpio(codec);
 
 	if (wm8962->irq) {
-		if (pdata && pdata->irq_active_low) {
+		if (pdata->irq_active_low) {
 			trigger = IRQF_TRIGGER_LOW;
 			irq_pol = WM8962_IRQ_POL;
 		} else {
@@ -3603,6 +3603,10 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 	init_completion(&wm8962->fll_lock);
 	wm8962->irq = i2c->irq;
 
+	/* If platform data was supplied, update the default data in priv */
+	if (pdata)
+		memcpy(&wm8962->pdata, pdata, sizeof(struct wm8962_pdata));
+
 	for (i = 0; i < ARRAY_SIZE(wm8962->supplies); i++)
 		wm8962->supplies[i].supply = wm8962_supply_names[i];
 
@@ -3666,7 +3670,7 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 		goto err_enable;
 	}
 
-	if (pdata && pdata->in4_dc_measure) {
+	if (wm8962->pdata.in4_dc_measure) {
 		ret = regmap_register_patch(wm8962->regmap,
 					    wm8962_dc_measure,
 					    ARRAY_SIZE(wm8962_dc_measure));
-- 
1.7.1
