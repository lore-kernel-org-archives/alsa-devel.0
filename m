From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/17] ASoC: twl4030: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Thu, 15 Jan 2015 12:52:06 +0100
Message-ID: <1421322737-19077-7-git-send-email-lars@metafoo.de>
References: <1421322737-19077-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A5F42605D3
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 12:52:24 +0100 (CET)
In-Reply-To: <1421322737-19077-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/twl4030.c | 55 ++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 44af318..d04693e 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -567,12 +567,13 @@ static const struct snd_kcontrol_new twl4030_dapm_dbypassv_control =
 static int pin_name##pga_event(struct snd_soc_dapm_widget *w,		\
 			       struct snd_kcontrol *kcontrol, int event) \
 {									\
-	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(w->codec); \
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);	\
+	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec); \
 									\
 	switch (event) {						\
 	case SND_SOC_DAPM_POST_PMU:					\
 		twl4030->pin_name##_enabled = 1;			\
-		twl4030_write(w->codec, reg, twl4030_read(w->codec, reg)); \
+		twl4030_write(codec, reg, twl4030_read(codec, reg));	\
 		break;							\
 	case SND_SOC_DAPM_POST_PMD:					\
 		twl4030->pin_name##_enabled = 0;			\
@@ -621,12 +622,14 @@ static void handsfree_ramp(struct snd_soc_codec *codec, int reg, int ramp)
 static int handsfreelpga_event(struct snd_soc_dapm_widget *w,
 			       struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		handsfree_ramp(w->codec, TWL4030_REG_HFL_CTL, 1);
+		handsfree_ramp(codec, TWL4030_REG_HFL_CTL, 1);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		handsfree_ramp(w->codec, TWL4030_REG_HFL_CTL, 0);
+		handsfree_ramp(codec, TWL4030_REG_HFL_CTL, 0);
 		break;
 	}
 	return 0;
@@ -635,12 +638,14 @@ static int handsfreelpga_event(struct snd_soc_dapm_widget *w,
 static int handsfreerpga_event(struct snd_soc_dapm_widget *w,
 			       struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		handsfree_ramp(w->codec, TWL4030_REG_HFR_CTL, 1);
+		handsfree_ramp(codec, TWL4030_REG_HFR_CTL, 1);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		handsfree_ramp(w->codec, TWL4030_REG_HFR_CTL, 0);
+		handsfree_ramp(codec, TWL4030_REG_HFR_CTL, 0);
 		break;
 	}
 	return 0;
@@ -649,19 +654,23 @@ static int handsfreerpga_event(struct snd_soc_dapm_widget *w,
 static int vibramux_event(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *kcontrol, int event)
 {
-	twl4030_write(w->codec, TWL4030_REG_VIBRA_SET, 0xff);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	twl4030_write(codec, TWL4030_REG_VIBRA_SET, 0xff);
 	return 0;
 }
 
 static int apll_event(struct snd_soc_dapm_widget *w,
 		      struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		twl4030_apll_enable(w->codec, 1);
+		twl4030_apll_enable(codec, 1);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		twl4030_apll_enable(w->codec, 0);
+		twl4030_apll_enable(codec, 0);
 		break;
 	}
 	return 0;
@@ -670,23 +679,24 @@ static int apll_event(struct snd_soc_dapm_widget *w,
 static int aif_event(struct snd_soc_dapm_widget *w,
 		     struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	u8 audio_if;
 
-	audio_if = twl4030_read(w->codec, TWL4030_REG_AUDIO_IF);
+	audio_if = twl4030_read(codec, TWL4030_REG_AUDIO_IF);
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		/* Enable AIF */
 		/* enable the PLL before we use it to clock the DAI */
-		twl4030_apll_enable(w->codec, 1);
+		twl4030_apll_enable(codec, 1);
 
-		twl4030_write(w->codec, TWL4030_REG_AUDIO_IF,
+		twl4030_write(codec, TWL4030_REG_AUDIO_IF,
 			      audio_if | TWL4030_AIF_EN);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		/* disable the DAI before we stop it's source PLL */
-		twl4030_write(w->codec, TWL4030_REG_AUDIO_IF,
+		twl4030_write(codec, TWL4030_REG_AUDIO_IF,
 			      audio_if &  ~TWL4030_AIF_EN);
-		twl4030_apll_enable(w->codec, 0);
+		twl4030_apll_enable(codec, 0);
 		break;
 	}
 	return 0;
@@ -758,20 +768,21 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 static int headsetlpga_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event)
 {
-	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(w->codec);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		/* Do the ramp-up only once */
 		if (!twl4030->hsr_enabled)
-			headset_ramp(w->codec, 1);
+			headset_ramp(codec, 1);
 
 		twl4030->hsl_enabled = 1;
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		/* Do the ramp-down only if both headsetL/R is disabled */
 		if (!twl4030->hsr_enabled)
-			headset_ramp(w->codec, 0);
+			headset_ramp(codec, 0);
 
 		twl4030->hsl_enabled = 0;
 		break;
@@ -782,20 +793,21 @@ static int headsetlpga_event(struct snd_soc_dapm_widget *w,
 static int headsetrpga_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event)
 {
-	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(w->codec);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		/* Do the ramp-up only once */
 		if (!twl4030->hsl_enabled)
-			headset_ramp(w->codec, 1);
+			headset_ramp(codec, 1);
 
 		twl4030->hsr_enabled = 1;
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		/* Do the ramp-down only if both headsetL/R is disabled */
 		if (!twl4030->hsl_enabled)
-			headset_ramp(w->codec, 0);
+			headset_ramp(codec, 0);
 
 		twl4030->hsr_enabled = 0;
 		break;
@@ -806,7 +818,8 @@ static int headsetrpga_event(struct snd_soc_dapm_widget *w,
 static int digimic_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
-	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(w->codec);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	struct twl4030_codec_data *pdata = twl4030->pdata;
 
 	if (pdata && pdata->digimic_delay)
-- 
1.8.0
