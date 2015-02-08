From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: control: obsolete 'already present'
	messaging because it's caller's fault
Date: Sun,  8 Feb 2015 19:29:08 +0900
Message-ID: <1423391348-2219-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id EC3AD260651
 for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2015 11:29:10 +0100 (CET)
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

When drivers or userspace applications add a duplicated control, snd
module outputs error message and return -EBUSY.

This state is a bug in driver or application, therefore the messaging
should be done by them, not by snd module.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index d482997..8906b66 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -357,18 +357,10 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 
 	down_write(&card->controls_rwsem);
 	if (snd_ctl_find_id(card, &id)) {
-		up_write(&card->controls_rwsem);
-		dev_err(card->dev, "control %i:%i:%i:%s:%i is already present\n",
-					id.iface,
-					id.device,
-					id.subdevice,
-					id.name,
-					id.index);
 		err = -EBUSY;
 		goto error;
 	}
 	if (snd_ctl_find_hole(card, kcontrol->count) < 0) {
-		up_write(&card->controls_rwsem);
 		err = -ENOMEM;
 		goto error;
 	}
@@ -388,6 +380,7 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 	return 0;
 
  error:
+	up_write(&card->controls_rwsem);
 	snd_ctl_free_one(kcontrol);
 	return err;
 }
-- 
2.1.0
