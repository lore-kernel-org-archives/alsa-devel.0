From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: fireface: obsolete usage of ktime_set()
	for zero assignment
Date: Fri, 14 Apr 2017 23:06:54 +0900
Message-ID: <20170414140654.4079-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 8D8CB26696B
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 16:07:02 +0200 (CEST)
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

In development period for Linux v4.10, ktime_t became an alias of s64,
instead of union. I forgot it. We can just assign zero, instead of usage
of ktime_set(0, 0).

Fixes: 19174295788 ("ALSA: fireface: add transaction support")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index d1b098f..dd6c8e8 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -21,7 +21,7 @@ static void finish_transmit_midi_msg(struct snd_ff *ff, unsigned int port,
 
 	if (rcode != RCODE_COMPLETE) {
 		/* Transfer the message again, immediately. */
-		ff->next_ktime[port] = ktime_set(0, 0);
+		ff->next_ktime[port] = 0;
 		schedule_work(&ff->rx_midi_work[port]);
 		return;
 	}
-- 
2.9.3
