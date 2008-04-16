From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: [PATCH 002a/003] snd-powermac: AWACS and Screamer
	mixers for PM7500, Beige, and iMac SL
Date: Wed, 16 Apr 2008 10:02:08 +0300
Message-ID: <46e1c7760804160002q4a0e3214uae3aa0fca0322c7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 743031037F9
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Apr 2008 09:02:09 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so662171ana.80
	for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2008 00:02:08 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Risto Suominen <Risto.Suominen@gmail.com>

Add mixer controls and correct headphone detection bits for PowerMacs
7300/7500 (AWACS) and G3 Beige (Screamer), and iMac G3 Slot-loading
(Screamer).

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
Kernel version 2.6.25-rc8 (probably any 2.6)

--- sound/ppc/awacs.c.orig	2008-04-05 17:45:08.000000000 +0300
+++ sound/ppc/awacs.c	2008-04-07 11:24:08.108621048 +0300
@@ -493,14 +500,14 @@ static struct snd_kcontrol_new snd_pmac_
 	  .private_value = AMP_CH_HD,
 	},
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	  .name = "Tone Control - Bass",
+	  .name = "Tone Control - Bass Playback Volume",
 	  .info = snd_pmac_awacs_info_tone_amp,
 	  .get = snd_pmac_awacs_get_tone_amp,
 	  .put = snd_pmac_awacs_put_tone_amp,
 	  .private_value = 0,
 	},
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	  .name = "Tone Control - Treble",
+	  .name = "Tone Control - Treble Playback Volume",
 	  .info = snd_pmac_awacs_info_tone_amp,
 	  .get = snd_pmac_awacs_get_tone_amp,
 	  .put = snd_pmac_awacs_put_tone_amp,
@@ -544,7 +551,7 @@ static int snd_pmac_screamer_mic_boost_i
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 2;
+	uinfo->value.integer.max = 3;
 	return 0;
 }

@@ -552,16 +559,14 @@ static int snd_pmac_screamer_mic_boost_g
 					   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
-	int val;
+	int val = 0;
 	unsigned long flags;

 	spin_lock_irqsave(&chip->reg_lock, flags);
 	if (chip->awacs_reg[6] & MASK_MIC_BOOST)
-		val = 2;
-	else if (chip->awacs_reg[0] & MASK_GAINLINE)
-		val = 1;
-	else
-		val = 0;
+		val |= 2;
+	if (chip->awacs_reg[0] & MASK_GAINLINE)
+		val |= 1;
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	ucontrol->value.integer.value[0] = val;
 	return 0;
@@ -578,11 +583,10 @@ static int snd_pmac_screamer_mic_boost_p
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	val0 = chip->awacs_reg[0] & ~MASK_GAINLINE;
 	val6 = chip->awacs_reg[6] & ~MASK_MIC_BOOST;
-	if (ucontrol->value.integer.value[0] > 0) {
+	if (ucontrol->value.integer.value[0] & 1)
 		val0 |= MASK_GAINLINE;
-		if (ucontrol->value.integer.value[0] > 1)
-			val6 |= MASK_MIC_BOOST;
-	}
+	if (ucontrol->value.integer.value[0] & 2)
+		val6 |= MASK_MIC_BOOST;
 	if (val0 != chip->awacs_reg[0]) {
 		snd_pmac_awacs_write_reg(chip, 0, val0);
 		changed = 1;
@@ -599,9 +603,32 @@ static int snd_pmac_screamer_mic_boost_p
  * lists of mixer elements
  */
 static struct snd_kcontrol_new snd_pmac_awacs_mixers[] __initdata = {
-	AWACS_VOLUME("Master Playback Volume", 2, 6, 1),
 	AWACS_SWITCH("Master Capture Switch", 1, SHIFT_LOOPTHRU, 0),
-	AWACS_VOLUME("Capture Volume", 0, 4, 0),
+	AWACS_VOLUME("Master Capture Volume", 0, 4, 0),
+/*	AWACS_SWITCH("Unknown Playback Switch", 6, SHIFT_PAROUT0, 0), */
+};
+
+static struct snd_kcontrol_new snd_pmac_screamer_mixers_beige[] __initdata = {
+	AWACS_VOLUME("Master Playback Volume", 2, 6, 1),
+	AWACS_VOLUME("Play-through Playback Volume", 5, 6, 1),
+	AWACS_SWITCH("Line Capture Switch", 0, SHIFT_MUX_MIC, 0),
+	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_LINE, 0),
+};
+
+static struct snd_kcontrol_new snd_pmac_screamer_mixers_imac[] __initdata = {
+	AWACS_VOLUME("Line out Playback Volume", 2, 6, 1),
+	AWACS_VOLUME("Master Playback Volume", 5, 6, 1),
+	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
+};
+
+static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac7500[] __initdata = {
+	AWACS_VOLUME("Line out Playback Volume", 2, 6, 1),
+	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
+	AWACS_SWITCH("Line Capture Switch", 0, SHIFT_MUX_MIC, 0),
+};
+
+static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac[] __initdata = {
+	AWACS_VOLUME("Master Playback Volume", 2, 6, 1),
 	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
 };

