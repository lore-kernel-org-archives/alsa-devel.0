From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH v3] ASoC: rt5677: make volume TLV closer to
	reality
Date: Thu,  4 Dec 2014 17:00:13 -0800
Message-ID: <1417741213-11326-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f74.google.com (mail-yh0-f74.google.com
 [209.85.213.74])
 by alsa0.perex.cz (Postfix) with ESMTP id A5BE126044B
 for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2014 02:00:16 +0100 (CET)
Received: by mail-yh0-f74.google.com with SMTP id 29so1050284yhl.1
 for <alsa-devel@alsa-project.org>; Thu, 04 Dec 2014 17:00:15 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: oder_chiou@realtek.com, anatol@chromium.org, tiwai@suse.de, benzh@chromium.org, broonie@kernel.org, bardliao@realtek.com, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

The volume blocks have an step of 0.375dB, but TLV uses 0.01dB for
units.  Only use the resolution supported, ignoring the LSB of the
volume register.  This results in half the steps and 0.75dB per step,
but reports accurate levels through TLV.  Update the masks to reflect
that these are registers have the LSB ignored.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/soc/codecs/rt5677.c | 22 +++++++++++-----------
 sound/soc/codecs/rt5677.h | 24 ++++++++++++------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 133010d..81fe146 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -763,9 +763,9 @@ static int rt5677_set_dsp_vad(struct snd_soc_codec *codec, bool on)
 }
 
 static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -4650, 150, 0);
-static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -65625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -6525, 75, 0);
 static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
-static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
 static const DECLARE_TLV_DB_SCALE(st_vol_tlv, -4650, 150, 0);
 
@@ -817,13 +817,13 @@ static const struct snd_kcontrol_new rt5677_snd_controls[] = {
 
 	/* DAC Digital Volume */
 	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5677_DAC1_DIG_VOL,
-		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 175, 0, dac_vol_tlv),
+		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 87, 0, dac_vol_tlv),
 	SOC_DOUBLE_TLV("DAC2 Playback Volume", RT5677_DAC2_DIG_VOL,
-		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 175, 0, dac_vol_tlv),
+		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 87, 0, dac_vol_tlv),
 	SOC_DOUBLE_TLV("DAC3 Playback Volume", RT5677_DAC3_DIG_VOL,
-		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 175, 0, dac_vol_tlv),
+		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 87, 0, dac_vol_tlv),
 	SOC_DOUBLE_TLV("DAC4 Playback Volume", RT5677_DAC4_DIG_VOL,
-		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 175, 0, dac_vol_tlv),
+		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 87, 0, dac_vol_tlv),
 
 	/* IN1/IN2 Control */
 	SOC_SINGLE_TLV("IN1 Boost", RT5677_IN1, RT5677_BST_SFT1, 8, 0, bst_tlv),
