From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2 v2] ALSA: Add snd_ctl_update() to
	dynamically update a control
Date: Tue, 15 Mar 2011 12:31:08 +0000
Message-ID: <1300192269-20435-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6259A103803
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 13:31:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Add a function to dynamically update a given control.  If the
control does not already exist, a third parameter is used to determine
whether to actually add that control.  This is useful in cases where
downloadable firmware at runtime can add or update existing controls.
A separate patch needs to be made to make ALSA Mixer cope with this.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/control.h |    1 +
 sound/core/control.c    |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index e67db28..12e4de7 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -113,6 +113,7 @@ struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new * kcontrolnew, v
 void snd_ctl_free_one(struct snd_kcontrol * kcontrol);
 int snd_ctl_add(struct snd_card * card, struct snd_kcontrol * kcontrol);
 int snd_ctl_remove(struct snd_card * card, struct snd_kcontrol * kcontrol);
+int snd_ctl_update(struct snd_card * card, struct snd_kcontrol * kcontrol, int add_on_update);
 int snd_ctl_remove_id(struct snd_card * card, struct snd_ctl_elem_id *id);
 int snd_ctl_rename_id(struct snd_card * card, struct snd_ctl_elem_id *src_id, struct snd_ctl_elem_id *dst_id);
 int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id,
diff --git a/sound/core/control.c b/sound/core/control.c
index db51e4e..9c5d7a9 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -397,6 +397,52 @@ int snd_ctl_remove(struct snd_card *card, struct snd_kcontrol *kcontrol)
 EXPORT_SYMBOL(snd_ctl_remove);
 
 /**
+ * snd_ctl_update - update the control instance of the card
+ * @card: the card instance
+ * @kcontrol: the control instance to update
+ * @add_on_update: add the control if not already added
+ *
+ * Updates the control instance created via snd_ctl_new() or
+ * snd_ctl_new1() of the given card.
+ *
+ * Returns zero if successful, or a negative error code on failure.
+ *
+ */
+int snd_ctl_update(struct snd_card *card, struct snd_kcontrol *kcontrol,
+		   int add_on_update)
+{
+	struct snd_ctl_elem_id id;
+	struct snd_kcontrol *old;
+	int ret;
+
+	if (!kcontrol)
+		return -EINVAL;
+	if (snd_BUG_ON(!card || !kcontrol->info))
+		return -EINVAL;
+	id = kcontrol->id;
+	down_write(&card->controls_rwsem);
+	old = snd_ctl_find_id(card, &id);
+	if (!old) {
+		up_write(&card->controls_rwsem);
+		if (add_on_update)
+			return snd_ctl_add(card, kcontrol);
+		return -EINVAL;
+	}
+	ret = snd_ctl_remove(card, old);
+	if (ret < 0) {
+		up_write(&card->controls_rwsem);
+		return ret;
+	}
+	up_write(&card->controls_rwsem);
+	ret = snd_ctl_add(card, kcontrol);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+EXPORT_SYMBOL(snd_ctl_update);
+
+/**
  * snd_ctl_remove_id - remove the control of the given id and release it
  * @card: the card instance
  * @id: the control id to remove
-- 
1.7.4.1