@@ -621,25 +648,49 @@ static struct snd_kcontrol_new snd_pmac_
 static struct snd_kcontrol_new snd_pmac_awacs_master_sw __initdata =
 AWACS_SWITCH("Master Playback Switch", 1, SHIFT_HDMUTE, 1);

+static struct snd_kcontrol_new snd_pmac_awacs_master_sw_imac __initdata =
+AWACS_SWITCH("Line out Playback Switch", 1, SHIFT_HDMUTE, 1);
+
 static struct snd_kcontrol_new snd_pmac_awacs_mic_boost[] __initdata = {
-	AWACS_SWITCH("Mic Boost", 0, SHIFT_GAINLINE, 0),
+	AWACS_SWITCH("Mic Boost Capture Switch", 0, SHIFT_GAINLINE, 0),
 };

 static struct snd_kcontrol_new snd_pmac_screamer_mic_boost[] __initdata = {
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	  .name = "Mic Boost",
+	  .name = "Mic Boost Capture Volume",
 	  .info = snd_pmac_screamer_mic_boost_info,
 	  .get = snd_pmac_screamer_mic_boost_get,
 	  .put = snd_pmac_screamer_mic_boost_put,
 	},
 };

+static struct snd_kcontrol_new snd_pmac_awacs_mic_boost_pmac7500[] __initdata =
+{
+	AWACS_SWITCH("Line Boost Capture Switch", 0, SHIFT_GAINLINE, 0),
+};
+
+static struct snd_kcontrol_new snd_pmac_screamer_mic_boost_beige[] __initdata =
+{
+	AWACS_SWITCH("Line Boost Capture Switch", 0, SHIFT_GAINLINE, 0),
+	AWACS_SWITCH("CD Boost Capture Switch", 6, SHIFT_MIC_BOOST, 0),
+};
+
+static struct snd_kcontrol_new snd_pmac_screamer_mic_boost_imac[] __initdata =
+{
+	AWACS_SWITCH("Line Boost Capture Switch", 0, SHIFT_GAINLINE, 0),
+	AWACS_SWITCH("Mic Boost Capture Switch", 6, SHIFT_MIC_BOOST, 0),
+};
+
 static struct snd_kcontrol_new snd_pmac_awacs_speaker_vol[] __initdata = {
 	AWACS_VOLUME("PC Speaker Playback Volume", 4, 6, 1),
 };
+
 static struct snd_kcontrol_new snd_pmac_awacs_speaker_sw __initdata =
 AWACS_SWITCH("PC Speaker Playback Switch", 1, SHIFT_SPKMUTE, 1);

+static struct snd_kcontrol_new snd_pmac_awacs_speaker_sw_imac __initdata =
+AWACS_SWITCH("PC Speaker Playback Switch", 1, SHIFT_PAROUT1, 0);
+

 /*
  * add new mixer elements to the card
@@ -708,6 +763,14 @@ static void snd_pmac_awacs_resume(struct
 }
 #endif /* CONFIG_PM */

