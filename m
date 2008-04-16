From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: [PATCH 002b/003] snd-powermac: style awacs.s and
	awacs.h
Date: Wed, 16 Apr 2008 10:02:38 +0300
Message-ID: <46e1c7760804160002j6d24d074qbb2192280ab23d4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 24F6E1037F9
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Apr 2008 09:02:39 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so662171ana.80
	for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2008 00:02:38 -0700 (PDT)
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

Coding style corrections for awacs.c and awacs.h.

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
Kernel version 2.6.25-rc8 (probably any 2.6)

--- sound/ppc/awacs.c.orig	2008-04-05 17:45:08.000000000 +0300
+++ sound/ppc/awacs.c	2008-04-07 11:24:08.108621048 +0300
@@ -141,7 +141,7 @@ static int snd_pmac_awacs_info_volume(st
 	uinfo->value.integer.max = 15;
 	return 0;
 }
-
+
 static int snd_pmac_awacs_get_volume(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
@@ -267,7 +267,8 @@ static int snd_pmac_awacs_put_switch(str
 static void awacs_set_cuda(int reg, int val)
 {
 	struct adb_request req;
-	cuda_request(&req, NULL, 5, CUDA_PACKET, CUDA_GET_SET_IIC, 0x8a, reg, val);
+	cuda_request(&req, NULL, 5, CUDA_PACKET, CUDA_GET_SET_IIC, 0x8a,
+			reg, val);
 	while (! req.complete)
 		cuda_poll();
 }
@@ -289,11 +290,11 @@ static void awacs_amp_set_tone(struct aw
 /*
  * vol = 0 - 31 (attenuation), 32 = mute bit, stereo
  */
-static int awacs_amp_set_vol(struct awacs_amp *amp, int index, int
lvol, int rvol,
-			     int do_check)
+static int awacs_amp_set_vol(struct awacs_amp *amp, int index,
+			     int lvol, int rvol, int do_check)
 {
 	if (do_check && amp->amp_vol[index][0] == lvol &&
-	    amp->amp_vol[index][1] == rvol)
+			amp->amp_vol[index][1] == rvol)
 		return 0;
 	awacs_set_cuda(3 + index, lvol);
 	awacs_set_cuda(5 + index, rvol);
@@ -337,7 +338,7 @@ static int snd_pmac_awacs_info_volume_am
 	uinfo->value.integer.max = 31;
 	return 0;
 }
-
+
 static int snd_pmac_awacs_get_volume_amp(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
@@ -361,8 +362,10 @@ static int snd_pmac_awacs_put_volume_amp
 	snd_assert(amp, return -EINVAL);
 	snd_assert(index >= 0 && index <= 1, return -EINVAL);

-	vol[0] = (31 - (ucontrol->value.integer.value[0] & 31)) |
(amp->amp_vol[index][0] & 32);
-	vol[1] = (31 - (ucontrol->value.integer.value[1] & 31)) |
(amp->amp_vol[index][1] & 32);
+	vol[0] = (31 - (ucontrol->value.integer.value[0] & 31))
+		| (amp->amp_vol[index][0] & 32);
+	vol[1] = (31 - (ucontrol->value.integer.value[1] & 31))
+		| (amp->amp_vol[index][1] & 32);
 	return awacs_amp_set_vol(amp, index, vol[0], vol[1], 1);
 }

@@ -374,8 +377,10 @@ static int snd_pmac_awacs_get_switch_amp
 	struct awacs_amp *amp = chip->mixer_data;
 	snd_assert(amp, return -EINVAL);
 	snd_assert(index >= 0 && index <= 1, return -EINVAL);
-	ucontrol->value.integer.value[0] = (amp->amp_vol[index][0] & 32) ? 0 : 1;
-	ucontrol->value.integer.value[1] = (amp->amp_vol[index][1] & 32) ? 0 : 1;
+	ucontrol->value.integer.value[0] = (amp->amp_vol[index][0] & 32)
+					? 0 : 1;
+	ucontrol->value.integer.value[1] = (amp->amp_vol[index][1] & 32)
+					? 0 : 1;
 	return 0;
 }

@@ -389,8 +394,10 @@ static int snd_pmac_awacs_put_switch_amp
 	snd_assert(amp, return -EINVAL);
 	snd_assert(index >= 0 && index <= 1, return -EINVAL);

-	vol[0] = (ucontrol->value.integer.value[0] ? 0 : 32) |
(amp->amp_vol[index][0] & 31);
-	vol[1] = (ucontrol->value.integer.value[1] ? 0 : 32) |
(amp->amp_vol[index][1] & 31);
+	vol[0] = (ucontrol->value.integer.value[0] ? 0 : 32)
+		| (amp->amp_vol[index][0] & 31);
+	vol[1] = (ucontrol->value.integer.value[1] ? 0 : 32)
+		| (amp->amp_vol[index][1] & 31);
 	return awacs_amp_set_vol(amp, index, vol[0], vol[1], 1);
 }

