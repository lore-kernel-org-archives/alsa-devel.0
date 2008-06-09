From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 1/2] opti93x: add support for Opti93x codec in
	cs4231-lib
Date: Mon, 9 Jun 2008 23:07:28 +0200
Message-ID: <20080609230728.273c9e1e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 8490D249F9
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jun 2008 23:04:50 +0200 (CEST)
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
Cc: Rene Herman <rene.herman@keyaccess.nl>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds support for WSS compatible Opti93x
codec to the cs4231-lib.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
This patch was sent some time ago but was not accepted
due to regression of the driver on the  opti 930 chip.
The regression is fixed with already accepted patch, so 
it should work now. 
The patch was prepared against the 2.6.26-rc5 kernel.
Tested on Opti 930, 931 and 933.

The previous repost:
http://mailman.alsa-project.org/pipermail/alsa-devel/2008-January/005679.html

diff -urp linux-rc2/include/sound/cs4231-regs.h linux-rc5/include/sound/cs4231-regs.h
--- linux-rc2/include/sound/cs4231-regs.h	2008-04-17 04:49:44.000000000 +0200
+++ linux-rc5/include/sound/cs4231-regs.h	2008-06-08 00:33:55.041903713 +0200
@@ -177,4 +177,12 @@
 #define CS4236_RIGHT_WAVE	0x1c	/* right wavetable serial port volume */
 #define CS4236_VERSION		0x9c	/* chip version and ID */
 
+/* definitions for extended registers - OPTI93X */
+#define OPTi931_AUX_LEFT_INPUT	0x10
+#define OPTi931_AUX_RIGHT_INPUT	0x11
+#define OPTi93X_MIC_LEFT_INPUT	0x14
+#define OPTi93X_MIC_RIGHT_INPUT	0x15
+#define OPTi93X_OUT_LEFT	0x16
+#define OPTi93X_OUT_RIGHT	0x17
+
 #endif /* __SOUND_CS4231_REGS_H */
diff -urp linux-rc2/include/sound/cs4231.h linux-rc5/include/sound/cs4231.h
--- linux-rc2/include/sound/cs4231.h	2008-04-17 04:49:44.000000000 +0200
+++ linux-rc5/include/sound/cs4231.h	2008-06-08 00:35:54.808064369 +0200
@@ -58,6 +58,7 @@
 /* compatible, but clones */
 #define CS4231_HW_INTERWAVE     0x1000	/* InterWave chip */
 #define CS4231_HW_OPL3SA2       0x1101	/* OPL3-SA2 chip, similar to cs4231 */
+#define CS4231_HW_OPTI93X 	0x1102	/* Opti 930/931/933 */
 
 /* defines for codec.hwshare */
 #define CS4231_HWSHARE_IRQ	(1<<0)
@@ -120,6 +121,8 @@ unsigned char snd_cs4236_ext_in(struct s
 void snd_cs4231_mce_up(struct snd_cs4231 *chip);
 void snd_cs4231_mce_down(struct snd_cs4231 *chip);
 
+void snd_cs4231_overrange(struct snd_cs4231 *chip);
+
 irqreturn_t snd_cs4231_interrupt(int irq, void *dev_id);
 
 const char *snd_cs4231_chip_id(struct snd_cs4231 *chip);
diff -urp linux-rc2/sound/isa/cs423x/cs4231_lib.c linux-rc5/sound/isa/cs423x/cs4231_lib.c
--- linux-rc2/sound/isa/cs423x/cs4231_lib.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-rc5/sound/isa/cs423x/cs4231_lib.c	2008-06-08 00:38:32.130878968 +0200
@@ -119,6 +119,42 @@ static unsigned char snd_cs4231_original
 	0x00,			/* 1f/31 - cbrl */
 };
 
