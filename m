From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm8994: Apply volume updates with
	clocks enabled
Date: Tue,  5 Jun 2012 13:52:20 +0100
Message-ID: <1338900740-24523-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1338900740-24523-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5906B24645
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 14:52:23 +0200 (CEST)
In-Reply-To: <1338900740-24523-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Volume updates may not be acted upon if there is no clock applied when
the volume update is written. Ensure this doesn't happen by writing out
registers with volume updates after we enable each of the clocks.

There are more registers updated than before as previously we were
relying on wm_hubs to set those for controls it manages.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   93 ++++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 6d3a865..aa8c98b 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -46,6 +46,39 @@
 #define WM8994_NUM_DRC 3
 #define WM8994_NUM_EQ  3
 
+static struct {
+	unsigned int reg;
+	unsigned int mask;
+} wm8994_vu_bits[] = {
+	{ WM8994_LEFT_LINE_INPUT_1_2_VOLUME, WM8994_IN1_VU },
+	{ WM8994_RIGHT_LINE_INPUT_1_2_VOLUME, WM8994_IN1_VU },
+	{ WM8994_LEFT_LINE_INPUT_3_4_VOLUME, WM8994_IN2_VU },
+	{ WM8994_RIGHT_LINE_INPUT_3_4_VOLUME, WM8994_IN2_VU },
+	{ WM8994_SPEAKER_VOLUME_LEFT, WM8994_SPKOUT_VU },
+	{ WM8994_SPEAKER_VOLUME_RIGHT, WM8994_SPKOUT_VU },
+	{ WM8994_LEFT_OUTPUT_VOLUME, WM8994_HPOUT1_VU },
+	{ WM8994_RIGHT_OUTPUT_VOLUME, WM8994_HPOUT1_VU },
+	{ WM8994_LEFT_OPGA_VOLUME, WM8994_MIXOUT_VU },
+	{ WM8994_RIGHT_OPGA_VOLUME, WM8994_MIXOUT_VU },
+
+	{ WM8994_AIF1_DAC1_LEFT_VOLUME, WM8994_AIF1DAC1_VU },
+	{ WM8994_AIF1_DAC1_RIGHT_VOLUME, WM8994_AIF1DAC1_VU },
+	{ WM8994_AIF1_DAC2_LEFT_VOLUME, WM8994_AIF1DAC2_VU },
+	{ WM8994_AIF1_DAC2_RIGHT_VOLUME, WM8994_AIF1DAC2_VU },
+	{ WM8994_AIF2_DAC_LEFT_VOLUME, WM8994_AIF2DAC_VU },
+	{ WM8994_AIF2_DAC_RIGHT_VOLUME, WM8994_AIF2DAC_VU },
+	{ WM8994_AIF1_ADC1_LEFT_VOLUME, WM8994_AIF1ADC1_VU },
+	{ WM8994_AIF1_ADC1_RIGHT_VOLUME, WM8994_AIF1ADC1_VU },
+	{ WM8994_AIF1_ADC2_LEFT_VOLUME, WM8994_AIF1ADC2_VU },
+	{ WM8994_AIF1_ADC2_RIGHT_VOLUME, WM8994_AIF1ADC2_VU },
+	{ WM8994_AIF2_ADC_LEFT_VOLUME, WM8994_AIF2ADC_VU },
+	{ WM8994_AIF2_ADC_RIGHT_VOLUME, WM8994_AIF1ADC2_VU },
+	{ WM8994_DAC1_LEFT_VOLUME, WM8994_DAC1_VU },
+	{ WM8994_DAC1_RIGHT_VOLUME, WM8994_DAC1_VU },
+	{ WM8994_DAC2_LEFT_VOLUME, WM8994_DAC2_VU },
+	{ WM8994_DAC2_RIGHT_VOLUME, WM8994_DAC2_VU },
+};
+
 static int wm8994_drc_base[] = {
 	WM8994_AIF1_DRC1_1,
 	WM8994_AIF1_DRC2_1,
@@ -989,6 +1022,7 @@ static int aif1clk_ev(struct snd_soc_dapm_widget *w,
 	struct snd_soc_codec *codec = w->codec;
 	struct wm8994 *control = codec->control_data;
 	int mask = WM8994_AIF1DAC1L_ENA | WM8994_AIF1DAC1R_ENA;
+	int i;
 	int dac;
 	int adc;
 	int val;
@@ -1047,6 +1081,13 @@ static int aif1clk_ev(struct snd_soc_dapm_widget *w,
 				    WM8994_AIF1DAC2L_ENA);
 		break;
 
+	case SND_SOC_DAPM_POST_PMU:
+		for (i = 0; i < ARRAY_SIZE(wm8994_vu_bits); i++)
+			snd_soc_write(codec, wm8994_vu_bits[i].reg,
+				      snd_soc_read(codec,
+						   wm8994_vu_bits[i].reg));
+		break;
+
 	case SND_SOC_DAPM_PRE_PMD:
 	case SND_SOC_DAPM_POST_PMD:
 		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
@@ -1072,6 +1113,7 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 		      struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
+	int i;
 	int dac;
 	int adc;
 	int val;
@@ -1122,6 +1164,13 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 				    WM8994_AIF2DACR_ENA);
 		break;
 
+	case SND_SOC_DAPM_POST_PMU:
+		for (i = 0; i < ARRAY_SIZE(wm8994_vu_bits); i++)
+			snd_soc_write(codec, wm8994_vu_bits[i].reg,
+				      snd_soc_read(codec,
+						   wm8994_vu_bits[i].reg));
+		break;
+
 	case SND_SOC_DAPM_PRE_PMD:
 	case SND_SOC_DAPM_POST_PMD:
 		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
@@ -1531,9 +1580,11 @@ SND_SOC_DAPM_POST("Late Disable PGA", late_disable_ev)
 
 static const struct snd_soc_dapm_widget wm8994_lateclk_widgets[] = {
 SND_SOC_DAPM_SUPPLY("AIF1CLK", WM8994_AIF1_CLOCKING_1, 0, 0, aif1clk_ev,
-		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		    SND_SOC_DAPM_PRE_PMD),
 SND_SOC_DAPM_SUPPLY("AIF2CLK", WM8994_AIF2_CLOCKING_1, 0, 0, aif2clk_ev,
-		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		    SND_SOC_DAPM_PRE_PMD),
 SND_SOC_DAPM_PGA("Direct Voice", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_MIXER("SPKL", WM8994_POWER_MANAGEMENT_3, 8, 0,
 		   left_speaker_mixer, ARRAY_SIZE(left_speaker_mixer)),
@@ -3883,39 +3934,11 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	pm_runtime_put(codec->dev);
 
-	/* Latch volume updates (right only; we always do left then right). */
-	snd_soc_update_bits(codec, WM8994_AIF1_DAC1_LEFT_VOLUME,
-			    WM8994_AIF1DAC1_VU, WM8994_AIF1DAC1_VU);
-	snd_soc_update_bits(codec, WM8994_AIF1_DAC1_RIGHT_VOLUME,
-			    WM8994_AIF1DAC1_VU, WM8994_AIF1DAC1_VU);
-	snd_soc_update_bits(codec, WM8994_AIF1_DAC2_LEFT_VOLUME,
-			    WM8994_AIF1DAC2_VU, WM8994_AIF1DAC2_VU);
-	snd_soc_update_bits(codec, WM8994_AIF1_DAC2_RIGHT_VOLUME,
-			    WM8994_AIF1DAC2_VU, WM8994_AIF1DAC2_VU);
-	snd_soc_update_bits(codec, WM8994_AIF2_DAC_LEFT_VOLUME,
-			    WM8994_AIF2DAC_VU, WM8994_AIF2DAC_VU);
-	snd_soc_update_bits(codec, WM8994_AIF2_DAC_RIGHT_VOLUME,
-			    WM8994_AIF2DAC_VU, WM8994_AIF2DAC_VU);
-	snd_soc_update_bits(codec, WM8994_AIF1_ADC1_LEFT_VOLUME,
-			    WM8994_AIF1ADC1_VU, WM8994_AIF1ADC1_VU);
-	snd_soc_update_bits(codec, WM8994_AIF1_ADC1_RIGHT_VOLUME,
-			    WM8994_AIF1ADC1_VU, WM8994_AIF1ADC1_VU);
-	snd_soc_update_bits(codec, WM8994_AIF1_ADC2_LEFT_VOLUME,
-			    WM8994_AIF1ADC2_VU, WM8994_AIF1ADC2_VU);
-	snd_soc_update_bits(codec, WM8994_AIF1_ADC2_RIGHT_VOLUME,
-			    WM8994_AIF1ADC2_VU, WM8994_AIF1ADC2_VU);
-	snd_soc_update_bits(codec, WM8994_AIF2_ADC_LEFT_VOLUME,
-			    WM8994_AIF2ADC_VU, WM8994_AIF1ADC2_VU);
-	snd_soc_update_bits(codec, WM8994_AIF2_ADC_RIGHT_VOLUME,
-			    WM8994_AIF2ADC_VU, WM8994_AIF1ADC2_VU);
-	snd_soc_update_bits(codec, WM8994_DAC1_LEFT_VOLUME,
-			    WM8994_DAC1_VU, WM8994_DAC1_VU);
-	snd_soc_update_bits(codec, WM8994_DAC1_RIGHT_VOLUME,
-			    WM8994_DAC1_VU, WM8994_DAC1_VU);
-	snd_soc_update_bits(codec, WM8994_DAC2_LEFT_VOLUME,
-			    WM8994_DAC2_VU, WM8994_DAC2_VU);
-	snd_soc_update_bits(codec, WM8994_DAC2_RIGHT_VOLUME,
-			    WM8994_DAC2_VU, WM8994_DAC2_VU);
+	/* Latch volume update bits */
+	for (i = 0; i < ARRAY_SIZE(wm8994_vu_bits); i++)
+		snd_soc_update_bits(codec, wm8994_vu_bits[i].reg,
+				    wm8994_vu_bits[i].mask,
+				    wm8994_vu_bits[i].mask);
 
 	/* Set the low bit of the 3D stereo depth so TLV matches */
 	snd_soc_update_bits(codec, WM8994_AIF1_DAC1_FILTERS_2,
-- 
1.7.10
