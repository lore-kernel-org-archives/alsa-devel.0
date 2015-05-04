From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/7] ASoC: adau17x1: Replace direct
	snd_soc_codec dapm field access
Date: Mon,  4 May 2015 18:46:09 +0200
Message-ID: <1430757974-7432-2-git-send-email-lars@metafoo.de>
References: <1430757974-7432-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 49405260635
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 18:46:21 +0200 (CEST)
In-Reply-To: <1430757974-7432-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adau1761.c | 26 ++++++++++++--------------
 sound/soc/codecs/adau1781.c |  9 ++++-----
 sound/soc/codecs/adau17x1.c | 20 ++++++++++----------
 3 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index 5ba2461..2f12477 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -482,6 +482,7 @@ static enum adau1761_output_mode adau1761_get_lineout_mode(
 
 static int adau1761_setup_digmic_jackdetect(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct adau1761_platform_data *pdata = codec->dev->platform_data;
 	struct adau *adau = snd_soc_codec_get_drvdata(codec);
 	enum adau1761_digmic_jackdet_pin_mode mode;
@@ -514,21 +515,18 @@ static int adau1761_setup_digmic_jackdetect(struct snd_soc_codec *codec)
 		if (ret)
 			return ret;
 	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE: /* fallthrough */
-		ret = snd_soc_dapm_add_routes(&codec->dapm,
-			adau1761_no_dmic_routes,
+		ret = snd_soc_dapm_add_routes(dapm, adau1761_no_dmic_routes,
 			ARRAY_SIZE(adau1761_no_dmic_routes));
 		if (ret)
 			return ret;
 		break;
 	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_DIGMIC:
-		ret = snd_soc_dapm_new_controls(&codec->dapm,
-			adau1761_dmic_widgets,
+		ret = snd_soc_dapm_new_controls(dapm, adau1761_dmic_widgets,
 			ARRAY_SIZE(adau1761_dmic_widgets));
 		if (ret)
 			return ret;
 
-		ret = snd_soc_dapm_add_routes(&codec->dapm,
-			adau1761_dmic_routes,
+		ret = snd_soc_dapm_add_routes(dapm, adau1761_dmic_routes,
 			ARRAY_SIZE(adau1761_dmic_routes));
 		if (ret)
 			return ret;
@@ -546,6 +544,7 @@ static int adau1761_setup_digmic_jackdetect(struct snd_soc_codec *codec)
 
 static int adau1761_setup_headphone_mode(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct adau *adau = snd_soc_codec_get_drvdata(codec);
 	struct adau1761_platform_data *pdata = codec->dev->platform_data;
 	enum adau1761_output_mode mode;
@@ -576,12 +575,12 @@ static int adau1761_setup_headphone_mode(struct snd_soc_codec *codec)
 	}
 
 	if (mode == ADAU1761_OUTPUT_MODE_HEADPHONE_CAPLESS) {
-		ret = snd_soc_dapm_new_controls(&codec->dapm,
+		ret = snd_soc_dapm_new_controls(dapm,
 			adau1761_capless_dapm_widgets,
 			ARRAY_SIZE(adau1761_capless_dapm_widgets));
 		if (ret)
 			return ret;
-		ret = snd_soc_dapm_add_routes(&codec->dapm,
+		ret = snd_soc_dapm_add_routes(dapm,
 			adau1761_capless_dapm_routes,
 			ARRAY_SIZE(adau1761_capless_dapm_routes));
 	} else {
@@ -589,12 +588,12 @@ static int adau1761_setup_headphone_mode(struct snd_soc_codec *codec)
 			ARRAY_SIZE(adau1761_mono_controls));
 		if (ret)
 			return ret;
-		ret = snd_soc_dapm_new_controls(&codec->dapm,
+		ret = snd_soc_dapm_new_controls(dapm,
 			adau1761_mono_dapm_widgets,
 			ARRAY_SIZE(adau1761_mono_dapm_widgets));
 		if (ret)
 			return ret;
-		ret = snd_soc_dapm_add_routes(&codec->dapm,
+		ret = snd_soc_dapm_add_routes(dapm,
 			adau1761_mono_dapm_routes,
 			ARRAY_SIZE(adau1761_mono_dapm_routes));
 	}
@@ -639,6 +638,7 @@ static bool adau1761_readable_register(struct device *dev, unsigned int reg)
 
 static int adau1761_codec_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct adau1761_platform_data *pdata = codec->dev->platform_data;
 	struct adau *adau = snd_soc_codec_get_drvdata(codec);
 	int ret;
@@ -691,14 +691,12 @@ static int adau1761_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 
 	if (adau->type == ADAU1761) {
-		ret = snd_soc_dapm_new_controls(&codec->dapm,
-			adau1761_dapm_widgets,
+		ret = snd_soc_dapm_new_controls(dapm, adau1761_dapm_widgets,
 			ARRAY_SIZE(adau1761_dapm_widgets));
 		if (ret)
 			return ret;
 
-		ret = snd_soc_dapm_add_routes(&codec->dapm,
-			adau1761_dapm_routes,
+		ret = snd_soc_dapm_add_routes(dapm, adau1761_dapm_routes,
 			ARRAY_SIZE(adau1761_dapm_routes));
 		if (ret)
 			return ret;
diff --git a/sound/soc/codecs/adau1781.c b/sound/soc/codecs/adau1781.c
index 9c01ef0..fde9068 100644
--- a/sound/soc/codecs/adau1781.c
+++ b/sound/soc/codecs/adau1781.c
@@ -382,6 +382,7 @@ static int adau1781_set_input_mode(struct adau *adau, unsigned int reg,
 
 static int adau1781_codec_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct adau1781_platform_data *pdata = dev_get_platdata(codec->dev);
 	struct adau *adau = snd_soc_codec_get_drvdata(codec);
 	int ret;
@@ -402,19 +403,17 @@ static int adau1781_codec_probe(struct snd_soc_codec *codec)
 	}
 
 	if (pdata && pdata->use_dmic) {
-		ret = snd_soc_dapm_new_controls(&codec->dapm,
+		ret = snd_soc_dapm_new_controls(dapm,
 			adau1781_dmic_dapm_widgets,
 			ARRAY_SIZE(adau1781_dmic_dapm_widgets));
 		if (ret)
 			return ret;
-		ret = snd_soc_dapm_add_routes(&codec->dapm,
-			adau1781_dmic_dapm_routes,
+		ret = snd_soc_dapm_add_routes(dapm, adau1781_dmic_dapm_routes,
 			ARRAY_SIZE(adau1781_dmic_dapm_routes));
 		if (ret)
 			return ret;
 	} else {
-		ret = snd_soc_dapm_add_routes(&codec->dapm,
-			adau1781_adc_dapm_routes,
+		ret = snd_soc_dapm_add_routes(dapm, adau1781_adc_dapm_routes,
 			ARRAY_SIZE(adau1781_adc_dapm_routes));
 		if (ret)
 			return ret;
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index fa2e690..fcf05b2 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -155,6 +155,7 @@ static int adau17x1_dsp_mux_enum_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct adau *adau = snd_soc_codec_get_drvdata(codec);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct snd_soc_dapm_update update;
@@ -188,7 +189,7 @@ static int adau17x1_dsp_mux_enum_put(struct snd_kcontrol *kcontrol,
 		update.reg = reg;
 		update.val = val;
 
-		snd_soc_dapm_mux_update_power(&codec->dapm, kcontrol,
+		snd_soc_dapm_mux_update_power(dapm, kcontrol,
 				ucontrol->value.enumerated.item[0], e, &update);
 	}
 
@@ -444,8 +445,8 @@ static int adau17x1_set_dai_pll(struct snd_soc_dai *dai, int pll_id,
 static int adau17x1_set_dai_sysclk(struct snd_soc_dai *dai,
 		int clk_id, unsigned int freq, int dir)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(dai->codec);
 	struct adau *adau = snd_soc_codec_get_drvdata(dai->codec);
-	struct snd_soc_dapm_context *dapm = &dai->codec->dapm;
 
 	switch (clk_id) {
 	case ADAU17X1_CLK_SRC_MCLK:
@@ -804,6 +805,7 @@ EXPORT_SYMBOL_GPL(adau17x1_setup_firmware);
 
 int adau17x1_add_widgets(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct adau *adau = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
@@ -811,14 +813,13 @@ int adau17x1_add_widgets(struct snd_soc_codec *codec)
 		ARRAY_SIZE(adau17x1_controls));
 	if (ret)
 		return ret;
-	ret = snd_soc_dapm_new_controls(&codec->dapm, adau17x1_dapm_widgets,
+	ret = snd_soc_dapm_new_controls(dapm, adau17x1_dapm_widgets,
 		ARRAY_SIZE(adau17x1_dapm_widgets));
 	if (ret)
 		return ret;
 
 	if (adau17x1_has_dsp(adau)) {
-		ret = snd_soc_dapm_new_controls(&codec->dapm,
-			adau17x1_dsp_dapm_widgets,
+		ret = snd_soc_dapm_new_controls(dapm, adau17x1_dsp_dapm_widgets,
 			ARRAY_SIZE(adau17x1_dsp_dapm_widgets));
 		if (ret)
 			return ret;
@@ -840,21 +841,20 @@ EXPORT_SYMBOL_GPL(adau17x1_add_widgets);
 
 int adau17x1_add_routes(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct adau *adau = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = snd_soc_dapm_add_routes(&codec->dapm, adau17x1_dapm_routes,
+	ret = snd_soc_dapm_add_routes(dapm, adau17x1_dapm_routes,
 		ARRAY_SIZE(adau17x1_dapm_routes));
 	if (ret)
 		return ret;
 
 	if (adau17x1_has_dsp(adau)) {
-		ret = snd_soc_dapm_add_routes(&codec->dapm,
-			adau17x1_dsp_dapm_routes,
+		ret = snd_soc_dapm_add_routes(dapm, adau17x1_dsp_dapm_routes,
 			ARRAY_SIZE(adau17x1_dsp_dapm_routes));
 	} else {
-		ret = snd_soc_dapm_add_routes(&codec->dapm,
-			adau17x1_no_dsp_dapm_routes,
+		ret = snd_soc_dapm_add_routes(dapm, adau17x1_no_dsp_dapm_routes,
 			ARRAY_SIZE(adau17x1_no_dsp_dapm_routes));
 	}
 	return ret;
-- 
1.8.0
