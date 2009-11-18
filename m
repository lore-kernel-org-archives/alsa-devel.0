From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cs4236: add dB scale for all volume controls
Date: Wed, 18 Nov 2009 17:29:36 +0100
Message-ID: <20091118172936.b84437ff.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id D337024385
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 17:28:25 +0100 (CET)
Received: from poczta.interia.pl (mi03.poczta.interia.pl [10.217.12.3])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id 3CE571EF175
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 17:28:22 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id DA60E3E3833
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 17:28:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use db scale for all volume controls according to Crystal's datasheets.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/cs423x/cs4236_lib.c |  152 +++++++++++++++++++++++++++++------------
 1 files changed, 108 insertions(+), 44 deletions(-)

diff --git a/sound/isa/cs423x/cs4236_lib.c b/sound/isa/cs423x/cs4236_lib.c
index 4c4024a..c5adca3 100644
--- a/sound/isa/cs423x/cs4236_lib.c
+++ b/sound/isa/cs423x/cs4236_lib.c
@@ -88,6 +88,7 @@
 #include <sound/wss.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
+#include <sound/tlv.h>
 
 /*
  *
@@ -399,6 +400,14 @@ int snd_cs4236_pcm(struct snd_wss *chip, int device, struct snd_pcm **rpcm)
   .get = snd_cs4236_get_single, .put = snd_cs4236_put_single, \
   .private_value = reg | (shift << 8) | (mask << 16) | (invert << 24) }
 
+#define CS4236_SINGLE_TLV(xname, xindex, reg, shift, mask, invert, xtlv) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
+  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
+  .info = snd_cs4236_info_single, \
+  .get = snd_cs4236_get_single, .put = snd_cs4236_put_single, \
+  .private_value = reg | (shift << 8) | (mask << 16) | (invert << 24), \
+  .tlv = { .p = (xtlv) } }
+
 static int snd_cs4236_info_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	int mask = (kcontrol->private_value >> 16) & 0xff;
@@ -502,6 +511,16 @@ static int snd_cs4236_put_singlec(struct snd_kcontrol *kcontrol, struct snd_ctl_
   .get = snd_cs4236_get_double, .put = snd_cs4236_put_double, \
   .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | (shift_right << 19) | (mask << 24) | (invert << 22) }
 
+#define CS4236_DOUBLE_TLV(xname, xindex, left_reg, right_reg, shift_left, \
+			  shift_right, mask, invert, xtlv) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
+  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
+  .info = snd_cs4236_info_double, \
+  .get = snd_cs4236_get_double, .put = snd_cs4236_put_double, \
+  .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | \
+		   (shift_right << 19) | (mask << 24) | (invert << 22), \
+  .tlv = { .p = (xtlv) } }
+
 static int snd_cs4236_info_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	int mask = (kcontrol->private_value >> 24) & 0xff;
@@ -572,12 +591,23 @@ static int snd_cs4236_put_double(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	return change;
 }
 
-#define CS4236_DOUBLE1(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert) \
+#define CS4236_DOUBLE1(xname, xindex, left_reg, right_reg, shift_left, \
+			shift_right, mask, invert) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
   .info = snd_cs4236_info_double, \
   .get = snd_cs4236_get_double1, .put = snd_cs4236_put_double1, \
   .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | (shift_right << 19) | (mask << 24) | (invert << 22) }
 
+#define CS4236_DOUBLE1_TLV(xname, xindex, left_reg, right_reg, shift_left, \
+			   shift_right, mask, invert, xtlv) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
+  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
+  .info = snd_cs4236_info_double, \
+  .get = snd_cs4236_get_double1, .put = snd_cs4236_put_double1, \
+  .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | \
+		   (shift_right << 19) | (mask << 24) | (invert << 22), \
+  .tlv = { .p = (xtlv) } }
+
 static int snd_cs4236_get_double1(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
@@ -631,16 +661,18 @@ static int snd_cs4236_put_double1(struct snd_kcontrol *kcontrol, struct snd_ctl_
 	return change;
 }
 
-#define CS4236_MASTER_DIGITAL(xname, xindex) \
+#define CS4236_MASTER_DIGITAL(xname, xindex, xtlv) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
+  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
   .info = snd_cs4236_info_double, \
   .get = snd_cs4236_get_master_digital, .put = snd_cs4236_put_master_digital, \
-  .private_value = 71 << 24 }
+  .private_value = 71 << 24, \
+  .tlv = { .p = (xtlv) } }
 
 static inline int snd_cs4236_mixer_master_digital_invert_volume(int vol)
 {
 	return (vol < 64) ? 63 - vol : 64 + (71 - vol);
-}        
+}
 
 static int snd_cs4236_get_master_digital(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
@@ -673,11 +705,13 @@ static int snd_cs4236_put_master_digital(struct snd_kcontrol *kcontrol, struct s
 	return change;
 }
 
-#define CS4235_OUTPUT_ACCU(xname, xindex) \
+#define CS4235_OUTPUT_ACCU(xname, xindex, xtlv) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
+  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
   .info = snd_cs4236_info_double, \
   .get = snd_cs4235_get_output_accu, .put = snd_cs4235_put_output_accu, \
-  .private_value = 3 << 24 }
+  .private_value = 3 << 24, \
+  .tlv = { .p = (xtlv) } }
 
 static inline int snd_cs4235_mixer_output_accu_get_volume(int vol)
 {
@@ -732,41 +766,56 @@ static int snd_cs4235_put_output_accu(struct snd_kcontrol *kcontrol, struct snd_
 	return change;
 }
 
+static const DECLARE_TLV_DB_SCALE(db_scale_7bit, -9450, 150, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_6bit, -9450, 150, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_6bit_12db_max, -8250, 150, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_5bit_12db_max, -3450, 150, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_5bit_22db_max, -2400, 150, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_4bit, -4500, 300, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_2bit, -1800, 600, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_rec_gain, 0, 150, 0);
+
 static struct snd_kcontrol_new snd_cs4236_controls[] = {
 
 CS4236_DOUBLE("Master Digital Playback Switch", 0,
 		CS4236_LEFT_MASTER, CS4236_RIGHT_MASTER, 7, 7, 1, 1),
 CS4236_DOUBLE("Master Digital Capture Switch", 0,
 		CS4236_DAC_MUTE, CS4236_DAC_MUTE, 7, 6, 1, 1),
-CS4236_MASTER_DIGITAL("Master Digital Volume", 0),
+CS4236_MASTER_DIGITAL("Master Digital Volume", 0, db_scale_7bit),
 
-CS4236_DOUBLE("Capture Boost Volume", 0,
-		CS4236_LEFT_MIX_CTRL, CS4236_RIGHT_MIX_CTRL, 5, 5, 3, 1),
+CS4236_DOUBLE_TLV("Capture Boost Volume", 0,
+		  CS4236_LEFT_MIX_CTRL, CS4236_RIGHT_MIX_CTRL, 5, 5, 3, 1,
+		  db_scale_2bit),
 
 WSS_DOUBLE("PCM Playback Switch", 0,
 		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
-WSS_DOUBLE("PCM Playback Volume", 0,
-		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
+WSS_DOUBLE_TLV("PCM Playback Volume", 0,
+		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1,
+		db_scale_6bit),
 
 CS4236_DOUBLE("DSP Playback Switch", 0,
 		CS4236_LEFT_DSP, CS4236_RIGHT_DSP, 7, 7, 1, 1),
-CS4236_DOUBLE("DSP Playback Volume", 0,
-		CS4236_LEFT_DSP, CS4236_RIGHT_DSP, 0, 0, 63, 1),
+CS4236_DOUBLE_TLV("DSP Playback Volume", 0,
+		  CS4236_LEFT_DSP, CS4236_RIGHT_DSP, 0, 0, 63, 1,
+		  db_scale_6bit),
 
 CS4236_DOUBLE("FM Playback Switch", 0,
 		CS4236_LEFT_FM, CS4236_RIGHT_FM, 7, 7, 1, 1),
-CS4236_DOUBLE("FM Playback Volume", 0,
-		CS4236_LEFT_FM, CS4236_RIGHT_FM, 0, 0, 63, 1),
+CS4236_DOUBLE_TLV("FM Playback Volume", 0,
+		  CS4236_LEFT_FM, CS4236_RIGHT_FM, 0, 0, 63, 1,
+		  db_scale_6bit),
 
 CS4236_DOUBLE("Wavetable Playback Switch", 0,
 		CS4236_LEFT_WAVE, CS4236_RIGHT_WAVE, 7, 7, 1, 1),
-CS4236_DOUBLE("Wavetable Playback Volume", 0,
-		CS4236_LEFT_WAVE, CS4236_RIGHT_WAVE, 0, 0, 63, 1),
+CS4236_DOUBLE_TLV("Wavetable Playback Volume", 0,
+		  CS4236_LEFT_WAVE, CS4236_RIGHT_WAVE, 0, 0, 63, 1,
+		  db_scale_6bit_12db_max),
 
 WSS_DOUBLE("Synth Playback Switch", 0,
 		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
-WSS_DOUBLE("Synth Volume", 0,
-		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1),
+WSS_DOUBLE_TLV("Synth Volume", 0,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1,
+		db_scale_5bit_12db_max),
 WSS_DOUBLE("Synth Capture Switch", 0,
 		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 6, 6, 1, 1),
 WSS_DOUBLE("Synth Capture Bypass", 0,
@@ -776,14 +825,16 @@ CS4236_DOUBLE("Mic Playback Switch", 0,
 		CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 6, 6, 1, 1),
 CS4236_DOUBLE("Mic Capture Switch", 0,
 		CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 7, 7, 1, 1),
-CS4236_DOUBLE("Mic Volume", 0, CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 0, 0, 31, 1),
+CS4236_DOUBLE_TLV("Mic Volume", 0, CS4236_LEFT_MIC, CS4236_RIGHT_MIC,
+		  0, 0, 31, 1, db_scale_5bit_22db_max),
 CS4236_DOUBLE("Mic Playback Boost (+20dB)", 0,
 		CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 5, 5, 1, 0),
 
 WSS_DOUBLE("Line Playback Switch", 0,
 		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-WSS_DOUBLE("Line Volume", 0,
-		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
+WSS_DOUBLE_TLV("Line Volume", 0,
+		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1,
+		db_scale_5bit_12db_max),
 WSS_DOUBLE("Line Capture Switch", 0,
 		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 6, 6, 1, 1),
 WSS_DOUBLE("Line Capture Bypass", 0,
@@ -791,8 +842,9 @@ WSS_DOUBLE("Line Capture Bypass", 0,
 
 WSS_DOUBLE("CD Playback Switch", 0,
 		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-WSS_DOUBLE("CD Volume", 0,
-		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
+WSS_DOUBLE_TLV("CD Volume", 0,
+		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1,
+		db_scale_5bit_12db_max),
 WSS_DOUBLE("CD Capture Switch", 0,
 		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 6, 6, 1, 1),
 
@@ -800,44 +852,53 @@ CS4236_DOUBLE1("Mono Output Playback Switch", 0,
 		CS4231_MONO_CTRL, CS4236_RIGHT_MIX_CTRL, 6, 7, 1, 1),
 CS4236_DOUBLE1("Beep Playback Switch", 0,
 		CS4231_MONO_CTRL, CS4236_LEFT_MIX_CTRL, 7, 7, 1, 1),
-WSS_SINGLE("Beep Playback Volume", 0, CS4231_MONO_CTRL, 0, 15, 1),
+WSS_SINGLE_TLV("Beep Playback Volume", 0, CS4231_MONO_CTRL, 0, 15, 1,
+		db_scale_4bit),
 WSS_SINGLE("Beep Bypass Playback Switch", 0, CS4231_MONO_CTRL, 5, 1, 0),
 
-WSS_DOUBLE("Capture Volume", 0,
-		CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0, 15, 0),
+WSS_DOUBLE_TLV("Capture Volume", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT,
+		0, 0, 15, 0, db_scale_rec_gain),
 WSS_DOUBLE("Analog Loopback Capture Switch", 0,
 		CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 7, 7, 1, 0),
 
-WSS_SINGLE("Digital Loopback Playback Switch", 0, CS4231_LOOPBACK, 0, 1, 0),
-CS4236_DOUBLE1("Digital Loopback Playback Volume", 0,
-		CS4231_LOOPBACK, CS4236_RIGHT_LOOPBACK, 2, 0, 63, 1)
+WSS_SINGLE("Loopback Digital Playback Switch", 0, CS4231_LOOPBACK, 0, 1, 0),
+CS4236_DOUBLE1_TLV("Loopback Digital Playback Volume", 0,
+		   CS4231_LOOPBACK, CS4236_RIGHT_LOOPBACK, 2, 0, 63, 1,
+		   db_scale_6bit),
 };
 
+static const DECLARE_TLV_DB_SCALE(db_scale_5bit_6db_max, -5600, 200, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_2bit_16db_max, -2400, 800, 0);
+
 static struct snd_kcontrol_new snd_cs4235_controls[] = {
 
 WSS_DOUBLE("Master Playback Switch", 0,
 		CS4235_LEFT_MASTER, CS4235_RIGHT_MASTER, 7, 7, 1, 1),
-WSS_DOUBLE("Master Playback Volume", 0,
-		CS4235_LEFT_MASTER, CS4235_RIGHT_MASTER, 0, 0, 31, 1),
+WSS_DOUBLE_TLV("Master Playback Volume", 0,
+		CS4235_LEFT_MASTER, CS4235_RIGHT_MASTER, 0, 0, 31, 1,
+		db_scale_5bit_6db_max),
 
-CS4235_OUTPUT_ACCU("Playback Volume", 0),
+CS4235_OUTPUT_ACCU("Playback Volume", 0, db_scale_2bit_16db_max),
 
 WSS_DOUBLE("Synth Playback Switch", 1,
 		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
 WSS_DOUBLE("Synth Capture Switch", 1,
 		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 6, 6, 1, 1),
-WSS_DOUBLE("Synth Volume", 1,
-		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1),
+WSS_DOUBLE_TLV("Synth Volume", 1,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1,
+		db_scale_5bit_12db_max),
 
-CS4236_DOUBLE("Capture Volume", 0,
-		CS4236_LEFT_MIX_CTRL, CS4236_RIGHT_MIX_CTRL, 5, 5, 3, 1),
+CS4236_DOUBLE_TLV("Capture Volume", 0,
+		  CS4236_LEFT_MIX_CTRL, CS4236_RIGHT_MIX_CTRL, 5, 5, 3, 1,
+		  db_scale_2bit),
 
 WSS_DOUBLE("PCM Playback Switch", 0,
 		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
 WSS_DOUBLE("PCM Capture Switch", 0,
 		CS4236_DAC_MUTE, CS4236_DAC_MUTE, 7, 6, 1, 1),
-WSS_DOUBLE("PCM Volume", 0,
-		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
+WSS_DOUBLE_TLV("PCM Volume", 0,
+		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1,
+		db_scale_6bit),
 
 CS4236_DOUBLE("DSP Switch", 0, CS4236_LEFT_DSP, CS4236_RIGHT_DSP, 7, 7, 1, 1),
 
@@ -850,22 +911,25 @@ CS4236_DOUBLE("Mic Capture Switch", 0,
 		CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 7, 7, 1, 1),
 CS4236_DOUBLE("Mic Playback Switch", 0,
 		CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 6, 6, 1, 1),
-CS4236_SINGLE("Mic Volume", 0, CS4236_LEFT_MIC, 0, 31, 1),
+CS4236_SINGLE_TLV("Mic Volume", 0, CS4236_LEFT_MIC, 0, 31, 1,
+		  db_scale_5bit_22db_max),
 CS4236_SINGLE("Mic Boost (+20dB)", 0, CS4236_LEFT_MIC, 5, 1, 0),
 
 WSS_DOUBLE("Line Playback Switch", 0,
 		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
 WSS_DOUBLE("Line Capture Switch", 0,
 		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 6, 6, 1, 1),
-WSS_DOUBLE("Line Volume", 0,
-		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
+WSS_DOUBLE_TLV("Line Volume", 0,
+		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1,
+		db_scale_5bit_12db_max),
 
 WSS_DOUBLE("CD Playback Switch", 1,
 		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
 WSS_DOUBLE("CD Capture Switch", 1,
 		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 6, 6, 1, 1),
-WSS_DOUBLE("CD Volume", 1,
-		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
+WSS_DOUBLE_TLV("CD Volume", 1,
+		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1,
+		db_scale_5bit_12db_max),
 
 CS4236_DOUBLE1("Beep Playback Switch", 0,
 		CS4231_MONO_CTRL, CS4236_LEFT_MIX_CTRL, 7, 7, 1, 1),
-- 
1.6.4


----------------------------------------------------------------------
Najlepsze oferty Sylwestrowe!
Sprawdz >>> http://link.interia.pl/f2426
