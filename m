From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 051/102] ASoC: wm8737: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:07 +0100
Message-ID: <1392723517-12772-24-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EB162655CD
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
 sound/soc/codecs/wm8737.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 2f167a8ca01b..d8e50f0aaf10 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -99,29 +99,29 @@ static const char *micbias_enum_text[] = {
 	"100%",
 };
 
-static const struct soc_enum micbias_enum =
-	SOC_ENUM_SINGLE(WM8737_MIC_PREAMP_CONTROL, 0, 4, micbias_enum_text);
+static SOC_ENUM_SINGLE_DECL(micbias_enum,
+			    WM8737_MIC_PREAMP_CONTROL, 0, micbias_enum_text);
 
 static const char *low_cutoff_text[] = {
 	"Low", "High"
 };
 
-static const struct soc_enum low_3d =
-	SOC_ENUM_SINGLE(WM8737_3D_ENHANCE, 6, 2, low_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(low_3d,
+			    WM8737_3D_ENHANCE, 6, low_cutoff_text);
 
 static const char *high_cutoff_text[] = {
 	"High", "Low"
 };
 
-static const struct soc_enum high_3d =
-	SOC_ENUM_SINGLE(WM8737_3D_ENHANCE, 5, 2, high_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(high_3d,
+			    WM8737_3D_ENHANCE, 5, high_cutoff_text);
 
 static const char *alc_fn_text[] = {
 	"Disabled", "Right", "Left", "Stereo"
 };
 
-static const struct soc_enum alc_fn =
-	SOC_ENUM_SINGLE(WM8737_ALC1, 7, 4, alc_fn_text);
+static SOC_ENUM_SINGLE_DECL(alc_fn,
+			    WM8737_ALC1, 7, alc_fn_text);
 
 static const char *alc_hold_text[] = {
 	"0", "2.67ms", "5.33ms", "10.66ms", "21.32ms", "42.64ms", "85.28ms",
@@ -129,24 +129,24 @@ static const char *alc_hold_text[] = {
 	"10.916s", "21.832s", "43.691s"
 };
 
-static const struct soc_enum alc_hold =
-	SOC_ENUM_SINGLE(WM8737_ALC2, 0, 16, alc_hold_text);
+static SOC_ENUM_SINGLE_DECL(alc_hold,
+			    WM8737_ALC2, 0, alc_hold_text);
 
 static const char *alc_atk_text[] = {
 	"8.4ms", "16.8ms", "33.6ms", "67.2ms", "134.4ms", "268.8ms", "537.6ms",
 	"1.075s", "2.15s", "4.3s", "8.6s"
 };
 
-static const struct soc_enum alc_atk =
-	SOC_ENUM_SINGLE(WM8737_ALC3, 0, 11, alc_atk_text);
+static SOC_ENUM_SINGLE_DECL(alc_atk,
+			    WM8737_ALC3, 0, alc_atk_text);
 
 static const char *alc_dcy_text[] = {
 	"33.6ms", "67.2ms", "134.4ms", "268.8ms", "537.6ms", "1.075s", "2.15s",
 	"4.3s", "8.6s", "17.2s", "34.41s"
 };
 
-static const struct soc_enum alc_dcy =
-	SOC_ENUM_SINGLE(WM8737_ALC3, 4, 11, alc_dcy_text);
+static SOC_ENUM_SINGLE_DECL(alc_dcy,
+			    WM8737_ALC3, 4, alc_dcy_text);
 
 static const struct snd_kcontrol_new wm8737_snd_controls[] = {
 SOC_DOUBLE_R_TLV("Mic Boost Volume", WM8737_AUDIO_PATH_L, WM8737_AUDIO_PATH_R,
@@ -191,8 +191,8 @@ static const char *linsel_text[] = {
 	"LINPUT1", "LINPUT2", "LINPUT3", "LINPUT1 DC",
 };
 
-static const struct soc_enum linsel_enum =
-	SOC_ENUM_SINGLE(WM8737_AUDIO_PATH_L, 7, 4, linsel_text);
+static SOC_ENUM_SINGLE_DECL(linsel_enum,
+			    WM8737_AUDIO_PATH_L, 7, linsel_text);
 
 static const struct snd_kcontrol_new linsel_mux =
 	SOC_DAPM_ENUM("LINSEL", linsel_enum);
@@ -202,8 +202,8 @@ static const char *rinsel_text[] = {
 	"RINPUT1", "RINPUT2", "RINPUT3", "RINPUT1 DC",
 };
 
-static const struct soc_enum rinsel_enum =
-	SOC_ENUM_SINGLE(WM8737_AUDIO_PATH_R, 7, 4, rinsel_text);
+static SOC_ENUM_SINGLE_DECL(rinsel_enum,
+			    WM8737_AUDIO_PATH_R, 7, rinsel_text);
 
 static const struct snd_kcontrol_new rinsel_mux =
 	SOC_DAPM_ENUM("RINSEL", rinsel_enum);
@@ -212,15 +212,15 @@ static const char *bypass_text[] = {
 	"Direct", "Preamp"
 };
 
-static const struct soc_enum lbypass_enum =
-	SOC_ENUM_SINGLE(WM8737_MIC_PREAMP_CONTROL, 2, 2, bypass_text);
+static SOC_ENUM_SINGLE_DECL(lbypass_enum,
+			    WM8737_MIC_PREAMP_CONTROL, 2, bypass_text);
 
 static const struct snd_kcontrol_new lbypass_mux =
 	SOC_DAPM_ENUM("Left Bypass", lbypass_enum);
 
 
-static const struct soc_enum rbypass_enum =
-	SOC_ENUM_SINGLE(WM8737_MIC_PREAMP_CONTROL, 3, 2, bypass_text);
+static SOC_ENUM_SINGLE_DECL(rbypass_enum,
+			    WM8737_MIC_PREAMP_CONTROL, 3, bypass_text);
 
 static const struct snd_kcontrol_new rbypass_mux =
 	SOC_DAPM_ENUM("Left Bypass", rbypass_enum);
-- 
1.8.5.2
