From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/7] ASoC: rt5677: Replace direct snd_soc_codec
	dapm field access
Date: Tue, 19 May 2015 21:49:11 +0200
Message-ID: <1432064952-31997-7-git-send-email-lars@metafoo.de>
References: <1432064952-31997-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 06C7F2605FB
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 21:49:25 +0200 (CEST)
In-Reply-To: <1432064952-31997-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level() and replace all
other manual access to codec->dapm with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/rt5677.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 696ba58..c0211a11 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -817,7 +817,7 @@ static int rt5677_dsp_vad_put(struct snd_kcontrol *kcontrol,
 
 	rt5677->dsp_vad_en = !!ucontrol->value.integer.value[0];
 
-	if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
+	if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
 		rt5677_set_dsp_vad(codec, rt5677->dsp_vad_en);
 
 	return 0;
@@ -2476,7 +2476,7 @@ static int rt5677_vref_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		if (codec->dapm.bias_level != SND_SOC_BIAS_ON &&
+		if (snd_soc_codec_get_bias_level(codec) != SND_SOC_BIAS_ON &&
 			!rt5677->is_vref_slow) {
 			mdelay(20);
 			regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG1,
@@ -4350,7 +4350,7 @@ static int rt5677_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY) {
 			rt5677_set_dsp_vad(codec, false);
 
 			regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG1,
@@ -4602,17 +4602,18 @@ static void rt5677_free_gpio(struct i2c_client *i2c)
 
 static int rt5677_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 	int i;
 
 	rt5677->codec = codec;
 
 	if (rt5677->pdata.dmic2_clk_pin == RT5677_DMIC_CLK2) {
-		snd_soc_dapm_add_routes(&codec->dapm,
+		snd_soc_dapm_add_routes(dapm,
 			rt5677_dmic2_clk_2,
 			ARRAY_SIZE(rt5677_dmic2_clk_2));
 	} else { /*use dmic1 clock by default*/
-		snd_soc_dapm_add_routes(&codec->dapm,
+		snd_soc_dapm_add_routes(dapm,
 			rt5677_dmic2_clk_1,
 			ARRAY_SIZE(rt5677_dmic2_clk_1));
 	}
-- 
1.8.0
