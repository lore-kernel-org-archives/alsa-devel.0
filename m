From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/8] ALSA: control: Add missing kerneldoc
	comments to exported functions
Date: Thu, 30 Oct 2014 16:06:16 +0100
Message-ID: <1414681581-4619-4-git-send-email-tiwai@suse.de>
References: <1414681581-4619-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C175B260622
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 16:06:23 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A96E5ADE3
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 15:06:23 +0000 (UTC)
In-Reply-To: <1414681581-4619-1-git-send-email-tiwai@suse.de>
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

A few functions have no proper documentation yet, so let's add them.
Along with it, remove superfluous blank line between the closing brace
and EXPORT_SYMBOL() line.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c | 64 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 5c35bbaf881e..99aa3aa157ba 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -141,6 +141,16 @@ static int snd_ctl_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+/**
+ * snd_ctl_notify - Send notification to user-space for a control change
+ * @card: the card to send notification
+ * @mask: the event mask, SNDRV_CTL_EVENT_*
+ * @id: the ctl element id to send notification
+ *
+ * This function adds an event record with the given id and mask, appends
+ * to the list and wakes up the user-space for notification.  This can be
+ * called in the atomic context.
+ */
 void snd_ctl_notify(struct snd_card *card, unsigned int mask,
 		    struct snd_ctl_elem_id *id)
 {
@@ -179,7 +189,6 @@ void snd_ctl_notify(struct snd_card *card, unsigned int mask,
 	}
 	read_unlock(&card->ctl_files_rwlock);
 }
-
 EXPORT_SYMBOL(snd_ctl_notify);
 
 /**
@@ -261,7 +270,6 @@ struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new *ncontrol,
 	kctl.private_data = private_data;
 	return snd_ctl_new(&kctl, access);
 }
-
 EXPORT_SYMBOL(snd_ctl_new1);
 
 /**
@@ -280,7 +288,6 @@ void snd_ctl_free_one(struct snd_kcontrol *kcontrol)
 		kfree(kcontrol);
 	}
 }
-
 EXPORT_SYMBOL(snd_ctl_free_one);
 
 static bool snd_ctl_remove_numid_conflict(struct snd_card *card,
@@ -376,7 +383,6 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 	snd_ctl_free_one(kcontrol);
 	return err;
 }
-
 EXPORT_SYMBOL(snd_ctl_add);
 
 /**
@@ -471,7 +477,6 @@ int snd_ctl_remove(struct snd_card *card, struct snd_kcontrol *kcontrol)
 	snd_ctl_free_one(kcontrol);
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_ctl_remove);
 
 /**
@@ -499,7 +504,6 @@ int snd_ctl_remove_id(struct snd_card *card, struct snd_ctl_elem_id *id)
 	up_write(&card->controls_rwsem);
 	return ret;
 }
-
 EXPORT_SYMBOL(snd_ctl_remove_id);
 
 /**
@@ -617,7 +621,6 @@ int snd_ctl_rename_id(struct snd_card *card, struct snd_ctl_elem_id *src_id,
 	up_write(&card->controls_rwsem);
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_ctl_rename_id);
 
 /**
@@ -645,7 +648,6 @@ struct snd_kcontrol *snd_ctl_find_numid(struct snd_card *card, unsigned int numi
 	}
 	return NULL;
 }
-
 EXPORT_SYMBOL(snd_ctl_find_numid);
 
 /**
@@ -687,7 +689,6 @@ struct snd_kcontrol *snd_ctl_find_id(struct snd_card *card,
 	}
 	return NULL;
 }
-
 EXPORT_SYMBOL(snd_ctl_find_id);
 
 static int snd_ctl_card_info(struct snd_card *card, struct snd_ctl_file * ctl,
@@ -1526,19 +1527,28 @@ static int _snd_ctl_register_ioctl(snd_kctl_ioctl_func_t fcn, struct list_head *
 	return 0;
 }
 
+/**
+ * snd_ctl_register_ioctl - register the device-specific control-ioctls
+ * @fcn: ioctl callback function
+ *
+ * called from each device manager like pcm.c, hwdep.c, etc.
+ */
 int snd_ctl_register_ioctl(snd_kctl_ioctl_func_t fcn)
 {
 	return _snd_ctl_register_ioctl(fcn, &snd_control_ioctls);
 }
-
 EXPORT_SYMBOL(snd_ctl_register_ioctl);
 
 #ifdef CONFIG_COMPAT
+/**
+ * snd_ctl_register_ioctl_compat - register the device-specific 32bit compat
+ * control-ioctls
+ * @fcn: ioctl callback function
+ */
 int snd_ctl_register_ioctl_compat(snd_kctl_ioctl_func_t fcn)
 {
 	return _snd_ctl_register_ioctl(fcn, &snd_control_compat_ioctls);
 }
-
 EXPORT_SYMBOL(snd_ctl_register_ioctl_compat);
 #endif
 
@@ -1566,19 +1576,26 @@ static int _snd_ctl_unregister_ioctl(snd_kctl_ioctl_func_t fcn,
 	return -EINVAL;
 }
 
+/**
+ * snd_ctl_unregister_ioctl - de-register the device-specific control-ioctls
+ * @fcn: ioctl callback function to unregister
+ */
 int snd_ctl_unregister_ioctl(snd_kctl_ioctl_func_t fcn)
 {
 	return _snd_ctl_unregister_ioctl(fcn, &snd_control_ioctls);
 }
-
 EXPORT_SYMBOL(snd_ctl_unregister_ioctl);
 
 #ifdef CONFIG_COMPAT
+/**
+ * snd_ctl_unregister_ioctl - de-register the device-specific compat 32bit
+ * control-ioctls
+ * @fcn: ioctl callback function to unregister
+ */
 int snd_ctl_unregister_ioctl_compat(snd_kctl_ioctl_func_t fcn)
 {
 	return _snd_ctl_unregister_ioctl(fcn, &snd_control_compat_ioctls);
 }
-
 EXPORT_SYMBOL(snd_ctl_unregister_ioctl_compat);
 #endif
 
@@ -1702,6 +1719,16 @@ int snd_ctl_create(struct snd_card *card)
 /*
  * Frequently used control callbacks/helpers
  */
+
+/**
+ * snd_ctl_boolean_mono_info - Helper function for a standard boolean info
+ * callback with a mono channel
+ * @kcontrol: the kcontrol instance
+ * @uinfo: info to store
+ *
+ * This is a function that can be used as info callback for a standard
+ * boolean control with a single mono channel.
+ */
 int snd_ctl_boolean_mono_info(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_info *uinfo)
 {
@@ -1711,9 +1738,17 @@ int snd_ctl_boolean_mono_info(struct snd_kcontrol *kcontrol,
 	uinfo->value.integer.max = 1;
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_ctl_boolean_mono_info);
 
+/**
+ * snd_ctl_boolean_stereo_info - Helper function for a standard boolean info
+ * callback with stereo two channels
+ * @kcontrol: the kcontrol instance
+ * @uinfo: info to store
+ *
+ * This is a function that can be used as info callback for a standard
+ * boolean control with stereo two channels.
+ */
 int snd_ctl_boolean_stereo_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
 {
@@ -1723,7 +1758,6 @@ int snd_ctl_boolean_stereo_info(struct snd_kcontrol *kcontrol,
 	uinfo->value.integer.max = 1;
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_ctl_boolean_stereo_info);
 
 /**
-- 
2.1.2
