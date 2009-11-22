From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/2] opti-miro: expose ACI mixer to outside
	drivers
Date: Sun, 22 Nov 2009 17:26:34 +0100
Message-ID: <20091122172634.f051f3ee.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 72CBD2466B
	for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2009 17:25:05 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The ACI mixer is used to control the radio FM module
installed on the Miro PCM20 sound card. Expose ACI mixer
outside the sound card driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
These two patches are enough to implement basic functionality
of the v4l driver for the PCM20's radio tuner.

 include/sound/aci.h      |   17 +++
 sound/isa/opti9xx/miro.c |  250 +++++++++++++++++++++++++++-------------------
 2 files changed, 162 insertions(+), 105 deletions(-)

diff --git a/include/sound/aci.h b/include/sound/aci.h
index bb796d0..ee639d3 100644
--- a/include/sound/aci.h
+++ b/include/sound/aci.h
@@ -70,4 +70,21 @@
 #define ACI_SET_EQ6		0x45
 #define ACI_SET_EQ7		0x46	/* ... to Treble */
 
+struct snd_miro_aci {
+	unsigned long aci_port;
+	int aci_vendor;
+	int aci_product;
+	int aci_version;
+	int aci_amp;
+	int aci_preamp;
+	int aci_solomode;
+
+	struct mutex aci_mutex;
+};
+
+int snd_aci_cmd(struct snd_miro_aci *aci, int write1, int write2, int write3);
+
+struct snd_miro_aci *snd_aci_get_aci(void);
+
 #endif  /* _ACI_H_ */
+
diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 932a067..40b64cd 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -96,7 +96,6 @@ MODULE_PARM_DESC(ide, "enable ide port");
 
 #define OPTi9XX_MC_REG(n)	n
 
