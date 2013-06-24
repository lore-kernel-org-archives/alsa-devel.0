From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: vmaster: Add snd_ctl_sync_vmaster()
	helper function
Date: Mon, 24 Jun 2013 16:32:55 +0200
Message-ID: <1372084377-14431-2-git-send-email-tiwai@suse.de>
References: <1372084377-14431-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FB58265286
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:32:14 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EDD69A52BF
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:32:11 +0200 (CEST)
In-Reply-To: <1372084377-14431-1-git-send-email-tiwai@suse.de>
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

Introduce a new helper function, snd_ctl_sync_vmaster(), which updates
the slave put callbacks forcibly as well as calling the hook.  This
will be used in the upcoming patch in HD-audio codec driver for
toggling the mute in vmaster slaves.

Along with the new function, the old snd_ctl_sync_vmaster_hook() is
replaced as a macro calling with the argument hook_only=true.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/control.h |  3 ++-
 sound/core/vmaster.c    | 65 ++++++++++++++++++++++++++++++++++---------------
 2 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index 34bc93d..5358892 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -233,7 +233,8 @@ snd_ctl_add_slave_uncached(struct snd_kcontrol *master,
 int snd_ctl_add_vmaster_hook(struct snd_kcontrol *kctl,
 			     void (*hook)(void *private_data, int),
 			     void *private_data);
-void snd_ctl_sync_vmaster_hook(struct snd_kcontrol *kctl);
+void snd_ctl_sync_vmaster(struct snd_kcontrol *kctl, bool hook_only);
+#define snd_ctl_sync_vmaster_hook(kctl)	snd_ctl_sync_vmaster(kctl, true)
 
 /*
  * Helper functions for jack-detection controls
diff --git a/sound/core/vmaster.c b/sound/core/vmaster.c
index 02f90b4..5df8dc2 100644
--- a/sound/core/vmaster.c
+++ b/sound/core/vmaster.c
@@ -310,20 +310,10 @@ static int master_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int master_put(struct snd_kcontrol *kcontrol,
-		      struct snd_ctl_elem_value *ucontrol)
+static int sync_slaves(struct link_master *master, int old_val, int new_val)
 {
-	struct link_master *master = snd_kcontrol_chip(kcontrol);
 	struct link_slave *slave;
 	struct snd_ctl_elem_value *uval;
-	int err, old_val;
-
-	err = master_init(master);
-	if (err < 0)
-		return err;
-	old_val = master->val;
-	if (ucontrol->value.integer.value[0] == old_val)
-		return 0;
 
 	uval = kmalloc(sizeof(*uval), GFP_KERNEL);
 	if (!uval)
@@ -332,11 +322,33 @@ static int master_put(struct snd_kcontrol *kcontrol,
 		master->val = old_val;
 		uval->id = slave->slave.id;
 		slave_get_val(slave, uval);
-		master->val = ucontrol->value.integer.value[0];
+		master->val = new_val;
 		slave_put_val(slave, uval);
 	}
 	kfree(uval);
-	if (master->hook && !err)
+	return 0;
+}
+
+static int master_put(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	struct link_master *master = snd_kcontrol_chip(kcontrol);
+	int err, new_val, old_val;
+	bool first_init;
+
+	err = master_init(master);
+	if (err < 0)
+		return err;
+	first_init = err;
+	old_val = master->val;
+	new_val = ucontrol->value.integer.value[0];
+	if (new_val == old_val)
+		return 0;
+
+	err = sync_slaves(master, old_val, new_val);
+	if (err < 0)
+		return err;
+	if (master->hook && first_init)
 		master->hook(master->hook_private_data, master->val);
 	return 1;
 }
@@ -442,20 +454,33 @@ int snd_ctl_add_vmaster_hook(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_ctl_add_vmaster_hook);
 
 /**
- * snd_ctl_sync_vmaster_hook - Sync the vmaster hook
+ * snd_ctl_sync_vmaster - Sync the vmaster slaves and hook
  * @kcontrol: vmaster kctl element
+ * @hook_only: sync only the hook
  *
- * Call the hook function to synchronize with the current value of the given
- * vmaster element.  NOP when NULL is passed to @kcontrol or the hook doesn't
- * exist.
+ * Forcibly call the put callback of each slave and call the hook function
+ * to synchronize with the current value of the given vmaster element.
+ * NOP when NULL is passed to @kcontrol.
  */
-void snd_ctl_sync_vmaster_hook(struct snd_kcontrol *kcontrol)
+void snd_ctl_sync_vmaster(struct snd_kcontrol *kcontrol, bool hook_only)
 {
 	struct link_master *master;
+	bool first_init = false;
+
 	if (!kcontrol)
 		return;
 	master = snd_kcontrol_chip(kcontrol);
-	if (master->hook)
+	if (!hook_only) {
+		int err = master_init(master);
+		if (err < 0)
+			return;
+		first_init = err;
+		err = sync_slaves(master, master->val, master->val);
+		if (err < 0)
+			return;
+	}
+
+	if (master->hook && !first_init)
 		master->hook(master->hook_private_data, master->val);
 }
-EXPORT_SYMBOL_GPL(snd_ctl_sync_vmaster_hook);
+EXPORT_SYMBOL_GPL(snd_ctl_sync_vmaster);
-- 
1.8.3.1
