From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 022/102] ASoC: wm8400: Fix the wrong number of
	enum items
Date: Tue, 18 Feb 2014 12:36:57 +0100
Message-ID: <1392723422-12689-7-git-send-email-tiwai@suse.de>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5576026558A
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

wm8400 codec driver has a few places wrongly defining the number of
enum items.

Use SOC_ENUM_SINGLE_DECL() macro and they are automatically fixed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8400.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 48dc7d2fee36..6d684d934f4d 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -117,19 +117,23 @@ static int wm8400_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
 static const char *wm8400_digital_sidetone[] =
 	{"None", "Left ADC", "Right ADC", "Reserved"};
 
-static const struct soc_enum wm8400_left_digital_sidetone_enum =
-SOC_ENUM_SINGLE(WM8400_DIGITAL_SIDE_TONE,
-		WM8400_ADC_TO_DACL_SHIFT, 2, wm8400_digital_sidetone);
+static SOC_ENUM_SINGLE_DECL(wm8400_left_digital_sidetone_enum,
+			    WM8400_DIGITAL_SIDE_TONE,
+			    WM8400_ADC_TO_DACL_SHIFT,
+			    wm8400_digital_sidetone);
 
-static const struct soc_enum wm8400_right_digital_sidetone_enum =
-SOC_ENUM_SINGLE(WM8400_DIGITAL_SIDE_TONE,
-		WM8400_ADC_TO_DACR_SHIFT, 2, wm8400_digital_sidetone);
+static SOC_ENUM_SINGLE_DECL(wm8400_right_digital_sidetone_enum,
+			    WM8400_DIGITAL_SIDE_TONE,
+			    WM8400_ADC_TO_DACR_SHIFT,
+			    wm8400_digital_sidetone);
 
 static const char *wm8400_adcmode[] =
 	{"Hi-fi mode", "Voice mode 1", "Voice mode 2", "Voice mode 3"};
 
-static const struct soc_enum wm8400_right_adcmode_enum =
-SOC_ENUM_SINGLE(WM8400_ADC_CTRL, WM8400_ADC_HPF_CUT_SHIFT, 3, wm8400_adcmode);
+static SOC_ENUM_SINGLE_DECL(wm8400_right_adcmode_enum,
+			    WM8400_ADC_CTRL,
+			    WM8400_ADC_HPF_CUT_SHIFT,
+			    wm8400_adcmode);
 
 static const struct snd_kcontrol_new wm8400_snd_controls[] = {
 /* INMIXL */
@@ -422,9 +426,10 @@ SOC_DAPM_SINGLE("RINPGA34 Switch", WM8400_INPUT_MIXER3, WM8400_L34MNB_SHIFT,
 static const char *wm8400_ainlmux[] =
 	{"INMIXL Mix", "RXVOICE Mix", "DIFFINL Mix"};
 
-static const struct soc_enum wm8400_ainlmux_enum =
-SOC_ENUM_SINGLE( WM8400_INPUT_MIXER1, WM8400_AINLMODE_SHIFT,
-	ARRAY_SIZE(wm8400_ainlmux), wm8400_ainlmux);
+static SOC_ENUM_SINGLE_DECL(wm8400_ainlmux_enum,
+			    WM8400_INPUT_MIXER1,
+			    WM8400_AINLMODE_SHIFT,
+			    wm8400_ainlmux);
 
 static const struct snd_kcontrol_new wm8400_dapm_ainlmux_controls =
 SOC_DAPM_ENUM("Route", wm8400_ainlmux_enum);
@@ -435,9 +440,10 @@ SOC_DAPM_ENUM("Route", wm8400_ainlmux_enum);
 static const char *wm8400_ainrmux[] =
 	{"INMIXR Mix", "RXVOICE Mix", "DIFFINR Mix"};
 
-static const struct soc_enum wm8400_ainrmux_enum =
-SOC_ENUM_SINGLE( WM8400_INPUT_MIXER1, WM8400_AINRMODE_SHIFT,
-	ARRAY_SIZE(wm8400_ainrmux), wm8400_ainrmux);
+static SOC_ENUM_SINGLE_DECL(wm8400_ainrmux_enum,
+			    WM8400_INPUT_MIXER1,
+			    WM8400_AINRMODE_SHIFT,
+			    wm8400_ainrmux);
 
 static const struct snd_kcontrol_new wm8400_dapm_ainrmux_controls =
 SOC_DAPM_ENUM("Route", wm8400_ainrmux_enum);
-- 
1.8.5.2
