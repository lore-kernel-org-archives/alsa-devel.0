From: Apostolos Dimitromanolakis <apostolos@aei.ca>
Subject: Prodigy 7.1 driver update [snd-ice1724]
Date: Mon, 24 Nov 2003 12:53:47 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FC245AB.8040902@aei.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030809050004050904000400"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030809050004050904000400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

  here's the new revision of the Audiotrak Prodigy 7.1 driver.  The 
driver now initializes correctly for the 24.576Mhz crystal and also I 
have added some more controls for adc oversampling ratio (in theory 
should be changed automatically to 64x at 96Khz sampling rate) and dac 
de-emphasis.

  The initialization sequence of the WM8770 has been modified to reduce 
the pop noise at startup (now it's almost nono-existant). Also the 
volume control updates now only at zero cross automatically to reduce 
again the noise when changing volumes. I think the aureon driver should 
also benefit from these two so I include a patch for the aureon.c too.

 Finally there is some misconception in the aureon & prodigy drivers: 
the codec chip does not have a Master control as it appears at the 
mixer. Instead the master control just updates the 8 volume controls of 
the individual DAC at the same time. Probably the best way is to add a 
virtual master control (ie that we update the volumes of the dac with  
<master attenuation> + <specific channel attenuation> ).

As I wrote some days ago, the default buffer/period rates that 
alsarecord uses at 44.1KHz and lower sampling , locks hard the kernel. 
Have no idea what is it/how to fix it whatsoever.

Apostolis





--------------030809050004050904000400
Content-Type: text/plain;
 name="prodigy-0.82.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prodigy-0.82.patch"

--- /tmp/alsa-cvs.orig/alsa-kernel/pci/ice1712/prodigy.c	2003-11-13 08:34:06.000000000 -0500
+++ /tmp/alsa-cvs.new/alsa-kernel/pci/ice1712/prodigy.c	2003-11-24 12:42:58.000000000 -0500
@@ -5,6 +5,11 @@
  *      Copyright (c) 2003 Dimitromanolakis Apostolos <apostol@cs.utoronto.ca>
  *	based on the aureon.c code (c) 2003 by Takashi Iwai <tiwai@suse.de>
  *
+ *   version 0.82: Stable / not all features work yet (no communication with AC97 secondary)
+ *       added 64x/128x oversampling switch (should be 64x only for 96khz)
+ *       fixed some recording labels (still need to check the rest)
+ *       recording is working probably thanks to correct wm8770 initialization
+ *
  *   version 0.5: Initial release:
  *           working: analog output, mixer, headphone amplifier switch
  *       not working: prety much everything else, at least i could verify that
@@ -42,12 +47,14 @@
  *   if they show better response than DAC analog volumes, we can use them
  *   instead.
  *
- * - Prodigy boards are equipped with AC97 codec, too.  it's used to do
+ * - Prodigy boards are equipped with AC97 STAC9744 chip , too.  it's used to do
  *   the analog mixing but not easily controllable (it's not connected
  *   directly from envy24ht chip).  so let's leave it as it is.
  *
  */
 
+#define REVISION 0.82b
+
 #include <sound/driver.h>
 #include <asm/io.h>
 #include <linux/delay.h>
@@ -65,7 +72,6 @@
 {
 	unsigned int tmp = snd_ice1712_gpio_read(ice);
 
-	tmp &= ~ PRODIGY_HP_AMP_EN;
 	if(enable)
 		tmp |= PRODIGY_HP_AMP_EN;
 	else
@@ -192,18 +198,107 @@
 {
 	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
 
-	/*snd_printk("Prodigy set headphone amplifier: %d\n",ucontrol->value.integer.value[0]);*/
 	prodigy_set_headphone_amp(ice,ucontrol->value.integer.value[0]);
 	return 1;
 }
 
 
+
+#define PRODIGY_CON_DEEMP \
+        {                                            \
+                .iface = SNDRV_CTL_ELEM_IFACE_MIXER,      \
+                .name =  "DAC De-emphasis", \
+                .info =  prodigy_deemp_info,         \
+                .get =   prodigy_deemp_get, \
+                .put =   prodigy_deemp_put  \
+        }
+
+static int prodigy_deemp_info(snd_kcontrol_t *k, snd_ctl_elem_info_t *uinfo)
+{
+	static char *texts[2] = { "Off", "On" };
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+
+        return 0;
+}
+
+static int prodigy_deemp_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	ucontrol->value.integer.value[0] = (wm_get(ice, 0x15) & 0xf) == 0xf;
+	return 0;
+}
+
+static int prodigy_deemp_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	wm_put(ice,0x15,(ucontrol->value.integer.value[0])*0xf);
+	return 1;
+}
+
+
+#define PRODIGY_CON_OVERSAMPLING \
+        {                                            \
+                .iface = SNDRV_CTL_ELEM_IFACE_MIXER,      \
+                .name =  "ADC Oversampling", \
+                .info =  prodigy_oversampling_info,         \
+                .get =   prodigy_oversampling_get, \
+                .put =   prodigy_oversampling_put  \
+        }
+
+static int prodigy_oversampling_info(snd_kcontrol_t *k, snd_ctl_elem_info_t *uinfo)
+{
+	static char *texts[2] = { "128x", "64x"	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+
+        return 0;
+}
+
+static int prodigy_oversampling_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	ucontrol->value.integer.value[0] = (wm_get(ice, 0x17) & 0x8) == 0x8;
+	return 0;
+}
+
+static int prodigy_oversampling_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	int temp;
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+
+	temp = wm_get(ice, 0x17);
+
+	if( ucontrol->value.integer.value[0] ) {
+		temp |= 0x8;
+	} else {
+		temp &= ~0x8;
+	}
+
+	wm_put(ice,0x17,temp);
+	return 1;
+}
+
+
+
+
 /*
  * DAC volume attenuation mixer control
  */
 static int wm_dac_vol_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
 {
-
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
 	uinfo->value.integer.min = 0;		/* mute */
@@ -251,7 +346,7 @@
 		if (nvol <= 0x1a && ovol <= 0x1a)
 			change = 0;
 		else
-			wm_put(ice, idx, nvol | 0x100);
+			wm_put(ice, idx, nvol | 0x180); /* update on zero detect */
 	}
 	snd_ice1712_restore_gpio_status(ice);
 	return change;
