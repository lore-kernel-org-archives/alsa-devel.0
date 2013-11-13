From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH] ASoC: cs42l52: Reorganize MICA/B Config and
	Select
Date: Wed, 13 Nov 2013 16:05:40 -0600
Message-ID: <1384380340-19074-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 by alsa0.perex.cz (Postfix) with ESMTP id CE96A2615F2
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 23:02:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch reworks the MICA an MICB config for single-ended or
differential and the selection of which MIC for the single config

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 include/sound/cs42l52.h    |  6 ------
 sound/soc/codecs/cs42l52.c | 25 ++++---------------------
 2 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/include/sound/cs42l52.h b/include/sound/cs42l52.h
index 7c2be4a..daa91f3 100644
--- a/include/sound/cs42l52.h
+++ b/include/sound/cs42l52.h
@@ -22,12 +22,6 @@ struct cs42l52_platform_data {
 	/* MICB mode selection 0=Single 1=Differential */
 	unsigned int micb_cfg;
 
-	/* MICA Select 0=MIC1A 1=MIC2A */
-	unsigned int mica_sel;
-
-	/* MICB Select 0=MIC2A 1=MIC2B */
-	unsigned int micb_sel;
-
 	/* Charge Pump Freq. Check datasheet Pg73 */
 	unsigned int chgfreq;
 
diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 8b427c9..5af8306 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -233,7 +233,7 @@ static const struct soc_enum mic_bias_level_enum =
 	SOC_ENUM_SINGLE(CS42L52_IFACE_CTL2, 0,
 			ARRAY_SIZE(mic_bias_level_text), mic_bias_level_text);
 
-static const char * const cs42l52_mic_text[] = { "Single", "Differential" };
+static const char * const cs42l52_mic_text[] = { "MIC1", "MIC2" };
 
 static const struct soc_enum mica_enum =
 	SOC_ENUM_SINGLE(CS42L52_MICA_CTL, 5,
@@ -243,12 +243,6 @@ static const struct soc_enum micb_enum =
 	SOC_ENUM_SINGLE(CS42L52_MICB_CTL, 5,
 			ARRAY_SIZE(cs42l52_mic_text), cs42l52_mic_text);
 
-static const struct snd_kcontrol_new mica_mux =
-	SOC_DAPM_ENUM("Left Mic Input Capture Mux", mica_enum);
-
-static const struct snd_kcontrol_new micb_mux =
-	SOC_DAPM_ENUM("Right Mic Input Capture Mux", micb_enum);
-
 static const char * const digital_output_mux_text[] = {"ADC", "DSP"};
 
 static const struct soc_enum digital_output_mux_enum =
@@ -425,6 +419,9 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
 
 	SOC_DOUBLE("Bypass Mute", CS42L52_MISC_CTL, 4, 5, 1, 0),
 
+	SOC_ENUM("MICA Select", mica_enum),
+	SOC_ENUM("MICB Select", micb_enum),
+
 	SOC_DOUBLE_R_TLV("MIC Gain Volume", CS42L52_MICA_CTL,
 			      CS42L52_MICB_CTL, 0, 0x10, 0, mic_tlv),
 
@@ -550,9 +547,6 @@ static const struct snd_soc_dapm_widget cs42l52_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("AIFOUTR", NULL,  0,
 			SND_SOC_NOPM, 0, 0),
 
-	SND_SOC_DAPM_MUX("MICA Mux", SND_SOC_NOPM, 0, 0, &mica_mux),
-	SND_SOC_DAPM_MUX("MICB Mux", SND_SOC_NOPM, 0, 0, &micb_mux),
-
 	SND_SOC_DAPM_ADC("ADC Left", NULL, CS42L52_PWRCTL1, 1, 1),
 	SND_SOC_DAPM_ADC("ADC Right", NULL, CS42L52_PWRCTL1, 2, 1),
 	SND_SOC_DAPM_PGA("PGA Left", CS42L52_PWRCTL1, 3, 1, NULL, 0),
@@ -1239,17 +1233,6 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 				cs42l52->pdata.micb_cfg <<
 				CS42L52_MIC_CTL_TYPE_SHIFT);
 
-	if (cs42l52->pdata.mica_sel)
-		regmap_update_bits(cs42l52->regmap, CS42L52_MICA_CTL,
-				   CS42L52_MIC_CTL_MIC_SEL_MASK,
-				cs42l52->pdata.mica_sel <<
-				CS42L52_MIC_CTL_MIC_SEL_SHIFT);
-	if (cs42l52->pdata.micb_sel)
-		regmap_update_bits(cs42l52->regmap, CS42L52_MICB_CTL,
-				   CS42L52_MIC_CTL_MIC_SEL_MASK,
-				cs42l52->pdata.micb_sel <<
-				CS42L52_MIC_CTL_MIC_SEL_SHIFT);
-
 	if (cs42l52->pdata.chgfreq)
 		regmap_update_bits(cs42l52->regmap, CS42L52_CHARGE_PUMP,
 				   CS42L52_CHARGE_PUMP_MASK,
-- 
1.8.4.3
