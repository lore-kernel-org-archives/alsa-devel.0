From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 026/102] ASoC: wm8991: Fix the wrong number of
	enum items
Date: Tue, 18 Feb 2014 12:37:01 +0100
Message-ID: <1392723422-12689-11-git-send-email-tiwai@suse.de>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5943926558D
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

wm8991 codec driver has a few places wrongly defining the number of
enum items.

Use SOC_ENUM_SINGLE_DECL() macro and they are automatically fixed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8991.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 244eb09ffa43..32d219570cca 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -171,26 +171,23 @@ static int wm899x_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
 static const char *wm8991_digital_sidetone[] =
 {"None", "Left ADC", "Right ADC", "Reserved"};
 
-static const struct soc_enum wm8991_left_digital_sidetone_enum =
-	SOC_ENUM_SINGLE(WM8991_DIGITAL_SIDE_TONE,
-			WM8991_ADC_TO_DACL_SHIFT,
-			WM8991_ADC_TO_DACL_MASK,
-			wm8991_digital_sidetone);
-
-static const struct soc_enum wm8991_right_digital_sidetone_enum =
-	SOC_ENUM_SINGLE(WM8991_DIGITAL_SIDE_TONE,
-			WM8991_ADC_TO_DACR_SHIFT,
-			WM8991_ADC_TO_DACR_MASK,
-			wm8991_digital_sidetone);
+static SOC_ENUM_SINGLE_DECL(wm8991_left_digital_sidetone_enum,
+			    WM8991_DIGITAL_SIDE_TONE,
+			    WM8991_ADC_TO_DACL_SHIFT,
+			    wm8991_digital_sidetone);
+
+static SOC_ENUM_SINGLE_DECL(wm8991_right_digital_sidetone_enum,
+			    WM8991_DIGITAL_SIDE_TONE,
+			    WM8991_ADC_TO_DACR_SHIFT,
+			    wm8991_digital_sidetone);
 
 static const char *wm8991_adcmode[] =
 {"Hi-fi mode", "Voice mode 1", "Voice mode 2", "Voice mode 3"};
 
-static const struct soc_enum wm8991_right_adcmode_enum =
-	SOC_ENUM_SINGLE(WM8991_ADC_CTRL,
-			WM8991_ADC_HPF_CUT_SHIFT,
-			WM8991_ADC_HPF_CUT_MASK,
-			wm8991_adcmode);
+static SOC_ENUM_SINGLE_DECL(wm8991_right_adcmode_enum,
+			    WM8991_ADC_CTRL,
+			    WM8991_ADC_HPF_CUT_SHIFT,
+			    wm8991_adcmode);
 
 static const struct snd_kcontrol_new wm8991_snd_controls[] = {
 	/* INMIXL */
@@ -486,9 +483,9 @@ static const struct snd_kcontrol_new wm8991_dapm_inmixr_controls[] = {
 static const char *wm8991_ainlmux[] =
 {"INMIXL Mix", "RXVOICE Mix", "DIFFINL Mix"};
 
-static const struct soc_enum wm8991_ainlmux_enum =
-	SOC_ENUM_SINGLE(WM8991_INPUT_MIXER1, WM8991_AINLMODE_SHIFT,
-			ARRAY_SIZE(wm8991_ainlmux), wm8991_ainlmux);
+static SOC_ENUM_SINGLE_DECL(wm8991_ainlmux_enum,
+			    WM8991_INPUT_MIXER1, WM8991_AINLMODE_SHIFT,
+			    wm8991_ainlmux);
 
 static const struct snd_kcontrol_new wm8991_dapm_ainlmux_controls =
 	SOC_DAPM_ENUM("Route", wm8991_ainlmux_enum);
@@ -499,9 +496,9 @@ static const struct snd_kcontrol_new wm8991_dapm_ainlmux_controls =
 static const char *wm8991_ainrmux[] =
 {"INMIXR Mix", "RXVOICE Mix", "DIFFINR Mix"};
 
-static const struct soc_enum wm8991_ainrmux_enum =
-	SOC_ENUM_SINGLE(WM8991_INPUT_MIXER1, WM8991_AINRMODE_SHIFT,
-			ARRAY_SIZE(wm8991_ainrmux), wm8991_ainrmux);
+static SOC_ENUM_SINGLE_DECL(wm8991_ainrmux_enum,
+			    WM8991_INPUT_MIXER1, WM8991_AINRMODE_SHIFT,
+			    wm8991_ainrmux);
 
 static const struct snd_kcontrol_new wm8991_dapm_ainrmux_controls =
 	SOC_DAPM_ENUM("Route", wm8991_ainrmux_enum);
-- 
1.8.5.2
