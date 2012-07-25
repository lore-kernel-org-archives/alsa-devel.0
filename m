From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_hubs: Move CODEC stored in private
	data into wm_hubs
Date: Wed, 25 Jul 2012 18:53:29 +0100
Message-ID: <1343238810-1221-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DF0B6265319
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 19:53:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Further wm_hubs code will use this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8958-dsp2.c |   28 ++++++++++++++++------------
 sound/soc/codecs/wm8994.c      |   28 +++++++++++++---------------
 sound/soc/codecs/wm8994.h      |    1 -
 sound/soc/codecs/wm_hubs.c     |    2 ++
 sound/soc/codecs/wm_hubs.h     |    2 ++
 5 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 1332692..00121ba 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -946,7 +946,7 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->mbc_texts = kmalloc(sizeof(char *)
 					    * pdata->num_mbc_cfgs, GFP_KERNEL);
 		if (!wm8994->mbc_texts) {
-			dev_err(wm8994->codec->dev,
+			dev_err(wm8994->hubs.codec->dev,
 				"Failed to allocate %d MBC config texts\n",
 				pdata->num_mbc_cfgs);
 			return;
@@ -958,9 +958,10 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->mbc_enum.max = pdata->num_mbc_cfgs;
 		wm8994->mbc_enum.texts = wm8994->mbc_texts;
 
-		ret = snd_soc_add_codec_controls(wm8994->codec, control, 1);
+		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
+						 control, 1);
 		if (ret != 0)
-			dev_err(wm8994->codec->dev,
+			dev_err(wm8994->hubs.codec->dev,
 				"Failed to add MBC mode controls: %d\n", ret);
 	}
 
@@ -974,7 +975,7 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->vss_texts = kmalloc(sizeof(char *)
 					    * pdata->num_vss_cfgs, GFP_KERNEL);
 		if (!wm8994->vss_texts) {
-			dev_err(wm8994->codec->dev,
+			dev_err(wm8994->hubs.codec->dev,
 				"Failed to allocate %d VSS config texts\n",
 				pdata->num_vss_cfgs);
 			return;
@@ -986,9 +987,10 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->vss_enum.max = pdata->num_vss_cfgs;
 		wm8994->vss_enum.texts = wm8994->vss_texts;
 
-		ret = snd_soc_add_codec_controls(wm8994->codec, control, 1);
+		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
+						 control, 1);
 		if (ret != 0)
-			dev_err(wm8994->codec->dev,
+			dev_err(wm8994->hubs.codec->dev,
 				"Failed to add VSS mode controls: %d\n", ret);
 	}
 
@@ -1003,7 +1005,7 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->vss_hpf_texts = kmalloc(sizeof(char *)
 						* pdata->num_vss_hpf_cfgs, GFP_KERNEL);
 		if (!wm8994->vss_hpf_texts) {
-			dev_err(wm8994->codec->dev,
+			dev_err(wm8994->hubs.codec->dev,
 				"Failed to allocate %d VSS HPF config texts\n",
 				pdata->num_vss_hpf_cfgs);
 			return;
@@ -1015,9 +1017,10 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->vss_hpf_enum.max = pdata->num_vss_hpf_cfgs;
 		wm8994->vss_hpf_enum.texts = wm8994->vss_hpf_texts;
 
-		ret = snd_soc_add_codec_controls(wm8994->codec, control, 1);
+		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
+						 control, 1);
 		if (ret != 0)
-			dev_err(wm8994->codec->dev,
+			dev_err(wm8994->hubs.codec->dev,
 				"Failed to add VSS HPFmode controls: %d\n",
 				ret);
 	}
@@ -1033,7 +1036,7 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->enh_eq_texts = kmalloc(sizeof(char *)
 						* pdata->num_enh_eq_cfgs, GFP_KERNEL);
 		if (!wm8994->enh_eq_texts) {
-			dev_err(wm8994->codec->dev,
+			dev_err(wm8994->hubs.codec->dev,
 				"Failed to allocate %d enhanced EQ config texts\n",
 				pdata->num_enh_eq_cfgs);
 			return;
@@ -1045,9 +1048,10 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->enh_eq_enum.max = pdata->num_enh_eq_cfgs;
 		wm8994->enh_eq_enum.texts = wm8994->enh_eq_texts;
 
-		ret = snd_soc_add_codec_controls(wm8994->codec, control, 1);
+		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
+						 control, 1);
 		if (ret != 0)
-			dev_err(wm8994->codec->dev,
+			dev_err(wm8994->hubs.codec->dev,
 				"Failed to add enhanced EQ controls: %d\n",
 				ret);
 	}
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2c9b8b7..1237c11 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3036,7 +3036,7 @@ static int wm8994_codec_resume(struct snd_soc_codec *codec)
 
 static void wm8994_handle_retune_mobile_pdata(struct wm8994_priv *wm8994)
 {
-	struct snd_soc_codec *codec = wm8994->codec;
+	struct snd_soc_codec *codec = wm8994->hubs.codec;
 	struct wm8994_pdata *pdata = wm8994->pdata;
 	struct snd_kcontrol_new controls[] = {
 		SOC_ENUM_EXT("AIF1.1 EQ Mode",
@@ -3094,16 +3094,16 @@ static void wm8994_handle_retune_mobile_pdata(struct wm8994_priv *wm8994)
 	wm8994->retune_mobile_enum.max = wm8994->num_retune_mobile_texts;
 	wm8994->retune_mobile_enum.texts = wm8994->retune_mobile_texts;
 
-	ret = snd_soc_add_codec_controls(wm8994->codec, controls,
+	ret = snd_soc_add_codec_controls(wm8994->hubs.codec, controls,
 				   ARRAY_SIZE(controls));
 	if (ret != 0)
-		dev_err(wm8994->codec->dev,
+		dev_err(wm8994->hubs.codec->dev,
 			"Failed to add ReTune Mobile controls: %d\n", ret);
 }
 
 static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 {
-	struct snd_soc_codec *codec = wm8994->codec;
+	struct snd_soc_codec *codec = wm8994->hubs.codec;
 	struct wm8994_pdata *pdata = wm8994->pdata;
 	int ret, i;
 
@@ -3132,10 +3132,10 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 		};
 
 		/* We need an array of texts for the enum API */
-		wm8994->drc_texts = devm_kzalloc(wm8994->codec->dev,
+		wm8994->drc_texts = devm_kzalloc(wm8994->hubs.codec->dev,
 			    sizeof(char *) * pdata->num_drc_cfgs, GFP_KERNEL);
 		if (!wm8994->drc_texts) {
-			dev_err(wm8994->codec->dev,
+			dev_err(wm8994->hubs.codec->dev,
 				"Failed to allocate %d DRC config texts\n",
 				pdata->num_drc_cfgs);
 			return;
@@ -3147,10 +3147,10 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 		wm8994->drc_enum.max = pdata->num_drc_cfgs;
 		wm8994->drc_enum.texts = wm8994->drc_texts;
 
-		ret = snd_soc_add_codec_controls(wm8994->codec, controls,
+		ret = snd_soc_add_codec_controls(wm8994->hubs.codec, controls,
 					   ARRAY_SIZE(controls));
 		if (ret != 0)
-			dev_err(wm8994->codec->dev,
+			dev_err(wm8994->hubs.codec->dev,
 				"Failed to add DRC mode controls: %d\n", ret);
 
 		for (i = 0; i < WM8994_NUM_DRC; i++)
@@ -3163,7 +3163,7 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 	if (pdata->num_retune_mobile_cfgs)
 		wm8994_handle_retune_mobile_pdata(wm8994);
 	else
-		snd_soc_add_codec_controls(wm8994->codec, wm8994_eq_controls,
+		snd_soc_add_codec_controls(wm8994->hubs.codec, wm8994_eq_controls,
 				     ARRAY_SIZE(wm8994_eq_controls));
 
 	for (i = 0; i < ARRAY_SIZE(pdata->micbias); i++) {
@@ -3318,7 +3318,7 @@ static void wm8994_mic_work(struct work_struct *work)
 static irqreturn_t wm8994_mic_irq(int irq, void *data)
 {
 	struct wm8994_priv *priv = data;
-	struct snd_soc_codec *codec = priv->codec;
+	struct snd_soc_codec *codec = priv->hubs.codec;
 
 #ifndef CONFIG_SND_SOC_WM8994_MODULE
 	trace_snd_soc_jack_irq(dev_name(codec->dev));
@@ -3431,7 +3431,7 @@ static void wm8958_default_micdet(u16 status, void *data)
 static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 {
 	struct wm8994_priv *wm8994 = data;
-	struct snd_soc_codec *codec = wm8994->codec;
+	struct snd_soc_codec *codec = wm8994->hubs.codec;
 	int reg;
 	bool present;
 
@@ -3609,7 +3609,7 @@ EXPORT_SYMBOL_GPL(wm8958_mic_detect);
 static irqreturn_t wm8958_mic_irq(int irq, void *data)
 {
 	struct wm8994_priv *wm8994 = data;
-	struct snd_soc_codec *codec = wm8994->codec;
+	struct snd_soc_codec *codec = wm8994->hubs.codec;
 	int reg, count;
 
 	/*
@@ -3699,13 +3699,11 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	unsigned int reg;
 	int ret, i;
 
-	wm8994->codec = codec;
+	wm8994->hubs.codec = codec;
 	codec->control_data = control->regmap;
 
 	snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_REGMAP);
 
-	wm8994->codec = codec;
-
 	mutex_init(&wm8994->accdet_lock);
 	INIT_DELAYED_WORK(&wm8994->mic_work, wm8994_mic_work);
 
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 19068d8..e6d8209 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -73,7 +73,6 @@ struct wm8994;
 struct wm8994_priv {
 	struct wm_hubs_data hubs;
 	struct wm8994 *wm8994;
-	struct snd_soc_codec *codec;
 	int sysclk[2];
 	int sysclk_rate[2];
 	int mclk[2];
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 61baa48..728a180 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -1112,6 +1112,8 @@ int wm_hubs_add_analogue_routes(struct snd_soc_codec *codec,
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
+	hubs->codec = codec;
+
 	INIT_LIST_HEAD(&hubs->dcs_cache);
 	init_completion(&hubs->dcs_done);
 
diff --git a/sound/soc/codecs/wm_hubs.h b/sound/soc/codecs/wm_hubs.h
index da2dc89..a5a09e6 100644
--- a/sound/soc/codecs/wm_hubs.h
+++ b/sound/soc/codecs/wm_hubs.h
@@ -46,6 +46,8 @@ struct wm_hubs_data {
 
 	bool dcs_done_irq;
 	struct completion dcs_done;
+
+	struct snd_soc_codec *codec;
 };
 
 extern int wm_hubs_add_analogue_controls(struct snd_soc_codec *);
-- 
1.7.10.4
