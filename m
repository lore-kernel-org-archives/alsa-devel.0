From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] ALSA: tascam: remove buffer initialization
	in driver side
Date: Sun, 18 Oct 2015 19:02:16 +0900
Message-ID: <1445162538-12293-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1445162538-12293-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 2639726164D
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 12:02:26 +0200 (CEST)
In-Reply-To: <1445162538-12293-1-git-send-email-o-takashi@sakamocchi.jp>
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

The given buffer to callback function is cleared in caller side.

This commit removes buffer initialization in callee side.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 1c9a88b..7fcee81 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -67,8 +67,6 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 	u8 status;
 	int consume;
 
-	buf[0] = buf[1] = buf[2] = buf[3] = 0x00;
-
 	len = snd_rawmidi_transmit_peek(substream, buf + 1, 3);
 	if (len == 0)
 		return 0;
-- 
2.1.4
