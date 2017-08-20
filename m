From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] ALSA: control: queue events within locking
	of controls_rwsem for ELEM_WRITE operation
Date: Sun, 20 Aug 2017 13:49:06 +0900
Message-ID: <20170820044908.17972-2-o-takashi@sakamocchi.jp>
References: <20170820044908.17972-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 469B3266BED
 for <alsa-devel@alsa-project.org>; Sun, 20 Aug 2017 06:49:16 +0200 (CEST)
In-Reply-To: <20170820044908.17972-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Any control event is queued by a call of snd_ctl_notify(). This function
adds the event to each queue of opened file data corresponding to ALSA
control character devices. This function acquired two types of lock; a
counting semaphore for a list of the opened file data and a spinlock for
card data opened by the file. Typically, this function is called after
acquiring a counting semaphore for a list of elements in the card data.

In current implementation of a handler for ELEM_WRITE request, the
function is called after releasing the semaphore for a list of elements
in the card data. This release is not necessarily needed.

This commit removes the release to call the function within the critical
section so that later commits are simple.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 9e7a4571488b..79fdb366ac8d 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -948,9 +948,8 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 		}
 		if (result > 0) {
 			struct snd_ctl_elem_id id = control->id;
-			up_read(&card->controls_rwsem);
 			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &id);
-			return 0;
+			result = 0;
 		}
 	}
 	up_read(&card->controls_rwsem);
-- 
2.11.0
