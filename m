From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/24] ALSA: ctl: unify calls of D0-wait
	function for ELEM_READ request
Date: Sat, 25 Nov 2017 18:19:52 +0900
Message-ID: <20171125092006.24408-11-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1DC2E2671E7
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

When handling I/O request for ELEM_READ, 'snd_power_wait()' function is
used before a call of 'snd_ctl_elem_read()' function. This is perhaps due
to performing I/O operation to actual devices. The same thing is done by
helper functions for native/compat ABI, and they can be unified.

This commit moves these duplicated codes into the callee function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c        | 30 +++++++++++++++++++-----------
 sound/core/control_compat.c |  3 ---
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 91966b190b8b..2b5921e9f111 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -897,18 +897,32 @@ static int snd_ctl_elem_read(struct snd_card *card,
 	struct snd_kcontrol *kctl;
 	struct snd_kcontrol_volatile *vd;
 	unsigned int index_offset;
+	int err;
+
+	err = snd_power_wait(card, SNDRV_CTL_POWER_D0);
+	if (err < 0)
+		return err;
+
+	down_read(&card->controls_rwsem);
 
 	kctl = snd_ctl_find_id(card, &control->id);
-	if (kctl == NULL)
-		return -ENOENT;
+	if (kctl == NULL) {
+		err = -ENOENT;
+		goto end;
+	}
 
 	index_offset = snd_ctl_get_ioff(kctl, &control->id);
 	vd = &kctl->vd[index_offset];
-	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) && kctl->get == NULL)
-		return -EPERM;
+	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) && kctl->get == NULL) {
+		err = -EPERM;
+		goto end;
+	}
 
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
-	return kctl->get(kctl, control);
+	err = kctl->get(kctl, control);
+end:
+	up_read(&card->controls_rwsem);
+	return err;
 }
 
 static int snd_ctl_elem_read_user(struct snd_card *card,
@@ -921,13 +935,7 @@ static int snd_ctl_elem_read_user(struct snd_card *card,
 	if (IS_ERR(control))
 		return PTR_ERR(control);
 
-	result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (result < 0)
-		goto error;
-
-	down_read(&card->controls_rwsem);
 	result = snd_ctl_elem_read(card, control);
-	up_read(&card->controls_rwsem);
 	if (result < 0)
 		goto error;
 
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index e6169b2bc6b3..b887cda28d30 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -688,9 +688,6 @@ static int ctl_elem_read_user(struct snd_card *card,
 	if (err < 0)
 		goto error;
 
-	err = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (err < 0)
-		goto error;
 	err = snd_ctl_elem_read(card, data);
 	if (err < 0)
 		goto error;
-- 
2.14.1
