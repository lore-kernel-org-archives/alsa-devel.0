From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Thu, 15 Dec 2005 18:34:44 +0000
Message-ID: <43A1B744.2050703@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050800010106080301060201"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050800010106080301060201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have implemented dB gain reporting for ALSA mixer controls.
By applying the attached patches to alsa-driver and alsa-lib, one will 
then see dB values appear in alsamixer. (I added support to alsamixer a 
long time ago)

Currently, only the snd-ca0106 sound card reports the values.

If the method is agreed upon, I will extend it to many more sound cards.

General description:

The only piece of information reported by the kernel sound driver is a 
db_scale value.  It is a unsigned int at application layer, but the 
current IOCTL TLV truncates this to 32bit unsigned int. alsa-lib then 
uses this value to decide which translation function to apply to the 
currently available "volume" value.
I view this "db_scale" value as simply a hint from the low level driver 
at which conversion function should be used.
The conversion function in alsa-lib can then be as simple or as 
complicated as required.

I have implemented a new IOCTL for the mixer "SNDRV_CTL_IOCTL_MISC".
This uses a TLV (Type Length Value) approach. This is endlessly 
extensible, and could be used instead of the "SNDRV_CTL_IOCTL_ELEM_INFO".
It supports nesting of TLVs.

Any comments?

James

--------------050800010106080301060201
Content-Type: text/x-patch;
 name="alsa-driver.db.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-driver.db.patch"

Index: alsa-driver/alsa-kernel/core/control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/control.c,v
retrieving revision 1.69
diff -u -r1.69 control.c
--- alsa-driver/alsa-kernel/core/control.c	20 Nov 2005 14:06:59 -0000	1.69
+++ alsa-driver/alsa-kernel/core/control.c	15 Dec 2005 18:16:43 -0000
@@ -237,6 +237,7 @@
 	kctl.info = ncontrol->info;
 	kctl.get = ncontrol->get;
 	kctl.put = ncontrol->put;
+	kctl.db_scale = ncontrol->db_scale;
 	kctl.private_value = ncontrol->private_value;
 	kctl.private_data = private_data;
 	return snd_ctl_new(&kctl, access);
@@ -547,6 +548,138 @@
 	return 0;
 }
 
