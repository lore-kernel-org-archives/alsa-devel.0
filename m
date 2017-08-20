From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] ALSA: control: use counting semaphore as
	write lock for ELEM_WRITE operation
Date: Sun, 20 Aug 2017 13:49:08 +0900
Message-ID: <20170820044908.17972-4-o-takashi@sakamocchi.jp>
References: <20170820044908.17972-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 458C2266BD4
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

In ALSA control interface, applications can execute two types of request
for value of members on each element; ELEM_READ and ELEM_WRITE. In ALSA
control core, these two requests are handled within read lock of a
counting semaphore, therefore several processes can run to execute these
two requests at the same time. This has an issue because ELEM_WRITE
requests have an effect to change state of the target element. Concurrent
access should be controlled for each of ELEM_READ/ELEM_WRITE case.

This commit uses the counting semaphore as write lock for ELEM_WRITE
requests, while use it as read lock for ELEM_READ requests. The state of
a target element is maintained exclusively between ELEM_WRITE/ELEM_READ
operations.

There's a concern. If the counting semaphore is acquired for read lock
in implementations of 'struct snd_kcontrol.put()' in each driver, this
commit shall cause dead lock. As of v4.13-rc5, 'snd-mixer-oss.ko',
'snd-emu10k1.ko' and 'snd-soc-sst-atom-hifi2-platform.ko' includes codes
for read locks, but these are not in a call graph from
'struct snd_kcontrol.put(). Therefore, this commit is safe.

In current implementation, the same solution is applied for the other
operations to element; e.g. ELEM_LOCK and ELEM_UNLOCK. There's another
discussion about an overhead to maintain concurrent access to an element
during operating the other elements on the same card instance, because the
lock primitive is originally implemented to maintain a list of elements on
the card instance. There's a substantial difference between
per-element-list lock and per-element lock.

Here, let me investigate another idea to add per-element lock to maintain
the concurrent accesses with inquiry/change requests to an element. It's
not so frequent for applications to operate members on elements, while
adding a new lock primitive to structure increases memory footprint for
all of element sets somehow. Experimentally, inquiry operation is more
frequent than change operation and usage of counting semaphore for the
inquiry operation brings no blocking to the other inquiry operations. Thus
the overhead is not so critical for usual applications. For the above
reasons, in this commit, the per-element lock is not introduced.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 1c1fc0898afb..249140c15d64 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -967,9 +967,9 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
 	snd_power_lock(card);
 	result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
 	if (result >= 0) {
-		down_read(&card->controls_rwsem);
+		down_write(&card->controls_rwsem);
 		result = snd_ctl_elem_write(card, file, control);
-		up_read(&card->controls_rwsem);
+		up_write(&card->controls_rwsem);
 	}
 	snd_power_unlock(card);
 	if (result >= 0)
-- 
2.11.0
