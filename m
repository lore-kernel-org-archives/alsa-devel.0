From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 019/102] ASoC: arizona: Fix wrong number of
	items in enum ctls
Date: Tue, 18 Feb 2014 12:36:54 +0100
Message-ID: <1392723422-12689-4-git-send-email-tiwai@suse.de>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 30780265587
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

arizona codec driver has a few places wrongly defining the number of
enum items.

Use SOC_ENUM_SINGLE_DECL() macro and they are automatically fixed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/arizona.c | 71 ++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e4295fee8f13..a32b84ac03f6 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -542,67 +542,76 @@ static const char *arizona_vol_ramp_text[] = {
 	"15ms/6dB", "30ms/6dB",
 };
 
-const struct soc_enum arizona_in_vd_ramp =
-	SOC_ENUM_SINGLE(ARIZONA_INPUT_VOLUME_RAMP,
-			ARIZONA_IN_VD_RAMP_SHIFT, 7, arizona_vol_ramp_text);
+SOC_ENUM_SINGLE_DECL(arizona_in_vd_ramp,
+		     ARIZONA_INPUT_VOLUME_RAMP,
+		     ARIZONA_IN_VD_RAMP_SHIFT,
+		     arizona_vol_ramp_text);
 EXPORT_SYMBOL_GPL(arizona_in_vd_ramp);
 
-const struct soc_enum arizona_in_vi_ramp =
-	SOC_ENUM_SINGLE(ARIZONA_INPUT_VOLUME_RAMP,
-			ARIZONA_IN_VI_RAMP_SHIFT, 7, arizona_vol_ramp_text);
+SOC_ENUM_SINGLE_DECL(arizona_in_vi_ramp,
+		     ARIZONA_INPUT_VOLUME_RAMP,
+		     ARIZONA_IN_VI_RAMP_SHIFT,
+		     arizona_vol_ramp_text);
 EXPORT_SYMBOL_GPL(arizona_in_vi_ramp);
 
-const struct soc_enum arizona_out_vd_ramp =
-	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_VOLUME_RAMP,
-			ARIZONA_OUT_VD_RAMP_SHIFT, 7, arizona_vol_ramp_text);
+SOC_ENUM_SINGLE_DECL(arizona_out_vd_ramp,
+		     ARIZONA_OUTPUT_VOLUME_RAMP,
+		     ARIZONA_OUT_VD_RAMP_SHIFT,
+		     arizona_vol_ramp_text);
 EXPORT_SYMBOL_GPL(arizona_out_vd_ramp);
 
-const struct soc_enum arizona_out_vi_ramp =
-	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_VOLUME_RAMP,
-			ARIZONA_OUT_VI_RAMP_SHIFT, 7, arizona_vol_ramp_text);
+SOC_ENUM_SINGLE_DECL(arizona_out_vi_ramp,
+		     ARIZONA_OUTPUT_VOLUME_RAMP,
+		     ARIZONA_OUT_VI_RAMP_SHIFT,
+		     arizona_vol_ramp_text);
 EXPORT_SYMBOL_GPL(arizona_out_vi_ramp);
 
 static const char *arizona_lhpf_mode_text[] = {
 	"Low-pass", "High-pass"
 };
 
-const struct soc_enum arizona_lhpf1_mode =
-	SOC_ENUM_SINGLE(ARIZONA_HPLPF1_1, ARIZONA_LHPF1_MODE_SHIFT, 2,
-			arizona_lhpf_mode_text);
+SOC_ENUM_SINGLE_DECL(arizona_lhpf1_mode,
+		     ARIZONA_HPLPF1_1,
+		     ARIZONA_LHPF1_MODE_SHIFT,
+		     arizona_lhpf_mode_text);
 EXPORT_SYMBOL_GPL(arizona_lhpf1_mode);
 
-const struct soc_enum arizona_lhpf2_mode =
-	SOC_ENUM_SINGLE(ARIZONA_HPLPF2_1, ARIZONA_LHPF2_MODE_SHIFT, 2,
-			arizona_lhpf_mode_text);
+SOC_ENUM_SINGLE_DECL(arizona_lhpf2_mode,
+		     ARIZONA_HPLPF2_1,
+		     ARIZONA_LHPF2_MODE_SHIFT,
+		     arizona_lhpf_mode_text);
 EXPORT_SYMBOL_GPL(arizona_lhpf2_mode);
 
-const struct soc_enum arizona_lhpf3_mode =
-	SOC_ENUM_SINGLE(ARIZONA_HPLPF3_1, ARIZONA_LHPF3_MODE_SHIFT, 2,
-			arizona_lhpf_mode_text);
+SOC_ENUM_SINGLE_DECL(arizona_lhpf3_mode,
+		     ARIZONA_HPLPF3_1,
+		     ARIZONA_LHPF3_MODE_SHIFT,
+		     arizona_lhpf_mode_text);
 EXPORT_SYMBOL_GPL(arizona_lhpf3_mode);
 
-const struct soc_enum arizona_lhpf4_mode =
-	SOC_ENUM_SINGLE(ARIZONA_HPLPF4_1, ARIZONA_LHPF4_MODE_SHIFT, 2,
-			arizona_lhpf_mode_text);
+SOC_ENUM_SINGLE_DECL(arizona_lhpf4_mode,
+		     ARIZONA_HPLPF4_1,
+		     ARIZONA_LHPF4_MODE_SHIFT,
+		     arizona_lhpf_mode_text);
 EXPORT_SYMBOL_GPL(arizona_lhpf4_mode);
 
 static const char *arizona_ng_hold_text[] = {
 	"30ms", "120ms", "250ms", "500ms",
 };
 
-const struct soc_enum arizona_ng_hold =
-	SOC_ENUM_SINGLE(ARIZONA_NOISE_GATE_CONTROL, ARIZONA_NGATE_HOLD_SHIFT,
-			4, arizona_ng_hold_text);
+SOC_ENUM_SINGLE_DECL(arizona_ng_hold,
+		     ARIZONA_NOISE_GATE_CONTROL,
+		     ARIZONA_NGATE_HOLD_SHIFT,
+		     arizona_ng_hold_text);
 EXPORT_SYMBOL_GPL(arizona_ng_hold);
 
 static const char * const arizona_in_hpf_cut_text[] = {
 	"2.5Hz", "5Hz", "10Hz", "20Hz", "40Hz"
 };
 
-const struct soc_enum arizona_in_hpf_cut_enum =
-	SOC_ENUM_SINGLE(ARIZONA_HPF_CONTROL, ARIZONA_IN_HPF_CUT_SHIFT,
-			ARRAY_SIZE(arizona_in_hpf_cut_text),
-			arizona_in_hpf_cut_text);
+SOC_ENUM_SINGLE_DECL(arizona_in_hpf_cut_enum,
+		     ARIZONA_HPF_CONTROL,
+		     ARIZONA_IN_HPF_CUT_SHIFT,
+		     arizona_in_hpf_cut_text);
 EXPORT_SYMBOL_GPL(arizona_in_hpf_cut_enum);
 
 static const char * const arizona_in_dmic_osr_text[] = {
-- 
1.8.5.2
