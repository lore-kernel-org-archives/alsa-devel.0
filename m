From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 7/8] ALSA: dice: expand timeout to wait for
	Dice notification
Date: Sun, 15 Nov 2015 18:25:35 +0900
Message-ID: <1447579536-4459-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E62832606CF
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 10:25:42 +0100 (CET)
In-Reply-To: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
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
at probing processing. It means that current timeout (=100msec) is not
enough for their models to transfer notifications.

This commit expands the timeout up to 2 sec. As a result, in a worst case,
any operations to start AMDTP streams takes 2 sec or more. In userspace,
snd_pcm_hw_params(), snd_pcm_prepare(), snd_pcm_recover(),
snd_rawmidi_open(), snd_seq_connect_from() and snd_seq_connect_to() takes
the time.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index a5fc694..aa639c6 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -10,7 +10,7 @@
 #include "dice.h"
 
 #define	CALLBACK_TIMEOUT	200
-#define NOTIFICATION_TIMEOUT_MS	100
+#define NOTIFICATION_TIMEOUT_MS	2000
 
 static const unsigned int dice_stream_rates[] = {
 	/* mode 0 */
-- 
2.5.0
