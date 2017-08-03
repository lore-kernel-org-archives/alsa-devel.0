From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] ALSA: control: queue events within locking
	of controls_rwsem for TLV operation
Date: Thu,  3 Aug 2017 20:20:40 +0900
Message-ID: <20170803112044.17138-2-o-takashi@sakamocchi.jp>
References: <20170803112044.17138-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id BFD42266FD1
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 13:20:49 +0200 (CEST)
In-Reply-To: <20170803112044.17138-1-o-takashi@sakamocchi.jp>
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

Any control event is queued by a call of snd_ctl_notify(). This function
adds the event to each queue of opened file data corresponding to ALSA
control character devices. This function acquired two types of lock; a
counting semaphore for a list of the opened file data and a spinlock for
card data opened by the file. Typically, this function is called after
acquiring a counting semaphore for a list of elements in the card data.

In current implementation of TLV request handler, the function is called
after releasing the semaphore for a list of elements in the card data.
This release is not necessarily needed.

This commit removes the release to call the function within the critical
section so that later commits are simple.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index ecd358213b83..31334abe673c 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1450,9 +1450,8 @@ static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
 		err = kctl->tlv.c(kctl, op_flag, tlv.length, _tlv->tlv);
 		if (err > 0) {
 			struct snd_ctl_elem_id id = kctl->id;
-			up_read(&card->controls_rwsem);
 			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_TLV, &id);
-			return 0;
+			err = 0;
 		}
 	} else {
 		if (op_flag != SNDRV_CTL_TLV_OP_READ) {
-- 
2.11.0
