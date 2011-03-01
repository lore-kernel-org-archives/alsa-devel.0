From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add platform data for WM9081 IRQ pin
	configuration
Date: Tue,  1 Mar 2011 20:11:10 +0000
Message-ID: <1299010270-31027-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 381AB103854
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 21:10:50 +0100 (CET)
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

The WM9081 IRQ output can be either active high or active low and can
support either CMOS or open drain modes.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/wm9081.h    |    9 ++++++---
 sound/soc/codecs/wm9081.c |   29 +++++++++++++++++++----------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/sound/wm9081.h b/include/sound/wm9081.h
index e173ddb..f34b0b1 100644
--- a/include/sound/wm9081.h
+++ b/include/sound/wm9081.h
@@ -17,9 +17,12 @@ struct wm9081_retune_mobile_setting {
 	u16 config[20];
 };
 
-struct wm9081_retune_mobile_config {
-	struct wm9081_retune_mobile_setting *configs;
-	int num_configs;
+struct wm9081_pdata {
+	bool irq_high;   /* IRQ is active high */
+	bool irq_cmos;   /* IRQ is in CMOS mode */
+
+	struct wm9081_retune_mobile_setting *retune_configs;
+	int num_retune_configs;
 };
 
 #endif
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 2103623..7883f3e 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -167,7 +167,7 @@ struct wm9081_priv {
 	int fll_fref;
 	int fll_fout;
 	int tdm_width;
-	struct wm9081_retune_mobile_config *retune;
+	struct wm9081_pdata pdata;
 };
 
 static int wm9081_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
@@ -1082,21 +1082,22 @@ static int wm9081_hw_params(struct snd_pcm_substream *substream,
 	aif4 |= wm9081->bclk / wm9081->fs;
 
 	/* Apply a ReTune Mobile configuration if it's in use */
-	if (wm9081->retune) {
-		struct wm9081_retune_mobile_config *retune = wm9081->retune;
+	if (wm9081->pdata.num_retune_configs) {
+		struct wm9081_pdata *pdata = &wm9081->pdata;
 		struct wm9081_retune_mobile_setting *s;
 		int eq1;
 
 		best = 0;
-		best_val = abs(retune->configs[0].rate - wm9081->fs);
-		for (i = 0; i < retune->num_configs; i++) {
-			cur_val = abs(retune->configs[i].rate - wm9081->fs);
+		best_val = abs(pdata->retune_configs[0].rate - wm9081->fs);
+		for (i = 0; i < pdata->num_retune_configs; i++) {
+			cur_val = abs(pdata->retune_configs[i].rate -
+				      wm9081->fs);
 			if (cur_val < best_val) {
 				best_val = cur_val;
 				best = i;
 			}
 		}
-		s = &retune->configs[best];
+		s = &pdata->retune_configs[best];
 
 		dev_dbg(codec->dev, "ReTune Mobile %s tuned for %dHz\n",
 			s->name, s->rate);
@@ -1255,6 +1256,14 @@ static int wm9081_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
+	reg = 0;
+	if (wm9081->pdata.irq_high)
+		reg |= WM9081_IRQ_POL;
+	if (!wm9081->pdata.irq_cmos)
+		reg |= WM9081_IRQ_OP_CTRL;
+	snd_soc_update_bits(codec, WM9081_INTERRUPT_CONTROL,
+			    WM9081_IRQ_POL | WM9081_IRQ_OP_CTRL, reg);
+
 	wm9081_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Enable zero cross by default */
@@ -1266,7 +1275,7 @@ static int wm9081_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, wm9081_snd_controls,
 			     ARRAY_SIZE(wm9081_snd_controls));
-	if (!wm9081->retune) {
+	if (!wm9081->pdata.num_retune_configs) {
 		dev_dbg(codec->dev,
 			"No ReTune Mobile data, using normal EQ\n");
 		snd_soc_add_controls(codec, wm9081_eq_controls,
@@ -1343,8 +1352,8 @@ static __devinit int wm9081_i2c_probe(struct i2c_client *i2c,
 	wm9081->control_data = i2c;
 
 	if (dev_get_platdata(&i2c->dev))
-		memcpy(&wm9081->retune, dev_get_platdata(&i2c->dev),
-		       sizeof(wm9081->retune));
+		memcpy(&wm9081->pdata, dev_get_platdata(&i2c->dev),
+		       sizeof(wm9081->pdata));
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm9081, &wm9081_dai, 1);
-- 
1.7.2.3