+static int uint32_to_message(struct snd_ctl_misc *misc, unsigned int value)
+{
+	unsigned int pointer = misc->length;
+	/* If unsigned int is a 64bit value, we will just ignore the high 32bits. */
+	misc->message[pointer++] = value & 0xff;
+	misc->message[pointer++] = (value >> 8) & 0xff;
+	misc->message[pointer++] = (value >> 16) & 0xff;
+	misc->message[pointer++] = (value >> 24) & 0xff;
+	misc->length = pointer;
+	return 0;
+}
+
+static int message_to_uint32(struct snd_ctl_misc *misc, unsigned int *value)
+{
+	unsigned int pointer = misc->length;
+	unsigned int val;
+	val = misc->message[pointer++] ;
+	val |= ((misc->message[pointer++]) << 8);
+	val |= ((misc->message[pointer++]) << 16);
+	val |= ((misc->message[pointer++]) << 24);
+	misc->length = pointer;
+	*value = val;
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
+	unsigned int pointer = 4;
+	unsigned int value = misc->length;
+	misc->message[pointer++] = value & 0xff;
+	misc->message[pointer++] = (value >> 8) & 0xff;
+	misc->message[pointer++] = (value >> 16) & 0xff;
+	misc->message[pointer++] = (value >> 24) & 0xff;
+	return 0;
+}
+
+static int snd_ctl_misc_user(struct snd_ctl_file *ctl,
+				  struct snd_ctl_misc __user *_misc)
+{
+	struct snd_ctl_misc *misc;
+	struct snd_card *card = ctl->card;
+	struct snd_kcontrol *kctl;
+	int result;
+	int err=0;
+	int numid;
+	unsigned int received_length;
+	unsigned int tlv_type;
+	unsigned int tlv_length;
+	unsigned int tlv_value;
+	unsigned int container_type;
+	unsigned int container_length;
+	
+	misc = kmalloc(sizeof(*misc), GFP_KERNEL);
+	if (misc == NULL)
+		return -ENOMEM;	
+	if (copy_from_user(misc, _misc, sizeof(*misc))) {
+		result = -EFAULT;
+		goto exit_free;
+	}
+	received_length = misc->length;
+	misc->length=0;
+	message_to_uint32(misc, &container_type);
+	switch (container_type) {
+		case SND_MISC_DB_SCALE:
+			message_to_uint32(misc, &container_length);
+			/* FIXME: Do more sanity checks here */
+			message_to_uint32(misc, &tlv_type);
+			switch (tlv_type) {
+				case SND_MISC_ELEM_NUMID:
+					message_to_uint32(misc, &tlv_length);
+					if (tlv_length != 4) {
+						err = -EINVAL;
+						goto exit_free;
+					}
+					message_to_uint32(misc, &tlv_value);
+					break;
+				default:
+					err = -EINVAL;
+					goto exit_free;
+					break;
+			}
+			break;
+		default:
+			err = -EINVAL;
+			goto exit_free;
+	}
+	numid=tlv_value;
+	down_read(&card->controls_rwsem);
+	kctl = snd_ctl_find_numid(card, numid);
+	if (kctl == NULL) {
+		result = -ENOENT;
+		snd_printk("exit_up1\n");
+		goto exit_up;
+	}
+	if (kctl->db_scale == 0) { /* Value defaults to zero when not implemented. */
+		err = -EINVAL;
+		goto exit_up;
+	}
+	misc->type=1;
+	misc->length=0;
+	container_open(misc, SND_MISC_DB_SCALE);
+	add_int32_tlv_to_container(misc, SND_MISC_ELEM_DB_SCALE, kctl->db_scale);
+	container_close(misc);
+	if (copy_to_user(_misc, misc, sizeof(*misc)))
+		result = -EFAULT;
+	
+exit_up:
+	up_read(&card->controls_rwsem);
+exit_free:
+	kfree(misc);
+exit:
+	return result;
+}
+
 static int snd_ctl_elem_list(struct snd_card *card,
 			     struct snd_ctl_elem_list __user *_list)
 {
@@ -1062,6 +1195,8 @@
 		return snd_ctl_elem_add_user(ctl, argp, 1);
 	case SNDRV_CTL_IOCTL_ELEM_REMOVE:
 		return snd_ctl_elem_remove(ctl, argp);
+	case SNDRV_CTL_IOCTL_MISC:
+		return snd_ctl_misc_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS:
 		return snd_ctl_subscribe_events(ctl, ip);
 	case SNDRV_CTL_IOCTL_POWER:
Index: alsa-driver/alsa-kernel/include/asound.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/asound.h,v
retrieving revision 1.57
diff -u -r1.57 asound.h
--- alsa-driver/alsa-kernel/include/asound.h	17 Nov 2005 13:51:18 -0000	1.57
+++ alsa-driver/alsa-kernel/include/asound.h	15 Dec 2005 18:16:43 -0000
@@ -818,6 +818,18 @@
         unsigned char reserved[128-sizeof(struct timespec)];
 };
 
+struct snd_ctl_misc {
+	u32 type;
+	u32 length;
+	unsigned char message[2040];
+};
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
@@ -833,6 +845,7 @@
 	SNDRV_CTL_IOCTL_ELEM_REMOVE = _IOWR('U', 0x19, struct snd_ctl_elem_id),
 	SNDRV_CTL_IOCTL_HWDEP_NEXT_DEVICE = _IOWR('U', 0x20, int),
 	SNDRV_CTL_IOCTL_HWDEP_INFO = _IOR('U', 0x21, struct snd_hwdep_info),
