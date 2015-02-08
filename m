From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: control: fix failure to return numerical
	ID in event data
Date: Sun,  8 Feb 2015 19:28:56 +0900
Message-ID: <1423391336-2167-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C1C626063A
 for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2015 11:29:01 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently an instance of control has zero as its member for numerical
ID even if any IDs are assigned to. According to this bug, any userspace
applications cannot identify controls by the ID when handling any events.
On the other hand, the other members such as name are still valid,
therefore applications can identify controls without fixing this.

This is not preferable because the ID has an advantage to allow userspace
applications to distinguish each controls by itself, without any
combinations.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 60caba1..d482997 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -352,6 +352,9 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 	if (id.index > UINT_MAX - kcontrol->count)
 		goto error;
 
+	/* Any ID numbers are not assigned to this control yet. */
+	id.numid = 0;
+
 	down_write(&card->controls_rwsem);
 	if (snd_ctl_find_id(card, &id)) {
 		up_write(&card->controls_rwsem);
@@ -369,12 +372,17 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 		err = -ENOMEM;
 		goto error;
 	}
-	list_add_tail(&kcontrol->list, &card->controls);
-	card->controls_count += kcontrol->count;
+
+	/* Now this control is allowed to have ID number. */
 	kcontrol->id.numid = card->last_numid + 1;
 	card->last_numid += kcontrol->count;
-	count = kcontrol->count;
+	card->controls_count += kcontrol->count;
+	list_add_tail(&kcontrol->list, &card->controls);
+
 	up_write(&card->controls_rwsem);
+
+	id = kcontrol->id;
+	count = kcontrol->count;
 	for (idx = 0; idx < count; idx++, id.index++, id.numid++)
 		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_ADD, &id);
 	return 0;
-- 
2.1.0
