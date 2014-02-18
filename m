From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 024/102] ASoC: wm8900: Fix the wrong number of
	enum items
Date: Tue, 18 Feb 2014 12:36:59 +0100
Message-ID: <1392723422-12689-9-git-send-email-tiwai@suse.de>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 58BBA26558B
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:37:06 +0100 (CET)
In-Reply-To: <1392723422-12689-1-git-send-email-tiwai@suse.de>
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

wm8900 codec driver has a few places wrongly defining the number of
enum items.

Use SOC_ENUM_SINGLE_DECL() macro and they are automatically fixed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8900.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index e98bc7038a08..43c2201cb901 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -304,53 +304,53 @@ static const DECLARE_TLV_DB_SCALE(adc_tlv, -7200, 75, 1);
 
 static const char *mic_bias_level_txt[] = { "0.9*AVDD", "0.65*AVDD" };
 
-static const struct soc_enum mic_bias_level =
-SOC_ENUM_SINGLE(WM8900_REG_INCTL, 8, 2, mic_bias_level_txt);
+static SOC_ENUM_SINGLE_DECL(mic_bias_level,
+			    WM8900_REG_INCTL, 8, mic_bias_level_txt);
 
 static const char *dac_mute_rate_txt[] = { "Fast", "Slow" };
 
-static const struct soc_enum dac_mute_rate =
-SOC_ENUM_SINGLE(WM8900_REG_DACCTRL, 7, 2, dac_mute_rate_txt);
+static SOC_ENUM_SINGLE_DECL(dac_mute_rate,
+			    WM8900_REG_DACCTRL, 7, dac_mute_rate_txt);
 
 static const char *dac_deemphasis_txt[] = {
 	"Disabled", "32kHz", "44.1kHz", "48kHz"
 };
 
-static const struct soc_enum dac_deemphasis =
-SOC_ENUM_SINGLE(WM8900_REG_DACCTRL, 4, 4, dac_deemphasis_txt);
+static SOC_ENUM_SINGLE_DECL(dac_deemphasis,
+			    WM8900_REG_DACCTRL, 4, dac_deemphasis_txt);
 
 static const char *adc_hpf_cut_txt[] = {
 	"Hi-fi mode", "Voice mode 1", "Voice mode 2", "Voice mode 3"
 };
 
-static const struct soc_enum adc_hpf_cut =
-SOC_ENUM_SINGLE(WM8900_REG_ADCCTRL, 5, 4, adc_hpf_cut_txt);
+static SOC_ENUM_SINGLE_DECL(adc_hpf_cut,
+			    WM8900_REG_ADCCTRL, 5, adc_hpf_cut_txt);
 
 static const char *lr_txt[] = {
 	"Left", "Right"
 };
 
-static const struct soc_enum aifl_src =
-SOC_ENUM_SINGLE(WM8900_REG_AUDIO1, 15, 2, lr_txt);
+static SOC_ENUM_SINGLE_DECL(aifl_src,
+			    WM8900_REG_AUDIO1, 15, lr_txt);
 
-static const struct soc_enum aifr_src =
-SOC_ENUM_SINGLE(WM8900_REG_AUDIO1, 14, 2, lr_txt);
+static SOC_ENUM_SINGLE_DECL(aifr_src,
+			    WM8900_REG_AUDIO1, 14, lr_txt);
 
-static const struct soc_enum dacl_src =
-SOC_ENUM_SINGLE(WM8900_REG_AUDIO2, 15, 2, lr_txt);
+static SOC_ENUM_SINGLE_DECL(dacl_src,
+			    WM8900_REG_AUDIO2, 15, lr_txt);
 
-static const struct soc_enum dacr_src =
-SOC_ENUM_SINGLE(WM8900_REG_AUDIO2, 14, 2, lr_txt);
+static SOC_ENUM_SINGLE_DECL(dacr_src,
+			    WM8900_REG_AUDIO2, 14, lr_txt);
 
 static const char *sidetone_txt[] = {
 	"Disabled", "Left ADC", "Right ADC"
 };
 
-static const struct soc_enum dacl_sidetone =
-SOC_ENUM_SINGLE(WM8900_REG_SIDETONE, 2, 3, sidetone_txt);
+static SOC_ENUM_SINGLE_DECL(dacl_sidetone,
+			    WM8900_REG_SIDETONE, 2, sidetone_txt);
 
-static const struct soc_enum dacr_sidetone =
-SOC_ENUM_SINGLE(WM8900_REG_SIDETONE, 0, 3, sidetone_txt);
+static SOC_ENUM_SINGLE_DECL(dacr_sidetone,
+			    WM8900_REG_SIDETONE, 0, sidetone_txt);
 
 static const struct snd_kcontrol_new wm8900_snd_controls[] = {
 SOC_ENUM("Mic Bias Level", mic_bias_level),
@@ -496,8 +496,8 @@ SOC_DAPM_SINGLE("RINPUT3 Switch", WM8900_REG_INCTL, 0, 1, 0),
 
 static const char *wm8900_lp_mux[] = { "Disabled", "Enabled" };
 
-static const struct soc_enum wm8900_lineout2_lp_mux =
-SOC_ENUM_SINGLE(WM8900_REG_LOUTMIXCTL1, 1, 2, wm8900_lp_mux);
+static SOC_ENUM_SINGLE_DECL(wm8900_lineout2_lp_mux,
+			    WM8900_REG_LOUTMIXCTL1, 1, wm8900_lp_mux);
 
 static const struct snd_kcontrol_new wm8900_lineout2_lp =
 SOC_DAPM_ENUM("Route", wm8900_lineout2_lp_mux);
-- 
1.8.5.2
