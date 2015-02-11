From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] ALSA: control: improve returned value
	because of the rest
Date: Wed, 11 Feb 2015 19:40:12 +0900
Message-ID: <1423651213-19829-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1423651213-19829-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 8821C264FEE
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 11:40:21 +0100 (CET)
In-Reply-To: <1423651213-19829-1-git-send-email-o-takashi@sakamocchi.jp>
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

When a character device doesn't have enough spaces for requested number
of controls or values, currently return -ENOMEM. This should be -ENOSPC
(No space left on device).

This commit improves this behaviour.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index bce4730..9944d75 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -313,7 +313,7 @@ static int snd_ctl_find_hole(struct snd_card *card, unsigned int count)
 
 		/* this situation is very unlikely */
 		dev_err(card->dev, "unable to allocate new control numid\n");
-		return -ENOMEM;
+		return -ENOSPC;
 	}
 	return 0;
 }
@@ -355,9 +355,9 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 		err = -EBUSY;
 		goto error;
 	}
-	if (snd_ctl_find_hole(card, kcontrol->count) < 0) {
+	err = snd_ctl_find_hole(card, kcontrol->count);
+	if (err < 0) {
 		up_write(&card->controls_rwsem);
-		err = -ENOMEM;
 		goto error;
 	}
 	list_add_tail(&kcontrol->list, &card->controls);
@@ -422,9 +422,9 @@ int snd_ctl_replace(struct snd_card *card, struct snd_kcontrol *kcontrol,
 		goto error;
 	}
 add:
-	if (snd_ctl_find_hole(card, kcontrol->count) < 0) {
+	err = snd_ctl_find_hole(card, kcontrol->count);
+	if (err < 0) {
 		up_write(&card->controls_rwsem);
-		ret = -ENOMEM;
 		goto error;
 	}
 	list_add_tail(&kcontrol->list, &card->controls);
-- 
2.1.0
