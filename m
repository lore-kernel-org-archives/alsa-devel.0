From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/17] ASoC: rt5670: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Thu, 15 Jan 2015 12:52:15 +0100
Message-ID: <1421322737-19077-16-git-send-email-lars@metafoo.de>
References: <1421322737-19077-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 345CD260660
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
 sound/soc/codecs/rt5670.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 0632b74..7b3d6b5 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -500,7 +500,7 @@ static const struct snd_kcontrol_new rt5670_snd_controls[] = {
 static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
 	int idx = -EINVAL;
 
@@ -517,9 +517,10 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	unsigned int val;
 
-	val = snd_soc_read(source->codec, RT5670_GLB_CLK);
+	val = snd_soc_read(codec, RT5670_GLB_CLK);
 	val &= RT5670_SCLK_SRC_MASK;
 	if (val == RT5670_SCLK_SRC_PLL1)
 		return 1;
@@ -530,6 +531,7 @@ static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 static int is_using_asrc(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	unsigned int reg, shift, val;
 
 	switch (source->shift) {
@@ -565,7 +567,7 @@ static int is_using_asrc(struct snd_soc_dapm_widget *source,
 		return 0;
 	}
 
-	val = (snd_soc_read(source->codec, reg) >> shift) & 0xf;
+	val = (snd_soc_read(codec, reg) >> shift) & 0xf;
 	switch (val) {
 	case 1:
 	case 2:
@@ -1231,7 +1233,7 @@ static const struct snd_kcontrol_new rt5670_vad_adc_mux =
 static int rt5670_hp_power_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -1267,7 +1269,7 @@ static int rt5670_hp_power_event(struct snd_soc_dapm_widget *w,
 static int rt5670_hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -1317,7 +1319,7 @@ static int rt5670_hp_event(struct snd_soc_dapm_widget *w,
 static int rt5670_bst1_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -1340,7 +1342,7 @@ static int rt5670_bst1_event(struct snd_soc_dapm_widget *w,
 static int rt5670_bst2_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-- 
1.8.0
