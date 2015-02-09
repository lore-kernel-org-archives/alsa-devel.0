From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: control: confirm to return all identical
	information in 'activate' event data
Date: Tue, 10 Feb 2015 00:02:06 +0900
Message-ID: <1423494126-24054-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: o-takashi@sakamocchi.jp, tiwai@alsa-project.org, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When event originator doesn't set numerical ID in identical information,
the event data includes no numerical ID, thus userspace applications
cannot identify the control just by unique ID in event data.

This commit fix this bug so as the event data includes all of identical
information.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index 6a72b3e..884fddd 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -587,6 +587,7 @@ int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id,
 	}
 	ret = 1;
  unlock:
+	*id = kctl->id;
 	up_write(&card->controls_rwsem);
 	if (ret > 0)
 		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, id);
-- 
2.1.0