@@ -309,10 +404,10 @@
 	static char *texts[] = {
 		"CD Left",
 		"CD Right",
-		"Aux Left",
-		"Aux Right",
 		"Line Left",
 		"Line Right",
+		"Aux Left",
+		"Aux Right",
 		"Mic Left",
 		"Mic Right",
 	};
@@ -393,8 +488,9 @@
 		.get = wm_adc_mux_get,
 		.put = wm_adc_mux_put,
 	},
-PRODIGY_CON_HPAMP
-
+	PRODIGY_CON_HPAMP ,
+	PRODIGY_CON_DEEMP ,
+	PRODIGY_CON_OVERSAMPLING
 };
 
 
@@ -403,8 +499,6 @@
 	unsigned int i;
 	int err;
 
-	// if (ice->eeprom.subvendor == VT1724_SUBDEVICE_PRODIGY71)
-
 	err = snd_ctl_add(ice->card, snd_ctl_new1(&prodigy71_dac_control, ice));
 	if (err < 0)
 		return err;
@@ -424,9 +518,17 @@
 static int __devinit prodigy_init(ice1712_t *ice)
 {
 	static unsigned short wm_inits[] = {
-		0x16, 0x122,		/* I2S, normal polarity, 24bit */
-		0x17, 0x022,		/* 256fs, slave mode */
+
+		/* These come first to reduce init pop noise */
+		0x1b, 0x000,		/* ADC Mux */
+		0x1c, 0x009,		/* Out Mux1 */
+		0x1d, 0x009,		/* Out Mux2 */
+
 		0x18, 0x000,		/* All power-up */
+
+		0x16, 0x022,		/* I2S, normal polarity, 24bit, high-pass on */
+		0x17, 0x006,		/* 128fs, slave mode */
+
 		0x00, 0,		/* DAC1 analog mute */
 		0x01, 0,		/* DAC2 analog mute */
 		0x02, 0,		/* DAC3 analog mute */
@@ -436,34 +538,41 @@
 		0x06, 0,		/* DAC7 analog mute */
 		0x07, 0,		/* DAC8 analog mute */
 		0x08, 0x100,		/* master analog mute */
-		0x09, 0xff,		/* DAC1 digital full */
-		0x0a, 0xff,		/* DAC2 digital full */
-		0x0b, 0xff,		/* DAC3 digital full */
-		0x0c, 0xff,		/* DAC4 digital full */
-		0x0d, 0xff,		/* DAC5 digital full */
-		0x0e, 0xff,		/* DAC6 digital full */
-		0x0f, 0xff,		/* DAC7 digital full */
-		0x10, 0xff,		/* DAC8 digital full */
-		0x11, 0x1ff,		/* master digital full */
+
+		0x09, 0x7f,		/* DAC1 digital full */
+		0x0a, 0x7f,		/* DAC2 digital full */
+		0x0b, 0x7f,		/* DAC3 digital full */
+		0x0c, 0x7f,		/* DAC4 digital full */
+		0x0d, 0x7f,		/* DAC5 digital full */
+		0x0e, 0x7f,		/* DAC6 digital full */
+		0x0f, 0x7f,		/* DAC7 digital full */
+		0x10, 0x7f,		/* DAC8 digital full */
+		0x11, 0x1FF,		/* master digital full */
+
 		0x12, 0x000,		/* phase normal */
 		0x13, 0x090,		/* unmute DAC L/R */
 		0x14, 0x000,		/* all unmute */
 		0x15, 0x000,		/* no deemphasis, no ZFLG */
+
 		0x19, 0x000,		/* -12dB ADC/L */
-		0x1a, 0x000,		/* -12dB ADC/R */
-		0x1b, 0x000,		/* ADC Mux */
-		0x1c, 0x009,		/* Out Mux1 */
-		0x1d, 0x009,		/* Out Mux2 */
+		0x1a, 0x000		/* -12dB ADC/R */
+
 	};
+
 	static unsigned short cs_inits[] = {
 		0x0441, /* RUN */
 		0x0100, /* no mute */
 		0x0200, /* */
 		0x0600, /* slave, 24bit */
 	};
+
 	unsigned int tmp;
 	unsigned int i;
 
+	printk(KERN_INFO "ice1724: AudioTrak Prodigy 7.1 driver rev. 0.82b\n");
+	printk(KERN_INFO "ice1724:   This driver is in beta stage. Forsuccess/failure reporting contact\n");
+	printk(KERN_INFO "ice1724:   Apostolos Dimitromanolakis <apostol@cs.utoronto.ca>\n");
+
 	ice->num_total_dacs = 8;
 
 	/* to remeber the register values */
@@ -507,14 +616,13 @@
 	return 0;
 }
 
