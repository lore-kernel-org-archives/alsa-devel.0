From: John Paul Lorenti <jpl31@columbia.edu>
Subject: Patch to get ali5451 to work on the Sharp MM10
Date: Sun, 18 May 2003 06:53:57 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EC76645.2010303@columbia.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070002030802060302010106"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070002030802060302010106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have a Sharp MM10 laptop and it freezes when I try to load the ali5451 
driver. After no solutions were found on alsa-user, I spent some time 
hacking the driver, and found that commenting out the spdif support 
stopped the freezing without losing any functionality. The laptop has no 
jacks to take advantage of spdif. Attached is a quick and dirty patch 
against  alsa-driver-0.9.3a/alsa-kernel/pci/ali5451/ali5451.c from 
alsa-driver-0.9.3a.tar.bz2 which makes the driver run perfectly for me. 
Maybe one of the developers can clean it up and make some load time 
option out of it.

John Paul


--------------070002030802060302010106
Content-Type: text/plain;
 name="ali5451_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ali5451_patch"

--- ali5451.c	2003-05-18 06:23:21.000000000 -0400
+++ ali5451_terse.c	2003-05-18 06:17:18.000000000 -0400
@@ -673,10 +673,11 @@
 
 	// recording
 	if (rec) {
-		if (inl(ALI_REG(codec, ALI_GLOBAL_CONTROL)) & (1<<11) &&
+	 /*JPL SPDIF	if (inl(ALI_REG(codec, ALI_GLOBAL_CONTROL)) & (1<<11) &&
 			( codec->revision == ALI_5451_V02 ))
 			idx = ALI_SPDIF_IN_CHANNEL;
 		else
+	 JPL SPDIF */		
 			idx = ALI_PCM_IN_CHANNEL;
 
 		if ((result = snd_ali_alloc_pcm_channel(codec,idx)) >= 0) {
@@ -688,6 +689,7 @@
 	}
 
 	//playback...
+        /* JPL SPDIF
 	if (inl(ALI_REG(codec, ALI_GLOBAL_CONTROL)) & (1<<15)) {
 		idx = ALI_SPDIF_OUT_CHANNEL;
 		if ((result = snd_ali_alloc_pcm_channel(codec,idx)) >= 0) {
@@ -696,7 +698,7 @@
 			snd_printk("ali_find_free_channel: S/PDIF out channel is in busy now.\n");
 		}
 	}
-
+	JPL SPDIF */
 	for (idx = 0; idx < ALI_CHANNELS; idx++) {
 		if ((result = snd_ali_alloc_pcm_channel(codec,idx)) >= 0)
 			return result;
@@ -748,6 +750,9 @@
 static void snd_ali_delay(ali_t *codec,int interval)
 {
 	unsigned long  begintimer,currenttimer;
+	printk("In snd_ali_delay\n");
+	/*
+
 
 	begintimer   = inl(ALI_REG(codec, ALI_STIMER));
 	currenttimer = inl(ALI_REG(codec, ALI_STIMER));
@@ -757,6 +762,7 @@
 			break;
 		currenttimer = inl(ALI_REG(codec,  ALI_STIMER));
 	}
+	*/
 }
 
 static void snd_ali_detect_spdif_rate(ali_t *codec)
@@ -764,6 +770,9 @@
 	u16 wval  = 0;
 	u16 count = 0;
 	u8  bval = 0, R1 = 0, R2 = 0;
+	printk("In snd_ali_detect_spdif_rate\n");
+	/*
+
 
 	bval  = inb(ALI_REG(codec,ALI_SPDIF_CTRL + 1));
 	bval |= 0x1F;
@@ -811,12 +820,15 @@
 		bval  = inb(ALI_REG(codec,ALI_SPDIF_CS +3)) & 0xF0;
 		outb(bval|0x03,ALI_REG(codec,ALI_SPDIF_CS + 3));
 	}
+	*/
 }
 
 static unsigned int snd_ali_get_spdif_in_rate(ali_t *codec)
 {
 	u32	dwRate = 0;
 	u8	bval = 0;
+	printk("In snd_ali_get_spdif_in_rate\n");
+	/*
 
 	bval  = inb(ALI_REG(codec,ALI_SPDIF_CTRL));
 	bval &= 0x7F;
@@ -827,7 +839,7 @@
 
 	bval  = inb(ALI_REG(codec,ALI_SPDIF_CS + 3));
 	bval &= 0x0F;
-
+	*/
 	if (bval == 0) dwRate = 44100;
 	if (bval == 1) dwRate = 48000;
 	if (bval == 2) dwRate = 32000;
@@ -838,6 +850,8 @@
 static void snd_ali_enable_spdif_in(ali_t *codec)
 {	
 	unsigned int dwVal;
+	printk("In snd_ali_enable_spdif_in\n");
+	/*
 
 	dwVal = inl(ALI_REG(codec, ALI_GLOBAL_CONTROL));
 	dwVal |= 1<<11;
@@ -848,6 +862,7 @@
 	outb(dwVal, ALI_REG(codec, ALI_SPDIF_CTRL));
 
 	snd_ali_enable_special_channel(codec, ALI_SPDIF_IN_CHANNEL);
+	*/
 }
 
 static void snd_ali_disable_spdif_in(ali_t *codec)
@@ -866,7 +881,8 @@
 {
 	unsigned char  bVal;
 	unsigned int  dwRate = 0;
-	
+		printk("In snd_ali_set_spdif_out_rate\n");
+	/*
 	if (rate == 32000) dwRate = 0x300;
 	if (rate == 44100) dwRate = 0;
 	if (rate == 48000) dwRate = 0x200;
@@ -881,6 +897,7 @@
 	bVal &= (~0x80);	//select left
 	outb(bVal, ALI_REG(codec, ALI_SPDIF_CTRL));
 	outw(rate | 0x10, ALI_REG(codec, ALI_SPDIF_CS + 2));
+	*/
 }
 
 static void snd_ali_enable_spdif_out(ali_t *codec)
@@ -1756,6 +1773,10 @@
 	unsigned long flags;
 	ali_t *codec = snd_magic_cast(ali_t, kcontrol->private_data, -ENXIO);
 	unsigned int enable;
+	printk("In snd_ali5451_spdif_get\n");
+	
+	/*
+
 
 	enable = ucontrol->value.integer.value[0] ? 1 : 0;
 
@@ -1775,12 +1796,18 @@
 	}
 	ucontrol->value.integer.value[0] = enable;
 	spin_unlock_irqrestore(&codec->reg_lock, flags);
+	*/	
 	return 0;
 }
 
 static int snd_ali5451_spdif_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	unsigned long flags;
+	printk("In snd_ali5451_spdif_put\n");
+	return 0;
+	/*
+
+
 	ali_t *codec = snd_magic_cast(ali_t, kcontrol->private_data, -ENXIO);
 	unsigned int change = 0, enable = 0;
 
@@ -1834,6 +1861,7 @@
 	spin_unlock_irqrestore(&codec->reg_lock, flags);
 	
 	return change;
+	*/
 }
 
 static snd_kcontrol_new_t snd_ali5451_mixer_spdif[] __devinitdata = {
@@ -1867,12 +1895,14 @@
 		snd_printk("ali mixer creating error.\n");
 		return err;
 	}
+	/* JPL SPDIF
 	if (codec->revision == ALI_5451_V02) {
 		for(idx = 0; idx < ARRAY_SIZE(snd_ali5451_mixer_spdif); idx++) {
 			err=snd_ctl_add(codec->card, snd_ctl_new1(&snd_ali5451_mixer_spdif[idx], codec));
 			if (err < 0) return err;
 		}
 	}
+	*/
 	return 0;
 }
 
@@ -2039,11 +2069,12 @@
 
 	codec->ac97_ext_id = snd_ali_codec_peek(codec, 0, AC97_EXTENDED_ID);
 	codec->ac97_ext_status = snd_ali_codec_peek(codec, 0, AC97_EXTENDED_STATUS);
+	/* JPL SPDIF
 	if (codec->revision == ALI_5451_V02) {
 		snd_ali_enable_spdif_out(codec);
 		codec->spdif_mask = 0x00000002;
 	}
-
+	*/
 	snd_ali_printk("chip initialize succeed.\n");
 	return 0;
 

--------------070002030802060302010106--



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
