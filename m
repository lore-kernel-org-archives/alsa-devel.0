From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/10] ALSA: dice: expand timeout to wait for
	Dice notification
Date: Sat, 12 Dec 2015 12:06:01 +0900
Message-ID: <1449889570-26641-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1449889570-26641-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 698DE26548F
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 04:06:15 +0100 (CET)
In-Reply-To: <1449889570-26641-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Some users have reported that their Dice based models generate ETIMEDOUT
when starting PCM playback. It means that current timeout (=100msec) is
not enough for their models to transfer notifications.

This commit expands the timeout up to 2 sec. As a result, in a worst case,
any operations to start AMDTP streams takes 2 sec or more. Then, in
userspace, snd_pcm_hw_params(), snd_pcm_prepare(), snd_pcm_recover(),
snd_rawmidi_open(), snd_seq_connect_from() and snd_seq_connect_to() may
take the time.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/dice/dice-transaction.c b/sound/firewire/dice/dice-transaction.c
index aee7461..9ea223a 100644
--- a/sound/firewire/dice/dice-transaction.c
+++ b/sound/firewire/dice/dice-transaction.c
@@ -9,7 +9,7 @@
 
 #include "dice.h"
 
-#define NOTIFICATION_TIMEOUT_MS	100
+#define NOTIFICATION_TIMEOUT_MS	(2 * MSEC_PER_SEC)
 
 static u64 get_subaddr(struct snd_dice *dice, enum snd_dice_addr_type type,
 		       u64 offset)
-- 
2.5.0
