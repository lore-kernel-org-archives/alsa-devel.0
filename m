From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2] ASoC: tpa6130a2: Replace DAPM code with
	direct interface
Date: Thu,  2 Dec 2010 09:29:56 +0200
Message-ID: <1291274996-28056-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 048AB1037FC
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 08:30:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The use of DAPM widgets, and extra routing can cause ordering
problems in the system.
Machine drivers should use the exported direct interface with
SND_SOC_DAPM_HP's event callback to manage the state of the
amplifier.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---

Hello,

Changes since v1:
- DAPM routing removed from the driver
- tpa6130a2_stereo_enable takes snd_soc_codec as argument

Peter

 sound/soc/codecs/tpa6130a2.c |   69 +++++++-----------------------------------
 sound/soc/codecs/tpa6130a2.h |    1 +
 2 files changed, 12 insertions(+), 58 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index c97badf..0a99f31 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -317,65 +317,24 @@ static void tpa6130a2_channel_enable(u8 channel, int enable)
 	}
 }
 
-static int tpa6130a2_pga_event(struct snd_soc_dapm_widget *w,
-		struct snd_kcontrol *kcontrol, int event)
-{
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		tpa6130a2_channel_enable(w->shift, 1);
-		break;
-	case SND_SOC_DAPM_POST_PMD:
-		tpa6130a2_channel_enable(w->shift, 0);
-		break;
-	}
-	return 0;
-}
-
-static int tpa6130a2_supply_event(struct snd_soc_dapm_widget *w,
-		struct snd_kcontrol *kcontrol, int event)
+int tpa6130a2_stereo_enable(struct snd_soc_codec *codec, int enable)
 {
 	int ret = 0;
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
+	if (enable) {
 		ret = tpa6130a2_power(1);
-		break;
-	case SND_SOC_DAPM_POST_PMD:
+		if (ret < 0)
+			return ret;
+		tpa6130a2_channel_enable(TPA6130A2_HP_EN_R | TPA6130A2_HP_EN_L,
+					 1);
+	} else {
+		tpa6130a2_channel_enable(TPA6130A2_HP_EN_R | TPA6130A2_HP_EN_L,
+					 0);
 		ret = tpa6130a2_power(0);
-		break;
 	}
+
 	return ret;
 }
-
-static const struct snd_soc_dapm_widget tpa6130a2_dapm_widgets[] = {
-	SND_SOC_DAPM_PGA_E("TPA6130A2 Left", SND_SOC_NOPM,
-			TPA6130A2_HP_EN_L, 0, NULL, 0, tpa6130a2_pga_event,
-			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_PGA_E("TPA6130A2 Right", SND_SOC_NOPM,
-			TPA6130A2_HP_EN_R, 0, NULL, 0, tpa6130a2_pga_event,
-			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_PGA_E("TPA6130A2 Stereo", SND_SOC_NOPM,
-			TPA6130A2_HP_EN_L | TPA6130A2_HP_EN_R, 0, NULL, 0,
-			tpa6130a2_pga_event,
-			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_SUPPLY("TPA6130A2 Enable", SND_SOC_NOPM,
-			0, 0, tpa6130a2_supply_event,
-			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
-	/* Outputs */
-	SND_SOC_DAPM_OUTPUT("TPA6130A2 Headphone Left"),
-	SND_SOC_DAPM_OUTPUT("TPA6130A2 Headphone Right"),
-	SND_SOC_DAPM_OUTPUT("TPA6130A2 Headphone Stereo"),
-};
-
-static const struct snd_soc_dapm_route audio_map[] = {
-	{"TPA6130A2 Headphone Left", NULL, "TPA6130A2 Left"},
-	{"TPA6130A2 Headphone Right", NULL, "TPA6130A2 Right"},
-	{"TPA6130A2 Headphone Stereo", NULL, "TPA6130A2 Stereo"},
-
-	{"TPA6130A2 Headphone Left", NULL, "TPA6130A2 Enable"},
-	{"TPA6130A2 Headphone Right", NULL, "TPA6130A2 Enable"},
-	{"TPA6130A2 Headphone Stereo", NULL, "TPA6130A2 Enable"},
-};
+EXPORT_SYMBOL_GPL(tpa6130a2_stereo_enable);
 
 int tpa6130a2_add_controls(struct snd_soc_codec *codec)
 {
@@ -387,18 +346,12 @@ int tpa6130a2_add_controls(struct snd_soc_codec *codec)
 
 	data = i2c_get_clientdata(tpa6130a2_client);
 
-	snd_soc_dapm_new_controls(dapm, tpa6130a2_dapm_widgets,
-				ARRAY_SIZE(tpa6130a2_dapm_widgets));
-
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	if (data->id == TPA6140A2)
 		return snd_soc_add_controls(codec, tpa6140a2_controls,
 						ARRAY_SIZE(tpa6140a2_controls));
 	else
 		return snd_soc_add_controls(codec, tpa6130a2_controls,
 						ARRAY_SIZE(tpa6130a2_controls));
-
 }
 EXPORT_SYMBOL_GPL(tpa6130a2_add_controls);
 
diff --git a/sound/soc/codecs/tpa6130a2.h b/sound/soc/codecs/tpa6130a2.h
index 57e867f..5df49c8 100644
--- a/sound/soc/codecs/tpa6130a2.h
+++ b/sound/soc/codecs/tpa6130a2.h
@@ -57,5 +57,6 @@
 #define TPA6130A2_VERSION_MASK		(0x0f)
 
 extern int tpa6130a2_add_controls(struct snd_soc_codec *codec);
+extern int tpa6130a2_stereo_enable(struct snd_soc_codec *codec, int enable);
 
 #endif /* __TPA6130A2_H__ */
-- 
1.7.3.2
