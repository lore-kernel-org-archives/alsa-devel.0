From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 3/3] sb_mixer: Add extended SB16 mixer controls
	for newer chips
Date: Tue, 22 May 2012 21:45:04 +0200
Message-ID: <201205222145.08026.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1-out2.atlantis.sk [80.94.52.71])
	by alsa0.perex.cz (Postfix) with ESMTP id C97D624556
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2012 21:45:25 +0200 (CEST)
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

Newer SB16 chips (Vibra 16C and later) have extended mixer controls.
This detects them and enables automatically if present.

Supported extended controls:
Synth Playback Switch
PCM Playback Switch
Beep Playback Switch
Master Playback Switch
PCM Capture Switch
Master Capture Volume
Master Capture Switch

Vibra 16XV has an additional Aux input which is used on
SF16-FMD and SF16-FMD2 cards to connect the onboard FM tuner:
Aux Playback Switch
Aux Volume
Aux Capture Switch

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- a/include/sound/sb.h
+++ b/include/sound/sb.h
@@ -214,6 +214,12 @@ struct snd_sb {
 #define SB_DSP4_IGAIN_DEV	0x3f
 #define SB_DSP4_OGAIN_DEV	0x41
 #define SB_DSP4_MIC_AGC		0x43
+/* extended registers for newer SB16 */
+#define SB_DSP4_OUTPUT2_SW	0x48
+#define SB_DSP4_MASTER_SW	0x49
+#define SB_DSP4_INPUT2_SW	0x4a
+#define SB_DSP4_MASTER_REC_DEV	0x50
+#define SB_DSP4_AUX_DEV		0x52
 
 /* additional registers for SB 16 mixer */
 #define SB_DSP4_IRQSETUP	0x80
--- a/sound/isa/sb/sb_mixer.c
+++ b/sound/isa/sb/sb_mixer.c
@@ -615,6 +615,38 @@ static struct sbmix_elem snd_sb16_gain_ctls[] = {
 		  SB_DSP4_OGAIN_DEV, (SB_DSP4_OGAIN_DEV + 1), 6, 6, 3),
 };
 
+static struct sbmix_elem snd_sb16_output2_ctls[] = {
+	SB_DOUBLE("Synth Playback Switch",
+		  SB_DSP4_OUTPUT2_SW, SB_DSP4_OUTPUT2_SW, 4, 3, 1),
+	SB_DOUBLE("PCM Playback Switch",
+		  SB_DSP4_OUTPUT2_SW, SB_DSP4_OUTPUT2_SW, 2, 1, 1),
+	SB_SINGLE("Beep Playback Switch", SB_DSP4_OUTPUT2_SW, 0, 1),
+};
+
+static struct sbmix_elem snd_sb16_master_sw_ctl =
+	SB_DOUBLE("Master Playback Switch",
+		  SB_DSP4_MASTER_SW, SB_DSP4_MASTER_SW, 3, 2, 1);
+
+static struct sbmix_elem snd_sb16_pcm_capture_sw_ctl =
+	SB_DOUBLE("PCM Capture Switch",
+		  SB_DSP4_INPUT2_SW, SB_DSP4_INPUT2_SW, 1, 0, 1);
+
+static struct sbmix_elem snd_sb16_master_rec_ctls[] = {
+	SB_DOUBLE("Master Capture Volume",
+		  SB_DSP4_MASTER_REC_DEV, (SB_DSP4_MASTER_REC_DEV + 1), 3, 3, 31),
+	SB_DOUBLE("Master Capture Switch",
+		  SB_DSP4_MASTER_SW, SB_DSP4_MASTER_SW, 1, 0, 1),
+};
+
+static struct sbmix_elem snd_sb16_aux_ctls[] = {
+	SB_DOUBLE("Aux Playback Switch",
+		  SB_DSP4_OUTPUT2_SW, SB_DSP4_OUTPUT2_SW, 6, 5, 1),
+	SB_DOUBLE("Aux Volume",
+		  SB_DSP4_AUX_DEV, (SB_DSP4_AUX_DEV + 1), 3, 3, 31),
+	SB_DOUBLE("Aux Capture Switch",
+		  SB_DSP4_INPUT2_SW, SB_DSP4_INPUT2_SW, 3, 2, 1),
+};
+
 static struct sbmix_elem snd_sb16_3d_ctl =
 	SB_SINGLE("3D Control - Switch", SB_DSP4_3DSE, 0, 1);
 
@@ -789,6 +821,43 @@ static int snd_sbmixer_sb16_opt_init(struct snd_sb *chip)
 		if (err < 0)
 			return err;
 	}
+	/* CT8903 has the following registers but they don't do anything */
+	if (sb16_type == CT8903)
+		return 0;
+	/* additional playback switches */
+	if ((snd_sbmixer_read(chip, SB_DSP4_OUTPUT2_SW) & 0x9f) == 0x1f)
+		for (idx = 0; idx < ARRAY_SIZE(snd_sb16_output2_ctls); idx++) {
+			err = snd_sbmixer_add_ctl_elem(chip, &snd_sb16_output2_ctls[idx]);
+			if (err < 0)
+				return err;
+		}
+	/* master playback switch */
+	if ((snd_sbmixer_read(chip, SB_DSP4_MASTER_SW) & 0xfc) == 0x0c) {
+		err = snd_sbmixer_add_ctl_elem(chip, &snd_sb16_master_sw_ctl);
+		if (err < 0)
+			return err;
+	}
+	/* PCM capture switch */
+	snd_sbmixer_write(chip, SB_DSP4_INPUT2_SW, 0xff);
+	if ((snd_sbmixer_read(chip, SB_DSP4_INPUT2_SW) & 0xf3) == 0x03) {
+		err = snd_sbmixer_add_ctl_elem(chip, &snd_sb16_pcm_capture_sw_ctl);
+		if (err < 0)
+			return err;
+	}
+	/* master capture volume + switch (CT2511) */
+	if (snd_sbmixer_read(chip, SB_DSP4_MASTER_REC_DEV) == 0xe0)
+		for (idx = 0; idx < ARRAY_SIZE(snd_sb16_master_rec_ctls); idx++) {
+			err = snd_sbmixer_add_ctl_elem(chip, &snd_sb16_master_rec_ctls[idx]);
+			if (err < 0)
+				return err;
+		}
+	/* Aux input + switches (CT2511) */
+	if (snd_sbmixer_read(chip, SB_DSP4_AUX_DEV) == 0xc0)
+		for (idx = 0; idx < ARRAY_SIZE(snd_sb16_aux_ctls); idx++) {
+			err = snd_sbmixer_add_ctl_elem(chip, &snd_sb16_aux_ctls[idx]);
+			if (err < 0)
+				return err;
+		}
 
 	return 0;
 }

-- 
Ondrej Zary
