From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ALSA: snd_ctl_activate_id(): Fix index look-up
Date: Fri,  7 Nov 2014 14:12:34 +0100
Message-ID: <1415365954-15019-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id EB81A261299
 for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2014 14:12:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

We want to know the offset for the id that was passed to the function, not
the offset of the first id of the control (which is always 0).

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
The function seems currently unused, so no need to add this for stable
---
 sound/core/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 99aa3aa..bb96a46 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -572,7 +572,7 @@ int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id,
 		ret = -ENOENT;
 		goto unlock;
 	}
-	index_offset = snd_ctl_get_ioff(kctl, &kctl->id);
+	index_offset = snd_ctl_get_ioff(kctl, id);
 	vd = &kctl->vd[index_offset];
 	ret = 0;
 	if (active) {
-- 
1.8.0