+#define IS_PM7500 (machine_is_compatible("AAPL,7500"))
+#define IS_BEIGE (machine_is_compatible("AAPL,Gossamer"))
+#define IS_IMAC (machine_is_compatible("PowerMac2,1") \
+		|| machine_is_compatible("PowerMac2,2") \
+		|| machine_is_compatible("PowerMac4,1"))
+
+static int imac;
+
 #ifdef PMAC_SUPPORT_AUTOMUTE
 /*
  * auto-mute stuffs
@@ -750,9 +813,16 @@ static void snd_pmac_awacs_update_automu
 		} else
 #endif
 		{
-			int reg = chip->awacs_reg[1] | (MASK_HDMUTE|MASK_SPKMUTE);
+			int reg = chip->awacs_reg[1]
+				| (MASK_HDMUTE | MASK_SPKMUTE);
+			if (imac) {
+				reg &= ~MASK_SPKMUTE;
+				reg &= ~MASK_PAROUT1;
+			}
 			if (snd_pmac_awacs_detect_headphone(chip))
 				reg &= ~MASK_HDMUTE;
+			else if (imac)
+				reg |= MASK_PAROUT1;
 			else
 				reg &= ~MASK_SPKMUTE;
 			if (do_notify && reg == chip->awacs_reg[1])
@@ -778,8 +848,11 @@ static void snd_pmac_awacs_update_automu
 int __init
 snd_pmac_awacs_init(struct snd_pmac *chip)
 {
+	int pm7500 = IS_PM7500;
+	int beige = IS_BEIGE;
 	int err, vol;

+	imac = IS_IMAC;
 	/* looks like MASK_GAINLINE triggers something, so we set here
 	 * as start-up
 	 */
@@ -826,20 +902,25 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 		/* set headphone-jack detection bit */
 		switch (chip->model) {
 		case PMAC_AWACS:
-			chip->hp_stat_mask = 0x04;
+			chip->hp_stat_mask = pm7500 ? MASK_HDPCONN
+				: MASK_LOCONN;
 			break;
 		case PMAC_SCREAMER:
 			switch (chip->device_id) {
 			case 0x08:
-				/* 1 = side jack, 2 = front jack */
-				chip->hp_stat_mask = 0x03;
+			case 0x0B:
+				chip->hp_stat_mask = imac
+					? MASK_LOCONN_IMAC |
+					MASK_HDPLCONN_IMAC |
+					MASK_HDPRCONN_IMAC
+					: MASK_HDPCONN;
 				break;
 			case 0x00:
 			case 0x05:
-				chip->hp_stat_mask = 0x04;
+				chip->hp_stat_mask = MASK_LOCONN;
 				break;
 			default:
-				chip->hp_stat_mask = 0x08;
+				chip->hp_stat_mask = MASK_HDPCONN;
 				break;
 			}
 			break;
@@ -857,15 +938,37 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 	if ((err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_mixers),
 				snd_pmac_awacs_mixers)) < 0)
 		return err;
-	if (chip->model == PMAC_SCREAMER)
+	if (beige)
+		;
+	else if (chip->model == PMAC_SCREAMER)
 		err = build_mixers(chip, ARRAY_SIZE(snd_pmac_screamer_mixers2),
 				   snd_pmac_screamer_mixers2);
-	else
+	else if (!pm7500)
 		err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_mixers2),
 				   snd_pmac_awacs_mixers2);
 	if (err < 0)
 		return err;
-	chip->master_sw_ctl = snd_ctl_new1(&snd_pmac_awacs_master_sw, chip);
+	if (pm7500)
+		err = build_mixers(chip,
+				   ARRAY_SIZE(snd_pmac_awacs_mixers_pmac7500),
+				   snd_pmac_awacs_mixers_pmac7500);
+	else if (beige)
+		err = build_mixers(chip,
+				   ARRAY_SIZE(snd_pmac_screamer_mixers_beige),
+				   snd_pmac_screamer_mixers_beige);
+	else if (imac)
+		err = build_mixers(chip,
+				   ARRAY_SIZE(snd_pmac_screamer_mixers_imac),
+				   snd_pmac_screamer_mixers_imac);
+	else
+		err = build_mixers(chip,
+				   ARRAY_SIZE(snd_pmac_awacs_mixers_pmac),
+				   snd_pmac_awacs_mixers_pmac);
+	if (err < 0)
+		return err;
+	chip->master_sw_ctl = snd_ctl_new1((pm7500 || imac)
+			? &snd_pmac_awacs_master_sw_imac
+			: &snd_pmac_awacs_master_sw, chip);
 	if ((err = snd_ctl_add(chip->card, chip->master_sw_ctl)) < 0)
 		return err;
 #ifdef PMAC_AMP_AVAIL
