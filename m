From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/7] ASoC: rt5640: Replace direct snd_soc_codec
	dapm field access
Date: Tue, 19 May 2015 21:49:08 +0200
Message-ID: <1432064952-31997-4-git-send-email-lars@metafoo.de>
References: <1432064952-31997-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CBB22605BB
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 21:49:23 +0200 (CEST)
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
 sound/soc/codecs/rt5640.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 7d488d8..f40752a 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1870,7 +1870,7 @@ static int rt5640_set_bias_level(struct snd_soc_codec *codec,
 {
 	switch (level) {
 	case SND_SOC_BIAS_STANDBY:
-		if (SND_SOC_BIAS_OFF == codec->dapm.bias_level) {
+		if (SND_SOC_BIAS_OFF == snd_soc_codec_get_bias_level(codec)) {
 			snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
 				RT5640_PWR_VREF1 | RT5640_PWR_MB |
 				RT5640_PWR_BG | RT5640_PWR_VREF2,
@@ -1934,6 +1934,7 @@ EXPORT_SYMBOL_GPL(rt5640_dmic_enable);
 
 static int rt5640_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
 
 	rt5640->codec = codec;
@@ -1950,18 +1951,18 @@ static int rt5640_probe(struct snd_soc_codec *codec)
 		snd_soc_add_codec_controls(codec,
 			rt5640_specific_snd_controls,
 			ARRAY_SIZE(rt5640_specific_snd_controls));
-		snd_soc_dapm_new_controls(&codec->dapm,
+		snd_soc_dapm_new_controls(dapm,
 			rt5640_specific_dapm_widgets,
 			ARRAY_SIZE(rt5640_specific_dapm_widgets));
-		snd_soc_dapm_add_routes(&codec->dapm,
+		snd_soc_dapm_add_routes(dapm,
 			rt5640_specific_dapm_routes,
 			ARRAY_SIZE(rt5640_specific_dapm_routes));
 		break;
 	case RT5640_ID_5639:
-		snd_soc_dapm_new_controls(&codec->dapm,
+		snd_soc_dapm_new_controls(dapm,
 			rt5639_specific_dapm_widgets,
 			ARRAY_SIZE(rt5639_specific_dapm_widgets));
-		snd_soc_dapm_add_routes(&codec->dapm,
+		snd_soc_dapm_add_routes(dapm,
 			rt5639_specific_dapm_routes,
 			ARRAY_SIZE(rt5639_specific_dapm_routes));
 		break;
-- 
1.8.0
