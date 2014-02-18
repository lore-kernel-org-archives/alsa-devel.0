From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 014/102] ASoC: wm8983: Remove superfluous const
Date: Tue, 18 Feb 2014 12:32:26 +0100
Message-ID: <1392723148-12597-12-git-send-email-tiwai@suse.de>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AEBD526549F
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
 sound/soc/codecs/wm8983.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index aa41ba0dfff4..770e5a705851 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -205,49 +205,44 @@ static const DECLARE_TLV_DB_SCALE(bypass_tlv, -1500, 300, 0);
 static const DECLARE_TLV_DB_SCALE(pga_boost_tlv, 0, 2000, 0);
 
 static const char *alc_sel_text[] = { "Off", "Right", "Left", "Stereo" };
-static const SOC_ENUM_SINGLE_DECL(alc_sel, WM8983_ALC_CONTROL_1, 7,
-				  alc_sel_text);
+static SOC_ENUM_SINGLE_DECL(alc_sel, WM8983_ALC_CONTROL_1, 7, alc_sel_text);
 
 static const char *alc_mode_text[] = { "ALC", "Limiter" };
-static const SOC_ENUM_SINGLE_DECL(alc_mode, WM8983_ALC_CONTROL_3, 8,
-				  alc_mode_text);
+static SOC_ENUM_SINGLE_DECL(alc_mode, WM8983_ALC_CONTROL_3, 8, alc_mode_text);
 
 static const char *filter_mode_text[] = { "Audio", "Application" };
-static const SOC_ENUM_SINGLE_DECL(filter_mode, WM8983_ADC_CONTROL, 7,
-				  filter_mode_text);
+static SOC_ENUM_SINGLE_DECL(filter_mode, WM8983_ADC_CONTROL, 7,
+			    filter_mode_text);
 
 static const char *eq_bw_text[] = { "Narrow", "Wide" };
 static const char *eqmode_text[] = { "Capture", "Playback" };
-static const SOC_ENUM_SINGLE_EXT_DECL(eqmode, eqmode_text);
+static SOC_ENUM_SINGLE_EXT_DECL(eqmode, eqmode_text);
 
 static const char *eq1_cutoff_text[] = {
 	"80Hz", "105Hz", "135Hz", "175Hz"
 };
-static const SOC_ENUM_SINGLE_DECL(eq1_cutoff, WM8983_EQ1_LOW_SHELF, 5,
-				  eq1_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(eq1_cutoff, WM8983_EQ1_LOW_SHELF, 5,
+			    eq1_cutoff_text);
 static const char *eq2_cutoff_text[] = {
 	"230Hz", "300Hz", "385Hz", "500Hz"
 };
-static const SOC_ENUM_SINGLE_DECL(eq2_bw, WM8983_EQ2_PEAK_1, 8, eq_bw_text);
-static const SOC_ENUM_SINGLE_DECL(eq2_cutoff, WM8983_EQ2_PEAK_1, 5,
-				  eq2_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(eq2_bw, WM8983_EQ2_PEAK_1, 8, eq_bw_text);
+static SOC_ENUM_SINGLE_DECL(eq2_cutoff, WM8983_EQ2_PEAK_1, 5, eq2_cutoff_text);
 static const char *eq3_cutoff_text[] = {
 	"650Hz", "850Hz", "1.1kHz", "1.4kHz"
 };
-static const SOC_ENUM_SINGLE_DECL(eq3_bw, WM8983_EQ3_PEAK_2, 8, eq_bw_text);
-static const SOC_ENUM_SINGLE_DECL(eq3_cutoff, WM8983_EQ3_PEAK_2, 5,
-				  eq3_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(eq3_bw, WM8983_EQ3_PEAK_2, 8, eq_bw_text);
+static SOC_ENUM_SINGLE_DECL(eq3_cutoff, WM8983_EQ3_PEAK_2, 5, eq3_cutoff_text);
 static const char *eq4_cutoff_text[] = {
 	"1.8kHz", "2.4kHz", "3.2kHz", "4.1kHz"
 };
-static const SOC_ENUM_SINGLE_DECL(eq4_bw, WM8983_EQ4_PEAK_3, 8, eq_bw_text);
-static const SOC_ENUM_SINGLE_DECL(eq4_cutoff, WM8983_EQ4_PEAK_3, 5,
-				  eq4_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(eq4_bw, WM8983_EQ4_PEAK_3, 8, eq_bw_text);
+static SOC_ENUM_SINGLE_DECL(eq4_cutoff, WM8983_EQ4_PEAK_3, 5, eq4_cutoff_text);
 static const char *eq5_cutoff_text[] = {
 	"5.3kHz", "6.9kHz", "9kHz", "11.7kHz"
 };
-static const SOC_ENUM_SINGLE_DECL(eq5_cutoff, WM8983_EQ5_HIGH_SHELF, 5,
-				  eq5_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(eq5_cutoff, WM8983_EQ5_HIGH_SHELF, 5,
+			    eq5_cutoff_text);
 
 static const char *depth_3d_text[] = {
 	"Off",
@@ -267,8 +262,8 @@ static const char *depth_3d_text[] = {
 	"93.3%",
 	"100%"
 };
-static const SOC_ENUM_SINGLE_DECL(depth_3d, WM8983_3D_CONTROL, 0,
-				  depth_3d_text);
+static SOC_ENUM_SINGLE_DECL(depth_3d, WM8983_3D_CONTROL, 0,
+			    depth_3d_text);
 
 static const struct snd_kcontrol_new wm8983_snd_controls[] = {
 	SOC_SINGLE("Digital Loopback Switch", WM8983_COMPANDING_CONTROL,
-- 
1.8.5.2
