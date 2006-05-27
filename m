From: James Courtier-Dutton <James@superbug.co.uk>
Subject: dB gain
Date: Sat, 27 May 2006 20:03:44 +0100
Message-ID: <4478A290.80702@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020909000909010602050701"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net
	[194.217.242.88])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6D3B6187
	for <alsa-devel@alsa-project.org>;
	Sat, 27 May 2006 21:03:46 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.0.10])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1Fk44f-000FVe-0E
	for alsa-devel@alsa-project.org; Sat, 27 May 2006 19:03:45 +0000
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020909000909010602050701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have made a new attempt at adding support for dB gain reports in
alsamixer.

See the attached diffs against the current alsa hg repository. 27-5-2006

It shows an example of support for the snd-ca0106 driver.
As one can see, this adds minimal amounts of code to each sound card
driver. 22 new lines + 1 per volume control making 33 lines total.

Any comments?

James






--------------020909000909010602050701
Content-Type: text/x-patch;
 name="alsa-kernel-db14.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-kernel-db14.diff"

diff -r 551da56a592c core/control.c
--- a/core/control.c	Fri May 19 19:22:34 2006 +0200
+++ b/core/control.c	Sat May 27 19:53:59 2006 +0100
@@ -241,6 +241,7 @@ struct snd_kcontrol *snd_ctl_new1(const 
 	kctl.info = ncontrol->info;
 	kctl.get = ncontrol->get;
 	kctl.put = ncontrol->put;
+	kctl.info2 = ncontrol->info2;
 	kctl.private_value = ncontrol->private_value;
 	kctl.private_data = private_data;
 	return snd_ctl_new(&kctl, access);
@@ -570,6 +571,172 @@ static int snd_ctl_card_info(struct snd_
 	}
 	kfree(info);
 	return 0;
+}
+
+static int uint32_to_message(struct snd_ctl_misc *misc, u32 value)
+{
+	unsigned int pointer = misc->length;
+	u32 *store = (u32*) &misc->message[pointer];
+	*store = value;
+	misc->length += sizeof(u32);
+	return 0;
+}
+
+static int message_to_uint32(struct snd_ctl_misc *misc, unsigned int *value)
+{
+	unsigned int pointer = misc->length;
+	u32 *store = (u32*) &misc->message[pointer];
+	*value = *store;
+	misc->length += sizeof(u32);
+	return 0;
+}
+
+
+static int add_int32_tlv_to_container(struct snd_ctl_misc *misc, unsigned int type, unsigned int value)
+{
+	uint32_to_message(misc, type);
+	uint32_to_message(misc, 4);
+	uint32_to_message(misc, value);
+	/* FIXME: Check for overflows */
+	return 0;
+}
+
+static int add_message_tlv_to_container(
+	struct snd_ctl_misc *misc, unsigned int length, unsigned char *message)
+{
+	unsigned int pointer = misc->length;
+	unsigned int n;
+	for(n=0; n<length; n++) {
+		misc->message[pointer++] = message[n];
+	}
+	misc->length = pointer;
+	/* FIXME: Check for overflows */
+	return 0;
+}
+
+
+static int container_open(struct snd_ctl_misc *misc, unsigned int type)
+{
+	uint32_to_message(misc, type);
+	uint32_to_message(misc, 0); /* This gets updated at container close */
+	return 0;
+}
+
+static int container_close(struct snd_ctl_misc *misc)
+{
+	u32 *store = (u32*) &misc->message[sizeof(u32)];
+	*store = misc->length;
+	return 0;
+}
+
+static int snd_ctl_misc_user(struct snd_ctl_file *ctl,
+				  struct snd_ctl_misc __user *_misc)
+{
+	struct snd_ctl_misc *misc;
+	struct snd_card *card = ctl->card;
+	struct snd_kcontrol *kctl;
+	struct snd_ctl_elem_info2 info2;
+	int result=0;
+	int numid;
+	unsigned int received_length;
+	unsigned int tlv_type;
+	unsigned int tlv_length;
+	unsigned int tlv_value;
+	unsigned int container_type;
+	unsigned int container_length;
+	
+	misc = kmalloc(2048, GFP_KERNEL);
+	if (misc == NULL)
+		return -ENOMEM;
+
+	/* Only copy _misc: version and length from user-space */
+	if (copy_from_user(misc, _misc, 8)) {
+		result = -EFAULT;
+		goto exit_free;
+	}
+	/* Sanity check */
+	snd_printk("misc->version=%d\n",misc->version);
+	if (misc->version!=1) {
+		result = -EINVAL;
+		goto exit_free;
+	}
+	received_length = misc->length;
+	snd_printk("misc->length=%d\n",misc->length);
+	if (received_length>2040 || received_length<8) {
+		result = -EINVAL;
+		goto exit_free;
+	}
+	/* Copy the entire _misc from user-space */
+	if (copy_from_user(misc, _misc, received_length)) {
+		result = -EFAULT;
+		goto exit_free;
+	}
+	misc->length=0;
+	message_to_uint32(misc, &container_type);
+	snd_printk("container_type=%d\n",container_type);
+	switch (container_type) {
+		case SND_MISC_DB_SCALE:
+			message_to_uint32(misc, &container_length);
+			/* FIXME: Do more sanity checks here */
+			message_to_uint32(misc, &tlv_type);
+			snd_printk("tlv_type=%d\n",tlv_type);
+			switch (tlv_type) {
+				case SND_MISC_ELEM_NUMID:
+					message_to_uint32(misc, &tlv_length);
+					snd_printk("tlv_length=%d\n",tlv_length);
+					if (tlv_length != 4) {
+						result = -EINVAL;
+						goto exit_free;
+					}
+					message_to_uint32(misc, &tlv_value);
+					snd_printk("tlv_value=%d\n",tlv_value);
+					break;
+				default:
+					result = -EINVAL;
+					goto exit_free;
+					break;
+			}
+			break;
+		default:
+			result = -EINVAL;
+			goto exit_free;
+	}
+	numid=tlv_value;
+	//snd_printk("numid=%d\n", tlv_value);
+	down_read(&card->controls_rwsem);
+	kctl = snd_ctl_find_numid(card, numid);
+	if (kctl == NULL) {
+		snd_printk("stop 1\n");
+		result = -ENOENT;
+		goto exit_up;
+	}
+	if ( !(kctl->info2) ) { 
+		snd_printk("stop 2\n");
+		result = -EINVAL;
+		goto exit_up;
+	}
+	if (kctl->info2(kctl, 1, &info2)) {
+		snd_printk("stop 3\n");
+		result = -EINVAL;
+		goto exit_up;
+	}
+		;
+	snd_printk("ok 1\n");
+	misc->version=1;
+	misc->length=0;
+	container_open(misc, SND_MISC_DB_SCALE);
+	add_message_tlv_to_container(misc, info2.length, info2.message);
+	container_close(misc);
+	if (copy_to_user(_misc, misc, received_length))
+		result = -EFAULT;
+	snd_printk("ok 2\n");
+	
+exit_up:
+	up_read(&card->controls_rwsem);
+exit_free:
+	kfree(misc);
+exit:
+	return result;
 }
 
 static int snd_ctl_elem_list(struct snd_card *card,
@@ -1103,6 +1270,8 @@ static long snd_ctl_ioctl(struct file *f
 		return snd_ctl_elem_add_user(ctl, argp, 1);
 	case SNDRV_CTL_IOCTL_ELEM_REMOVE:
 		return snd_ctl_elem_remove(ctl, argp);
+	case SNDRV_CTL_IOCTL_MISC:
+		return snd_ctl_misc_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS:
 		return snd_ctl_subscribe_events(ctl, ip);
 	case SNDRV_CTL_IOCTL_POWER:
diff -r 551da56a592c include/asound.h
--- a/include/asound.h	Fri May 19 19:22:34 2006 +0200
+++ b/include/asound.h	Sat May 27 19:53:59 2006 +0100
@@ -818,6 +818,44 @@ struct snd_ctl_elem_value {
         unsigned char reserved[128-sizeof(struct timespec)];
 };
 
+struct snd_ctl_misc {
+	u32 version;
+	u32 length;
+	unsigned char message[];
+};
+
+struct snd_ctl_elem_db_scale_type1 {
+	/* Type=1 for simple
+	 * dB = (X * db_per_devision) - db_offset
+	 * This equation is used instead of a more normal
+	 * dB = (( X - db_offset) * db_numerator) / db_denominator
+	 * in order to avoid any devision by zero possibilities,
+	 * save 4 bytes per db_scale and avoid floating point maths.
+	 *
+	 * Types >= 2 are for future more complex conversion functions.
+	 * All types have to have a length value, in case the user land
+	 * alsa lib does not yet understand the type. The length field allows
+	 * user land to safely skip this TLV.
+	 */
+	u32 type; /* 1 */
+	u32 length; /* 12 */
+	s32 db_per_devision; /* Use db per devision * 100 */
+	s32 db_offset; /* Use dB offset * 100. This identifies the 0dB point */
+	s32 db_mute; /* The value, before conversion, that is equivalent to MUTE */
+};
+
+struct snd_ctl_elem_info2 {
+	u32 length;
+	unsigned char *message;
+};
+
+
+#define SND_MISC_DB_SCALE 2
+/* Request */
+#define SND_MISC_ELEM_NUMID 2
+/* Response */
+#define SND_MISC_ELEM_DB_SCALE 2
+
 enum {
 	SNDRV_CTL_IOCTL_PVERSION = _IOR('U', 0x00, int),
 	SNDRV_CTL_IOCTL_CARD_INFO = _IOR('U', 0x01, struct snd_ctl_card_info),
@@ -833,6 +871,7 @@ enum {
 	SNDRV_CTL_IOCTL_ELEM_REMOVE = _IOWR('U', 0x19, struct snd_ctl_elem_id),
 	SNDRV_CTL_IOCTL_HWDEP_NEXT_DEVICE = _IOWR('U', 0x20, int),
 	SNDRV_CTL_IOCTL_HWDEP_INFO = _IOR('U', 0x21, struct snd_hwdep_info),
+	SNDRV_CTL_IOCTL_MISC = _IOR('U', 0x22, struct snd_ctl_misc),
 	SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE = _IOR('U', 0x30, int),
 	SNDRV_CTL_IOCTL_PCM_INFO = _IOWR('U', 0x31, struct snd_pcm_info),
 	SNDRV_CTL_IOCTL_PCM_PREFER_SUBDEVICE = _IOW('U', 0x32, int),
diff -r 551da56a592c include/control.h
--- a/include/control.h	Fri May 19 19:22:34 2006 +0200
+++ b/include/control.h	Sat May 27 19:53:59 2006 +0100
@@ -30,6 +30,7 @@ typedef int (snd_kcontrol_info_t) (struc
 typedef int (snd_kcontrol_info_t) (struct snd_kcontrol * kcontrol, struct snd_ctl_elem_info * uinfo);
 typedef int (snd_kcontrol_get_t) (struct snd_kcontrol * kcontrol, struct snd_ctl_elem_value * ucontrol);
 typedef int (snd_kcontrol_put_t) (struct snd_kcontrol * kcontrol, struct snd_ctl_elem_value * ucontrol);
+typedef int (snd_kcontrol_info2_t) (struct snd_kcontrol * kcontrol, int type, struct snd_ctl_elem_info2 * uinfo);
 
 struct snd_kcontrol_new {
 	snd_ctl_elem_iface_t iface;	/* interface identifier */
@@ -42,6 +43,7 @@ struct snd_kcontrol_new {
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
 	snd_kcontrol_put_t *put;
+	snd_kcontrol_info2_t *info2;
 	unsigned long private_value;
 };
 
@@ -58,6 +60,7 @@ struct snd_kcontrol {
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
 	snd_kcontrol_put_t *put;
+	snd_kcontrol_info2_t *info2;
 	unsigned long private_value;
 	void *private_data;
 	void (*private_free)(struct snd_kcontrol *kcontrol);
diff -r 551da56a592c pci/ca0106/ca0106_mixer.c
--- a/pci/ca0106/ca0106_mixer.c	Fri May 19 19:22:34 2006 +0200
+++ b/pci/ca0106/ca0106_mixer.c	Sat May 27 19:53:59 2006 +0100
@@ -362,6 +362,28 @@ static int snd_ca0106_spdif_put(struct s
         return change;
 }
 
+static struct snd_ctl_elem_db_scale_type1 db_scale_1 =
+{
+ /* Scale from -51.50 dB to +12.00 dB in steps of 0.25 dB. 256 steps. */
+	.type=1,
+	.length=12,
+	.db_per_devision=25,
+	.db_offset=5175,
+	.db_mute=0
+};
+
+static int snd_ca0106_info2_db_scale_1(struct snd_kcontrol *kcontrol, int type,
+				  struct snd_ctl_elem_info2 *uinfo)
+{
+	if (type==1) {
+		uinfo->length=sizeof(struct snd_ctl_elem_db_scale_type1);
+		uinfo->message=(unsigned char*) &db_scale_1;
+        	return 0;
+	}
+	return -EINVAL; /* type not implemented */
+}
+
+
 static int snd_ca0106_volume_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
@@ -466,13 +488,14 @@ static int snd_ca0106_i2c_volume_put(str
 	return change;
 }
 
-#define CA_VOLUME(xname,chid,reg) \
+#define CA_VOLUME(xname,chid,reg,db_function) \
 {								\
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,	\
 	.info =	 snd_ca0106_volume_info,			\
 	.get =   snd_ca0106_volume_get,				\
 	.put =   snd_ca0106_volume_put,				\
-	.private_value = ((chid) << 8) | (reg)			\
+	.private_value = ((chid) << 8) | (reg),			\
+	.info2 = db_function					\
 }
 
 #define I2C_VOLUME(xname,chid) \
@@ -487,25 +510,33 @@ static int snd_ca0106_i2c_volume_put(str
 
 static struct snd_kcontrol_new snd_ca0106_volume_ctls[] __devinitdata = {
 	CA_VOLUME("Analog Front Playback Volume",
-		  CONTROL_FRONT_CHANNEL, PLAYBACK_VOLUME2),
+		  CONTROL_FRONT_CHANNEL, PLAYBACK_VOLUME2,
+		  &snd_ca0106_info2_db_scale_1),
         CA_VOLUME("Analog Rear Playback Volume",
-		  CONTROL_REAR_CHANNEL, PLAYBACK_VOLUME2),
+		  CONTROL_REAR_CHANNEL, PLAYBACK_VOLUME2,
+		  &snd_ca0106_info2_db_scale_1),
 	CA_VOLUME("Analog Center/LFE Playback Volume",
-		  CONTROL_CENTER_LFE_CHANNEL, PLAYBACK_VOLUME2),
+		  CONTROL_CENTER_LFE_CHANNEL, PLAYBACK_VOLUME2,
+		  &snd_ca0106_info2_db_scale_1),
         CA_VOLUME("Analog Side Playback Volume",
-		  CONTROL_UNKNOWN_CHANNEL, PLAYBACK_VOLUME2),
-
+		  CONTROL_UNKNOWN_CHANNEL, PLAYBACK_VOLUME2,
+		  &snd_ca0106_info2_db_scale_1),
         CA_VOLUME("IEC958 Front Playback Volume",
-		  CONTROL_FRONT_CHANNEL, PLAYBACK_VOLUME1),
+		  CONTROL_FRONT_CHANNEL, PLAYBACK_VOLUME1,
+		  &snd_ca0106_info2_db_scale_1),
 	CA_VOLUME("IEC958 Rear Playback Volume",
-		  CONTROL_REAR_CHANNEL, PLAYBACK_VOLUME1),
+		  CONTROL_REAR_CHANNEL, PLAYBACK_VOLUME1,
+		  &snd_ca0106_info2_db_scale_1),
 	CA_VOLUME("IEC958 Center/LFE Playback Volume",
-		  CONTROL_CENTER_LFE_CHANNEL, PLAYBACK_VOLUME1),
+		  CONTROL_CENTER_LFE_CHANNEL, PLAYBACK_VOLUME1,
+		  &snd_ca0106_info2_db_scale_1),
 	CA_VOLUME("IEC958 Unknown Playback Volume",
-		  CONTROL_UNKNOWN_CHANNEL, PLAYBACK_VOLUME1),
+		  CONTROL_UNKNOWN_CHANNEL, PLAYBACK_VOLUME1,
+		  &snd_ca0106_info2_db_scale_1),
 
         CA_VOLUME("CAPTURE feedback Playback Volume",
-		  1, CAPTURE_CONTROL),
+		  1, CAPTURE_CONTROL,
+		  &snd_ca0106_info2_db_scale_1),
 
         I2C_VOLUME("Phone Capture Volume", 0),
         I2C_VOLUME("Mic Capture Volume", 1),