@@ -403,7 +410,7 @@ static int snd_pmac_awacs_info_tone_amp(
 	uinfo->value.integer.max = 14;
 	return 0;
 }
-
+
 static int snd_pmac_awacs_get_tone_amp(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_value *ucontrol)
 {
@@ -445,7 +452,7 @@ static int snd_pmac_awacs_info_master_am
 	uinfo->value.integer.max = 99;
 	return 0;
 }
-
+
 static int snd_pmac_awacs_get_master_amp(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
@@ -688,12 +694,14 @@ static struct snd_kcontrol_new snd_pmac_
 /*
  * add new mixer elements to the card
  */
-static int build_mixers(struct snd_pmac *chip, int nums, struct
snd_kcontrol_new *mixers)
+static int build_mixers(struct snd_pmac *chip, int nums,
+			struct snd_kcontrol_new *mixers)
 {
 	int i, err;

 	for (i = 0; i < nums; i++) {
-		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&mixers[i], chip))) < 0)
+		if ((err = snd_ctl_add(chip->card,
+				       snd_ctl_new1(&mixers[i], chip))) < 0)
 			return err;
 	}
 	return 0;
@@ -743,8 +752,10 @@ static void snd_pmac_awacs_resume(struct
 #ifdef PMAC_AMP_AVAIL
 	if (chip->mixer_data) {
 		struct awacs_amp *amp = chip->mixer_data;
-		awacs_amp_set_vol(amp, 0, amp->amp_vol[0][0], amp->amp_vol[0][1], 0);
-		awacs_amp_set_vol(amp, 1, amp->amp_vol[1][0], amp->amp_vol[1][1], 0);
+		awacs_amp_set_vol(amp, 0,
+				  amp->amp_vol[0][0], amp->amp_vol[0][1], 0);
+		awacs_amp_set_vol(amp, 1,
+				  amp->amp_vol[1][0], amp->amp_vol[1][1], 0);
 		awacs_amp_set_tone(amp, amp->amp_tone[0], amp->amp_tone[1]);
 		awacs_amp_set_master(amp, amp->amp_master);
 	}
@@ -849,7 +860,7 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 	chip->awacs_reg[1] = MASK_CMUTE | MASK_AMUTE;
 	/* FIXME: Only machines with external SRS module need MASK_PAROUT */
 	if (chip->has_iic || chip->device_id == 0x5 ||
-	    /*chip->_device_id == 0x8 || */
+	    /* chip->_device_id == 0x8 || */
 	    chip->device_id == 0xb)
 		chip->awacs_reg[1] |= MASK_PAROUT;
 	/* get default volume from nvram */
@@ -860,8 +871,10 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 	chip->awacs_reg[2] = vol;
 	chip->awacs_reg[4] = vol;
 	if (chip->model == PMAC_SCREAMER) {
-		chip->awacs_reg[5] = vol; /* FIXME: screamer has loopthru vol control */
-		chip->awacs_reg[6] = MASK_MIC_BOOST; /* FIXME: maybe should be vol
<< 3 for PCMCIA speaker */
+		/* FIXME: screamer has loopthru vol control */
+		chip->awacs_reg[5] = vol;
+		/* FIXME: maybe should be vol << 3 for PCMCIA speaker */
+		chip->awacs_reg[6] = MASK_MIC_BOOST;
 		chip->awacs_reg[7] = 0;
 	}

@@ -877,7 +890,8 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 			return -ENOMEM;
 		chip->mixer_data = amp;
 		chip->mixer_free = awacs_amp_free;
-		awacs_amp_set_vol(amp, 0, 63, 63, 0); /* mute and zero vol */
+		/* mute and zero vol */
+		awacs_amp_set_vol(amp, 0, 63, 63, 0);
 		awacs_amp_set_vol(amp, 1, 63, 63, 0);
 		awacs_amp_set_tone(amp, 7, 7); /* 0 dB */
 		awacs_amp_set_master(amp, 79); /* 0 dB */
@@ -965,21 +979,25 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 		 * screamer registers.
 		 * in this case, it seems the route C is not used.
 		 */
-		if ((err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_amp_vol),
+		if ((err = build_mixers(chip,
+					ARRAY_SIZE(snd_pmac_awacs_amp_vol),
 					snd_pmac_awacs_amp_vol)) < 0)
 			return err;
 		/* overwrite */
-		chip->master_sw_ctl = snd_ctl_new1(&snd_pmac_awacs_amp_hp_sw, chip);
+		chip->master_sw_ctl = snd_ctl_new1(&snd_pmac_awacs_amp_hp_sw,
+						   chip);
 		if ((err = snd_ctl_add(chip->card, chip->master_sw_ctl)) < 0)
 			return err;
-		chip->speaker_sw_ctl = snd_ctl_new1(&snd_pmac_awacs_amp_spk_sw, chip);
+		chip->speaker_sw_ctl = snd_ctl_new1(&snd_pmac_awacs_amp_spk_sw,
+						    chip);
 		if ((err = snd_ctl_add(chip->card, chip->speaker_sw_ctl)) < 0)
 			return err;
 	} else
 #endif /* PMAC_AMP_AVAIL */
 	{
 		/* route A = headphone, route C = speaker */
-		if ((err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_speaker_vol),
+		if ((err = build_mixers(chip,
+					ARRAY_SIZE(snd_pmac_awacs_speaker_vol),
 					snd_pmac_awacs_speaker_vol)) < 0)
 			return err;
 		chip->speaker_sw_ctl = snd_ctl_new1(imac
@@ -1010,8 +1028,9 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 				snd_pmac_awacs_mic_boost_pmac7500)) < 0)
 			return err;
 	} else {
-		if ((err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_mic_boost),
-					snd_pmac_awacs_mic_boost)) < 0)
+		if ((err = build_mixers(chip,
+				ARRAY_SIZE(snd_pmac_awacs_mic_boost),
+				snd_pmac_awacs_mic_boost)) < 0)
 			return err;
 	}

--- sound/ppc/awacs.h.orig	2008-04-05 17:45:08.000000000 +0300
+++ sound/ppc/awacs.h	2008-04-07 11:26:58.198763416 +0300
@@ -175,7 +175,8 @@ struct awacs_regs {
 /* DBDMA ChannelStatus Bit Masks */
 /* ----- ------------- --- ----- */
 #define MASK_CSERR	(0x1 << 7)	/* Error */
-#define MASK_EOI	(0x1 << 6)	/* End of Input -- only for Input Channel */
+#define MASK_EOI	(0x1 << 6)	/* End of Input --
+					   only for Input Channel */
 #define MASK_CSUNUSED	(0x1f << 1)	/* bits 1-5 not used */
 #define MASK_WAIT	(0x1)		/* Wait */