+static unsigned char snd_opti93x_original_image[32] =
+{
+	0x00,		/* 00/00 - l_mixout_outctrl */
+	0x00,		/* 01/01 - r_mixout_outctrl */
+	0x88,		/* 02/02 - l_cd_inctrl */
+	0x88,		/* 03/03 - r_cd_inctrl */
+	0x88,		/* 04/04 - l_a1/fm_inctrl */
+	0x88,		/* 05/05 - r_a1/fm_inctrl */
+	0x80,		/* 06/06 - l_dac_inctrl */
+	0x80,		/* 07/07 - r_dac_inctrl */
+	0x00,		/* 08/08 - ply_dataform_reg */
+	0x00,		/* 09/09 - if_conf */
+	0x00,		/* 0a/10 - pin_ctrl */
+	0x00,		/* 0b/11 - err_init_reg */
+	0x0a,		/* 0c/12 - id_reg */
+	0x00,		/* 0d/13 - reserved */
+	0x00,		/* 0e/14 - ply_upcount_reg */
+	0x00,		/* 0f/15 - ply_lowcount_reg */
+	0x88,		/* 10/16 - reserved/l_a1_inctrl */
+	0x88,		/* 11/17 - reserved/r_a1_inctrl */
+	0x88,		/* 12/18 - l_line_inctrl */
+	0x88,		/* 13/19 - r_line_inctrl */
+	0x88,		/* 14/20 - l_mic_inctrl */
+	0x88,		/* 15/21 - r_mic_inctrl */
+	0x80,		/* 16/22 - l_out_outctrl */
+	0x80,		/* 17/23 - r_out_outctrl */
+	0x00,		/* 18/24 - reserved */
+	0x00,		/* 19/25 - reserved */
+	0x00,		/* 1a/26 - reserved */
+	0x00,		/* 1b/27 - reserved */
+	0x00,		/* 1c/28 - cap_dataform_reg */
+	0x00,		/* 1d/29 - reserved */
+	0x00,		/* 1e/30 - cap_upcount_reg */
+	0x00		/* 1f/31 - cap_lowcount_reg */
+};
+
 /*
  *  Basic I/O functions
  */
@@ -895,7 +931,7 @@ static int snd_cs4231_capture_prepare(st
 	return 0;
 }
 