-
 struct snd_miro {
 	unsigned short hardware;
 	unsigned char password;
@@ -120,17 +119,11 @@ struct snd_miro {
 	long mpu_port;
 	int mpu_irq;
 
-	unsigned long aci_port;
-	int aci_vendor;
-	int aci_product;
-	int aci_version;
-	int aci_amp;
-	int aci_preamp;
-	int aci_solomode;
-
-	struct mutex aci_mutex;
+	struct snd_miro_aci *aci;
 };
 
+static struct snd_miro_aci aci_device;
+
 static char * snd_opti9xx_names[] = {
 	"unkown",
 	"82C928", "82C929",
@@ -142,13 +135,14 @@ static char * snd_opti9xx_names[] = {
  *  ACI control
  */
 
-static int aci_busy_wait(struct snd_miro * miro)
+static int aci_busy_wait(struct snd_miro_aci *aci)
 {
 	long timeout;
 	unsigned char byte;
 
-	for (timeout = 1; timeout <= ACI_MINTIME+30; timeout++) {
-		if (((byte=inb(miro->aci_port + ACI_REG_BUSY)) & 1) == 0) {
+	for (timeout = 1; timeout <= ACI_MINTIME + 30; timeout++) {
+		byte = inb(aci->aci_port + ACI_REG_BUSY);
+		if ((byte & 1) == 0) {
 			if (timeout >= ACI_MINTIME)
 				snd_printd("aci ready in round %ld.\n",
 					   timeout-ACI_MINTIME);
@@ -174,10 +168,10 @@ static int aci_busy_wait(struct snd_miro * miro)
 	return -EBUSY;
 }
 
-static inline int aci_write(struct snd_miro * miro, unsigned char byte)
+static inline int aci_write(struct snd_miro_aci *aci, unsigned char byte)
 {
-	if (aci_busy_wait(miro) >= 0) {
-		outb(byte, miro->aci_port + ACI_REG_COMMAND);
+	if (aci_busy_wait(aci) >= 0) {
+		outb(byte, aci->aci_port + ACI_REG_COMMAND);
 		return 0;
 	} else {
 		snd_printk(KERN_ERR "aci busy, aci_write(0x%x) stopped.\n", byte);
@@ -185,12 +179,12 @@ static inline int aci_write(struct snd_miro * miro, unsigned char byte)
 	}
 }
 
-static inline int aci_read(struct snd_miro * miro)
+static inline int aci_read(struct snd_miro_aci *aci)
 {
 	unsigned char byte;
 
-	if (aci_busy_wait(miro) >= 0) {
-		byte=inb(miro->aci_port + ACI_REG_STATUS);
+	if (aci_busy_wait(aci) >= 0) {
+		byte = inb(aci->aci_port + ACI_REG_STATUS);
 		return byte;
 	} else {
 		snd_printk(KERN_ERR "aci busy, aci_read() stopped.\n");
@@ -198,39 +192,49 @@ static inline int aci_read(struct snd_miro * miro)
 	}
 }
 
-static int aci_cmd(struct snd_miro * miro, int write1, int write2, int write3)
+int snd_aci_cmd(struct snd_miro_aci *aci, int write1, int write2, int write3)
 {
 	int write[] = {write1, write2, write3};
 	int value, i;
 
-	if (mutex_lock_interruptible(&miro->aci_mutex))
+	if (mutex_lock_interruptible(&aci->aci_mutex))
 		return -EINTR;
 
 	for (i=0; i<3; i++) {
 		if (write[i]< 0 || write[i] > 255)
 			break;
 		else {
-			value = aci_write(miro, write[i]);
+			value = aci_write(aci, write[i]);
 			if (value < 0)
 				goto out;
 		}
 	}
 
-	value = aci_read(miro);
+	value = aci_read(aci);
 
-out:	mutex_unlock(&miro->aci_mutex);
+out:	mutex_unlock(&aci->aci_mutex);
 	return value;
 }
+EXPORT_SYMBOL(snd_aci_cmd);
+
+static int aci_getvalue(struct snd_miro_aci *aci, unsigned char index)
+{
+	return snd_aci_cmd(aci, ACI_STATUS, index, -1);
+}
 
-static int aci_getvalue(struct snd_miro * miro, unsigned char index)
+static int aci_setvalue(struct snd_miro_aci *aci, unsigned char index,
+			int value)
 {
-	return aci_cmd(miro, ACI_STATUS, index, -1);
+	return snd_aci_cmd(aci, index, value, -1);
 }
 
-static int aci_setvalue(struct snd_miro * miro, unsigned char index, int value)
+struct snd_miro_aci *snd_aci_get_aci(void)
 {
-	return aci_cmd(miro, index, value, -1);
+	if (aci_device.aci_port == 0)
+		return NULL;
+	return &aci_device;
 }
+EXPORT_SYMBOL(snd_aci_get_aci);
 
 /*
  *  MIXER part
@@ -244,8 +248,10 @@ static int snd_miro_get_capture(struct snd_kcontrol *kcontrol,
 	struct snd_miro *miro = snd_kcontrol_chip(kcontrol);
 	int value;
 
-	if ((value = aci_getvalue(miro, ACI_S_GENERAL)) < 0) {
-		snd_printk(KERN_ERR "snd_miro_get_capture() failed: %d\n", value);
+	value = aci_getvalue(miro->aci, ACI_S_GENERAL);
+	if (value < 0) {
+		snd_printk(KERN_ERR "snd_miro_get_capture() failed: %d\n",
+			   value);
 		return value;
 	}
 
@@ -262,13 +268,15 @@ static int snd_miro_put_capture(struct snd_kcontrol *kcontrol,
 
 	value = !(ucontrol->value.integer.value[0]);
 
-	if ((error = aci_setvalue(miro, ACI_SET_SOLOMODE, value)) < 0) {
-		snd_printk(KERN_ERR "snd_miro_put_capture() failed: %d\n", error);
+	error = aci_setvalue(miro->aci, ACI_SET_SOLOMODE, value);
+	if (error < 0) {
+		snd_printk(KERN_ERR "snd_miro_put_capture() failed: %d\n",
+			   error);
 		return error;
 	}
 
-	change = (value != miro->aci_solomode);
-	miro->aci_solomode = value;
+	change = (value != miro->aci->aci_solomode);
+	miro->aci->aci_solomode = value;
 	
 	return change;
 }
@@ -290,7 +298,7 @@ static int snd_miro_get_preamp(struct snd_kcontrol *kcontrol,
 	struct snd_miro *miro = snd_kcontrol_chip(kcontrol);
 	int value;
 
-	if (miro->aci_version <= 176) {
+	if (miro->aci->aci_version <= 176) {
 
 		/* 
 		   OSS says it's not readable with versions < 176.
@@ -298,12 +306,14 @@ static int snd_miro_get_preamp(struct snd_kcontrol *kcontrol,
 		   which is a PCM12 with aci_version = 176.
 		*/
 
-		ucontrol->value.integer.value[0] = miro->aci_preamp;
+		ucontrol->value.integer.value[0] = miro->aci->aci_preamp;
 		return 0;
 	}
 
-	if ((value = aci_getvalue(miro, ACI_GET_PREAMP)) < 0) {
-		snd_printk(KERN_ERR "snd_miro_get_preamp() failed: %d\n", value);
+	value = aci_getvalue(miro->aci, ACI_GET_PREAMP);
+	if (value < 0) {
+		snd_printk(KERN_ERR "snd_miro_get_preamp() failed: %d\n",
+			   value);
 		return value;
 	}
 	
@@ -320,13 +330,15 @@ static int snd_miro_put_preamp(struct snd_kcontrol *kcontrol,
 
 	value = ucontrol->value.integer.value[0];
 
-	if ((error = aci_setvalue(miro, ACI_SET_PREAMP, value)) < 0) {
-		snd_printk(KERN_ERR "snd_miro_put_preamp() failed: %d\n", error);
+	error = aci_setvalue(miro->aci, ACI_SET_PREAMP, value);
+	if (error < 0) {
+		snd_printk(KERN_ERR "snd_miro_put_preamp() failed: %d\n",
+			   error);
 		return error;
 	}
 
-	change = (value != miro->aci_preamp);
-	miro->aci_preamp = value;
+	change = (value != miro->aci->aci_preamp);
+	miro->aci->aci_preamp = value;
 
 	return change;
 }
@@ -337,7 +349,7 @@ static int snd_miro_get_amp(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_miro *miro = snd_kcontrol_chip(kcontrol);
-	ucontrol->value.integer.value[0] = miro->aci_amp;
+	ucontrol->value.integer.value[0] = miro->aci->aci_amp;
 
 	return 0;
 }
@@ -350,13 +362,14 @@ static int snd_miro_put_amp(struct snd_kcontrol *kcontrol,
 
 	value = ucontrol->value.integer.value[0];
 
-	if ((error = aci_setvalue(miro, ACI_SET_POWERAMP, value)) < 0) {
+	error = aci_setvalue(miro->aci, ACI_SET_POWERAMP, value);
+	if (error < 0) {
 		snd_printk(KERN_ERR "snd_miro_put_amp() to %d failed: %d\n", value, error);
 		return error;
 	}
 
-	change = (value != miro->aci_amp);
-	miro->aci_amp = value;
+	change = (value != miro->aci->aci_amp);
+	miro->aci->aci_amp = value;
 
 	return change;
 }
@@ -405,12 +418,14 @@ static int snd_miro_get_double(struct snd_kcontrol *kcontrol,
 	int right_reg = kcontrol->private_value & 0xff;
 	int left_reg = right_reg + 1;
 
-	if ((right_val = aci_getvalue(miro, right_reg)) < 0) {
+	right_val = aci_getvalue(miro->aci, right_reg);
+	if (right_val < 0) {
 		snd_printk(KERN_ERR "aci_getvalue(%d) failed: %d\n", right_reg, right_val);
 		return right_val;
 	}
 
-	if ((left_val = aci_getvalue(miro, left_reg)) < 0) {
+	left_val = aci_getvalue(miro->aci, left_reg);
+	if (left_val < 0) {
 		snd_printk(KERN_ERR "aci_getvalue(%d) failed: %d\n", left_reg, left_val);
 		return left_val;
 	}
@@ -446,6 +461,7 @@ static int snd_miro_put_double(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_miro *miro = snd_kcontrol_chip(kcontrol);
+	struct snd_miro_aci *aci = miro->aci;
 	int left, right, left_old, right_old;
 	int setreg_left, setreg_right, getreg_left, getreg_right;
 	int change, error;
@@ -461,12 +477,14 @@ static int snd_miro_put_double(struct snd_kcontrol *kcontrol,
 	getreg_right = kcontrol->private_value & 0xff;
 	getreg_left = getreg_right + 1;
 
-	if ((left_old = aci_getvalue(miro, getreg_left)) < 0) {
+	left_old = aci_getvalue(aci, getreg_left);
+	if (left_old < 0) {
 		snd_printk(KERN_ERR "aci_getvalue(%d) failed: %d\n", getreg_left, left_old);
 		return left_old;
 	}
 
-	if ((right_old = aci_getvalue(miro, getreg_right)) < 0) {
+	right_old = aci_getvalue(aci, getreg_right);
+	if (right_old < 0) {
 		snd_printk(KERN_ERR "aci_getvalue(%d) failed: %d\n", getreg_right, right_old);
 		return right_old;
 	}
@@ -485,13 +503,15 @@ static int snd_miro_put_double(struct snd_kcontrol *kcontrol,
 			right_old = 0x80 - right_old;
 
 		if (left >= 0) {
-			if ((error = aci_setvalue(miro, setreg_left, left)) < 0) {
+			error = aci_setvalue(aci, setreg_left, left);
+			if (error < 0) {
 				snd_printk(KERN_ERR "aci_setvalue(%d) failed: %d\n",
 					   left, error);
 				return error;
 			}
 		} else {
-			if ((error = aci_setvalue(miro, setreg_left, 0x80 - left)) < 0) {
+			error = aci_setvalue(aci, setreg_left, 0x80 - left);
+			if (error < 0) {
 				snd_printk(KERN_ERR "aci_setvalue(%d) failed: %d\n",
 					   0x80 - left, error);
 				return error;
@@ -499,13 +519,15 @@ static int snd_miro_put_double(struct snd_kcontrol *kcontrol,
 		}
 
 		if (right >= 0) {
-			if ((error = aci_setvalue(miro, setreg_right, right)) < 0) {
+			error = aci_setvalue(aci, setreg_right, right);
+			if (error < 0) {
 				snd_printk(KERN_ERR "aci_setvalue(%d) failed: %d\n",
 					   right, error);
 				return error;
 			}
 		} else {
-			if ((error = aci_setvalue(miro, setreg_right, 0x80 - right)) < 0) {
+			error = aci_setvalue(aci, setreg_right, 0x80 - right);
+			if (error < 0) {
 				snd_printk(KERN_ERR "aci_setvalue(%d) failed: %d\n",
 					   0x80 - right, error);
 				return error;
@@ -523,12 +545,14 @@ static int snd_miro_put_double(struct snd_kcontrol *kcontrol,
 		left_old = 0x20 - left_old;
 		right_old = 0x20 - right_old;
 
-		if ((error = aci_setvalue(miro, setreg_left, 0x20 - left)) < 0) {
+		error = aci_setvalue(aci, setreg_left, 0x20 - left);
+		if (error < 0) {
 			snd_printk(KERN_ERR "aci_setvalue(%d) failed: %d\n",
 				   0x20 - left, error);
 			return error;
 		}
-		if ((error = aci_setvalue(miro, setreg_right, 0x20 - right)) < 0) {
+		error = aci_setvalue(aci, setreg_right, 0x20 - right);
+		if (error < 0) {
 			snd_printk(KERN_ERR "aci_setvalue(%d) failed: %d\n",
 				   0x20 - right, error);
 			return error;
@@ -626,11 +650,13 @@ static unsigned char aci_init_values[][2] __devinitdata = {
 static int __devinit snd_set_aci_init_values(struct snd_miro *miro)
 {
 	int idx, error;
+	struct snd_miro_aci *aci = miro->aci;
 
 	/* enable WSS on PCM1 */
 
-	if ((miro->aci_product == 'A') && wss) {
-		if ((error = aci_setvalue(miro, ACI_SET_WSS, wss)) < 0) {
+	if ((aci->aci_product == 'A') && wss) {
+		error = aci_setvalue(aci, ACI_SET_WSS, wss);
+		if (error < 0) {
 			snd_printk(KERN_ERR "enabling WSS mode failed\n");
 			return error;
 		}
@@ -639,7 +665,8 @@ static int __devinit snd_set_aci_init_values(struct snd_miro *miro)
 	/* enable IDE port */
 
 	if (ide) {
-		if ((error = aci_setvalue(miro, ACI_SET_IDE, ide)) < 0) {
+		error = aci_setvalue(aci, ACI_SET_IDE, ide);
+		if (error < 0) {
 			snd_printk(KERN_ERR "enabling IDE port failed\n");
 			return error;
 		}
@@ -647,17 +674,18 @@ static int __devinit snd_set_aci_init_values(struct snd_miro *miro)
 
 	/* set common aci values */
 
-	for (idx = 0; idx < ARRAY_SIZE(aci_init_values); idx++)
-                if ((error = aci_setvalue(miro, aci_init_values[idx][0], 
-					  aci_init_values[idx][1])) < 0) {
+	for (idx = 0; idx < ARRAY_SIZE(aci_init_values); idx++) {
+		error = aci_setvalue(aci, aci_init_values[idx][0],
+				     aci_init_values[idx][1]);
+		if (error < 0) {
 			snd_printk(KERN_ERR "aci_setvalue(%d) failed: %d\n", 
 				   aci_init_values[idx][0], error);
                         return error;
                 }
-
-	miro->aci_amp = 0;
-	miro->aci_preamp = 0;
-	miro->aci_solomode = 1;
+	}
+	aci->aci_amp = 0;
+	aci->aci_preamp = 0;
+	aci->aci_solomode = 1;
 
 	return 0;
 }
@@ -688,7 +716,8 @@ static int __devinit snd_miro_mixer(struct snd_card *card,
 			return err;
 	}
 
-	if ((miro->aci_product == 'A') || (miro->aci_product == 'B')) {
+	if ((miro->aci->aci_product == 'A') ||
+	    (miro->aci->aci_product == 'B')) {
 		/* PCM1/PCM12 with power-amp and Line 2 */
 		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_miro_line_control[0], miro))) < 0)
 			return err;
@@ -696,16 +725,17 @@ static int __devinit snd_miro_mixer(struct snd_card *card,
 			return err;
 	}
 
-	if ((miro->aci_product == 'B') || (miro->aci_product == 'C')) {
+	if ((miro->aci->aci_product == 'B') ||
+	    (miro->aci->aci_product == 'C')) {
 		/* PCM12/PCM20 with mic-preamp */
 		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_miro_preamp_control[0], miro))) < 0)
 			return err;
-		if (miro->aci_version >= 176)
+		if (miro->aci->aci_version >= 176)
 			if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_miro_capture_control[0], miro))) < 0)
 				return err;
 	}
 
-	if (miro->aci_product == 'C') {
+	if (miro->aci->aci_product == 'C') {
 		/* PCM20 with radio and 7 band equalizer */
 		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_miro_radio_control[0], miro))) < 0)
 			return err;
@@ -843,14 +873,15 @@ static void snd_miro_proc_read(struct snd_info_entry * entry,
 			       struct snd_info_buffer *buffer)
 {
 	struct snd_miro *miro = (struct snd_miro *) entry->private_data;
+	struct snd_miro_aci *aci = miro->aci;
 	char* model = "unknown";
 
 	/* miroSOUND PCM1 pro, early PCM12 */
 
 	if ((miro->hardware == OPTi9XX_HW_82C929) &&
-	    (miro->aci_vendor == 'm') && 
-	    (miro->aci_product == 'A')) {
-		switch(miro->aci_version) {
+	    (aci->aci_vendor == 'm') &&
+	    (aci->aci_product == 'A')) {
+		switch (aci->aci_version) {
 		case 3:
 			model = "miroSOUND PCM1 pro";
 			break;
@@ -863,9 +894,9 @@ static void snd_miro_proc_read(struct snd_info_entry * entry,
 	/* miroSOUND PCM12, PCM12 (Rev. E), PCM12 pnp */
 
 	if ((miro->hardware == OPTi9XX_HW_82C924) &&
-	    (miro->aci_vendor == 'm') && 
-	    (miro->aci_product == 'B')) {
-		switch(miro->aci_version) {
+	    (aci->aci_vendor == 'm') &&
+	    (aci->aci_product == 'B')) {
+		switch (aci->aci_version) {
 		case 4:
 			model = "miroSOUND PCM12";
 			break;
@@ -881,9 +912,9 @@ static void snd_miro_proc_read(struct snd_info_entry * entry,
 	/* miroSOUND PCM20 radio */
 
 	if ((miro->hardware == OPTi9XX_HW_82C924) &&
-	    (miro->aci_vendor == 'm') && 
-	    (miro->aci_product == 'C')) {
-		switch(miro->aci_version) {
+	    (aci->aci_vendor == 'm') &&
+	    (aci->aci_product == 'C')) {
+		switch (aci->aci_version) {
 		case 7:
 			model = "miroSOUND PCM20 radio (Rev. E)";
 			break;
@@ -907,17 +938,17 @@ static void snd_miro_proc_read(struct snd_info_entry * entry,
 
 	snd_iprintf(buffer, "ACI information:\n");
 	snd_iprintf(buffer, "  vendor  : ");
-	switch(miro->aci_vendor) {
+	switch (aci->aci_vendor) {
 	case 'm':
 		snd_iprintf(buffer, "Miro\n");
 		break;
 	default:
-		snd_iprintf(buffer, "unknown (0x%x)\n", miro->aci_vendor);
+		snd_iprintf(buffer, "unknown (0x%x)\n", aci->aci_vendor);
 		break;
 	}
 
 	snd_iprintf(buffer, "  product : ");
-	switch(miro->aci_product) {
+	switch (aci->aci_product) {
 	case 'A':
 		snd_iprintf(buffer, "miroSOUND PCM1 pro / (early) PCM12\n");
 		break;
@@ -928,19 +959,19 @@ static void snd_miro_proc_read(struct snd_info_entry * entry,
 		snd_iprintf(buffer, "miroSOUND PCM20 radio\n");
 		break;
 	default:
-		snd_iprintf(buffer, "unknown (0x%x)\n", miro->aci_product);
+		snd_iprintf(buffer, "unknown (0x%x)\n", aci->aci_product);
 		break;
 	}
 
 	snd_iprintf(buffer, "  firmware: %d (0x%x)\n",
-		    miro->aci_version, miro->aci_version);
+		    aci->aci_version, aci->aci_version);
 	snd_iprintf(buffer, "  port    : 0x%lx-0x%lx\n", 
-		    miro->aci_port, miro->aci_port+2);
+		    aci->aci_port, aci->aci_port+2);
 	snd_iprintf(buffer, "  wss     : 0x%x\n", wss);
 	snd_iprintf(buffer, "  ide     : 0x%x\n", ide);
-	snd_iprintf(buffer, "  solomode: 0x%x\n", miro->aci_solomode);
-	snd_iprintf(buffer, "  amp     : 0x%x\n", miro->aci_amp);
-	snd_iprintf(buffer, "  preamp  : 0x%x\n", miro->aci_preamp);
+	snd_iprintf(buffer, "  solomode: 0x%x\n", aci->aci_solomode);
+	snd_iprintf(buffer, "  amp     : 0x%x\n", aci->aci_amp);
+	snd_iprintf(buffer, "  preamp  : 0x%x\n", aci->aci_preamp);
 }
 
 static void __devinit snd_miro_proc_init(struct snd_card *card,
@@ -1139,46 +1170,53 @@ static int __devinit snd_card_miro_detect(struct snd_card *card,
 }
 
 static int __devinit snd_card_miro_aci_detect(struct snd_card *card,
-					      struct snd_miro * miro)
+					      struct snd_miro *miro)
 {
 	unsigned char regval;
 	int i;
+	struct snd_miro_aci *aci = &aci_device;
+
+	miro->aci = aci;
 
-	mutex_init(&miro->aci_mutex);
+	mutex_init(&aci->aci_mutex);
 
 	/* get ACI port from OPTi9xx MC 4 */
 
 	regval=inb(miro->mc_base + 4);
-	miro->aci_port = (regval & 0x10) ? 0x344: 0x354;
+	aci->aci_port = (regval & 0x10) ? 0x344 : 0x354;
 
-	if ((miro->res_aci_port = request_region(miro->aci_port, 3, "miro aci")) == NULL) {
+	miro->res_aci_port = request_region(aci->aci_port, 3, "miro aci");
+	if (miro->res_aci_port == NULL) {
 		snd_printk(KERN_ERR "aci i/o area 0x%lx-0x%lx already used.\n", 
-			   miro->aci_port, miro->aci_port+2);
+			   aci->aci_port, aci->aci_port+2);
 		return -ENOMEM;
 	}
 
         /* force ACI into a known state */
 	for (i = 0; i < 3; i++)
-		if (aci_cmd(miro, ACI_ERROR_OP, -1, -1) < 0) {
+		if (snd_aci_cmd(aci, ACI_ERROR_OP, -1, -1) < 0) {
 			snd_printk(KERN_ERR "can't force aci into known state.\n");
 			return -ENXIO;
 		}
 
-	if ((miro->aci_vendor=aci_cmd(miro, ACI_READ_IDCODE, -1, -1)) < 0 ||
-	    (miro->aci_product=aci_cmd(miro, ACI_READ_IDCODE, -1, -1)) < 0) {
-		snd_printk(KERN_ERR "can't read aci id on 0x%lx.\n", miro->aci_port);
+	aci->aci_vendor = snd_aci_cmd(aci, ACI_READ_IDCODE, -1, -1);
+	aci->aci_product = snd_aci_cmd(aci, ACI_READ_IDCODE, -1, -1);
+	if (aci->aci_vendor < 0 || aci->aci_product < 0) {
+		snd_printk(KERN_ERR "can't read aci id on 0x%lx.\n",
+			   aci->aci_port);
 		return -ENXIO;
 	}
 
-	if ((miro->aci_version=aci_cmd(miro, ACI_READ_VERSION, -1, -1)) < 0) {
+	aci->aci_version = snd_aci_cmd(aci, ACI_READ_VERSION, -1, -1);
+	if (aci->aci_version < 0) {
 		snd_printk(KERN_ERR "can't read aci version on 0x%lx.\n", 
-			   miro->aci_port);
+			   aci->aci_port);
 		return -ENXIO;
 	}
 
-	if (aci_cmd(miro, ACI_INIT, -1, -1) < 0 ||
-	    aci_cmd(miro, ACI_ERROR_OP, ACI_ERROR_OP, ACI_ERROR_OP) < 0 ||
-	    aci_cmd(miro, ACI_ERROR_OP, ACI_ERROR_OP, ACI_ERROR_OP) < 0) {
+	if (snd_aci_cmd(aci, ACI_INIT, -1, -1) < 0 ||
+	    snd_aci_cmd(aci, ACI_ERROR_OP, ACI_ERROR_OP, ACI_ERROR_OP) < 0 ||
+	    snd_aci_cmd(aci, ACI_ERROR_OP, ACI_ERROR_OP, ACI_ERROR_OP) < 0) {
 		snd_printk(KERN_ERR "can't initialize aci.\n"); 
 		return -ENXIO;
 	}
@@ -1191,6 +1229,7 @@ static void snd_card_miro_free(struct snd_card *card)
 	struct snd_miro *miro = card->private_data;
         
 	release_and_free_resource(miro->res_aci_port);
+	miro->aci->aci_port = 0;
 	release_and_free_resource(miro->res_mc_base);
 }
 
@@ -1250,7 +1289,6 @@ static int __devinit snd_miro_probe(struct device *devptr, unsigned int n)
 	}
 
 	miro->wss_base = port;
-	miro->mpu_port = mpu_port;
 	miro->irq = irq;
 	miro->mpu_irq = mpu_irq;
 	miro->dma1 = dma1;
@@ -1272,6 +1310,8 @@ static int __devinit snd_miro_probe(struct device *devptr, unsigned int n)
 			return -EBUSY;
 		}
 	}
+	miro->mpu_port = mpu_port;
+
 	if (miro->irq == SNDRV_AUTO_IRQ) {
 		if ((miro->irq = snd_legacy_find_free_irq(possible_irqs)) < 0) {
 			snd_card_free(card);
@@ -1339,9 +1379,9 @@ static int __devinit snd_miro_probe(struct device *devptr, unsigned int n)
 		return error;
 	}
 
-	if (miro->aci_vendor == 'm') {
+	if (miro->aci->aci_vendor == 'm') {
 		/* It looks like a miro sound card. */
-		switch (miro->aci_product) {
+		switch (miro->aci->aci_product) {
 		case 'A':
 			sprintf(card->shortname, 
 				"miroSOUND PCM1 pro / PCM12");
-- 
1.6.4


----------------------------------------------------------------------
Najlepsze oferty Sylwestrowe!
Sprawdz >>> http://link.interia.pl/f2426
