From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ALSA: control: use counting semaphore as
	write lock for TLV write/command operations
Date: Thu,  3 Aug 2017 20:20:41 +0900
Message-ID: <20170803112044.17138-3-o-takashi@sakamocchi.jp>
References: <20170803112044.17138-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id BEC52266FC9
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 13:20:49 +0200 (CEST)
In-Reply-To: <20170803112044.17138-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In ALSA control interface, applications can execute three types of request
for Type-Length-Value (TLV) data to a set of elements; read, write and
command. In ALSA control core, all of the requests are handled within read
lock to a counting semaphore, therefore several processes can run to access
to the data at the same time for any purposes. This has an issue because
write and command requests have side effect to change state of a set of
elements for the TLV data. Concurrent access should be controlled for each
of reference/change case.

This commit uses the counting semaphore as read lock for TLV read requests,
while use it as write lock for TLV write/command requests. The state of a
set of elements for the TLV data is maintained exclusively between read
requests and write/command requests, or between write and command requests.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 72 +++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 31334abe673c..3648fff28138 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1414,7 +1414,6 @@ static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
 	struct snd_kcontrol *kctl;
 	struct snd_kcontrol_volatile *vd;
 	unsigned int len;
-	int err = 0;
 
 	if (copy_from_user(&tlv, _tlv, sizeof(tlv)))
 		return -EFAULT;
@@ -1422,53 +1421,49 @@ static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
 		return -EINVAL;
 	if (!tlv.numid)
 		return -EINVAL;
-	down_read(&card->controls_rwsem);
+
 	kctl = snd_ctl_find_numid(card, tlv.numid);
-	if (kctl == NULL) {
-		err = -ENOENT;
-		goto __kctl_end;
-	}
-	if (kctl->tlv.p == NULL) {
-		err = -ENXIO;
-		goto __kctl_end;
-	}
+	if (kctl == NULL)
+		return -ENOENT;
+
+	if (kctl->tlv.p == NULL)
+		return -ENXIO;
+
 	vd = &kctl->vd[tlv.numid - kctl->id.numid];
 	if ((op_flag == SNDRV_CTL_TLV_OP_READ &&
 	     (vd->access & SNDRV_CTL_ELEM_ACCESS_TLV_READ) == 0) ||
 	    (op_flag == SNDRV_CTL_TLV_OP_WRITE &&
 	     (vd->access & SNDRV_CTL_ELEM_ACCESS_TLV_WRITE) == 0) ||
 	    (op_flag == SNDRV_CTL_TLV_OP_CMD &&
-	     (vd->access & SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND) == 0)) {
-	    	err = -ENXIO;
-	    	goto __kctl_end;
-	}
+	     (vd->access & SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND) == 0))
+		return -ENXIO;
+
 	if (vd->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
-		if (vd->owner != NULL && vd->owner != file) {
-			err = -EPERM;
-			goto __kctl_end;
-		}
+		int err;
+
+		if (vd->owner != NULL && vd->owner != file)
+			return -EPERM;
+
 		err = kctl->tlv.c(kctl, op_flag, tlv.length, _tlv->tlv);
+		if (err < 0)
+			return err;
 		if (err > 0) {
 			struct snd_ctl_elem_id id = kctl->id;
 			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_TLV, &id);
-			err = 0;
 		}
 	} else {
-		if (op_flag != SNDRV_CTL_TLV_OP_READ) {
-			err = -ENXIO;
-			goto __kctl_end;
-		}
+		if (op_flag != SNDRV_CTL_TLV_OP_READ)
+			return -ENXIO;
+
 		len = kctl->tlv.p[1] + 2 * sizeof(unsigned int);
-		if (tlv.length < len) {
-			err = -ENOMEM;
-			goto __kctl_end;
-		}
+		if (tlv.length < len)
+			return -ENOMEM;
+
 		if (copy_to_user(_tlv->tlv, kctl->tlv.p, len))
-			err = -EFAULT;
+			return -EFAULT;
 	}
-      __kctl_end:
-	up_read(&card->controls_rwsem);
-	return err;
+
+	return 0;
 }
 
 static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -1510,11 +1505,20 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 	case SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS:
 		return snd_ctl_subscribe_events(ctl, ip);
 	case SNDRV_CTL_IOCTL_TLV_READ:
-		return snd_ctl_tlv_ioctl(ctl, argp, SNDRV_CTL_TLV_OP_READ);
+		down_read(&ctl->card->controls_rwsem);
+		err = snd_ctl_tlv_ioctl(ctl, argp, SNDRV_CTL_TLV_OP_READ);
+		up_read(&ctl->card->controls_rwsem);
+		return err;
 	case SNDRV_CTL_IOCTL_TLV_WRITE:
-		return snd_ctl_tlv_ioctl(ctl, argp, SNDRV_CTL_TLV_OP_WRITE);
+		down_write(&ctl->card->controls_rwsem);
+		err = snd_ctl_tlv_ioctl(ctl, argp, SNDRV_CTL_TLV_OP_WRITE);
+		up_write(&ctl->card->controls_rwsem);
+		return err;
 	case SNDRV_CTL_IOCTL_TLV_COMMAND:
-		return snd_ctl_tlv_ioctl(ctl, argp, SNDRV_CTL_TLV_OP_CMD);
+		down_write(&ctl->card->controls_rwsem);
+		err = snd_ctl_tlv_ioctl(ctl, argp, SNDRV_CTL_TLV_OP_CMD);
+		up_write(&ctl->card->controls_rwsem);
+		return err;
 	case SNDRV_CTL_IOCTL_POWER:
 		return -ENOPROTOOPT;
 	case SNDRV_CTL_IOCTL_POWER_STATE:
-- 
2.11.0
