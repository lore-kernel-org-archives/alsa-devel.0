From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/7] ASoC: rt5670: Replace direct snd_soc_codec
	dapm field access
Date: Tue, 19 May 2015 21:49:10 +0200
Message-ID: <1432064952-31997-6-git-send-email-lars@metafoo.de>
References: <1432064952-31997-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 57B712605C1
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
 sound/soc/codecs/rt5670.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 9235711..840dd6d 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -416,12 +416,12 @@ static bool rt5670_readable_register(struct device *dev, unsigned int reg)
 static int rt5670_headset_detect(struct snd_soc_codec *codec, int jack_insert)
 {
 	int val;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
 
 	if (jack_insert) {
-		snd_soc_dapm_force_enable_pin(&codec->dapm,
-						       "Mic Det Power");
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_force_enable_pin(dapm, "Mic Det Power");
+		snd_soc_dapm_sync(dapm);
 		snd_soc_update_bits(codec, RT5670_GEN_CTRL3, 0x4, 0x0);
 		snd_soc_update_bits(codec, RT5670_CJ_CTRL2,
 			RT5670_CBJ_DET_MODE | RT5670_CBJ_MN_JD,
@@ -447,15 +447,15 @@ static int rt5670_headset_detect(struct snd_soc_codec *codec, int jack_insert)
 		} else {
 			snd_soc_update_bits(codec, RT5670_GEN_CTRL3, 0x4, 0x4);
 			rt5670->jack_type = SND_JACK_HEADPHONE;
-			snd_soc_dapm_disable_pin(&codec->dapm, "Mic Det Power");
-			snd_soc_dapm_sync(&codec->dapm);
+			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
+			snd_soc_dapm_sync(dapm);
 		}
 	} else {
 		snd_soc_update_bits(codec, RT5670_INT_IRQ_ST, 0x8, 0x0);
 		snd_soc_update_bits(codec, RT5670_GEN_CTRL3, 0x4, 0x4);
 		rt5670->jack_type = 0;
-		snd_soc_dapm_disable_pin(&codec->dapm, "Mic Det Power");
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
+		snd_soc_dapm_sync(dapm);
 	}
 
 	return rt5670->jack_type;
@@ -2603,7 +2603,7 @@ static int rt5670_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
-		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level) {
+		if (SND_SOC_BIAS_STANDBY == snd_soc_codec_get_bias_level(codec)) {
 			snd_soc_update_bits(codec, RT5670_PWR_ANLG1,
 				RT5670_PWR_VREF1 | RT5670_PWR_MB |
 				RT5670_PWR_BG | RT5670_PWR_VREF2,
@@ -2653,23 +2653,24 @@ static int rt5670_set_bias_level(struct snd_soc_codec *codec,
 
 static int rt5670_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
 
 	switch (snd_soc_read(codec, RT5670_RESET) & RT5670_ID_MASK) {
 	case RT5670_ID_5670:
 	case RT5670_ID_5671:
-		snd_soc_dapm_new_controls(&codec->dapm,
+		snd_soc_dapm_new_controls(dapm,
 			rt5670_specific_dapm_widgets,
 			ARRAY_SIZE(rt5670_specific_dapm_widgets));
-		snd_soc_dapm_add_routes(&codec->dapm,
+		snd_soc_dapm_add_routes(dapm,
 			rt5670_specific_dapm_routes,
 			ARRAY_SIZE(rt5670_specific_dapm_routes));
 		break;
 	case RT5670_ID_5672:
-		snd_soc_dapm_new_controls(&codec->dapm,
+		snd_soc_dapm_new_controls(dapm,
 			rt5672_specific_dapm_widgets,
 			ARRAY_SIZE(rt5672_specific_dapm_widgets));
-		snd_soc_dapm_add_routes(&codec->dapm,
+		snd_soc_dapm_add_routes(dapm,
 			rt5672_specific_dapm_routes,
 			ARRAY_SIZE(rt5672_specific_dapm_routes));
 		break;
-- 
1.8.0
