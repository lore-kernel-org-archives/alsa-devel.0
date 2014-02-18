From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 038/102] ASoC: max98095: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:37:54 +0100
Message-ID: <1392723517-12772-11-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 73D9B2655C2
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
 sound/soc/codecs/max98095.c | 50 ++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 5bce9cde4a6d..4c22582f3f56 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -560,25 +560,27 @@ static void m98095_biquad_band(struct snd_soc_codec *codec, unsigned int dai,
 }
 
 static const char * const max98095_fltr_mode[] = { "Voice", "Music" };
-static const struct soc_enum max98095_dai1_filter_mode_enum[] = {
-	SOC_ENUM_SINGLE(M98095_02E_DAI1_FILTERS, 7, 2, max98095_fltr_mode),
-};
-static const struct soc_enum max98095_dai2_filter_mode_enum[] = {
-	SOC_ENUM_SINGLE(M98095_038_DAI2_FILTERS, 7, 2, max98095_fltr_mode),
-};
+static SOC_ENUM_SINGLE_DECL(max98095_dai1_filter_mode_enum,
+			    M98095_02E_DAI1_FILTERS, 7,
+			    max98095_fltr_mode);
+static SOC_ENUM_SINGLE_DECL(max98095_dai2_filter_mode_enum,
+			    M98095_038_DAI2_FILTERS, 7,
+			    max98095_fltr_mode);
 
 static const char * const max98095_extmic_text[] = { "None", "MIC1", "MIC2" };
 
-static const struct soc_enum max98095_extmic_enum =
-	SOC_ENUM_SINGLE(M98095_087_CFG_MIC, 0, 3, max98095_extmic_text);
+static SOC_ENUM_SINGLE_DECL(max98095_extmic_enum,
+			    M98095_087_CFG_MIC, 0,
+			    max98095_extmic_text);
 
 static const struct snd_kcontrol_new max98095_extmic_mux =
 	SOC_DAPM_ENUM("External MIC Mux", max98095_extmic_enum);
 
 static const char * const max98095_linein_text[] = { "INA", "INB" };
 
-static const struct soc_enum max98095_linein_enum =
-	SOC_ENUM_SINGLE(M98095_086_CFG_LINE, 6, 2, max98095_linein_text);
+static SOC_ENUM_SINGLE_DECL(max98095_linein_enum,
+			    M98095_086_CFG_LINE, 6,
+			    max98095_linein_text);
 
 static const struct snd_kcontrol_new max98095_linein_mux =
 	SOC_DAPM_ENUM("Linein Input Mux", max98095_linein_enum);
@@ -586,24 +588,26 @@ static const struct snd_kcontrol_new max98095_linein_mux =
 static const char * const max98095_line_mode_text[] = {
 	"Stereo", "Differential"};
 
-static const struct soc_enum max98095_linein_mode_enum =
-	SOC_ENUM_SINGLE(M98095_086_CFG_LINE, 7, 2, max98095_line_mode_text);
+static SOC_ENUM_SINGLE_DECL(max98095_linein_mode_enum,
+			    M98095_086_CFG_LINE, 7,
+			    max98095_line_mode_text);
 
-static const struct soc_enum max98095_lineout_mode_enum =
-	SOC_ENUM_SINGLE(M98095_086_CFG_LINE, 4, 2, max98095_line_mode_text);
+static SOC_ENUM_SINGLE_DECL(max98095_lineout_mode_enum,
+			    M98095_086_CFG_LINE, 4,
+			    max98095_line_mode_text);
 
 static const char * const max98095_dai_fltr[] = {
 	"Off", "Elliptical-HPF-16k", "Butterworth-HPF-16k",
 	"Elliptical-HPF-8k", "Butterworth-HPF-8k", "Butterworth-HPF-Fs/240"};
-static const struct soc_enum max98095_dai1_dac_filter_enum[] = {
-	SOC_ENUM_SINGLE(M98095_02E_DAI1_FILTERS, 0, 6, max98095_dai_fltr),
-};
-static const struct soc_enum max98095_dai2_dac_filter_enum[] = {
-	SOC_ENUM_SINGLE(M98095_038_DAI2_FILTERS, 0, 6, max98095_dai_fltr),
-};
-static const struct soc_enum max98095_dai3_dac_filter_enum[] = {
-	SOC_ENUM_SINGLE(M98095_042_DAI3_FILTERS, 0, 6, max98095_dai_fltr),
-};
+static SOC_ENUM_SINGLE_DECL(max98095_dai1_dac_filter_enum,
+			    M98095_02E_DAI1_FILTERS, 0,
+			    max98095_dai_fltr);
+static SOC_ENUM_SINGLE_DECL(max98095_dai2_dac_filter_enum,
+			    M98095_038_DAI2_FILTERS, 0,
+			    max98095_dai_fltr);
+static SOC_ENUM_SINGLE_DECL(max98095_dai3_dac_filter_enum,
+			    M98095_042_DAI3_FILTERS, 0,
+			    max98095_dai_fltr);
 
 static int max98095_mic1pre_set(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
-- 
1.8.5.2