--------------020909000909010602050701
Content-Type: text/x-patch;
 name="alsa-lib-db14.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib-db14.diff"

diff -r d5a6770e7faf include/control.h
--- a/include/control.h	Fri May 19 18:26:41 2006 +0200
+++ b/include/control.h	Sat May 27 19:54:17 2006 +0100
@@ -52,6 +52,9 @@ typedef struct snd_aes_iec958 {
 
 /** CTL card info container */
 typedef struct _snd_ctl_card_info snd_ctl_card_info_t;
+
+/** CTL misc container */
+typedef struct _snd_ctl_misc snd_ctl_misc_t;
 
 /** CTL element identifier container */
 typedef struct _snd_ctl_elem_id snd_ctl_elem_id_t;
@@ -212,6 +215,7 @@ int snd_ctl_poll_descriptors_revents(snd
 int snd_ctl_poll_descriptors_revents(snd_ctl_t *ctl, struct pollfd *pfds, unsigned int nfds, unsigned short *revents);
 int snd_ctl_subscribe_events(snd_ctl_t *ctl, int subscribe);
 int snd_ctl_card_info(snd_ctl_t *ctl, snd_ctl_card_info_t *info);
+int snd_ctl_misc(snd_ctl_t *ctl, snd_ctl_misc_t *misc);
 int snd_ctl_elem_list(snd_ctl_t *ctl, snd_ctl_elem_list_t * list);
 int snd_ctl_elem_info(snd_ctl_t *ctl, snd_ctl_elem_info_t *info);
 int snd_ctl_elem_read(snd_ctl_t *ctl, snd_ctl_elem_value_t *value);
@@ -485,6 +489,8 @@ int snd_hctl_elem_info(snd_hctl_elem_t *
 int snd_hctl_elem_info(snd_hctl_elem_t *elem, snd_ctl_elem_info_t * info);
 int snd_hctl_elem_read(snd_hctl_elem_t *elem, snd_ctl_elem_value_t * value);
 int snd_hctl_elem_write(snd_hctl_elem_t *elem, snd_ctl_elem_value_t * value);
+int snd_hctl_elem_misc(snd_hctl_elem_t *elem, snd_ctl_misc_t * misc);
+int snd_hctl_elem_get_db_gain(snd_hctl_elem_t *elem, long volume, long *db_gain);
 
 snd_hctl_t *snd_hctl_elem_get_hctl(snd_hctl_elem_t *elem);
 
diff -r d5a6770e7faf include/local.h
--- a/include/local.h	Fri May 19 18:26:41 2006 +0200
+++ b/include/local.h	Sat May 27 19:54:17 2006 +0100
@@ -46,6 +46,7 @@
 #define _snd_pcm_status sndrv_pcm_status
 
 #define _snd_ctl_card_info sndrv_ctl_card_info
+#define _snd_ctl_misc sndrv_ctl_misc
 #define _snd_ctl_elem_id sndrv_ctl_elem_id
 #define _snd_ctl_elem_list sndrv_ctl_elem_list
 #define _snd_ctl_elem_info sndrv_ctl_elem_info
diff -r d5a6770e7faf include/sound/asound.h
--- a/include/sound/asound.h	Fri May 19 18:26:41 2006 +0200
+++ b/include/sound/asound.h	Sat May 27 19:54:17 2006 +0100
@@ -26,6 +26,7 @@
 #if defined(LINUX) || defined(__LINUX__) || defined(__linux__)
 
 #include <linux/ioctl.h>
+#include <inttypes.h>
 
 #ifdef __KERNEL__
 
@@ -847,6 +848,18 @@ struct sndrv_ctl_elem_value {
         unsigned char reserved[128-sizeof(struct timespec)];
 };
 
+struct sndrv_ctl_misc {
+	uint32_t version;  /* This should be uint32_t */
+	uint32_t length; /* This should be uint32_t */
+	unsigned char message[];
+};
+
+#define SND_MISC_DB_SCALE 2
+/* Request */
+#define SND_MISC_ELEM_NUMID 2
+/* Response */
+#define SND_MISC_ELEM_DB_SCALE_TYPE1 1
+
 enum {
 	SNDRV_CTL_IOCTL_PVERSION = _IOR('U', 0x00, int),
 	SNDRV_CTL_IOCTL_CARD_INFO = _IOR('U', 0x01, struct sndrv_ctl_card_info),
@@ -862,6 +875,7 @@ enum {
 	SNDRV_CTL_IOCTL_ELEM_REMOVE = _IOWR('U', 0x19, struct sndrv_ctl_elem_id),
 	SNDRV_CTL_IOCTL_HWDEP_NEXT_DEVICE = _IOWR('U', 0x20, int),
 	SNDRV_CTL_IOCTL_HWDEP_INFO = _IOR('U', 0x21, struct sndrv_hwdep_info),
+	SNDRV_CTL_IOCTL_MISC = _IOR('U', 0x22, struct sndrv_ctl_misc),
 	SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE = _IOR('U', 0x30, int),
 	SNDRV_CTL_IOCTL_PCM_INFO = _IOWR('U', 0x31, struct sndrv_pcm_info),
 	SNDRV_CTL_IOCTL_PCM_PREFER_SUBDEVICE = _IOW('U', 0x32, int),
diff -r d5a6770e7faf src/control/control.c
--- a/src/control/control.c	Fri May 19 18:26:41 2006 +0200
+++ b/src/control/control.c	Sat May 27 19:54:17 2006 +0100
@@ -234,6 +234,20 @@ int snd_ctl_card_info(snd_ctl_t *ctl, sn
 {
 	assert(ctl && info);
 	return ctl->ops->card_info(ctl, info);
+}
+
+/**
+ * \brief Get/Set misc related information
+ * \param ctl CTL handle
+ * \param misc pointer
+ * \return 0 on success otherwise a negative error code
+ */
+int snd_ctl_misc(snd_ctl_t *ctl, snd_ctl_misc_t *misc)
+{
+	int err;
+	assert(ctl && misc);
+	err = ctl->ops->misc(ctl, misc);
+	return err;
 }
 
 /**
diff -r d5a6770e7faf src/control/control_hw.c
--- a/src/control/control_hw.c	Fri May 19 18:26:41 2006 +0200
+++ b/src/control/control_hw.c	Sat May 27 19:54:17 2006 +0100
@@ -128,6 +128,16 @@ static int snd_ctl_hw_card_info(snd_ctl_
 	return 0;
 }
 
+static int snd_ctl_hw_misc(snd_ctl_t *handle, snd_ctl_misc_t *misc)
+{
+	snd_ctl_hw_t *hw = handle->private_data;
+	if (ioctl(hw->fd, SNDRV_CTL_IOCTL_MISC, misc) < 0) {
+		//SYSERR("SNDRV_CTL_IOCTL_MISC failed");
+		return -errno;
+	}
+	return 0;
+}
+
 static int snd_ctl_hw_elem_list(snd_ctl_t *handle, snd_ctl_elem_list_t *list)
 {
 	snd_ctl_hw_t *hw = handle->private_data;
@@ -296,6 +306,7 @@ snd_ctl_ops_t snd_ctl_hw_ops = {
 	.async = snd_ctl_hw_async,
 	.subscribe_events = snd_ctl_hw_subscribe_events,
 	.card_info = snd_ctl_hw_card_info,
+	.misc = snd_ctl_hw_misc,
 	.element_list = snd_ctl_hw_elem_list,
 	.element_info = snd_ctl_hw_elem_info,
 	.element_add = snd_ctl_hw_elem_add,
diff -r d5a6770e7faf src/control/control_local.h
--- a/src/control/control_local.h	Fri May 19 18:26:41 2006 +0200
+++ b/src/control/control_local.h	Sat May 27 19:54:17 2006 +0100
@@ -27,6 +27,7 @@ typedef struct _snd_ctl_ops {
 	int (*async)(snd_ctl_t *handle, int sig, pid_t pid);
 	int (*subscribe_events)(snd_ctl_t *handle, int subscribe);
 	int (*card_info)(snd_ctl_t *handle, snd_ctl_card_info_t *info);
+	int (*misc)(snd_ctl_t *handle, snd_ctl_misc_t *info);
 	int (*element_list)(snd_ctl_t *handle, snd_ctl_elem_list_t *list);
 	int (*element_info)(snd_ctl_t *handle, snd_ctl_elem_info_t *info);
 	int (*element_add)(snd_ctl_t *handle, snd_ctl_elem_info_t *info);
diff -r d5a6770e7faf src/control/hcontrol.c
--- a/src/control/hcontrol.c	Fri May 19 18:26:41 2006 +0200
+++ b/src/control/hcontrol.c	Sat May 27 19:54:17 2006 +0100
@@ -49,6 +49,7 @@ to reduce overhead accessing the real co
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <pthread.h>
+#include <inttypes.h>
 #ifndef DOC_HIDDEN
 #define __USE_GNU
 #endif
@@ -757,6 +758,181 @@ int snd_hctl_handle_events(snd_hctl_t *h
 	return count;
 }
 
+
+static int uint32_to_message(snd_ctl_misc_t *misc, uint32_t value)
+{
+	unsigned int pointer = misc->length;
+	uint32_t *store = (uint32_t*) &misc->message[pointer];
+	*store = value;
+	misc->length += sizeof(uint32_t);
+	return 0;
+}
+
+static int message_to_uint32(snd_ctl_misc_t *misc, uint32_t *value)
+{
+	unsigned int pointer = misc->length;
+	uint32_t *store = (uint32_t*) &misc->message[pointer];
+	*value = *store;
+	misc->length += sizeof(uint32_t);
+	return 0;
+}
+
+
+static int add_int32_tlv_to_container(snd_ctl_misc_t *misc, uint32_t type, uint32_t value)
+{
+	uint32_to_message(misc, type);
+	uint32_to_message(misc, 4);
+	uint32_to_message(misc, value);
+	/* FIXME: Check for overflows */
+	return 0;
+}
+
+static int add_message_tlv_to_container(
+	snd_ctl_misc_t *misc, uint32_t length, unsigned char *message)
+{
+	unsigned int pointer = misc->length;
+	unsigned int n;
+	for(n=0; n<length; n++) {
+		misc->message[pointer++] = message[n];
+	}
+	misc->length = pointer;
+	/* FIXME: Check for overflows */
+	return 0;
+}
+
+
+static int container_open(snd_ctl_misc_t *misc, uint32_t type)
+{
+	uint32_to_message(misc, type);
+	uint32_to_message(misc, 0); /* This gets updated at container close */
+	return 0;
+}
+
+static int container_close(snd_ctl_misc_t *misc)
+{
+	uint32_t *store = (uint32_t*) &misc->message[sizeof(uint32_t)];
+	*store = misc->length;
+	return 0;
+}
+
+
+struct snd_ctl_elem_db_scale_type1 {
+	/* Type=1 for simple
+	 * dB = (X * db_per_devision) - db_offset
+	 * This equation is used instead of a more normal
+	 * dB = (( X - db_offset) * db_numerator) / db_denominator
+	 * in order to avoid any devision by zero possibilities,
+	 * save 4 bytes per db_scale and avoid floating point maths.
+	 *
+	 * Types >= 2 are for future more complex conversion functions.
+	 * All types have to have a length value, in case the user land
+	 * alsa lib does not yet understand the type. The length field allows
+	 * user land to safely skip this TLV.
+	 */
+	uint32_t type; /* 1 */
+	uint32_t length; /* 12 */
+	int32_t db_per_devision; /* Use db per devision * 100 */
+	int32_t db_offset; /* Use dB offset * 100. This identifies the 0dB point */
+	int32_t db_mute; /* The value, before conversion, that is equivalent to MUTE */
+};
+
+/**
+ * \brief Get misc information for an HCTL element
+ * \param elem HCTL element
+ * \param info HCTL element information
+ * \return 0 otherwise a negative error code on failure
+ */
+int snd_hctl_elem_get_db_gain(snd_hctl_elem_t *elem, long volume, long *db_gain)
+{
+	snd_ctl_misc_t *misc;
+	int err=0;
+	unsigned int received_length;
+	unsigned int tlv_type;
+	unsigned int tlv_length;
+	unsigned int container_type;
+	unsigned int container_length;
+	struct snd_ctl_elem_db_scale_type1 *db_scale_1;
+
+	assert(elem);
+	assert(elem->hctl);
+	misc=malloc(2048);
+	if (misc == NULL) {
+		err = -ENOMEM;
+		return err;
+	}
+	misc->version=1;
+	misc->length=0;
+	container_open(misc, SND_MISC_DB_SCALE);
+	add_int32_tlv_to_container(misc, SND_MISC_ELEM_NUMID, elem->id.numid);
+	container_close(misc);
+	misc->length=2040;
+	
+	err = snd_ctl_misc(elem->hctl->ctl, misc);
+	if (err) goto _err;
+
+	received_length = misc->length;
+	misc->length=0;
+	message_to_uint32(misc, &container_type);
+	switch (container_type) {
+		case SND_MISC_DB_SCALE:
+			message_to_uint32(misc, &container_length);
+			db_scale_1 = (struct snd_ctl_elem_db_scale_type1*) &misc->message[misc->length];
+			/* FIXME: Do more sanity checks here */
+			message_to_uint32(misc, &tlv_type);
+			switch (tlv_type) {
+				case SND_MISC_ELEM_DB_SCALE_TYPE1:
+					message_to_uint32(misc, &tlv_length);
+					if (tlv_length != 12) {
+						err = -EINVAL;
+						goto _err;
+					}
+					misc->length+=tlv_length;
+					if (volume == db_scale_1->db_mute) {
+						*db_gain=-9999999; /* Muted */
+						break;
+					}
+					/* Scale ca0106: from -51.50 dB to +12.00 dB in steps of 0.75 dB. 256 steps. */
+					/* Scale emu10k1 dsp controls: from -39.60 dB to 0.00 dB in steps of 0.4 dB. 100 steps. */
+					*db_gain=(volume * db_scale_1->db_per_devision) - db_scale_1->db_offset; 
+					break;
+				default:
+					err = -EINVAL;
+					goto _err;
+					break;
+			}
+			break;
+		default:
+			err = -EINVAL;
+			goto _err;
+	}
+
+_err:
+	free(misc);
+	return err;
+#if 0
+	switch (tlv_value) {
+	case 1:  /* Scale from -51.50 dB to +12.00 dB in steps of 0.75 dB. 256 steps. */
+		if (volume == 0) {
+			*db_gain=-9999999; /* Muted */
+			break;
+		}
+		*db_gain=(volume * 25) - 5175; /* For ca0106 controls */
+		break;
+	case 2:  /* Scale from -39.60 dB to 0.00 dB in steps of 0.4 dB. 100 steps. */
+		if (volume == 0) {
+			*db_gain=-9999999; /* Muted */
+			break;
+		}
+		*db_gain=(volume * 40) - 4000; /* For emu10k1 dsp controls */
+		break;
+	default:
+		*db_gain=-9999999; /* Muted */
+		return 1;
+	}
+	return 0;
+#endif
+}
+
 /**
  * \brief Get information for an HCTL element
  * \param elem HCTL element
diff -r d5a6770e7faf src/mixer/simple_none.c
--- a/src/mixer/simple_none.c	Fri May 19 18:26:41 2006 +0200
+++ b/src/mixer/simple_none.c	Sat May 27 19:54:17 2006 +0100
@@ -971,12 +971,41 @@ static int get_volume_ops(snd_mixer_elem
 	return 0;
 }
 
-static int get_dB_ops(snd_mixer_elem_t *elem ATTRIBUTE_UNUSED,
-		      int dir ATTRIBUTE_UNUSED,
-		      snd_mixer_selem_channel_id_t channel ATTRIBUTE_UNUSED,
-		      long *value ATTRIBUTE_UNUSED)
-{
-	return -ENXIO;
+static int get_dB_ops(snd_mixer_elem_t *elem,
+		      int dir,
+		      snd_mixer_selem_channel_id_t channel,
+		      long *value)
+{
+	selem_none_t *s = snd_mixer_elem_get_private(elem);
+	selem_ctl_t *c;
+	int err=-EINVAL;
+	long volume, db_gain;
+	if (dir==SM_PLAY) {
+		c = &s->ctls[CTL_PLAYBACK_VOLUME];
+		if (c->type==2) {
+			if (get_volume_ops(elem, dir, channel, &volume)) 
+				goto _err;
+			if ((err = snd_hctl_elem_get_db_gain(c->elem, volume, &db_gain)) < 0)
+				goto _err;
+		} else
+			goto _err;
+	} else if (dir==SM_CAPT) {
+		c = &s->ctls[CTL_CAPTURE_VOLUME];
+		if (c->type==2) {
+			if (get_volume_ops(elem, dir, channel, &volume)) 
+				goto _err;
+			if ((err = snd_hctl_elem_get_db_gain(c->elem, volume, &db_gain)) < 0)
+				goto _err;
+		} else
+			goto _err;
+
+	} else
+		goto _err;
+	err=0;
+	*value=db_gain;
+_err:
+	//if (err) printf("get_dB_ops:err=%d\n",err);
+	return err;
 }
 
 static int get_switch_ops(snd_mixer_elem_t *elem, int dir,

--------------020909000909010602050701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020909000909010602050701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------020909000909010602050701--
