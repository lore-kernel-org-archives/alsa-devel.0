From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: Add a hook capability to vmaster
	controls
Date: Mon, 12 Mar 2012 15:28:46 +0100
Message-ID: <1331562530-16044-2-git-send-email-tiwai@suse.de>
References: <1331562530-16044-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 16B10104237
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:29:49 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E04B1927A5
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:29:48 +0100 (CET)
In-Reply-To: <1331562530-16044-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This patch adds a hook to vmaster control to be called at each time
when the master value is changed.  It'd be handy for an additional
mute LED control following the Master switch, for example.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/control.h |    5 +++++
 sound/core/vmaster.c    |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index b2796e8..eff96dc 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -227,6 +227,11 @@ snd_ctl_add_slave_uncached(struct snd_kcontrol *master,
 	return _snd_ctl_add_slave(master, slave, SND_CTL_SLAVE_NEED_UPDATE);
 }
 
+int snd_ctl_add_vmaster_hook(struct snd_kcontrol *kctl,
+			     void (*hook)(void *private_data, int),
+			     void *private_data);
+void snd_ctl_sync_vmaster_hook(struct snd_kcontrol *kctl);
+
 /*
  * Helper functions for jack-detection controls
  */
diff --git a/sound/core/vmaster.c b/sound/core/vmaster.c
index 130cfe6..14a286a 100644
--- a/sound/core/vmaster.c
+++ b/sound/core/vmaster.c
@@ -37,6 +37,8 @@ struct link_master {
 	struct link_ctl_info info;
 	int val;		/* the master value */
 	unsigned int tlv[4];
+	void (*hook)(void *private_data, int);
+	void *hook_private_data;
 };
 
 /*
@@ -126,7 +128,9 @@ static int master_init(struct link_master *master)
 		master->info.count = 1; /* always mono */
 		/* set full volume as default (= no attenuation) */
 		master->val = master->info.max_val;
-		return 0;
+		if (master->hook)
+			master->hook(master->hook_private_data, master->val);
+		return 1;
 	}
 	return -ENOENT;
 }
@@ -329,6 +333,8 @@ static int master_put(struct snd_kcontrol *kcontrol,
 		slave_put_val(slave, uval);
 	}
 	kfree(uval);
+	if (master->hook && !err)
+		master->hook(master->hook_private_data, master->val);
 	return 1;
 }
 
@@ -408,3 +414,41 @@ struct snd_kcontrol *snd_ctl_make_virtual_master(char *name,
 	return kctl;
 }
 EXPORT_SYMBOL(snd_ctl_make_virtual_master);
+
+/**
+ * snd_ctl_add_vmaster_hook - Add a hook to a vmaster control
+ * @kcontrol: vmaster kctl element
+ * @hook: the hook function
+ *
+ * Adds the given hook to the vmaster control element so that it's called
+ * at each time when the value is changed.
+ */
+int snd_ctl_add_vmaster_hook(struct snd_kcontrol *kcontrol,
+			     void (*hook)(void *private_data, int),
+			     void *private_data)
+{
+	struct link_master *master = snd_kcontrol_chip(kcontrol);
+	master->hook = hook;
+	master->hook_private_data = private_data;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_ctl_add_vmaster_hook);
+
+/**
+ * snd_ctl_sync_vmaster_hook - Sync the vmaster hook
+ * @kcontrol: vmaster kctl element
+ *
+ * Call the hook function to synchronize with the current value of the given
+ * vmaster element.  NOP when NULL is passed to @kcontrol or the hook doesn't
+ * exist.
+ */
+void snd_ctl_sync_vmaster_hook(struct snd_kcontrol *kcontrol)
+{
+	struct link_master *master;
+	if (!kcontrol)
+		return;
+	master = snd_kcontrol_chip(kcontrol);
+	if (master->hook)
+		master->hook(master->hook_private_data, master->val);
+}
+EXPORT_SYMBOL_GPL(snd_ctl_sync_vmaster_hook);
-- 
1.7.9.2
