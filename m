From: yang.a.fang@intel.com
Subject: [PATCH 2/2] ASoC: max98090: Enforce correct device
	sequencing when configuring a new
Date: Thu,  6 Aug 2015 16:15:45 -0700
Message-ID: <1438902946-49633-2-git-send-email-yang.a.fang@intel.com>
References: <1438902946-49633-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id ACEAA26065A
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 01:16:53 +0200 (CEST)
In-Reply-To: <1438902946-49633-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, Anish.Kumar@maximintegrated.com, praveen.k.jain@intel.com, denny.iriawan@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, ullysses.a.eoff@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

audio route when there is an existing active audio route(s).

This patch fixed recording noise issue while playback is active.

We have some registers which require the device to be in full shutdown
or to enter full shutdown before the register settings will take effect.
Currently the driver is not shutting down the device when a new audio
route is created. If a new audio route is made active while there is
already an active audio route, then the required register sequencing is
violated. A hardware shutdown toggle when creating a new audio route
corrects the sequencing error. The device must remain in hardware
shutdown for 40ms to allow the internal hardware core to fully shutdown.

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
---
 sound/soc/codecs/max98090.c |   46 +++++++++++++++++++++++++++++++++++++------
 sound/soc/codecs/max98090.h |    1 +
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 91c9f9f..1516c6b 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -850,6 +850,19 @@ static int max98090_micinput_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int max98090_shdn_event(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
+
+	if (event & SND_SOC_DAPM_POST_PMU)
+		max98090->shdn_pending = TRUE;
+
+	return 0;
+
+}
+
 static const char *mic1_mux_text[] = { "IN12", "IN56" };
 
 static SOC_ENUM_SINGLE_DECL(mic1_mux_enum,
@@ -1158,9 +1171,11 @@ static const struct snd_soc_dapm_widget max98090_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("SDOEN", M98090_REG_IO_CONFIGURATION,
 		M98090_SDOEN_SHIFT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("DMICL_ENA", M98090_REG_DIGITAL_MIC_ENABLE,
-		 M98090_DIGMICL_SHIFT, 0, NULL, 0),
+		 M98090_DIGMICL_SHIFT, 0, max98090_shdn_event,
+			SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("DMICR_ENA", M98090_REG_DIGITAL_MIC_ENABLE,
-		 M98090_DIGMICR_SHIFT, 0, NULL, 0),
+		 M98090_DIGMICR_SHIFT, 0, max98090_shdn_event,
+			 SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("AHPF", M98090_REG_FILTER_CONFIG,
 		M98090_AHPF_SHIFT, 0, NULL, 0),
 
@@ -1205,10 +1220,12 @@ static const struct snd_soc_dapm_widget max98090_dapm_widgets[] = {
 		&max98090_right_adc_mixer_controls[0],
 		ARRAY_SIZE(max98090_right_adc_mixer_controls)),
 
-	SND_SOC_DAPM_ADC("ADCL", NULL, M98090_REG_INPUT_ENABLE,
-		M98090_ADLEN_SHIFT, 0),
-	SND_SOC_DAPM_ADC("ADCR", NULL, M98090_REG_INPUT_ENABLE,
-		M98090_ADREN_SHIFT, 0),
+	SND_SOC_DAPM_ADC_E("ADCL", NULL, M98090_REG_INPUT_ENABLE,
+		M98090_ADLEN_SHIFT, 0, max98090_shdn_event,
+		SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_ADC_E("ADCR", NULL, M98090_REG_INPUT_ENABLE,
+		M98090_ADREN_SHIFT, 0, max98090_shdn_event,
+		SND_SOC_DAPM_POST_PMU),
 
 	SND_SOC_DAPM_AIF_OUT("AIFOUTL", "HiFi Capture", 0,
 		SND_SOC_NOPM, 0, 0),
@@ -2539,9 +2556,26 @@ static int max98090_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
+static void max98090_seq_notifier(struct snd_soc_dapm_context *dapm,
+	enum snd_soc_dapm_type event, int subseq, bool power_up)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
+	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
+
+	if (max98090->shdn_pending && power_up) {
+		snd_soc_update_bits(codec, M98090_REG_DEVICE_SHUTDOWN,
+				M98090_SHDNN_MASK, 0);
+		msleep(40);
+		snd_soc_update_bits(codec, M98090_REG_DEVICE_SHUTDOWN,
+				M98090_SHDNN_MASK, M98090_SHDNN_MASK);
+		max98090->shdn_pending = FALSE;
+	}
+}
+
 static struct snd_soc_codec_driver soc_codec_dev_max98090 = {
 	.probe   = max98090_probe,
 	.remove  = max98090_remove,
+	.seq_notifier = max98090_seq_notifier,
 	.set_bias_level = max98090_set_bias_level,
 };
 
diff --git a/sound/soc/codecs/max98090.h b/sound/soc/codecs/max98090.h
index 21ff743..bc610d9 100644
--- a/sound/soc/codecs/max98090.h
+++ b/sound/soc/codecs/max98090.h
@@ -1543,6 +1543,7 @@ struct max98090_priv {
 	unsigned int pa2en;
 	unsigned int sidetone;
 	bool master;
+	bool shdn_pending;
 };
 
 int max98090_mic_detect(struct snd_soc_codec *codec,
-- 
1.7.9.5