+	SNDRV_CTL_IOCTL_MISC = _IOR('U', 0x22, struct snd_ctl_misc),
 	SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE = _IOR('U', 0x30, int),
 	SNDRV_CTL_IOCTL_PCM_INFO = _IOWR('U', 0x31, struct snd_pcm_info),
 	SNDRV_CTL_IOCTL_PCM_PREFER_SUBDEVICE = _IOW('U', 0x32, int),
Index: alsa-driver/alsa-kernel/include/control.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/control.h,v
retrieving revision 1.14
diff -u -r1.14 control.h
--- alsa-driver/alsa-kernel/include/control.h	17 Nov 2005 13:53:23 -0000	1.14
+++ alsa-driver/alsa-kernel/include/control.h	15 Dec 2005 18:16:43 -0000
@@ -42,6 +42,7 @@
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
 	snd_kcontrol_put_t *put;
+	unsigned int db_scale;
 	unsigned long private_value;
 };
 
@@ -58,6 +59,7 @@
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
 	snd_kcontrol_put_t *put;
+	unsigned int db_scale;
 	unsigned long private_value;
 	void *private_data;
 	void (*private_free)(struct snd_kcontrol *kcontrol);
Index: alsa-driver/alsa-kernel/pci/ca0106/ca0106_mixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ca0106/ca0106_mixer.c,v
retrieving revision 1.9
diff -u -r1.9 ca0106_mixer.c
--- alsa-driver/alsa-kernel/pci/ca0106/ca0106_mixer.c	17 Nov 2005 14:55:40 -0000	1.9
+++ alsa-driver/alsa-kernel/pci/ca0106/ca0106_mixer.c	15 Dec 2005 18:16:43 -0000
@@ -329,37 +329,38 @@
 	return 1;
 }
 
