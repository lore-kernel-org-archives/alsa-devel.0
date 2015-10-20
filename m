From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] ALSA: firewire-tascam: use better name for
	local variables to describe their intension
Date: Tue, 20 Oct 2015 23:46:57 +0900
Message-ID: <1445352419-21827-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1445352419-21827-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C1A02665E1
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 16:47:04 +0200 (CEST)
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

In the callback function of asynchronous MIDI port, the intension of some
local variables are not clear.

This commit improves them. The 'len' variable is used to calculate the
number of MIDI bytes including in the transaction. The 'consume' variable
is used to return the actual number of consumed bytes in ALSA MIDI buffer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 7c80684..ea88655 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -65,14 +65,14 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 	int i, len, consume;
 	u8 status;
 
-	len = snd_rawmidi_transmit_peek(substream, buf + 1, 3);
-	if (len == 0)
+	consume = snd_rawmidi_transmit_peek(substream, buf + 1, 3);
+	if (consume == 0)
 		return 0;
 
 	/* On exclusive message. */
 	if (tscm->on_sysex[port]) {
 		/* Seek the end of exclusives. */
-		for (i = 1; i < 4 || i < len; ++i) {
+		for (i = 1; i < 4 || i < consume; ++i) {
 			if (buf[i] == 0xf7) {
 				tscm->on_sysex[port] = false;
 				break;
@@ -81,14 +81,14 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 
 		/* At the end of exclusive message, use label 0x07. */
 		if (!tscm->on_sysex[port]) {
-			len = i;
+			consume = i;
 			buf[0] = (port << 4) | 0x07;
 		/* During exclusive message, use label 0x04. */
-		} else if (len == 3) {
+		} else if (consume == 3) {
 			buf[0] = (port << 4) | 0x04;
 		/* We need to fill whole 3 bytes. Go to next change. */
 		} else {
-			len = 0;
+			consume = 0;
 		}
 	} else {
 		/* The beginning of exclusives. */
@@ -104,8 +104,8 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 				status = buf[1];
 
 			/* Calculate consume bytes. */
-			consume = calculate_message_bytes(status);
-			if (consume <= 0)
+			len = calculate_message_bytes(status);
+			if (len <= 0)
 				return 0;
 
 			/* On running-status. */
@@ -119,16 +119,16 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 			}
 
 			/* Confirm length. */
-			if (len < consume)
+			if (consume < len)
 				return 0;
-			if (len > consume)
-				len = consume;
+			if (consume > len)
+				consume = len;
 		}
 
 		buf[0] = (port << 4) | (buf[1] >> 4);
 	}
 
-	return len;
+	return consume;
 }
 
 static void handle_midi_tx(struct fw_card *card, struct fw_request *request,
-- 
2.1.4
