From: Jaroslav Kysela <perex@suse.cz>
Subject: Control TLV extension - final proposal
Date: Wed, 28 Jun 2006 13:57:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606281350300.9302@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D0EB8271
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jun 2006 13:57:51 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	B23F09932B for <alsa-devel@alsa-project.org>;
	Wed, 28 Jun 2006 13:57:51 +0200 (MEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	9610E11034 for <alsa-devel@alsa-project.org>;
	Wed, 28 Jun 2006 13:57:51 +0200 (CEST)
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

Hi,

	here is the final TLV update. The patch bellow will add:

- TLV write support
- TLV callback mechanism for lowlevel drivers
- TLV change notification
- TLV ioctl support for user space control elements
- SNDRV_CTL_ELEM_ACCESS_TLV_READ / SNDRV_CTL_ELEM_ACCESS_TLV_WRITE info
  access flags

	I'd like to commit this patch really soon (we can fix bugs during 
testing). I'll do appropriate alsa-lib update in meanwhile.

						Jaroslav

diff -r d322c1177758 core/control.c
--- a/core/control.c	Fri Jun 23 15:18:41 2006 +0200
+++ b/core/control.c	Wed Jun 28 13:47:20 2006 +0200
@@ -236,12 +236,16 @@ struct snd_kcontrol *snd_ctl_new1(const 
 	kctl.id.index = ncontrol->index;
 	kctl.count = ncontrol->count ? ncontrol->count : 1;
 	access = ncontrol->access == 0 ? SNDRV_CTL_ELEM_ACCESS_READWRITE :
-		 (ncontrol->access & (SNDRV_CTL_ELEM_ACCESS_READWRITE|SNDRV_CTL_ELEM_ACCESS_INACTIVE|
-		 		      SNDRV_CTL_ELEM_ACCESS_DINDIRECT|SNDRV_CTL_ELEM_ACCESS_INDIRECT));
+		 (ncontrol->access & (SNDRV_CTL_ELEM_ACCESS_READWRITE|
+				      SNDRV_CTL_ELEM_ACCESS_INACTIVE|
+		 		      SNDRV_CTL_ELEM_ACCESS_DINDIRECT|
+		 		      SNDRV_CTL_ELEM_ACCESS_INDIRECT|
+		 		      SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE|
+		 		      SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK));
 	kctl.info = ncontrol->info;
 	kctl.get = ncontrol->get;
 	kctl.put = ncontrol->put;
-	kctl.tlv = ncontrol->tlv;
+	kctl.tlv.p = ncontrol->tlv.p;
 	kctl.private_value = ncontrol->private_value;
 	kctl.private_data = private_data;
 	return snd_ctl_new(&kctl, access);
@@ -883,6 +887,8 @@ struct user_element {
 	struct snd_ctl_elem_info info;
 	void *elem_data;		/* element data */
 	unsigned long elem_data_size;	/* size of element data in bytes */
+	void *tlv_data;			/* TLV data */
+	unsigned long tlv_data_size;	/* TLV data size */
 	void *priv_data;		/* private data (like strings for enumerated type) */
 	unsigned long priv_data_size;	/* size of private data in bytes */
 };
@@ -917,9 +923,46 @@ static int snd_ctl_elem_user_put(struct 
 	return change;
 }
 
+static int snd_ctl_elem_user_tlv(struct snd_kcontrol *kcontrol,
+				 int write_flag,
+				 unsigned int size,
+				 unsigned int __user *tlv)
+{
+	struct user_element *ue = kcontrol->private_data;
+	int change = 0;
+	void *new_data;
+
+	if (write_flag) {
+		if (size > 1024 * 128)	/* sane value */
+			return -EINVAL;
+		new_data = kmalloc(size, GFP_KERNEL);
+		if (new_data == NULL)
+			return -ENOMEM;
+		if (copy_from_user(new_data, tlv, size)) {
+			kfree(new_data);
+			return -EFAULT;
+		}
+		change = ue->tlv_data_size != size;
+		if (!change)
+			change = memcmp(ue->tlv_data, new_data, size);
+		kfree(ue->tlv_data);
+		ue->tlv_data = new_data;
+		ue->tlv_data_size = size;
+	} else {
+		if (size < ue->tlv_data_size)
+			return -ENOSPC;
+		if (copy_to_user(tlv, ue->tlv_data, ue->tlv_data_size))
+			return -EFAULT;
+	}
+	return change;
+}
+
 static void snd_ctl_elem_user_free(struct snd_kcontrol *kcontrol)
 {
-	kfree(kcontrol->private_data);
+	struct user_element *ue = kcontrol->private_data;
+	if (ue->tlv_data)
+		kfree(ue->tlv_data);
+	kfree(ue);
 }
 
 static int snd_ctl_elem_add(struct snd_ctl_file *file,
@@ -938,7 +981,8 @@ static int snd_ctl_elem_add(struct snd_c
 		return -EINVAL;
 	access = info->access == 0 ? SNDRV_CTL_ELEM_ACCESS_READWRITE :
 		(info->access & (SNDRV_CTL_ELEM_ACCESS_READWRITE|
-				 SNDRV_CTL_ELEM_ACCESS_INACTIVE));
+				 SNDRV_CTL_ELEM_ACCESS_INACTIVE|
+				 SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE));
 	info->id.numid = 0;
 	memset(&kctl, 0, sizeof(kctl));
 	down_write(&card->controls_rwsem);
@@ -964,6 +1008,10 @@ static int snd_ctl_elem_add(struct snd_c
 		kctl.get = snd_ctl_elem_user_get;
 	if (access & SNDRV_CTL_ELEM_ACCESS_WRITE)
 		kctl.put = snd_ctl_elem_user_put;
+	if (access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE) {
+		kctl.tlv.c = snd_ctl_elem_user_tlv;
+		access |= SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+	}
 	switch (info->type) {
 	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
 		private_size = sizeof(char);
@@ -1068,38 +1116,59 @@ static int snd_ctl_subscribe_events(stru
 	return 0;
 }
 
-static int snd_ctl_tlv_read(struct snd_card *card,
-                            struct snd_ctl_tlv __user *_tlv)
-{
+static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
+                             struct snd_ctl_tlv __user *_tlv,
+                             int write_flag)
+{
+	struct snd_card *card = file->card;
 	struct snd_ctl_tlv tlv;
 	struct snd_kcontrol *kctl;
+	struct snd_kcontrol_volatile *vd;
 	unsigned int len;
 	int err = 0;
 
 	if (copy_from_user(&tlv, _tlv, sizeof(tlv)))
 		return -EFAULT;
-        if (tlv.length < sizeof(unsigned int) * 3)
-                return -EINVAL;
-        down_read(&card->controls_rwsem);
-        kctl = snd_ctl_find_numid(card, tlv.numid);
-        if (kctl == NULL) {
-                err = -ENOENT;
-                goto __kctl_end;
-        }
-        if (kctl->tlv == NULL) {
-                err = -ENXIO;
-                goto __kctl_end;
-        }
-        len = kctl->tlv[1] + 2 * sizeof(unsigned int);
-        if (tlv.length < len) {
-                err = -ENOMEM;
-                goto __kctl_end;
-        }
-        if (copy_to_user(_tlv->tlv, kctl->tlv, len))
-        	err = -EFAULT;
+	if (tlv.length < sizeof(unsigned int) * 3)
+		return -EINVAL;
+	down_read(&card->controls_rwsem);
+	kctl = snd_ctl_find_numid(card, tlv.numid);
+	if (kctl == NULL) {
+		err = -ENOENT;
+		goto __kctl_end;
+	}
+	if (kctl->tlv.p == NULL) {
+		err = -ENXIO;
+		goto __kctl_end;
+	}
+	vd = &kctl->vd[tlv.numid - kctl->id.numid];
+	if (vd->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
+		if (file && vd->owner != NULL && vd->owner != file) {
+			err = -EPERM;
+			goto __kctl_end;
+		}
+		err = kctl->tlv.c(kctl, write_flag, tlv.length, _tlv->tlv); 
+		if (err > 0) {
+			up_read(&card->controls_rwsem);
+			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_TLV, &kctl->id);
+			return 0;
+		}
+	} else {
+		if (write_flag) {
+			err = -ENXIO;
+			goto __kctl_end;
+		}
+		len = kctl->tlv.p[1] + 2 * sizeof(unsigned int);
+		if (tlv.length < len) {
+			err = -ENOMEM;
+			goto __kctl_end;
+		}
+		if (copy_to_user(_tlv->tlv, kctl->tlv.p, len))
+			err = -EFAULT;
+	}
       __kctl_end:
-        up_read(&card->controls_rwsem);
-        return err;
+	up_read(&card->controls_rwsem);
+	return err;
 }
 
 static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -1140,8 +1209,10 @@ static long snd_ctl_ioctl(struct file *f
 		return snd_ctl_elem_remove(ctl, argp);
 	case SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS:
 		return snd_ctl_subscribe_events(ctl, ip);
-        case SNDRV_CTL_IOCTL_TLV_READ:
-                return snd_ctl_tlv_read(card, argp);
+	case SNDRV_CTL_IOCTL_TLV_READ:
+		return snd_ctl_tlv_ioctl(ctl, argp, 0);
+	case SNDRV_CTL_IOCTL_TLV_WRITE:
+		return snd_ctl_tlv_ioctl(ctl, argp, 1);
 	case SNDRV_CTL_IOCTL_POWER:
 		return -ENOPROTOOPT;
 	case SNDRV_CTL_IOCTL_POWER_STATE:
diff -r d322c1177758 include/asound.h
--- a/include/asound.h	Fri Jun 23 15:18:41 2006 +0200
+++ b/include/asound.h	Wed Jun 28 13:47:20 2006 +0200
@@ -727,10 +727,14 @@ typedef int __bitwise snd_ctl_elem_iface
 #define SNDRV_CTL_ELEM_ACCESS_WRITE		(1<<1)
 #define SNDRV_CTL_ELEM_ACCESS_READWRITE		(SNDRV_CTL_ELEM_ACCESS_READ|SNDRV_CTL_ELEM_ACCESS_WRITE)
 #define SNDRV_CTL_ELEM_ACCESS_VOLATILE		(1<<2)	/* control value may be changed without a notification */
-#define SNDRV_CTL_ELEM_ACCESS_TIMESTAMP		(1<<2)	/* when was control changed */
+#define SNDRV_CTL_ELEM_ACCESS_TIMESTAMP		(1<<3)	/* when was control changed */
+#define SNDRV_CTL_ELEM_ACCESS_TLV_READ		(1<<4)	/* TLV read is possible */
+#define SNDRV_CTL_ELEM_ACCESS_TLV_WRITE		(1<<5)	/* TLV write is possible */
+#define SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE	(SNDRV_CTL_ELEM_ACCESS_TLV_READ|SNDRV_CTL_ELEM_ACCESS_TLV_WRITE)
 #define SNDRV_CTL_ELEM_ACCESS_INACTIVE		(1<<8)	/* control does actually nothing, but may be updated */
 #define SNDRV_CTL_ELEM_ACCESS_LOCK		(1<<9)	/* write lock */
 #define SNDRV_CTL_ELEM_ACCESS_OWNER		(1<<10)	/* write lock owner */
+#define SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK	(1<<28)	/* kernel use a TLV callback */ 
 #define SNDRV_CTL_ELEM_ACCESS_USER		(1<<29) /* user space element */
 #define SNDRV_CTL_ELEM_ACCESS_DINDIRECT		(1<<30)	/* indirect access for matrix dimensions in the info structure */
 #define SNDRV_CTL_ELEM_ACCESS_INDIRECT		(1<<31)	/* indirect access for element value in the value structure */
@@ -838,6 +842,7 @@ enum {
 	SNDRV_CTL_IOCTL_ELEM_REPLACE = _IOWR('U', 0x18, struct snd_ctl_elem_info),
 	SNDRV_CTL_IOCTL_ELEM_REMOVE = _IOWR('U', 0x19, struct snd_ctl_elem_id),
 	SNDRV_CTL_IOCTL_TLV_READ = _IOWR('U', 0x1a, struct snd_ctl_tlv),
+	SNDRV_CTL_IOCTL_TLV_WRITE = _IOWR('U', 0x1b, struct snd_ctl_tlv),
 	SNDRV_CTL_IOCTL_HWDEP_NEXT_DEVICE = _IOWR('U', 0x20, int),
 	SNDRV_CTL_IOCTL_HWDEP_INFO = _IOR('U', 0x21, struct snd_hwdep_info),
 	SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE = _IOR('U', 0x30, int),
@@ -862,6 +867,7 @@ enum sndrv_ctl_event_type {
 #define SNDRV_CTL_EVENT_MASK_VALUE	(1<<0)	/* element value was changed */
 #define SNDRV_CTL_EVENT_MASK_INFO	(1<<1)	/* element info was changed */
 #define SNDRV_CTL_EVENT_MASK_ADD	(1<<2)	/* element was added */
+#define SNDRV_CTL_EVENT_MASK_TLV	(1<<3)	/* element TLV tree was changed */
 #define SNDRV_CTL_EVENT_MASK_REMOVE	(~0U)	/* element was removed */
 
 struct snd_ctl_event {
diff -r d322c1177758 include/control.h
--- a/include/control.h	Fri Jun 23 15:18:41 2006 +0200
+++ b/include/control.h	Wed Jun 28 13:47:20 2006 +0200
@@ -30,6 +30,11 @@ typedef int (snd_kcontrol_info_t) (struc
 typedef int (snd_kcontrol_info_t) (struct snd_kcontrol * kcontrol, struct snd_ctl_elem_info * uinfo);
 typedef int (snd_kcontrol_get_t) (struct snd_kcontrol * kcontrol, struct snd_ctl_elem_value * ucontrol);
 typedef int (snd_kcontrol_put_t) (struct snd_kcontrol * kcontrol, struct snd_ctl_elem_value * ucontrol);
+typedef int (snd_kcontrol_tlv_rw_t)(struct snd_kcontrol *kcontrol,
+				    int write_flag,
+				    unsigned int size,
+				    unsigned int __user *tlv);
+
 
 struct snd_kcontrol_new {
 	snd_ctl_elem_iface_t iface;	/* interface identifier */
@@ -42,7 +47,10 @@ struct snd_kcontrol_new {
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
 	snd_kcontrol_put_t *put;
-	unsigned int *tlv;
+	union {
+		snd_kcontrol_tlv_rw_t *c;
+		unsigned int *p;
+	} tlv;
 	unsigned long private_value;
 };
 
@@ -59,7 +67,11 @@ struct snd_kcontrol {
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
 	snd_kcontrol_put_t *put;
-	unsigned int *tlv;
+	snd_kcontrol_tlv_rw_t *tlv_rw;
+	union {
+		snd_kcontrol_tlv_rw_t *c;
+		unsigned int *p;
+	} tlv;
 	unsigned long private_value;
 	void *private_data;
 	void (*private_free)(struct snd_kcontrol *kcontrol);

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
