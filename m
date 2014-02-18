From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 025/102] ASoC: wm8990: Fix the wrong number of
	enum items
Date: Tue, 18 Feb 2014 12:37:00 +0100
Message-ID: <1392723422-12689-10-git-send-email-tiwai@suse.de>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BA1926558F
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

wm8990 codec driver has a few places wrongly defining the number of
enum items.

Use SOC_ENUM_SINGLE_DECL() macro and they are automatically fixed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8990.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 0ccd4d8d043b..33f53ab1e7b0 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -157,26 +157,23 @@ static int wm899x_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
 static const char *wm8990_digital_sidetone[] =
 	{"None", "Left ADC", "Right ADC", "Reserved"};
 
-static const struct soc_enum wm8990_left_digital_sidetone_enum =
-SOC_ENUM_SINGLE(WM8990_DIGITAL_SIDE_TONE,
-	WM8990_ADC_TO_DACL_SHIFT,
-	WM8990_ADC_TO_DACL_MASK,
-	wm8990_digital_sidetone);
-
-static const struct soc_enum wm8990_right_digital_sidetone_enum =
-SOC_ENUM_SINGLE(WM8990_DIGITAL_SIDE_TONE,
-	WM8990_ADC_TO_DACR_SHIFT,
-	WM8990_ADC_TO_DACR_MASK,
-	wm8990_digital_sidetone);
+static SOC_ENUM_SINGLE_DECL(wm8990_left_digital_sidetone_enum,
+			    WM8990_DIGITAL_SIDE_TONE,
+			    WM8990_ADC_TO_DACL_SHIFT,
+			    wm8990_digital_sidetone);
+
+static SOC_ENUM_SINGLE_DECL(wm8990_right_digital_sidetone_enum,
+			    WM8990_DIGITAL_SIDE_TONE,
+			    WM8990_ADC_TO_DACR_SHIFT,
+			    wm8990_digital_sidetone);
 
 static const char *wm8990_adcmode[] =
 	{"Hi-fi mode", "Voice mode 1", "Voice mode 2", "Voice mode 3"};
 
-static const struct soc_enum wm8990_right_adcmode_enum =
-SOC_ENUM_SINGLE(WM8990_ADC_CTRL,
-	WM8990_ADC_HPF_CUT_SHIFT,
-	WM8990_ADC_HPF_CUT_MASK,
-	wm8990_adcmode);
+static SOC_ENUM_SINGLE_DECL(wm8990_right_adcmode_enum,
+			    WM8990_ADC_CTRL,
+			    WM8990_ADC_HPF_CUT_SHIFT,
+			    wm8990_adcmode);
 
 static const struct snd_kcontrol_new wm8990_snd_controls[] = {
 /* INMIXL */
@@ -475,9 +472,9 @@ SOC_DAPM_SINGLE("RINPGA34 Switch", WM8990_INPUT_MIXER3, WM8990_L34MNB_BIT,
 static const char *wm8990_ainlmux[] =
 	{"INMIXL Mix", "RXVOICE Mix", "DIFFINL Mix"};
 
-static const struct soc_enum wm8990_ainlmux_enum =
-SOC_ENUM_SINGLE(WM8990_INPUT_MIXER1, WM8990_AINLMODE_SHIFT,
-	ARRAY_SIZE(wm8990_ainlmux), wm8990_ainlmux);
+static SOC_ENUM_SINGLE_DECL(wm8990_ainlmux_enum,
+			    WM8990_INPUT_MIXER1, WM8990_AINLMODE_SHIFT,
+			    wm8990_ainlmux);
 
 static const struct snd_kcontrol_new wm8990_dapm_ainlmux_controls =
 SOC_DAPM_ENUM("Route", wm8990_ainlmux_enum);
@@ -488,9 +485,9 @@ SOC_DAPM_ENUM("Route", wm8990_ainlmux_enum);
 static const char *wm8990_ainrmux[] =
 	{"INMIXR Mix", "RXVOICE Mix", "DIFFINR Mix"};
 
-static const struct soc_enum wm8990_ainrmux_enum =
-SOC_ENUM_SINGLE(WM8990_INPUT_MIXER1, WM8990_AINRMODE_SHIFT,
-	ARRAY_SIZE(wm8990_ainrmux), wm8990_ainrmux);
+static SOC_ENUM_SINGLE_DECL(wm8990_ainrmux_enum,
+			    WM8990_INPUT_MIXER1, WM8990_AINRMODE_SHIFT,
+			    wm8990_ainrmux);
 
 static const struct snd_kcontrol_new wm8990_dapm_ainrmux_controls =
 SOC_DAPM_ENUM("Route", wm8990_ainrmux_enum);
-- 
1.8.5.2
