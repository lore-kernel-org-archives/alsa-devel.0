From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RFC: minimalistic TLV implementation
Date: Thu, 1 Jun 2006 16:08:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606011602020.9144@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0605311500480.9226@tm8103.perex-int.cz>
	<s5hzmgx6rtb.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606011510010.9144@tm8103.perex-int.cz>
	<s5hpsht6lo6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 62FE912B
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jun 2006 16:08:14 +0200 (MEST)
In-Reply-To: <s5hpsht6lo6.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 1 Jun 2006, Takashi Iwai wrote:

> Yes.  It's similar but a really big difference if you consider about
> 32/64bit compatibility.
> 
> Also, the order of "TLV" is type-length-value.

Ok, the second version of my patch. Note: in the ca0106 driver, only
three lines (if I don't count one empty line) are required to add
the dB scale information.

					Jaroslav

diff -r 96e63842ba5d core/control.c
--- a/core/control.c	Wed May 31 11:55:17 2006 +0200
+++ b/core/control.c	Thu Jun  1 16:04:37 2006 +0200
@@ -241,6 +241,7 @@ struct snd_kcontrol *snd_ctl_new1(const 
 	kctl.info = ncontrol->info;
 	kctl.get = ncontrol->get;
 	kctl.put = ncontrol->put;
+	kctl.tlv = ncontrol->tlv;
 	kctl.private_value = ncontrol->private_value;
 	kctl.private_data = private_data;
 	return snd_ctl_new(&kctl, access);
@@ -1067,6 +1068,46 @@ static int snd_ctl_subscribe_events(stru
 	return 0;
 }
 
+static int snd_ctl_tlv_read(struct snd_card *card, struct snd_ctl_tlv __user *_tlv)
+{
+	struct snd_ctl_tlv tlv;
+	struct snd_kcontrol *kctl;
+	unsigned int len;
+	int err = 0;
+
+	if (copy_to_user(&tlv, _tlv, sizeof(tlv)))
+		return -EFAULT;
+        if (tlv.length < sizeof(unsigned int) * 3)
+                return -EINVAL;
+        if (tlv.flags & SNDRV_CTL_TLV_NUMID) {
+        	down_read(&card->controls_rwsem);
+                kctl = snd_ctl_find_numid(card, tlv.ident);
+                if (kctl == NULL) {
+                        err = -ENOENT;
+                        goto __kctl_end;
+                }
+                if (kctl->tlv == NULL) {
+                        err = -EIO;
+                        goto __kctl_end;
+                }
+                len = *(((unsigned int *)kctl->tlv) + 1) +
+                      2 * sizeof(unsigned int);
+                if (tlv.length < len) {
+                        err = -ENOMEM;
+                        goto __kctl_end;
+                }
+        	if (copy_to_user((unsigned char *)_tlv + tlv.data_offset,
+        	                 kctl->tlv, len))
+        		err = -EFAULT;
+              __kctl_end:
+        	up_read(&card->controls_rwsem);
+        } else {
+                /* not implemented */
+                err = -EINVAL;
+        }
+        return err;
+}
+
 static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct snd_ctl_file *ctl;
@@ -1086,11 +1127,11 @@ static long snd_ctl_ioctl(struct file *f
 	case SNDRV_CTL_IOCTL_CARD_INFO:
 		return snd_ctl_card_info(card, ctl, cmd, argp);
 	case SNDRV_CTL_IOCTL_ELEM_LIST:
-		return snd_ctl_elem_list(ctl->card, argp);
+		return snd_ctl_elem_list(card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_INFO:
 		return snd_ctl_elem_info_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_READ:
-		return snd_ctl_elem_read_user(ctl->card, argp);
+		return snd_ctl_elem_read_user(card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_WRITE:
 		return snd_ctl_elem_write_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_LOCK:
@@ -1105,6 +1146,8 @@ static long snd_ctl_ioctl(struct file *f
 		return snd_ctl_elem_remove(ctl, argp);
 	case SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS:
 		return snd_ctl_subscribe_events(ctl, ip);
+        case SNDRV_CTL_IOCTL_TLV_READ:
+                return snd_ctl_tlv_read(card, argp);
 	case SNDRV_CTL_IOCTL_POWER:
 		return -ENOPROTOOPT;
 	case SNDRV_CTL_IOCTL_POWER_STATE:
diff -r 96e63842ba5d include/asound.h
--- a/include/asound.h	Wed May 31 11:55:17 2006 +0200
+++ b/include/asound.h	Thu Jun  1 16:04:37 2006 +0200
@@ -818,6 +818,26 @@ struct snd_ctl_elem_value {
         unsigned char reserved[128-sizeof(struct timespec)];
 };
 
+#define SNDRV_CTL_TLV_NUMID	(1<<0)	/* ident is numid, otherwise request global TLV info */
+
+#define SNDRV_CTL_TLVT_LEVEL	0	/* one level down - group of TLVs */
+#define SNDRV_CTL_TLVT_DB_SCALE	1	/* dB scale */
+
+struct snd_ctl_tlv {
+        unsigned int flags;
+        unsigned int length;
+        unsigned int ident;
+        /*
+         * TLV structure is:
+         *   unsigned int type	- see SNDRV_CTL_TLVT_*
+         *   unsigned int length
+         *   .... data aligned to sizeof(unsigned int), use
+         *        block_length = (length + (sizeof(unsigned int) - 1)) &
+         *                       ~(sizeof(unsigned int) - 1)) ....
+         */
+        unsigned int data_offset;	/* offset to data in bytes behind ioctl structure */
+};
+
 enum {
 	SNDRV_CTL_IOCTL_PVERSION = _IOR('U', 0x00, int),
 	SNDRV_CTL_IOCTL_CARD_INFO = _IOR('U', 0x01, struct snd_ctl_card_info),
@@ -831,6 +851,7 @@ enum {
 	SNDRV_CTL_IOCTL_ELEM_ADD = _IOWR('U', 0x17, struct snd_ctl_elem_info),
 	SNDRV_CTL_IOCTL_ELEM_REPLACE = _IOWR('U', 0x18, struct snd_ctl_elem_info),
 	SNDRV_CTL_IOCTL_ELEM_REMOVE = _IOWR('U', 0x19, struct snd_ctl_elem_id),
+	SNDRV_CTL_IOCTL_TLV_READ = _IOWR('U', 0x1a, struct snd_ctl_tlv),
 	SNDRV_CTL_IOCTL_HWDEP_NEXT_DEVICE = _IOWR('U', 0x20, int),
 	SNDRV_CTL_IOCTL_HWDEP_INFO = _IOR('U', 0x21, struct snd_hwdep_info),
 	SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE = _IOR('U', 0x30, int),
diff -r 96e63842ba5d include/control.h
--- a/include/control.h	Wed May 31 11:55:17 2006 +0200
+++ b/include/control.h	Thu Jun  1 16:04:37 2006 +0200
@@ -42,6 +42,7 @@ struct snd_kcontrol_new {
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
 	snd_kcontrol_put_t *put;
+	unsigned int *tlv;
 	unsigned long private_value;
 };
 
@@ -58,6 +59,7 @@ struct snd_kcontrol {
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
 	snd_kcontrol_put_t *put;
+	unsigned int *tlv;
 	unsigned long private_value;
 	void *private_data;
 	void (*private_free)(struct snd_kcontrol *kcontrol);
diff -r 96e63842ba5d pci/ca0106/ca0106_mixer.c
--- a/pci/ca0106/ca0106_mixer.c	Wed May 31 11:55:17 2006 +0200
+++ b/pci/ca0106/ca0106_mixer.c	Thu Jun  1 16:04:37 2006 +0200
@@ -70,8 +70,11 @@
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
+#include <sound/tlv.h>
 
 #include "ca0106.h"
+
+static DECLARE_TLV_DB_SCALE(snd_ca0106_db_scale, -5150, 75, 1);
 
 static int snd_ca0106_shared_spdif_info(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_info *uinfo)
@@ -472,6 +475,7 @@ static int snd_ca0106_i2c_volume_put(str
 	.info =	 snd_ca0106_volume_info,			\
 	.get =   snd_ca0106_volume_get,				\
 	.put =   snd_ca0106_volume_put,				\
+	.tlv =	 snd_ca0106_db_scale,				\
 	.private_value = ((chid) << 8) | (reg)			\
 }
 
diff -r 96e63842ba5d include/tlv.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/include/tlv.h	Thu Jun  1 16:04:37 2006 +0200
@@ -0,0 +1,31 @@
+#ifndef __SOUND_TLV_H
+#define __SOUND_TLV_H
+
+/*
+ *  Advanced Linux Sound Architecture - ALSA - Driver
+ *  Copyright (c) 2006 by Jaroslav Kysela <perex@suse.cz>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#define DECLARE_TLV_DB_SCALE(name, min, step, mute) \
+unsigned int name[] = { \
+        SNDRV_CTL_TLVT_DB_SCALE, 2 * sizeof(unsigned int), \
+        (min), ((step) & 0xffff) | ((mute) ? 0x10000 : 0) \
+}
+
+#endif /* __SOUND_TLV_H */

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