-#define CA_VOLUME(xname,chid,reg) \
+#define CA_VOLUME(xname,chid,reg,db) \
 {								\
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,	\
 	.info = snd_ca0106_volume_info,				\
 	.get =          snd_ca0106_volume_get,			\
 	.put =          snd_ca0106_volume_put,			\
-	.private_value = ((chid) << 8) | (reg)			\
+	.private_value = ((chid) << 8) | (reg),			\
+	.db_scale = db						\
 }
 
 
 static struct snd_kcontrol_new snd_ca0106_volume_ctls[] __devinitdata = {
 	CA_VOLUME("Analog Front Playback Volume",
-		  CONTROL_FRONT_CHANNEL, PLAYBACK_VOLUME2),
+		  CONTROL_FRONT_CHANNEL, PLAYBACK_VOLUME2, 1),
         CA_VOLUME("Analog Rear Playback Volume",
-		  CONTROL_REAR_CHANNEL, PLAYBACK_VOLUME2),
+		  CONTROL_REAR_CHANNEL, PLAYBACK_VOLUME2, 1),
 	CA_VOLUME("Analog Center/LFE Playback Volume",
-		  CONTROL_CENTER_LFE_CHANNEL, PLAYBACK_VOLUME2),
+		  CONTROL_CENTER_LFE_CHANNEL, PLAYBACK_VOLUME2, 1),
         CA_VOLUME("Analog Side Playback Volume",
-		  CONTROL_UNKNOWN_CHANNEL, PLAYBACK_VOLUME2),
+		  CONTROL_UNKNOWN_CHANNEL, PLAYBACK_VOLUME2, 1),
 
         CA_VOLUME("SPDIF Front Playback Volume",
-		  CONTROL_FRONT_CHANNEL, PLAYBACK_VOLUME1),
+		  CONTROL_FRONT_CHANNEL, PLAYBACK_VOLUME1, 1),
 	CA_VOLUME("SPDIF Rear Playback Volume",
-		  CONTROL_REAR_CHANNEL, PLAYBACK_VOLUME1),
+		  CONTROL_REAR_CHANNEL, PLAYBACK_VOLUME1, 1),
 	CA_VOLUME("SPDIF Center/LFE Playback Volume",
-		  CONTROL_CENTER_LFE_CHANNEL, PLAYBACK_VOLUME1),
+		  CONTROL_CENTER_LFE_CHANNEL, PLAYBACK_VOLUME1, 1),
 	CA_VOLUME("SPDIF Unknown Playback Volume",
-		  CONTROL_UNKNOWN_CHANNEL, PLAYBACK_VOLUME1),
+		  CONTROL_UNKNOWN_CHANNEL, PLAYBACK_VOLUME1, 1),
 
         CA_VOLUME("CAPTURE feedback Playback Volume",
-		  1, CAPTURE_CONTROL),
+		  1, CAPTURE_CONTROL, 1),
 
 	{
 		.access =	SNDRV_CTL_ELEM_ACCESS_READ,

--------------050800010106080301060201
Content-Type: text/x-patch;
 name="alsa-lib.db.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib.db.patch"

Index: alsa-lib/include/control.h
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/include/control.h,v
retrieving revision 1.101
diff -u -r1.101 control.h
--- alsa-lib/include/control.h	9 Jun 2005 17:12:08 -0000	1.101
+++ alsa-lib/include/control.h	15 Dec 2005 18:17:27 -0000
@@ -53,6 +53,12 @@
 /** CTL card info container */
 typedef struct _snd_ctl_card_info snd_ctl_card_info_t;
 
+/** CTL misc container */
+typedef struct _snd_ctl_misc snd_ctl_misc_t;
+
+/** CTL misc container */
+/* FIXME: Add */
+
 /** CTL element identifier container */
 typedef struct _snd_ctl_elem_id snd_ctl_elem_id_t;
 
@@ -212,6 +218,8 @@
 int snd_ctl_poll_descriptors_revents(snd_ctl_t *ctl, struct pollfd *pfds, unsigned int nfds, unsigned short *revents);
 int snd_ctl_subscribe_events(snd_ctl_t *ctl, int subscribe);
 int snd_ctl_card_info(snd_ctl_t *ctl, snd_ctl_card_info_t *info);
+int snd_ctl_misc(snd_ctl_t *ctl, snd_ctl_misc_t *misc);
+int snd_ctl_elem_get_db_scale(snd_ctl_t *ctl, unsigned int numid, long *db_scale);
 int snd_ctl_elem_list(snd_ctl_t *ctl, snd_ctl_elem_list_t * list);
 int snd_ctl_elem_info(snd_ctl_t *ctl, snd_ctl_elem_info_t *info);
 int snd_ctl_elem_read(snd_ctl_t *ctl, snd_ctl_elem_value_t *value);
@@ -485,6 +493,8 @@
 int snd_hctl_elem_info(snd_hctl_elem_t *elem, snd_ctl_elem_info_t * info);
 int snd_hctl_elem_read(snd_hctl_elem_t *elem, snd_ctl_elem_value_t * value);
 int snd_hctl_elem_write(snd_hctl_elem_t *elem, snd_ctl_elem_value_t * value);
+int snd_hctl_elem_misc(snd_hctl_elem_t *elem, snd_ctl_misc_t * misc);
+int snd_hctl_elem_get_db_gain(snd_hctl_elem_t *elem, long volume, long *db_gain);
 
 snd_hctl_t *snd_hctl_elem_get_hctl(snd_hctl_elem_t *elem);
 
Index: alsa-lib/include/local.h
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/include/local.h,v
retrieving revision 1.44
diff -u -r1.44 local.h
--- alsa-lib/include/local.h	29 Sep 2005 19:11:50 -0000	1.44
+++ alsa-lib/include/local.h	15 Dec 2005 18:17:27 -0000
@@ -46,6 +46,7 @@
 #define _snd_pcm_status sndrv_pcm_status
 
 #define _snd_ctl_card_info sndrv_ctl_card_info
+#define _snd_ctl_misc sndrv_ctl_misc
 #define _snd_ctl_elem_id sndrv_ctl_elem_id
 #define _snd_ctl_elem_list sndrv_ctl_elem_list
 #define _snd_ctl_elem_info sndrv_ctl_elem_info
Index: alsa-lib/include/sound/asound.h
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/include/sound/asound.h,v
retrieving revision 1.22
diff -u -r1.22 asound.h
--- alsa-lib/include/sound/asound.h	16 Aug 2005 12:19:15 -0000	1.22
+++ alsa-lib/include/sound/asound.h	15 Dec 2005 18:17:27 -0000
@@ -847,6 +847,18 @@
         unsigned char reserved[128-sizeof(struct timespec)];
 };
 
