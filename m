From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/17] ASoC: rt5631: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Thu, 15 Jan 2015 12:52:11 +0100
Message-ID: <1421322737-19077-12-git-send-email-lars@metafoo.de>
References: <1421322737-19077-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id A783E26063F
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 12:52:26 +0100 (CET)
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
 sound/soc/codecs/rt5631.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 6d7b7ca..c618527 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -287,70 +287,78 @@ static const struct snd_kcontrol_new rt5631_snd_controls[] = {
 static int check_sysclk1_source(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(source->codec, RT5631_GLOBAL_CLK_CTRL);
+	reg = snd_soc_read(codec, RT5631_GLOBAL_CLK_CTRL);
 	return reg & RT5631_SYSCLK_SOUR_SEL_PLL;
 }
 
 static int check_dmic_used(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(source->codec);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
 	return rt5631->dmic_used_flag;
 }
 
 static int check_dacl_to_outmixl(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(source->codec, RT5631_OUTMIXER_L_CTRL);
+	reg = snd_soc_read(codec, RT5631_OUTMIXER_L_CTRL);
 	return !(reg & RT5631_M_DAC_L_TO_OUTMIXER_L);
 }
 
 static int check_dacr_to_outmixr(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(source->codec, RT5631_OUTMIXER_R_CTRL);
+	reg = snd_soc_read(codec, RT5631_OUTMIXER_R_CTRL);
 	return !(reg & RT5631_M_DAC_R_TO_OUTMIXER_R);
 }
 
 static int check_dacl_to_spkmixl(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(source->codec, RT5631_SPK_MIXER_CTRL);
+	reg = snd_soc_read(codec, RT5631_SPK_MIXER_CTRL);
 	return !(reg & RT5631_M_DAC_L_TO_SPKMIXER_L);
 }
 
 static int check_dacr_to_spkmixr(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(source->codec, RT5631_SPK_MIXER_CTRL);
+	reg = snd_soc_read(codec, RT5631_SPK_MIXER_CTRL);
 	return !(reg & RT5631_M_DAC_R_TO_SPKMIXER_R);
 }
 
 static int check_adcl_select(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(source->codec, RT5631_ADC_REC_MIXER);
+	reg = snd_soc_read(codec, RT5631_ADC_REC_MIXER);
 	return !(reg & RT5631_M_MIC1_TO_RECMIXER_L);
 }
 
 static int check_adcr_select(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(source->codec, RT5631_ADC_REC_MIXER);
+	reg = snd_soc_read(codec, RT5631_ADC_REC_MIXER);
 	return !(reg & RT5631_M_MIC2_TO_RECMIXER_R);
 }
 
@@ -556,7 +564,7 @@ static void depop_seq_mute_stage(struct snd_soc_codec *codec, int enable)
 static int hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -590,7 +598,7 @@ static int hp_event(struct snd_soc_dapm_widget *w,
 static int set_dmic_params(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
 
 	switch (rt5631->rx_rate) {
-- 
1.8.0
