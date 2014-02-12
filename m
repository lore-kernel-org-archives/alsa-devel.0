From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/10] ALSA: control: Use standard printk
	helpers
Date: Wed, 12 Feb 2014 12:33:04 +0100
Message-ID: <1392204792-12655-3-git-send-email-tiwai@suse.de>
References: <1392204792-12655-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3704B2650EE
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 12:33:18 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DFB45ABFB
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:33:17 +0000 (UTC)
In-Reply-To: <1392204792-12655-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use dev_err() & co as much as possible.  If not available (no device
assigned at the calling point), use pr_xxx() helpers instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c        | 15 +++++++--------
 sound/core/control_compat.c |  2 +-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index c228f00e5701..f038f5afafe2 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -170,7 +170,7 @@ void snd_ctl_notify(struct snd_card *card, unsigned int mask,
 			ev->mask = mask;
 			list_add_tail(&ev->list, &ctl->events);
 		} else {
-			snd_printk(KERN_ERR "No memory available to allocate event\n");
+			dev_err(card->dev, "No memory available to allocate event\n");
 		}
 	_found:
 		wake_up(&ctl->change_sleep);
@@ -206,7 +206,7 @@ static struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol *control,
 
 	kctl = kzalloc(sizeof(*kctl) + sizeof(struct snd_kcontrol_volatile) * control->count, GFP_KERNEL);
 	if (kctl == NULL) {
-		snd_printk(KERN_ERR "Cannot allocate control instance\n");
+		pr_err("ALSA: Cannot allocate control instance\n");
 		return NULL;
 	}
 	*kctl = *control;
@@ -241,9 +241,8 @@ struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new *ncontrol,
 	if (ncontrol->name) {
 		strlcpy(kctl.id.name, ncontrol->name, sizeof(kctl.id.name));
 		if (strcmp(ncontrol->name, kctl.id.name) != 0)
-			snd_printk(KERN_WARNING
-				   "Control name '%s' truncated to '%s'\n",
-				   ncontrol->name, kctl.id.name);
+			pr_warn("ALSA: Control name '%s' truncated to '%s'\n",
+				ncontrol->name, kctl.id.name);
 	}
 	kctl.id.index = ncontrol->index;
 	kctl.count = ncontrol->count ? ncontrol->count : 1;
@@ -306,7 +305,7 @@ static int snd_ctl_find_hole(struct snd_card *card, unsigned int count)
 	while (snd_ctl_remove_numid_conflict(card, count)) {
 		if (--iter == 0) {
 			/* this situation is very unlikely */
-			snd_printk(KERN_ERR "unable to allocate new control numid\n");
+			dev_err(card->dev, "unable to allocate new control numid\n");
 			return -ENOMEM;
 		}
 	}
@@ -341,7 +340,7 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 	down_write(&card->controls_rwsem);
 	if (snd_ctl_find_id(card, &id)) {
 		up_write(&card->controls_rwsem);
-		snd_printd(KERN_ERR "control %i:%i:%i:%s:%i is already present\n",
+		dev_err(card->dev, "control %i:%i:%i:%s:%i is already present\n",
 					id.iface,
 					id.device,
 					id.subdevice,
@@ -1406,7 +1405,7 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 		}
 	}
 	up_read(&snd_ioctl_rwsem);
-	snd_printdd("unknown ioctl = 0x%x\n", cmd);
+	dev_dbg(card->dev, "unknown ioctl = 0x%x\n", cmd);
 	return -ENOTTY;
 }
 
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 2bb95a7a8809..b9c0910fb8c4 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -247,7 +247,7 @@ static int copy_ctl_value_from_user(struct snd_card *card,
 	} else {
 		size = get_elem_size(type, count);
 		if (size < 0) {
-			printk(KERN_ERR "snd_ioctl32_ctl_elem_value: unknown type %d\n", type);
+			dev_err(card->dev, "snd_ioctl32_ctl_elem_value: unknown type %d\n", type);
 			return -EINVAL;
 		}
 		if (copy_from_user(data->value.bytes.data,
-- 
1.8.5.2
