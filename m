From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_hubs: Allow configuration of MICBIAS
	power up delay via pdata
Date: Tue, 21 Aug 2012 18:06:41 +0100
Message-ID: <1345568801-26939-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC35D265FFF
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 19:06:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Sometimes the analogue circuitry connected to the microphone needs some
time to settle after power up. Allow systems to configure this delay in
the platform data, the driver will then insert the required delay during
power up of paths that involve the microphone.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/pdata.h |    4 ++++
 include/sound/wm8993.h           |    4 ++++
 sound/soc/codecs/wm8993.c        |    2 ++
 sound/soc/codecs/wm8994.c        |    2 ++
 sound/soc/codecs/wm_hubs.c       |   35 +++++++++++++++++++++++++++++++----
 sound/soc/codecs/wm_hubs.h       |    4 ++++
 6 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index f0361c0..fc87be4 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -164,6 +164,10 @@ struct wm8994_pdata {
 	int num_micd_rates;
 	struct wm8958_micd_rate *micd_rates;
 
+	/* Power up delays to add after microphone bias power up (ms) */
+	int micb1_delay;
+	int micb2_delay;
+
         /* LINEOUT can be differential or single ended */
         unsigned int lineout1_diff:1;
         unsigned int lineout2_diff:1;
diff --git a/include/sound/wm8993.h b/include/sound/wm8993.h
index eee19f6..8016fd8 100644
--- a/include/sound/wm8993.h
+++ b/include/sound/wm8993.h
@@ -32,6 +32,10 @@ struct wm8993_platform_data {
 	unsigned int lineout1fb:1;
 	unsigned int lineout2fb:1;
 
+	/* Delay to add for microphones to stabalise after power up */
+	int micbias1_delay;
+	int micbias2_delay;
+
 	/* Microphone biases: 0=0.9*AVDD1 1=0.65*AVVD1 */
 	unsigned int micbias1_lvl:1;
 	unsigned int micbias2_lvl:1;
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 9fd80d6..94737a3 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1520,6 +1520,8 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 				      wm8993->pdata.lineout2fb,
 				      wm8993->pdata.jd_scthr,
 				      wm8993->pdata.jd_thr,
+				      wm8993->pdata.micbias1_delay,
+				      wm8993->pdata.micbias2_delay,
 				      wm8993->pdata.micbias1_lvl,
 				      wm8993->pdata.micbias2_lvl);
 
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2d60ed3..a51431c 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3233,6 +3233,8 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 				      pdata->lineout2fb,
 				      pdata->jd_scthr,
 				      pdata->jd_thr,
+				      pdata->micb1_delay,
+				      pdata->micb2_delay,
 				      pdata->micbias1_lvl,
 				      pdata->micbias2_lvl);
 
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 8dc4e89..c72eaef 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -859,6 +859,28 @@ static int lineout_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int micbias_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+
+	switch (w->shift) {
+	case WM8993_MICB1_ENA_SHIFT:
+		if (hubs->micb1_delay)
+			msleep(hubs->micb1_delay);
+		break;
+	case WM8993_MICB2_ENA_SHIFT:
+		if (hubs->micb2_delay)
+			msleep(hubs->micb2_delay);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 void wm_hubs_update_class_w(struct snd_soc_codec *codec)
 {
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
@@ -1049,8 +1071,10 @@ SND_SOC_DAPM_INPUT("IN1RP"),
 SND_SOC_DAPM_INPUT("IN2RN"),
 SND_SOC_DAPM_INPUT("IN2RP:VXRP"),
 
-SND_SOC_DAPM_SUPPLY("MICBIAS2", WM8993_POWER_MANAGEMENT_1, 5, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("MICBIAS1", WM8993_POWER_MANAGEMENT_1, 4, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS2", WM8993_POWER_MANAGEMENT_1, 5, 0,
+		    micbias_event, SND_SOC_DAPM_POST_PMU),
+SND_SOC_DAPM_SUPPLY("MICBIAS1", WM8993_POWER_MANAGEMENT_1, 4, 0,
+		    micbias_event, SND_SOC_DAPM_POST_PMU),
 
 SND_SOC_DAPM_MIXER("IN1L PGA", WM8993_POWER_MANAGEMENT_2, 6, 0,
 		   in1l_pga, ARRAY_SIZE(in1l_pga)),
@@ -1388,13 +1412,16 @@ EXPORT_SYMBOL_GPL(wm_hubs_add_analogue_routes);
 int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *codec,
 				  int lineout1_diff, int lineout2_diff,
 				  int lineout1fb, int lineout2fb,
-				  int jd_scthr, int jd_thr, int micbias1_lvl,
-				  int micbias2_lvl)
+				  int jd_scthr, int jd_thr,
+				  int micbias1_delay, int micbias2_delay,
+				  int micbias1_lvl, int micbias2_lvl)
 {
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 
 	hubs->lineout1_se = !lineout1_diff;
 	hubs->lineout2_se = !lineout2_diff;
+	hubs->micb1_delay = micbias1_delay;
+	hubs->micb2_delay = micbias2_delay;
 
 	if (!lineout1_diff)
 		snd_soc_update_bits(codec, WM8993_LINE_MIXER1,
diff --git a/sound/soc/codecs/wm_hubs.h b/sound/soc/codecs/wm_hubs.h
index 14927f6..704e53f 100644
--- a/sound/soc/codecs/wm_hubs.h
+++ b/sound/soc/codecs/wm_hubs.h
@@ -55,6 +55,9 @@ struct wm_hubs_data {
 	struct list_head dcs_cache;
 	bool (*check_class_w_digital)(struct snd_soc_codec *);
 
+	int micb1_delay;
+	int micb2_delay;
+
 	bool lineout1_se;
 	bool lineout1n_ena;
 	bool lineout1p_ena;
@@ -75,6 +78,7 @@ extern int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *,
 					 int lineout1_diff, int lineout2_diff,
 					 int lineout1fb, int lineout2fb,
 					 int jd_scthr, int jd_thr,
+					 int micbias1_dly, int micbias2_dly,
 					 int micbias1_lvl, int micbias2_lvl);
 
 extern irqreturn_t wm_hubs_dcs_done(int irq, void *data);
-- 
1.7.10.4