-static void snd_cs4231_overrange(struct snd_cs4231 *chip)
+void snd_cs4231_overrange(struct snd_cs4231 *chip)
 {
 	unsigned long flags;
 	unsigned char res;
@@ -1054,8 +1090,11 @@ static int snd_cs4231_probe(struct snd_c
 	chip->image[CS4231_IFACE_CTRL] =
 	    (chip->image[CS4231_IFACE_CTRL] & ~CS4231_SINGLE_DMA) |
 	    (chip->single_dma ? CS4231_SINGLE_DMA : 0);
-	chip->image[CS4231_ALT_FEATURE_1] = 0x80;
-	chip->image[CS4231_ALT_FEATURE_2] = chip->hardware == CS4231_HW_INTERWAVE ? 0xc2 : 0x01;
+	if (chip->hardware != CS4231_HW_OPTI93X) {
+		chip->image[CS4231_ALT_FEATURE_1] = 0x80;
+		chip->image[CS4231_ALT_FEATURE_2] =
+			chip->hardware == CS4231_HW_INTERWAVE ? 0xc2 : 0x01;
+	}
 	ptr = (unsigned char *) &chip->image;
 	snd_cs4231_mce_down(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
@@ -1376,6 +1415,7 @@ const char *snd_cs4231_chip_id(struct sn
 	case CS4231_HW_INTERWAVE: return "AMD InterWave";
 	case CS4231_HW_OPL3SA2: return chip->card->shortname;
 	case CS4231_HW_AD1845: return "AD1845";
+	case CS4231_HW_OPTI93X: return "OPTi 93x";
 	default: return "???";
 	}
 }
@@ -1401,8 +1441,13 @@ static int snd_cs4231_new(struct snd_car
 	chip->rate_constraint = snd_cs4231_xrate;
 	chip->set_playback_format = snd_cs4231_playback_format;
 	chip->set_capture_format = snd_cs4231_capture_format;
-        memcpy(&chip->image, &snd_cs4231_original_image, sizeof(snd_cs4231_original_image));
-        
+	if (chip->hardware == CS4231_HW_OPTI93X)
+		memcpy(&chip->image, &snd_opti93x_original_image,
+		       sizeof(snd_opti93x_original_image));
+	else
+		memcpy(&chip->image, &snd_cs4231_original_image,
+		       sizeof(snd_cs4231_original_image));
+
         *rchip = chip;
         return 0;
 }
@@ -1790,6 +1835,48 @@ CS4231_SINGLE("Loopback Capture Switch",
 CS4231_SINGLE("Loopback Capture Volume", 0, CS4231_LOOPBACK, 2, 63, 1)
 };
                                         
+static struct snd_kcontrol_new snd_opti93x_controls[] = {
+CS4231_DOUBLE("Master Playback Switch", 0,
+	      OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 7, 7, 1, 1),
+CS4231_DOUBLE("Master Playback Volume", 0,
+	      OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 1, 1, 31, 1),
+CS4231_DOUBLE("PCM Playback Switch", 0,
+	      CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("PCM Playback Volume", 0,
+	      CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 31, 1),
+CS4231_DOUBLE("FM Playback Switch", 0,
+	      CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("FM Playback Volume", 0,
+	      CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 1, 1, 15, 1),
+CS4231_DOUBLE("Line Playback Switch", 0,
+	      CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
+CS4231_DOUBLE("Line Playback Volume", 0,
+	      CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 15, 1),
+CS4231_DOUBLE("Mic Playback Switch", 0,
+	      OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("Mic Playback Volume", 0,
+	      OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 1, 1, 15, 1),
+CS4231_DOUBLE("Mic Boost", 0,
+	      CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 5, 5, 1, 0),
+CS4231_DOUBLE("CD Playback Switch", 0,
+	      CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("CD Playback Volume", 0,
+	      CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 1, 1, 15, 1),
+CS4231_DOUBLE("Aux Playback Switch", 0,
+	      OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("Aux Playback Volume", 0,
+	      OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 1, 1, 15, 1),
+CS4231_DOUBLE("Capture Volume", 0,
+	      CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0, 15, 0),
+{
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Capture Source",
+	.info = snd_cs4231_info_mux,
+	.get = snd_cs4231_get_mux,
+	.put = snd_cs4231_put_mux,
+}
+};
+
 int snd_cs4231_mixer(struct snd_cs4231 *chip)
 {
 	struct snd_card *card;
@@ -1802,10 +1889,22 @@ int snd_cs4231_mixer(struct snd_cs4231 *
 
 	strcpy(card->mixername, chip->pcm->name);
 
-	for (idx = 0; idx < ARRAY_SIZE(snd_cs4231_controls); idx++) {
-		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_cs4231_controls[idx], chip))) < 0)
-			return err;
-	}
+	if (chip->hardware == CS4231_HW_OPTI93X)
+		for (idx = 0; idx < ARRAY_SIZE(snd_opti93x_controls); idx++) {
+			err = snd_ctl_add(card,
+					snd_ctl_new1(&snd_opti93x_controls[idx],
+						     chip));
+			if (err < 0)
+				return err;
+		}
+	else
+		for (idx = 0; idx < ARRAY_SIZE(snd_cs4231_controls); idx++) {
+			err = snd_ctl_add(card,
+					snd_ctl_new1(&snd_cs4231_controls[idx],
+						     chip));
+			if (err < 0)
+				return err;
+		}
 	return 0;
 }
 
@@ -1815,6 +1914,7 @@ EXPORT_SYMBOL(snd_cs4236_ext_out);
 EXPORT_SYMBOL(snd_cs4236_ext_in);
 EXPORT_SYMBOL(snd_cs4231_mce_up);
 EXPORT_SYMBOL(snd_cs4231_mce_down);
+EXPORT_SYMBOL(snd_cs4231_overrange);
 EXPORT_SYMBOL(snd_cs4231_interrupt);
 EXPORT_SYMBOL(snd_cs4231_chip_id);
 EXPORT_SYMBOL(snd_cs4231_create);

---------------------------------------------------------------
Sprawdz jak zdobyc zdrowy usmiech!
Kliknij >> http://link.interia.pl/f1e26