@@ -842,19 +842,19 @@ static const struct snd_kcontrol_new rt5677_snd_controls[] = {
 		RT5677_L_MUTE_SFT, RT5677_R_MUTE_SFT, 1, 1),
 
 	SOC_DOUBLE_TLV("ADC1 Capture Volume", RT5677_STO1_ADC_DIG_VOL,
-		RT5677_STO1_ADC_L_VOL_SFT, RT5677_STO1_ADC_R_VOL_SFT, 127, 0,
+		RT5677_STO1_ADC_L_VOL_SFT, RT5677_STO1_ADC_R_VOL_SFT, 63, 0,
 		adc_vol_tlv),
 	SOC_DOUBLE_TLV("ADC2 Capture Volume", RT5677_STO2_ADC_DIG_VOL,
-		RT5677_STO1_ADC_L_VOL_SFT, RT5677_STO1_ADC_R_VOL_SFT, 127, 0,
+		RT5677_STO1_ADC_L_VOL_SFT, RT5677_STO1_ADC_R_VOL_SFT, 63, 0,
 		adc_vol_tlv),
 	SOC_DOUBLE_TLV("ADC3 Capture Volume", RT5677_STO3_ADC_DIG_VOL,
-		RT5677_STO1_ADC_L_VOL_SFT, RT5677_STO1_ADC_R_VOL_SFT, 127, 0,
+		RT5677_STO1_ADC_L_VOL_SFT, RT5677_STO1_ADC_R_VOL_SFT, 63, 0,
 		adc_vol_tlv),
 	SOC_DOUBLE_TLV("ADC4 Capture Volume", RT5677_STO4_ADC_DIG_VOL,
-		RT5677_STO1_ADC_L_VOL_SFT, RT5677_STO1_ADC_R_VOL_SFT, 127, 0,
+		RT5677_STO1_ADC_L_VOL_SFT, RT5677_STO1_ADC_R_VOL_SFT, 63, 0,
 		adc_vol_tlv),
 	SOC_DOUBLE_TLV("Mono ADC Capture Volume", RT5677_MONO_ADC_DIG_VOL,
-		RT5677_MONO_ADC_L_VOL_SFT, RT5677_MONO_ADC_R_VOL_SFT, 127, 0,
+		RT5677_MONO_ADC_L_VOL_SFT, RT5677_MONO_ADC_R_VOL_SFT, 63, 0,
 		adc_vol_tlv),
 
 	/* Sidetone Control */
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index dbd9ffd..c0a625f 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -306,10 +306,10 @@
 #define RT5677_R_MUTE_SFT			7
 #define RT5677_VOL_R_MUTE			(0x1 << 6)
 #define RT5677_VOL_R_SFT			6
-#define RT5677_L_VOL_MASK			(0x3f << 8)
-#define RT5677_L_VOL_SFT			8
-#define RT5677_R_VOL_MASK			(0x3f)
-#define RT5677_R_VOL_SFT			0
+#define RT5677_L_VOL_MASK			(0x7f << 9)
+#define RT5677_L_VOL_SFT			9
+#define RT5677_R_VOL_MASK			(0x7f << 1)
+#define RT5677_R_VOL_SFT			1
 
 /* LOUT1 Control (0x01) */
 #define RT5677_LOUT1_L_MUTE			(0x1 << 15)
@@ -447,16 +447,16 @@
 #define RT5677_SEL_DAC2_R_SRC_SFT		0
 
 /* Stereo1 ADC Digital Volume Control (0x1c) */
-#define RT5677_STO1_ADC_L_VOL_MASK		(0x7f << 8)
-#define RT5677_STO1_ADC_L_VOL_SFT		8
-#define RT5677_STO1_ADC_R_VOL_MASK		(0x7f)
-#define RT5677_STO1_ADC_R_VOL_SFT		0
+#define RT5677_STO1_ADC_L_VOL_MASK		(0x3f << 9)
+#define RT5677_STO1_ADC_L_VOL_SFT		9
+#define RT5677_STO1_ADC_R_VOL_MASK		(0x3f << 1)
+#define RT5677_STO1_ADC_R_VOL_SFT		1
 
 /* Mono ADC Digital Volume Control (0x1d) */
-#define RT5677_MONO_ADC_L_VOL_MASK		(0x7f << 8)
-#define RT5677_MONO_ADC_L_VOL_SFT		8
-#define RT5677_MONO_ADC_R_VOL_MASK		(0x7f)
-#define RT5677_MONO_ADC_R_VOL_SFT		0
+#define RT5677_MONO_ADC_L_VOL_MASK		(0x3f << 9)
+#define RT5677_MONO_ADC_L_VOL_SFT		9
+#define RT5677_MONO_ADC_R_VOL_MASK		(0x3f << 1)
+#define RT5677_MONO_ADC_R_VOL_SFT		1
 
 /* Stereo 1/2 ADC Boost Gain Control (0x1e) */
 #define RT5677_STO1_ADC_L_BST_MASK		(0x3 << 14)
-- 
2.2.0.rc0.207.ga3a616c
