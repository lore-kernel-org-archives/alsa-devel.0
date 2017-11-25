From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/24] ALSA: ctl: unify calls of D0-wait
	function for ELEM_WRITE request
Date: Sat, 25 Nov 2017 18:19:53 +0900
Message-ID: <20171125092006.24408-12-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1CA2C2670A1
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:15 +0100 (CET)
In-Reply-To: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
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

When handling I/O request for ELEM_WRITE, 'snd_power_wait()' function is
used before a call of 'snd_ctl_elem_write()' function. This is perhaps due
to performing I/O operation to actual devices. The same thing is done by
helper functions for native/compat ABI, and they can be unified.

This commit moves these duplicated codes into the callee function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c        | 31 +++++++++++++++----------------
 sound/core/control_compat.c |  3 ---
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 2b5921e9f111..8d158a49467d 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -954,27 +954,33 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	unsigned int index_offset;
 	int result;
 
-	kctl = snd_ctl_find_id(card, &control->id);
-	if (kctl == NULL)
-		return -ENOENT;
+	result = snd_power_wait(file->card, SNDRV_CTL_POWER_D0);
+	if (result < 0)
+		return result;
+
+	down_write(&file->card->controls_rwsem);
+	kctl = snd_ctl_find_id(file->card, &control->id);
+	if (kctl == NULL) {
+		result = -ENOENT;
+		goto end;
+	}
 
 	index_offset = snd_ctl_get_ioff(kctl, &control->id);
 	vd = &kctl->vd[index_offset];
 	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_WRITE) || kctl->put == NULL ||
 	    (file && vd->owner && vd->owner != file)) {
-		return -EPERM;
+		result = -EPERM;
+		goto end;
 	}
 
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
 	result = kctl->put(kctl, control);
-	if (result < 0)
-		return result;
-
 	if (result > 0) {
 		struct snd_ctl_elem_id id = control->id;
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &id);
+		snd_ctl_notify(file->card, SNDRV_CTL_EVENT_MASK_VALUE, &id);
 	}
-
+end:
+	up_write(&file->card->controls_rwsem);
 	return 0;
 }
 
@@ -989,14 +995,7 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
 	if (IS_ERR(control))
 		return PTR_ERR(control);
 
-	card = file->card;
-	result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (result < 0)
-		goto error;
-
-	down_write(&card->controls_rwsem);
 	result = snd_ctl_elem_write(card, file, control);
-	up_write(&card->controls_rwsem);
 	if (result < 0)
 		goto error;
 
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index b887cda28d30..b3f0be74ba0f 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -713,9 +713,6 @@ static int ctl_elem_write_user(struct snd_ctl_file *file,
 	if (err < 0)
 		goto error;
 
-	err = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (err < 0)
-		goto error;
 	err = snd_ctl_elem_write(card, file, data);
 	if (err < 0)
 		goto error;
-- 
2.14.1
