From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/17] ASoC: rt5677: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Thu, 15 Jan 2015 12:52:16 +0100
Message-ID: <1421322737-19077-17-git-send-email-lars@metafoo.de>
References: <1421322737-19077-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id B63B3260661
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 12:52:29 +0100 (CET)
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
 sound/soc/codecs/rt5677.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index a683e69..26fc538 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -896,7 +896,7 @@ static const struct snd_kcontrol_new rt5677_snd_controls[] = {
 static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 	int idx = rl6231_calc_dmic_clk(rt5677->sysclk);
 
@@ -911,7 +911,8 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(source->codec);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val;
 
 	regmap_read(rt5677->regmap, RT5677_GLB_CLK1, &val);
@@ -925,7 +926,7 @@ static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 static int is_using_asrc(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = source->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 	unsigned int reg, shift, val;
 
@@ -2126,7 +2127,7 @@ static const struct snd_kcontrol_new rt5677_if2_dac7_tdm_sel_mux =
 static int rt5677_bst1_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -2150,7 +2151,7 @@ static int rt5677_bst1_event(struct snd_soc_dapm_widget *w,
 static int rt5677_bst2_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -2174,7 +2175,7 @@ static int rt5677_bst2_event(struct snd_soc_dapm_widget *w,
 static int rt5677_set_pll1_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -2196,7 +2197,7 @@ static int rt5677_set_pll1_event(struct snd_soc_dapm_widget *w,
 static int rt5677_set_pll2_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -2218,7 +2219,7 @@ static int rt5677_set_pll2_event(struct snd_soc_dapm_widget *w,
 static int rt5677_set_micbias1_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -2245,7 +2246,7 @@ static int rt5677_set_micbias1_event(struct snd_soc_dapm_widget *w,
 static int rt5677_if1_adc_tdm_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 	unsigned int value;
 
@@ -2268,7 +2269,7 @@ static int rt5677_if1_adc_tdm_event(struct snd_soc_dapm_widget *w,
 static int rt5677_if2_adc_tdm_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 	unsigned int value;
 
@@ -2291,7 +2292,7 @@ static int rt5677_if2_adc_tdm_event(struct snd_soc_dapm_widget *w,
 static int rt5677_vref_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
-- 
1.8.0
