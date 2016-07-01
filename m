From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] ALSA: control: add dimension validator for
	kernel driver
Date: Fri,  1 Jul 2016 13:15:11 +0900
Message-ID: <1467346511-28051-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1467346511-28051-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 072B32651DB
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 06:15:16 +0200 (CEST)
In-Reply-To: <1467346511-28051-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Currently, kernel drivers are allowed to set arbitrary dimension
information to elements. The total number of members calculated by the
dimension information should be within the number of members in the
element, while there's no validator. When userspace applications have quite
simple implementation, this can cause buffer-over-run over
'struct snd_ctl_elem_value' data.

This commit adds the validation. Unfortunately, the dimension information
is set at runtime, thus the validation cannot run in advance.

As of Linux 4.7, there's no drivers to use the dimen information
except for Echo Audio PCI cards.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index eeb080f..19464d6 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -854,28 +854,44 @@ static int snd_ctl_elem_info(struct snd_ctl_file *ctl,
 	down_read(&card->controls_rwsem);
 	kctl = snd_ctl_find_id(card, &info->id);
 	if (kctl == NULL) {
-		up_read(&card->controls_rwsem);
-		return -ENOENT;
+		result = -ENOENT;
+		goto end;
 	}
 #ifdef CONFIG_SND_DEBUG
 	info->access = 0;
 #endif
 	result = kctl->info(kctl, info);
-	if (result >= 0) {
-		snd_BUG_ON(info->access);
-		index_offset = snd_ctl_get_ioff(kctl, &info->id);
-		vd = &kctl->vd[index_offset];
-		snd_ctl_build_ioff(&info->id, kctl, index_offset);
-		info->access = vd->access;
-		if (vd->owner) {
-			info->access |= SNDRV_CTL_ELEM_ACCESS_LOCK;
-			if (vd->owner == ctl)
-				info->access |= SNDRV_CTL_ELEM_ACCESS_OWNER;
-			info->owner = pid_vnr(vd->owner->pid);
-		} else {
-			info->owner = -1;
-		}
+	if (result < 0)
+		goto end;
+
+	snd_BUG_ON(info->access);
+
+	/* This is a driver bug. */
+	if (!validate_element_member_dimension(info)) {
+		dev_err(card->dev,
+			"This module has a bug of invalid dimention info.\n");
+		result = -ENODATA;
+		goto end;
 	}
+
+	index_offset = snd_ctl_get_ioff(kctl, &info->id);
+	vd = &kctl->vd[index_offset];
+	snd_ctl_build_ioff(&info->id, kctl, index_offset);
+	info->access = vd->access;
+
+	/* This element is not locked by any processes. */
+	if (vd->owner == NULL) {
+		info->owner = -1;
+		goto end;
+	}
+
+	info->owner = pid_vnr(vd->owner->pid);
+	info->access |= SNDRV_CTL_ELEM_ACCESS_LOCK;
+
+	/* This element is locked by this process. */
+	if (vd->owner == ctl)
+		info->access |= SNDRV_CTL_ELEM_ACCESS_OWNER;
+end:
 	up_read(&card->controls_rwsem);
 	return result;
 }
-- 
2.7.4
