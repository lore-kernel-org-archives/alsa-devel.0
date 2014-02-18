From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 079/102] ASoC: tlv320dac33: Use
	SOC_ENUM_SINGLE_*_DECL()
Date: Tue, 18 Feb 2014 12:38:35 +0100
Message-ID: <1392723517-12772-52-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BD9B72655EB
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

Just replace with the helper macros.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/tlv320dac33.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 4f358393d6d6..9ce849623a0a 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -478,9 +478,7 @@ static const char *dac33_fifo_mode_texts[] = {
 	"Bypass", "Mode 1", "Mode 7"
 };
 
-static const struct soc_enum dac33_fifo_mode_enum =
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(dac33_fifo_mode_texts),
-			    dac33_fifo_mode_texts);
+static SOC_ENUM_SINGLE_EXT_DECL(dac33_fifo_mode_enum, dac33_fifo_mode_texts);
 
 /* L/R Line Output Gain */
 static const char *lr_lineout_gain_texts[] = {
@@ -488,15 +486,13 @@ static const char *lr_lineout_gain_texts[] = {
 	"Line 0dB DAC 12dB", "Line 6dB DAC 18dB",
 };
 
-static const struct soc_enum l_lineout_gain_enum =
-	SOC_ENUM_SINGLE(DAC33_LDAC_PWR_CTRL, 0,
-			ARRAY_SIZE(lr_lineout_gain_texts),
-			lr_lineout_gain_texts);
+static SOC_ENUM_SINGLE_DECL(l_lineout_gain_enum,
+			    DAC33_LDAC_PWR_CTRL, 0,
+			    lr_lineout_gain_texts);
 
-static const struct soc_enum r_lineout_gain_enum =
-	SOC_ENUM_SINGLE(DAC33_RDAC_PWR_CTRL, 0,
-			ARRAY_SIZE(lr_lineout_gain_texts),
-			lr_lineout_gain_texts);
+static SOC_ENUM_SINGLE_DECL(r_lineout_gain_enum,
+			    DAC33_RDAC_PWR_CTRL, 0,
+			    lr_lineout_gain_texts);
 
 /*
  * DACL/R digital volume control:
@@ -534,18 +530,16 @@ static const struct snd_kcontrol_new dac33_dapm_abypassr_control =
 /* LOP L/R invert selection */
 static const char *dac33_lr_lom_texts[] = {"DAC", "LOP"};
 
-static const struct soc_enum dac33_left_lom_enum =
-	SOC_ENUM_SINGLE(DAC33_OUT_AMP_CTRL, 3,
-			ARRAY_SIZE(dac33_lr_lom_texts),
-			dac33_lr_lom_texts);
+static SOC_ENUM_SINGLE_DECL(dac33_left_lom_enum,
+			    DAC33_OUT_AMP_CTRL, 3,
+			    dac33_lr_lom_texts);
 
 static const struct snd_kcontrol_new dac33_dapm_left_lom_control =
 SOC_DAPM_ENUM("Route", dac33_left_lom_enum);
 
-static const struct soc_enum dac33_right_lom_enum =
-	SOC_ENUM_SINGLE(DAC33_OUT_AMP_CTRL, 2,
-			ARRAY_SIZE(dac33_lr_lom_texts),
-			dac33_lr_lom_texts);
+static SOC_ENUM_SINGLE_DECL(dac33_right_lom_enum,
+			    DAC33_OUT_AMP_CTRL, 2,
+			    dac33_lr_lom_texts);
 
 static const struct snd_kcontrol_new dac33_dapm_right_lom_control =
 SOC_DAPM_ENUM("Route", dac33_right_lom_enum);
-- 
1.8.5.2
