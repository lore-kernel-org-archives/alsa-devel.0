From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/5] ALSA: firewire-tascam: clear extra MIDI
	bytes in an asynchronous transaction
Date: Tue, 20 Oct 2015 23:46:59 +0900
Message-ID: <1445352419-21827-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1445352419-21827-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id F0BC22665E5
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 16:47:05 +0200 (CEST)
In-Reply-To: <1445352419-21827-1-git-send-email-o-takashi@sakamocchi.jp>
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

When MIDI buffer stores two or more MIDI messages, TASCAM driver
transfers asynchronous transactions including one MIDI message and
extra bytes from second MIDI message.

This commit fixes this bug by clearing needless bytes in the buffer. The
consumed bytes are already calculated correctly, thus the sequence of
transactions is already correct.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 99098aa..904ce03 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -93,8 +93,10 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 			*label = (port << 4) | 0x04;
 		/* We need to fill whole 3 bytes. Go to next change. */
 		} else {
-			consume = 0;
+			return 0;
 		}
+
+		len = consume;
 	} else {
 		/* The beginning of exclusives. */
 		if (msg[0] == 0xf0) {
@@ -115,24 +117,30 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 
 			/* On running-status. */
 			if ((msg[0] & 0x80) != 0x80) {
+				/* Enough MIDI bytes were not retrieved. */
+				if (consume < len - 1)
+					return 0;
+				consume = len - 1;
+
 				msg[2] = msg[1];
 				msg[1] = msg[0];
 				msg[0] = tscm->running_status[port];
-				consume--;
 			} else {
+				/* Enough MIDI bytes were not retrieved. */
+				if (consume < len)
+					return 0;
+				consume = len;
+
 				tscm->running_status[port] = msg[0];
 			}
-
-			/* Confirm length. */
-			if (consume < len)
-				return 0;
-			if (consume > len)
-				consume = len;
 		}
 
 		*label = (port << 4) | (msg[0] >> 4);
 	}
 
+	if (len > 0 && len < 3)
+		memset(msg + len, 0, 3 - len);
+
 	return consume;
 }
 
-- 
2.1.4