-
 /*
  * Prodigy boards don't provide the EEPROM data except for the vendor IDs.
  * hence the driver needs to sets up it properly.
  */
 
 static unsigned char prodigy71_eeprom[] __devinitdata = {
-	0x13,	/* SYSCONF: clock 512, mpu401, spdif-in/ADC, 4DACs */
+	0x2b,	/* SYSCONF: clock 512, mpu401, spdif-in/ADC, 4DACs */
 	0x80,	/* ACLINK: I2S */
 	0xf8,	/* I2S: vol, 96k, 24bit, 192k */
 	0xc3,	/* SPDIF: out-en, out-int, spdif-in */

--------------030809050004050904000400
Content-Type: text/plain;
 name="aureon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aureon.patch"

--- /tmp/alsa-cvs.orig/alsa-kernel/pci/ice1712/aureon.c	2003-09-01 05:20:56.000000000 -0400
+++ /tmp/alsa-cvs.new/alsa-kernel/pci/ice1712/aureon.c	2003-11-23 14:52:48.000000000 -0500
@@ -185,7 +185,7 @@
 		if (nvol <= 0x1a && ovol <= 0x1a)
 			change = 0;
 		else
-			wm_put(ice, idx, nvol | 0x100);
+			wm_put(ice, idx, nvol | 0x180); /* update on zero detect */
 	}
 	snd_ice1712_restore_gpio_status(ice);
 	return change;
@@ -366,9 +366,15 @@
 static int __devinit aureon_init(ice1712_t *ice)
 {
 	static unsigned short wm_inits[] = {
+		/* These come first to reduce init pop noise */
+		0x1b, 0x000,		/* ADC Mux */
+		0x1c, 0x009,		/* Out Mux1 */
+		0x1d, 0x009,		/* Out Mux2 */
+
+		0x18, 0x000,		/* All power-up */
+
 		0x16, 0x122,		/* I2S, normal polarity, 24bit */
 		0x17, 0x022,		/* 256fs, slave mode */
-		0x18, 0x000,		/* All power-up */
 		0x00, 0,		/* DAC1 analog mute */
 		0x01, 0,		/* DAC2 analog mute */
 		0x02, 0,		/* DAC3 analog mute */
@@ -393,9 +399,6 @@
 		0x15, 0x000,		/* no deemphasis, no ZFLG */
 		0x19, 0x000,		/* -12dB ADC/L */
 		0x1a, 0x000,		/* -12dB ADC/R */
-		0x1b, 0x000,		/* ADC Mux */
-		0x1c, 0x009,		/* Out Mux1 */
-		0x1d, 0x009,		/* Out Mux2 */
 	};
 	static unsigned short cs_inits[] = {
 		0x0441, /* RUN */

--------------030809050004050904000400--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
