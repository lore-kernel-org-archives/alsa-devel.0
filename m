From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] ALSA: control: code refactoring for
	ELEM_READ/ELEM_WRITE operations
Date: Sun, 20 Aug 2017 13:49:07 +0900
Message-ID: <20170820044908.17972-3-o-takashi@sakamocchi.jp>
References: <20170820044908.17972-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 4346A266BCE
 for <alsa-devel@alsa-project.org>; Sun, 20 Aug 2017 06:49:16 +0200 (CEST)
In-Reply-To: <20170820044908.17972-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA control core handles ELEM_READ/ELEM_WRITE requests within lock
acquisition of a counting semaphore. The lock is acquired in helper
functions in the end of call path before calling implementations of each
driver.

ioctl(2) with SNDRV_CTL_ELEM_READ
...
->snd_ctl_ioctl()
  ->snd_ctl_elem_read_user()
    ->snd_ctl_elem_read()
      ->down_read(controls_rwsem)
      ->snd_ctl_find_id()
      ->struct snd_kcontrol.get()
      ->up_read(controls_rwsem)

ioctl(2) with SNDRV_CTL_ELEM_WRITE
...
->snd_ctl_ioctl()
  ->snd_ctl_elem_write_user()
    ->snd_ctl_elem_write()
      ->down_read(controls_rwsem)
      ->snd_ctl_find_id()
      ->struct snd_kcontrol.put()
      ->up_read(controls_rwsem)

This commit moves the lock acquisition to middle of the call graph to
simplify the helper functions. As a result:

ioctl(2) with SNDRV_CTL_ELEM_READ
...
->snd_ctl_ioctl()
  ->snd_ctl_elem_read_user()
    ->down_read(controls_rwsem)
    ->snd_ctl_elem_read()
      ->snd_ctl_find_id()
      ->struct snd_kcontrol.get()
    ->up_read(controls_rwsem)

ioctl(2) with SNDRV_CTL_ELEM_WRITE
...
->snd_ctl_ioctl()
  ->snd_ctl_elem_write_user()
    ->down_read(controls_rwsem)
    ->snd_ctl_elem_write()
      ->snd_ctl_find_id()
      ->struct snd_kcontrol.put()
    ->up_read(controls_rwsem)

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 77 ++++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 79fdb366ac8d..1c1fc0898afb 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -881,24 +881,18 @@ static int snd_ctl_elem_read(struct snd_card *card,
 	struct snd_kcontrol *kctl;
 	struct snd_kcontrol_volatile *vd;
 	unsigned int index_offset;
-	int result;
 
-	down_read(&card->controls_rwsem);
 	kctl = snd_ctl_find_id(card, &control->id);
-	if (kctl == NULL) {
-		result = -ENOENT;
-	} else {
-		index_offset = snd_ctl_get_ioff(kctl, &control->id);
-		vd = &kctl->vd[index_offset];
-		if ((vd->access & SNDRV_CTL_ELEM_ACCESS_READ) &&
-		    kctl->get != NULL) {
-			snd_ctl_build_ioff(&control->id, kctl, index_offset);
-			result = kctl->get(kctl, control);
-		} else
-			result = -EPERM;
-	}
-	up_read(&card->controls_rwsem);
-	return result;
+	if (kctl == NULL)
+		return -ENOENT;
+
+	index_offset = snd_ctl_get_ioff(kctl, &control->id);
+	vd = &kctl->vd[index_offset];
+	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) && kctl->get == NULL)
+		return -EPERM;
+
+	snd_ctl_build_ioff(&control->id, kctl, index_offset);
+	return kctl->get(kctl, control);
 }
 
 static int snd_ctl_elem_read_user(struct snd_card *card,
@@ -913,8 +907,11 @@ static int snd_ctl_elem_read_user(struct snd_card *card,
 
 	snd_power_lock(card);
 	result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (result >= 0)
+	if (result >= 0) {
+		down_read(&card->controls_rwsem);
 		result = snd_ctl_elem_read(card, control);
+		up_read(&card->controls_rwsem);
+	}
 	snd_power_unlock(card);
 	if (result >= 0)
 		if (copy_to_user(_control, control, sizeof(*control)))
@@ -931,29 +928,28 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	unsigned int index_offset;
 	int result;
 
-	down_read(&card->controls_rwsem);
 	kctl = snd_ctl_find_id(card, &control->id);
-	if (kctl == NULL) {
-		result = -ENOENT;
-	} else {
-		index_offset = snd_ctl_get_ioff(kctl, &control->id);
-		vd = &kctl->vd[index_offset];
-		if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_WRITE) ||
-		    kctl->put == NULL ||
-		    (file && vd->owner && vd->owner != file)) {
-			result = -EPERM;
-		} else {
-			snd_ctl_build_ioff(&control->id, kctl, index_offset);
-			result = kctl->put(kctl, control);
-		}
-		if (result > 0) {
-			struct snd_ctl_elem_id id = control->id;
-			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &id);
-			result = 0;
-		}
+	if (kctl == NULL)
+		return -ENOENT;
+
+	index_offset = snd_ctl_get_ioff(kctl, &control->id);
+	vd = &kctl->vd[index_offset];
+	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_WRITE) || kctl->put == NULL ||
+	    (file && vd->owner && vd->owner != file)) {
+		return -EPERM;
 	}
-	up_read(&card->controls_rwsem);
-	return result;
+
+	snd_ctl_build_ioff(&control->id, kctl, index_offset);
+	result = kctl->put(kctl, control);
+	if (result < 0)
+		return result;
+
+	if (result > 0) {
+		struct snd_ctl_elem_id id = control->id;
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &id);
+	}
+
+	return 0;
 }
 
 static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
@@ -970,8 +966,11 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
 	card = file->card;
 	snd_power_lock(card);
 	result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (result >= 0)
+	if (result >= 0) {
+		down_read(&card->controls_rwsem);
 		result = snd_ctl_elem_write(card, file, control);
+		up_read(&card->controls_rwsem);
+	}
 	snd_power_unlock(card);
 	if (result >= 0)
 		if (copy_to_user(_control, control, sizeof(*control)))
-- 
2.11.0
