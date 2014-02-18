From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 016/102] ASoC: wm8995: Remove superfluous const
Date: Tue, 18 Feb 2014 12:32:28 +0100
Message-ID: <1392723148-12597-14-git-send-email-tiwai@suse.de>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ADAF265497
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:32:33 +0100 (CET)
In-Reply-To: <1392723148-12597-1-git-send-email-tiwai@suse.de>
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

As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
reduce const from its users.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8995.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 403e1db6870f..b5e3ab094fb6 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -423,24 +423,24 @@ static const char *in1l_text[] = {
 	"Differential", "Single-ended IN1LN", "Single-ended IN1LP"
 };
 
-static const SOC_ENUM_SINGLE_DECL(in1l_enum, WM8995_LEFT_LINE_INPUT_CONTROL,
-				  2, in1l_text);
+static SOC_ENUM_SINGLE_DECL(in1l_enum, WM8995_LEFT_LINE_INPUT_CONTROL,
+			    2, in1l_text);
 
 static const char *in1r_text[] = {
 	"Differential", "Single-ended IN1RN", "Single-ended IN1RP"
 };
 
-static const SOC_ENUM_SINGLE_DECL(in1r_enum, WM8995_LEFT_LINE_INPUT_CONTROL,
-				  0, in1r_text);
+static SOC_ENUM_SINGLE_DECL(in1r_enum, WM8995_LEFT_LINE_INPUT_CONTROL,
+			    0, in1r_text);
 
 static const char *dmic_src_text[] = {
 	"DMICDAT1", "DMICDAT2", "DMICDAT3"
 };
 
-static const SOC_ENUM_SINGLE_DECL(dmic_src1_enum, WM8995_POWER_MANAGEMENT_5,
-				  8, dmic_src_text);
-static const SOC_ENUM_SINGLE_DECL(dmic_src2_enum, WM8995_POWER_MANAGEMENT_5,
-				  6, dmic_src_text);
+static SOC_ENUM_SINGLE_DECL(dmic_src1_enum, WM8995_POWER_MANAGEMENT_5,
+			    8, dmic_src_text);
+static SOC_ENUM_SINGLE_DECL(dmic_src2_enum, WM8995_POWER_MANAGEMENT_5,
+			    6, dmic_src_text);
 
 static const struct snd_kcontrol_new wm8995_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("DAC1 Volume", WM8995_DAC1_LEFT_VOLUME,
@@ -897,14 +897,14 @@ static const char *spk_src_text[] = {
 	"DAC1L", "DAC1R", "DAC2L", "DAC2R"
 };
 
-static const SOC_ENUM_SINGLE_DECL(spk1l_src_enum, WM8995_LEFT_PDM_SPEAKER_1,
-				  0, spk_src_text);
-static const SOC_ENUM_SINGLE_DECL(spk1r_src_enum, WM8995_RIGHT_PDM_SPEAKER_1,
-				  0, spk_src_text);
-static const SOC_ENUM_SINGLE_DECL(spk2l_src_enum, WM8995_LEFT_PDM_SPEAKER_2,
-				  0, spk_src_text);
-static const SOC_ENUM_SINGLE_DECL(spk2r_src_enum, WM8995_RIGHT_PDM_SPEAKER_2,
-				  0, spk_src_text);
+static SOC_ENUM_SINGLE_DECL(spk1l_src_enum, WM8995_LEFT_PDM_SPEAKER_1,
+			    0, spk_src_text);
+static SOC_ENUM_SINGLE_DECL(spk1r_src_enum, WM8995_RIGHT_PDM_SPEAKER_1,
+			    0, spk_src_text);
+static SOC_ENUM_SINGLE_DECL(spk2l_src_enum, WM8995_LEFT_PDM_SPEAKER_2,
+			    0, spk_src_text);
+static SOC_ENUM_SINGLE_DECL(spk2r_src_enum, WM8995_RIGHT_PDM_SPEAKER_2,
+			    0, spk_src_text);
 
 static const struct snd_kcontrol_new spk1l_mux =
 	SOC_DAPM_ENUM("SPK1L SRC", spk1l_src_enum);
-- 
1.8.5.2
