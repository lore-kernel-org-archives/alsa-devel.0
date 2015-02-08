From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2] ALSA: control: fix failure to return
	numerical ID in 'add' event
Date: Sun,  8 Feb 2015 22:39:44 +0900
Message-ID: <1423402784-13791-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 10C7A260411
 for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2015 14:39:48 +0100 (CET)
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

Currently when adding a new control, the assigned numerical ID is not
set for event data, thus userspace applications cannot realize it just
by event data.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index 60caba1..8aae6ea 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -373,6 +373,7 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 	card->controls_count += kcontrol->count;
 	kcontrol->id.numid = card->last_numid + 1;
 	card->last_numid += kcontrol->count;
+	id = kcontrol->id;
 	count = kcontrol->count;
 	up_write(&card->controls_rwsem);
 	for (idx = 0; idx < count; idx++, id.index++, id.numid++)
-- 
2.1.0