@@ -893,14 +1000,32 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 		if ((err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_speaker_vol),
 					snd_pmac_awacs_speaker_vol)) < 0)
 			return err;
-		chip->speaker_sw_ctl = snd_ctl_new1(&snd_pmac_awacs_speaker_sw, chip);
+		chip->speaker_sw_ctl = snd_ctl_new1(imac
+				? &snd_pmac_awacs_speaker_sw_imac
+				: &snd_pmac_awacs_speaker_sw, chip);
 		if ((err = snd_ctl_add(chip->card, chip->speaker_sw_ctl)) < 0)
 			return err;
 	}

-	if (chip->model == PMAC_SCREAMER) {
-		if ((err = build_mixers(chip, ARRAY_SIZE(snd_pmac_screamer_mic_boost),
-					snd_pmac_screamer_mic_boost)) < 0)
+	if (beige) {
+		if ((err = build_mixers(chip,
+				ARRAY_SIZE(snd_pmac_screamer_mic_boost_beige),
+				snd_pmac_screamer_mic_boost_beige)) < 0)
+			return err;
+	} else if (imac) {
+		if ((err = build_mixers(chip,
+				ARRAY_SIZE(snd_pmac_screamer_mic_boost_imac),
+				snd_pmac_screamer_mic_boost_imac)) < 0)
+			return err;
+	} else if (chip->model == PMAC_SCREAMER) {
+		if ((err = build_mixers(chip,
+				ARRAY_SIZE(snd_pmac_screamer_mic_boost),
+				snd_pmac_screamer_mic_boost)) < 0)
+			return err;
+	} else if (pm7500) {
+		if ((err = build_mixers(chip,
+				ARRAY_SIZE(snd_pmac_awacs_mic_boost_pmac7500),
+				snd_pmac_awacs_mic_boost_pmac7500)) < 0)
 			return err;
 	} else {
 		if ((err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_mic_boost),
--- sound/ppc/awacs.h.orig	2008-04-05 17:45:08.000000000 +0300
+++ sound/ppc/awacs.h	2008-04-07 11:26:58.198763416 +0300
@@ -116,6 +116,11 @@ struct awacs_regs {
 #define MASK_HDMUTE	MASK_AMUTE
 #define SHIFT_HDMUTE	9
 #define MASK_PAROUT	(0x3 << 10)	/* Parallel Out (???) */
+#define MASK_PAROUT0	(0x1 << 10)	/* Parallel Out (???) */
+#define MASK_PAROUT1	(0x1 << 11)	/* Parallel Out (enable speaker) */
+#define SHIFT_PAROUT	10
+#define SHIFT_PAROUT0	10
+#define SHIFT_PAROUT1	11

 #define SAMPLERATE_48000	(0x0 << 3)	/* 48 or 44.1 kHz */
 #define SAMPLERATE_32000	(0x1 << 3)	/* 32 or 29.4 kHz */
@@ -152,8 +157,15 @@ struct awacs_regs {
 #define MASK_REVISION	(0xf << 12)	/* Revision Number */
 #define MASK_MFGID	(0xf << 8)	/* Mfg. ID */
 #define MASK_CODSTATRES	(0xf << 4)	/* bits 4 - 7 reserved */
-#define MASK_INPPORT	(0xf)		/* Input Port */
-#define MASK_HDPCONN	8		/* headphone plugged in */
+#define MASK_INSENSE	(0xf)		/* port sense bits: */
+#define MASK_HDPCONN		8	/* headphone plugged in */
+#define MASK_LOCONN		4	/* line-out plugged in */
+#define MASK_LICONN		2	/* line-in plugged in */
+#define MASK_MICCONN		1	/* microphone plugged in */
+#define MASK_LICONN_IMAC	8	/* line-in plugged in */
+#define MASK_HDPRCONN_IMAC	4	/* headphone right plugged in */
+#define MASK_HDPLCONN_IMAC	2	/* headphone left plugged in */
+#define MASK_LOCONN_IMAC	1	/* line-out plugged in */

 /* Clipping Count Reg Bit Masks */
 /* -------- ----- --- --- ----- */