+struct sndrv_ctl_misc {
+	unsigned int type;  /* This should be uint32_t */
+	unsigned int length; /* This should be uint32_t */
+	unsigned char message[2040];
+};
+
+#define SND_MISC_DB_SCALE 2
+/* Request */
+#define SND_MISC_ELEM_NUMID 2
+/* Response */
+#define SND_MISC_ELEM_DB_SCALE 2
+
 enum {
 	SNDRV_CTL_IOCTL_PVERSION = _IOR('U', 0x00, int),
 	SNDRV_CTL_IOCTL_CARD_INFO = _IOR('U', 0x01, struct sndrv_ctl_card_info),
@@ -862,6 +874,7 @@
 	SNDRV_CTL_IOCTL_ELEM_REMOVE = _IOWR('U', 0x19, struct sndrv_ctl_elem_id),
 	SNDRV_CTL_IOCTL_HWDEP_NEXT_DEVICE = _IOWR('U', 0x20, int),
 	SNDRV_CTL_IOCTL_HWDEP_INFO = _IOR('U', 0x21, struct sndrv_hwdep_info),
+	SNDRV_CTL_IOCTL_MISC = _IOR('U', 0x22, struct sndrv_ctl_misc),
 	SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE = _IOR('U', 0x30, int),
 	SNDRV_CTL_IOCTL_PCM_INFO = _IOWR('U', 0x31, struct sndrv_pcm_info),
 	SNDRV_CTL_IOCTL_PCM_PREFER_SUBDEVICE = _IOW('U', 0x32, int),
Index: alsa-lib/src/control/control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/control/control.c,v
retrieving revision 1.108
diff -u -r1.108 control.c
--- alsa-lib/src/control/control.c	14 Nov 2005 10:18:22 -0000	1.108
+++ alsa-lib/src/control/control.c	15 Dec 2005 18:17:27 -0000
@@ -238,6 +238,138 @@
 }
 
 /**
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
+}
+
+static int uint32_to_message(snd_ctl_misc_t *misc, unsigned int value)
+{
+	unsigned int pointer = misc->length;
+	/* If unsigned int is a 64bit value, we will just ignore the high 32bits. */
+	misc->message[pointer++] = value & 0xff;
+	misc->message[pointer++] = (value >> 8) & 0xff;
+	misc->message[pointer++] = (value >> 16) & 0xff;
+	misc->message[pointer++] = (value >> 24) & 0xff;
+	misc->length = pointer;
+	return 0;
+}
+
+static int message_to_uint32(snd_ctl_misc_t *misc, unsigned int *value)
+{
+	unsigned int pointer = misc->length;
+	unsigned int val;
+	val = misc->message[pointer++] ;
+	val |= ((misc->message[pointer++]) << 8);
+	val |= ((misc->message[pointer++]) << 16);
+	val |= ((misc->message[pointer++]) << 24);
+	misc->length = pointer;
+	*value = val;
+	return 0;
+}
+
+static int add_int32_tlv_to_container(snd_ctl_misc_t *misc, unsigned int type, unsigned int value)
+{
+	uint32_to_message(misc, type);
+	uint32_to_message(misc, 4);
+	uint32_to_message(misc, value);
+	/* FIXME: Check for overflows */
+	return 0;
+}
+
+static int container_open(snd_ctl_misc_t *misc, unsigned int type)
+{
+        uint32_to_message(misc, type);
+        uint32_to_message(misc, 0); /* This gets updated at container close */
+	return 0;
+}
+
+static int container_close(snd_ctl_misc_t *misc)
+{
+	unsigned int pointer = 4;
+	unsigned int value = misc->length;
+	misc->message[pointer++] = value & 0xff;
+	misc->message[pointer++] = (value >> 8) & 0xff;
+	misc->message[pointer++] = (value >> 16) & 0xff;
+	misc->message[pointer++] = (value >> 24) & 0xff;
+	return 0;
+}
+
+/**
+ * \brief Get/Set misc related information
+ * \param ctl CTL handle
+ * \param misc pointer
+ * \return 0 on success otherwise a negative error code
+ * db_scale: index into volume to db gain function.
+ */
+int snd_ctl_elem_get_db_scale(snd_ctl_t *ctl, unsigned int numid, long *db_scale)
+{
+	snd_ctl_misc_t *misc;
+	int err=0;
+	unsigned int received_length;
+	unsigned int tlv_type;
+	unsigned int tlv_length;
+	unsigned int tlv_value;
+	unsigned int container_type;
+	unsigned int container_length;
+
+	assert(ctl && db_scale);
+	misc=malloc(sizeof(*misc));
+	if (misc == NULL) {
+		err = -ENOMEM;
+		return err;
+	}
+	misc->type=1;
+	misc->length=0;
+	container_open(misc, SND_MISC_DB_SCALE);
+	add_int32_tlv_to_container(misc, SND_MISC_ELEM_NUMID, numid);
+	container_close(misc);
+	
+	err = ctl->ops->misc(ctl, misc);
+	received_length = misc->length;
+	misc->length=0;
+	message_to_uint32(misc, &container_type);
+	switch (container_type) {
+		case SND_MISC_DB_SCALE:
+			message_to_uint32(misc, &container_length);
+			/* FIXME: Do more sanity checks here */
+			message_to_uint32(misc, &tlv_type);
+			switch (tlv_type) {
+				case SND_MISC_ELEM_DB_SCALE:
+					message_to_uint32(misc, &tlv_length);
+					if (tlv_length != 4) {
+						err = -EINVAL;
+						goto _err;
+					}
+					message_to_uint32(misc, &tlv_value);
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
+	*db_scale=tlv_value;
+
+_err:
+	free(misc);
+	return err;
+}
+
+
+/**
  * \brief Get a list of element identifiers
  * \param ctl CTL handle
  * \param list CTL element identifiers list pointer
Index: alsa-lib/src/control/control_hw.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/control/control_hw.c,v
retrieving revision 1.43
diff -u -r1.43 control_hw.c
--- alsa-lib/src/control/control_hw.c	9 Jun 2005 17:14:22 -0000	1.43
+++ alsa-lib/src/control/control_hw.c	15 Dec 2005 18:17:27 -0000
@@ -128,6 +128,16 @@
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
@@ -296,6 +306,7 @@
 	.async = snd_ctl_hw_async,
 	.subscribe_events = snd_ctl_hw_subscribe_events,
 	.card_info = snd_ctl_hw_card_info,
+	.misc = snd_ctl_hw_misc,
 	.element_list = snd_ctl_hw_elem_list,
 	.element_info = snd_ctl_hw_elem_info,
 	.element_add = snd_ctl_hw_elem_add,
Index: alsa-lib/src/control/control_local.h
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/control/control_local.h,v
retrieving revision 1.31
diff -u -r1.31 control_local.h
--- alsa-lib/src/control/control_local.h	9 Jun 2005 17:09:33 -0000	1.31
+++ alsa-lib/src/control/control_local.h	15 Dec 2005 18:17:27 -0000
@@ -27,6 +27,7 @@
 	int (*async)(snd_ctl_t *handle, int sig, pid_t pid);
 	int (*subscribe_events)(snd_ctl_t *handle, int subscribe);
 	int (*card_info)(snd_ctl_t *handle, snd_ctl_card_info_t *info);
+	int (*misc)(snd_ctl_t *handle, snd_ctl_misc_t *info);
 	int (*element_list)(snd_ctl_t *handle, snd_ctl_elem_list_t *list);
 	int (*element_info)(snd_ctl_t *handle, snd_ctl_elem_info_t *info);
 	int (*element_add)(snd_ctl_t *handle, snd_ctl_elem_info_t *info);
Index: alsa-lib/src/control/hcontrol.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/control/hcontrol.c,v
retrieving revision 1.36
diff -u -r1.36 hcontrol.c
--- alsa-lib/src/control/hcontrol.c	28 Jun 2005 10:24:44 -0000	1.36
+++ alsa-lib/src/control/hcontrol.c	15 Dec 2005 18:17:27 -0000
@@ -759,6 +759,42 @@
 }
 
 /**
+ * \brief Get misc information for an HCTL element
+ * \param elem HCTL element
+ * \param info HCTL element information
+ * \return 0 otherwise a negative error code on failure
+ */
+int snd_hctl_elem_get_db_gain(snd_hctl_elem_t *elem, long volume, long *db_gain)
+{
+	int err;
+	long db_scale;
+	assert(elem);
+	assert(elem->hctl);
+	if ((err = snd_ctl_elem_get_db_scale(elem->hctl->ctl, elem->id.numid, &db_scale)) < 0)
+		return err;
+	switch (db_scale) {
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
+}
+
+/**
  * \brief Get information for an HCTL element
  * \param elem HCTL element
  * \param info HCTL element information
Index: alsa-lib/src/mixer/simple_none.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/mixer/simple_none.c,v
retrieving revision 1.8
diff -u -r1.8 simple_none.c
--- alsa-lib/src/mixer/simple_none.c	2 Dec 2005 13:39:24 -0000	1.8
+++ alsa-lib/src/mixer/simple_none.c	15 Dec 2005 18:17:27 -0000
@@ -971,12 +971,36 @@
 	return 0;
 }
 
-static int get_dB_ops(snd_mixer_elem_t *elem ATTRIBUTE_UNUSED,
-		      int dir ATTRIBUTE_UNUSED,
-		      snd_mixer_selem_channel_id_t channel ATTRIBUTE_UNUSED,
-		      long *value ATTRIBUTE_UNUSED)
+static int get_dB_ops(snd_mixer_elem_t *elem,
+		      int dir,
+		      snd_mixer_selem_channel_id_t channel,
+		      long *value)
 {
-	return -ENXIO;
+	selem_none_t *s = snd_mixer_elem_get_private(elem);
+	selem_ctl_t *c;
+	int err=0;
+	int n;
+	long volume, db_gain;
+	if (dir==SM_PLAY) {
+		c = &s->ctls[CTL_PLAYBACK_VOLUME];
+		if (c->type==2) {
+			if (get_volume_ops(elem, dir, channel, &volume)) 
+				return -EINVAL;
+			if ((err = snd_hctl_elem_get_db_gain(c->elem, volume, &db_gain)) < 0)
+				goto _err;
+		}
+	}
+        //for (n=0;n<=CTL_LAST;n++) {
+	//	c = &s->ctls[n];
+	//	printf("%d:c->inactive=%d\n",n, c->inactive);
+	//}
+	//misc=malloc(2048);
+	//if ((err = snd_hctl_misc(elem->ctl, misc)) < 0)
+	//	return err;
+	//printf("misc=%p, *misc=%d\n",misc, (int) *misc);
+	*value=db_gain;
+_err:
+	return err;
 }
 
 static int get_switch_ops(snd_mixer_elem_t *elem, int dir,

--------------050800010106080301060201--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
