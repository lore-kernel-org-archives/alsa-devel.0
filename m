From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 2/3] sb_mixer: Autodetect optional SB16 mixer
	controls
Date: Tue, 22 May 2012 21:44:55 +0200
Message-ID: <201205222145.00058.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1-out2.atlantis.sk [80.94.52.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 58AAA104148
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2012 21:45:20 +0200 (CEST)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tone (bass/treble), gain and 3D mixer controls are not present on all SB16 cards.

This attempts to detect chip type and enable them only if they're really present.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- a/sound/isa/sb/sb_mixer.c
+++ b/sound/isa/sb/sb_mixer.c
@@ -592,10 +592,6 @@ static struct sbmix_elem snd_sb16_controls[] = {
 	SB_SINGLE("Mic Playback Switch", SB_DSP4_OUTPUT_SW, 0, 1),
 	SB_SINGLE("Mic Volume", SB_DSP4_MIC_DEV, 3, 31),
 	SB_SINGLE("Beep Volume", SB_DSP4_SPEAKER_DEV, 6, 3),
-	SB_DOUBLE("Gain Capture Volume",
-		  SB_DSP4_IGAIN_DEV, (SB_DSP4_IGAIN_DEV + 1), 6, 6, 3),
-	SB_DOUBLE("Gain Playback Volume",
-		  SB_DSP4_OGAIN_DEV, (SB_DSP4_OGAIN_DEV + 1), 6, 6, 3),
 	SB16_INPUT_SW("Line Capture Route",
 		      SB_DSP4_INPUT_LEFT, SB_DSP4_INPUT_RIGHT, 4, 3),
 	SB_DOUBLE("Line Playback Switch",
@@ -603,13 +599,25 @@ static struct sbmix_elem snd_sb16_controls[] = {
 	SB_DOUBLE("Line Volume",
 		  SB_DSP4_LINE_DEV, (SB_DSP4_LINE_DEV + 1), 3, 3, 31),
 	SB_SINGLE("Mic Auto Gain", SB_DSP4_MIC_AGC, 0, 1),
-	SB_SINGLE("3D Control - Switch", SB_DSP4_3DSE, 0, 1),
+};
+
+static struct sbmix_elem snd_sb16_tone_ctls[] = {
 	SB_DOUBLE("Tone Control - Bass",
 		  SB_DSP4_BASS_DEV, (SB_DSP4_BASS_DEV + 1), 4, 4, 15),
 	SB_DOUBLE("Tone Control - Treble",
-		  SB_DSP4_TREBLE_DEV, (SB_DSP4_TREBLE_DEV + 1), 4, 4, 15)
+		  SB_DSP4_TREBLE_DEV, (SB_DSP4_TREBLE_DEV + 1), 4, 4, 15),
+};
+
+static struct sbmix_elem snd_sb16_gain_ctls[] = {
+	SB_DOUBLE("Gain Capture Volume",
+		  SB_DSP4_IGAIN_DEV, (SB_DSP4_IGAIN_DEV + 1), 6, 6, 3),
+	SB_DOUBLE("Gain Playback Volume",
+		  SB_DSP4_OGAIN_DEV, (SB_DSP4_OGAIN_DEV + 1), 6, 6, 3),
 };
 
+static struct sbmix_elem snd_sb16_3d_ctl =
+	SB_SINGLE("3D Control - Switch", SB_DSP4_3DSE, 0, 1);
+
 static unsigned char snd_sb16_init_values[][2] = {
 	{ SB_DSP4_MASTER_DEV + 0, 0 },
 	{ SB_DSP4_MASTER_DEV + 1, 0 },
@@ -720,6 +728,71 @@ static unsigned char snd_als4000_init_values[][2] = {
 	{ SB_ALS4000_MIC_IN_GAIN, 0 },
 };
 
+static int snd_sbmixer_sb16_opt_init(struct snd_sb *chip)
+{
+	int idx, err;
+	enum { CLASSIC, CT2504, CT2505, CT2511, CT8903, CT8920 } sb16_type;
+	/*
+	   The detection is a mess because some chips have registers that
+	   appear to work (read/write) but don't do anything. This applies
+	   mainly to tone controls which are present on all SB16 cards but
+	   do nothing on all Vibra chips except CT2502. Also CT8903 appears to
+	   have additional switch registers but they have no effect too.
+	   CT8920 has non-working gain.
+
+	   This tries to detect chip type. CLASSIC means older non-integrated
+	   cards (CT1746/CT1747/CT1749 + CT1745 mixer).
+	   No detection code for CT2501 Vibra 16, CT2502 Vibra 16Pro,
+	   CT2508 Vibra 16CL and CT2510 Vibra 16X (lack of HW for testing).
+	*/
+	sb16_type = CLASSIC;
+	if (snd_sbmixer_read(chip, SB_DSP4_IRQSTATUS) & 0x40) {
+		/* read chip ID (only present on newer (PnP?) chips) */
+		u16 id = snd_sbmixer_read(chip, 0xfd) |
+			 snd_sbmixer_read(chip, 0xfe) << 8;
+		printk("sb16 id=0x%04x\n", id);
+		switch (id) {
+		case 0xffff:	/* No ID? Assume CT2504 Vibra 16S */
+			sb16_type = CT2504;
+			break;
+		case 0x0721:	/* CT2505 Vibra 16C */
+			sb16_type = CT2505;
+			break;
+		case 0x0810:	/* CT2511 Vibra 16XV */
+			sb16_type = CT2511;
+			break;
+		case 0x1190:	/* CT8903 AWE64 */
+			sb16_type = CT8903;
+			break;
+		case 0x1241:	/* CT8920 AWE64 */
+			sb16_type = CT8920;
+			break;
+		}
+	}
+	/* tone controls */
+	if (sb16_type == CLASSIC || sb16_type == CT8903 || sb16_type == CT8920)
+		for (idx = 0; idx < ARRAY_SIZE(snd_sb16_tone_ctls); idx++) {
+			err = snd_sbmixer_add_ctl_elem(chip, &snd_sb16_tone_ctls[idx]);
+			if (err < 0)
+				return err;
+		}
+	/* gain */
+	if (sb16_type == CLASSIC || sb16_type == CT8903)
+		for (idx = 0; idx < ARRAY_SIZE(snd_sb16_gain_ctls); idx++) {
+			err = snd_sbmixer_add_ctl_elem(chip, &snd_sb16_gain_ctls[idx]);
+			if (err < 0)
+				return err;
+		}
+	/* 3D Stereo Enhancement */
+	if (snd_sbmixer_read(chip, SB_DSP4_3DSE) != 0xff) {
+		err = snd_sbmixer_add_ctl_elem(chip, &snd_sb16_3d_ctl);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 /*
  */
 static int snd_sbmixer_init(struct snd_sb *chip,
@@ -750,6 +823,14 @@ static int snd_sbmixer_init(struct snd_sb *chip,
 		if (err < 0)
 			return err;
 	}
+
+	/* detect optional SB16 controls */
+	if (controls == snd_sb16_controls) {
+		err = snd_sbmixer_sb16_opt_init(chip);
+		if (err < 0)
+			return err;
+	}
+
 	snd_component_add(card, name);
 	strcpy(card->mixername, name);
 	return 0;

-- 
Ondrej Zary
