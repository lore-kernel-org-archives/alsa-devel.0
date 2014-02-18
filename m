From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 041/102] ASoC: sn95031: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:37:57 +0100
Message-ID: <1392723517-12772-14-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F1A32655C4
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:38:39 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Just replace with the helper macro.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/sn95031.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 13045f2af4d3..bca7d02b362a 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -312,14 +312,14 @@ static int sn95031_dmic56_event(struct snd_soc_dapm_widget *w,
 /* mux controls */
 static const char *sn95031_mic_texts[] = { "AMIC", "LineIn" };
 
-static const struct soc_enum sn95031_micl_enum =
-	SOC_ENUM_SINGLE(SN95031_ADCCONFIG, 1, 2, sn95031_mic_texts);
+static SOC_ENUM_SINGLE_DECL(sn95031_micl_enum,
+			    SN95031_ADCCONFIG, 1, sn95031_mic_texts);
 
 static const struct snd_kcontrol_new sn95031_micl_mux_control =
 	SOC_DAPM_ENUM("Route", sn95031_micl_enum);
 
-static const struct soc_enum sn95031_micr_enum =
-	SOC_ENUM_SINGLE(SN95031_ADCCONFIG, 3, 2, sn95031_mic_texts);
+static SOC_ENUM_SINGLE_DECL(sn95031_micr_enum,
+			    SN95031_ADCCONFIG, 3, sn95031_mic_texts);
 
 static const struct snd_kcontrol_new sn95031_micr_mux_control =
 	SOC_DAPM_ENUM("Route", sn95031_micr_enum);
@@ -328,26 +328,26 @@ static const char *sn95031_input_texts[] = {	"DMIC1", "DMIC2", "DMIC3",
 						"DMIC4", "DMIC5", "DMIC6",
 						"ADC Left", "ADC Right" };
 
-static const struct soc_enum sn95031_input1_enum =
-	SOC_ENUM_SINGLE(SN95031_AUDIOMUX12, 0, 8, sn95031_input_texts);
+static SOC_ENUM_SINGLE_DECL(sn95031_input1_enum,
+			    SN95031_AUDIOMUX12, 0, sn95031_input_texts);
 
 static const struct snd_kcontrol_new sn95031_input1_mux_control =
 	SOC_DAPM_ENUM("Route", sn95031_input1_enum);
 
-static const struct soc_enum sn95031_input2_enum =
-	SOC_ENUM_SINGLE(SN95031_AUDIOMUX12, 4, 8, sn95031_input_texts);
+static SOC_ENUM_SINGLE_DECL(sn95031_input2_enum,
+			    SN95031_AUDIOMUX12, 4, sn95031_input_texts);
 
 static const struct snd_kcontrol_new sn95031_input2_mux_control =
 	SOC_DAPM_ENUM("Route", sn95031_input2_enum);
 
-static const struct soc_enum sn95031_input3_enum =
-	SOC_ENUM_SINGLE(SN95031_AUDIOMUX34, 0, 8, sn95031_input_texts);
+static SOC_ENUM_SINGLE_DECL(sn95031_input3_enum,
+			    SN95031_AUDIOMUX34, 0, sn95031_input_texts);
 
 static const struct snd_kcontrol_new sn95031_input3_mux_control =
 	SOC_DAPM_ENUM("Route", sn95031_input3_enum);
 
-static const struct soc_enum sn95031_input4_enum =
-	SOC_ENUM_SINGLE(SN95031_AUDIOMUX34, 4, 8, sn95031_input_texts);
+static SOC_ENUM_SINGLE_DECL(sn95031_input4_enum,
+			    SN95031_AUDIOMUX34, 4, sn95031_input_texts);
 
 static const struct snd_kcontrol_new sn95031_input4_mux_control =
 	SOC_DAPM_ENUM("Route", sn95031_input4_enum);
@@ -359,19 +359,19 @@ static const char *sn95031_micmode_text[] = {"Single Ended", "Differential"};
 /* 0dB to 30dB in 10dB steps */
 static const DECLARE_TLV_DB_SCALE(mic_tlv, 0, 10, 0);
 
-static const struct soc_enum sn95031_micmode1_enum =
-	SOC_ENUM_SINGLE(SN95031_MICAMP1, 1, 2, sn95031_micmode_text);
-static const struct soc_enum sn95031_micmode2_enum =
-	SOC_ENUM_SINGLE(SN95031_MICAMP2, 1, 2, sn95031_micmode_text);
+static SOC_ENUM_SINGLE_DECL(sn95031_micmode1_enum,
+			    SN95031_MICAMP1, 1, sn95031_micmode_text);
+static SOC_ENUM_SINGLE_DECL(sn95031_micmode2_enum,
+			    SN95031_MICAMP2, 1, sn95031_micmode_text);
 
 static const char *sn95031_dmic_cfg_text[] = {"GPO", "DMIC"};
 
-static const struct soc_enum sn95031_dmic12_cfg_enum =
-	SOC_ENUM_SINGLE(SN95031_DMICMUX, 0, 2, sn95031_dmic_cfg_text);
-static const struct soc_enum sn95031_dmic34_cfg_enum =
-	SOC_ENUM_SINGLE(SN95031_DMICMUX, 1, 2, sn95031_dmic_cfg_text);
-static const struct soc_enum sn95031_dmic56_cfg_enum =
-	SOC_ENUM_SINGLE(SN95031_DMICMUX, 2, 2, sn95031_dmic_cfg_text);
+static SOC_ENUM_SINGLE_DECL(sn95031_dmic12_cfg_enum,
+			    SN95031_DMICMUX, 0, sn95031_dmic_cfg_text);
+static SOC_ENUM_SINGLE_DECL(sn95031_dmic34_cfg_enum,
+			    SN95031_DMICMUX, 1, sn95031_dmic_cfg_text);
+static SOC_ENUM_SINGLE_DECL(sn95031_dmic56_cfg_enum,
+			    SN95031_DMICMUX, 2, sn95031_dmic_cfg_text);
 
 static const struct snd_kcontrol_new sn95031_snd_controls[] = {
 	SOC_ENUM("Mic1Mode Capture Route", sn95031_micmode1_enum),
-- 
1.8.5.2
