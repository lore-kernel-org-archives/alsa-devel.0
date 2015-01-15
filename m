From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/17] ASoC: rt5640: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Thu, 15 Jan 2015 12:52:12 +0100
Message-ID: <1421322737-19077-13-git-send-email-lars@metafoo.de>
References: <1421322737-19077-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 6593426064C
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 12:52:27 +0100 (CET)
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
 sound/soc/codecs/rt5640.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index c3f2dec..b386958 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -458,7 +458,7 @@ static const struct snd_kcontrol_new rt5640_specific_snd_controls[] = {
 static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
 	int idx = -EINVAL;
 
@@ -475,9 +475,10 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
 	unsigned int val;
 
-	val = snd_soc_read(source->codec, RT5640_GLB_CLK);
+	val = snd_soc_read(codec, RT5640_GLB_CLK);
 	val &= RT5640_SCLK_SRC_MASK;
 	if (val == RT5640_SCLK_SRC_PLL1)
 		return 1;
@@ -963,7 +964,7 @@ static void rt5640_pmu_depop(struct snd_soc_codec *codec)
 static int rt5640_hp_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -987,7 +988,7 @@ static int rt5640_hp_event(struct snd_soc_dapm_widget *w,
 static int rt5640_hp_power_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -1003,7 +1004,7 @@ static int rt5640_hp_power_event(struct snd_soc_dapm_widget *w,
 static int rt5640_hp_post_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
-- 
1.8.0
