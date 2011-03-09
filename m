From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: Add snd_ctl_activate_id()
Date: Wed,  9 Mar 2011 20:03:41 +0000
Message-ID: <1299701021-28682-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 932D61039D3
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 21:03:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Takashi Iwai <tiwai@suse.de>

Added a new API function snd_ctl_activate_id() for activate / inactivate
the control element dynamically.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

You wrote this patch a long time ago now - I'm currently working on a
driver which I think can make use if it.  Is it OK if I cherry-pick it
over into my code and push it through the ASoC branch if I do so?  Or
if you could merge it in the coming merge window, but there's a risk I
may come up with another way of doing things that doesn't need it.

 include/sound/control.h |    2 ++
 sound/core/control.c    |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index 7715e6f..e67db28 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -115,6 +115,8 @@ int snd_ctl_add(struct snd_card * card, struct snd_kcontrol * kcontrol);
 int snd_ctl_remove(struct snd_card * card, struct snd_kcontrol * kcontrol);
 int snd_ctl_remove_id(struct snd_card * card, struct snd_ctl_elem_id *id);
 int snd_ctl_rename_id(struct snd_card * card, struct snd_ctl_elem_id *src_id, struct snd_ctl_elem_id *dst_id);
+int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id,
+			int active);
 struct snd_kcontrol *snd_ctl_find_numid(struct snd_card * card, unsigned int numid);
 struct snd_kcontrol *snd_ctl_find_id(struct snd_card * card, struct snd_ctl_elem_id *id);
 
diff --git a/sound/core/control.c b/sound/core/control.c
index 9ce00ed..db51e4e 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -466,6 +466,52 @@ error:
 }
 
 /**
+ * snd_ctl_activate_id - activate/inactivate the control of the given id
+ * @card: the card instance
+ * @id: the control id to activate/inactivate
+ * @active: non-zero to activate
+ *
+ * Finds the control instance with the given id, and activate or
+ * inactivate the control together with notification, if changed.
+ *
+ * Returns 0 if unchanged, 1 if changed, or a negative error code on failure.
+ */
+int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id,
+			int active)
+{
+	struct snd_kcontrol *kctl;
+	struct snd_kcontrol_volatile *vd;
+	unsigned int index_offset;
+	int ret;
+
+	down_write(&card->controls_rwsem);
+	kctl = snd_ctl_find_id(card, id);
+	if (kctl == NULL) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+	index_offset = snd_ctl_get_ioff(kctl, &kctl->id);
+	vd = &kctl->vd[index_offset];
+	ret = 0;
+	if (active) {
+		if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_INACTIVE))
+			goto unlock;
+		vd->access &= ~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
+	} else {
+		if (vd->access & SNDRV_CTL_ELEM_ACCESS_INACTIVE)
+			goto unlock;
+		vd->access |= SNDRV_CTL_ELEM_ACCESS_INACTIVE;
+	}
+	ret = 1;
+ unlock:
+	up_write(&card->controls_rwsem);
+	if (ret > 0)
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, id);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_ctl_activate_id);
+
+/**
  * snd_ctl_rename_id - replace the id of a control on the card
  * @card: the card instance
  * @src_id: the old id
-- 
1.7.2.3
