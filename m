From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: ctl: confirm to return all identical
	information
Date: Thu,  9 Apr 2015 02:07:15 +0900
Message-ID: <1428512838-2493-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1428512838-2493-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id EC4B1265469
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 19:07:21 +0200 (CEST)
In-Reply-To: <1428512838-2493-1-git-send-email-o-takashi@sakamocchi.jp>
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

When event originator doesn't set numerical ID in identical information,
the event data includes no numerical ID, thus userspace applications
cannot identify the control just by unique ID in event data.

This commit fix this bug so as the event data includes all of identical
information.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index d677c27..6d12e85 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -578,6 +578,7 @@ error:
  *
  * Finds the control instance with the given id, and activate or
  * inactivate the control together with notification, if changed.
+ * The given ID data is filled by full information.
  *
  * Return: 0 if unchanged, 1 if changed, or a negative error code on failure.
  */
@@ -609,6 +610,7 @@ int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id,
 	}
 	ret = 1;
  unlock:
+	*id = kctl->id;
 	up_write(&card->controls_rwsem);
 	if (ret > 0)
 		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, id);
-- 
2.1.0
