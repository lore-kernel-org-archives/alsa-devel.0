From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2 v4] ALSA: Add snd_ctl_replace() to
	dynamically replace a control
Date: Wed, 16 Mar 2011 12:16:39 +0000
Message-ID: <1300277800-610-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5273324343
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 13:16:48 +0100 (CET)
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

Add a function to dynamically replace a given control.  If the
control does not already exist, a third parameter is used to determine
whether to actually add that control.  This is useful in cases where
downloadable firmware at runtime can add or replace existing controls.
A separate patch needs to be made to allow ALSA Mixer to render the
replaced controls on the fly.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/control.h |    1 +
 sound/core/control.c    |   65 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index e67db28..1c8b3ee 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -113,6 +113,7 @@ struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new * kcontrolnew, v
 void snd_ctl_free_one(struct snd_kcontrol * kcontrol);
 int snd_ctl_add(struct snd_card * card, struct snd_kcontrol * kcontrol);
 int snd_ctl_remove(struct snd_card * card, struct snd_kcontrol * kcontrol);
+int snd_ctl_replace(struct snd_card * card, struct snd_kcontrol * kcontrol, bool add_on_replace);
 int snd_ctl_remove_id(struct snd_card * card, struct snd_ctl_elem_id *id);
 int snd_ctl_rename_id(struct snd_card * card, struct snd_ctl_elem_id *src_id, struct snd_ctl_elem_id *dst_id);
 int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id,
diff --git a/sound/core/control.c b/sound/core/control.c
index db51e4e..a8cae8a 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -368,6 +368,71 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 EXPORT_SYMBOL(snd_ctl_add);
 
 /**
+ * snd_ctl_replace - replace the control instance of the card
+ * @card: the card instance
+ * @kcontrol: the control instance to replace
+ * @add_on_replace: add the control if not already added
+ *
+ * Replaces the given control.  If the given control does not exist
+ * and the add_on_replace flag is set, the control is added.  If the
+ * control exists, it is destroyed first.
+ *
+ * Returns zero if successful, or a negative error code on failure.
+ *
+ * It frees automatically the control which cannot be added or replaced.
+ */
+int snd_ctl_replace(struct snd_card *card, struct snd_kcontrol *kcontrol,
+		    bool add_on_replace)
+{
+	struct snd_ctl_elem_id id;
+	unsigned int idx;
+	struct snd_kcontrol *old;
+	int ret;
+
+	if (!kcontrol)
+		return -EINVAL;
+	if (snd_BUG_ON(!card || !kcontrol->info)) {
+		ret = -EINVAL;
+		goto error;
+	}
+	id = kcontrol->id;
+	down_write(&card->controls_rwsem);
+	old = snd_ctl_find_id(card, &id);
+	if (!old) {
+		if (add_on_replace)
+			goto add;
+		up_write(&card->controls_rwsem);
+		ret = -EINVAL;
+		goto error;
+	}
+	ret = snd_ctl_remove(card, old);
+	if (ret < 0) {
+		up_write(&card->controls_rwsem);
+		goto error;
+	}
+add:
+	if (snd_ctl_find_hole(card, kcontrol->count) < 0) {
+		up_write(&card->controls_rwsem);
+		ret = -ENOMEM;
+		goto error;
+	}
+	list_add_tail(&kcontrol->list, &card->controls);
+	card->controls_count += kcontrol->count;
+	kcontrol->id.numid = card->last_numid + 1;
+	card->last_numid += kcontrol->count;
+	up_write(&card->controls_rwsem);
+	for (idx = 0; idx < kcontrol->count; idx++, id.index++, id.numid++)
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_ADD, &id);
+	return 0;
+
+error:
+	snd_ctl_free_one(kcontrol);
+	return ret;
+}
+
+EXPORT_SYMBOL(snd_ctl_replace);
+
+/**
  * snd_ctl_remove - remove the control from the card and release it
  * @card: the card instance
  * @kcontrol: the control instance to remove
-- 
1.7.4.1
