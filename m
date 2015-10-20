From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] ALSA: firewire-tascam: fix loop condition
	with some readable variables
Date: Tue, 20 Oct 2015 23:46:58 +0900
Message-ID: <1445352419-21827-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1445352419-21827-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 87D6C2665D4
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

In transactions for MIDI messages, the first byte is used for label and
the rest is for MIDI bytes. In current code, these are handled correctly,
while there's a small mistake for loop condition to include meaningless
statement.

This commit adds two local variables for them and improve the loop
condition.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 35 +++++++++++++++++-------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index ea88655..99098aa 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -63,17 +63,22 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 	struct snd_tscm *tscm = substream->rmidi->private_data;
 	unsigned int port = substream->number;
 	int i, len, consume;
+	u8 *label, *msg;
 	u8 status;
 
-	consume = snd_rawmidi_transmit_peek(substream, buf + 1, 3);
+	/* The first byte is used for label, the rest for MIDI bytes. */
+	label = buf;
+	msg = buf + 1;
+
+	consume = snd_rawmidi_transmit_peek(substream, msg, 3);
 	if (consume == 0)
 		return 0;
 
 	/* On exclusive message. */
 	if (tscm->on_sysex[port]) {
 		/* Seek the end of exclusives. */
-		for (i = 1; i < 4 || i < consume; ++i) {
-			if (buf[i] == 0xf7) {
+		for (i = 0; i < consume; ++i) {
+			if (msg[i] == 0xf7) {
 				tscm->on_sysex[port] = false;
 				break;
 			}
@@ -81,27 +86,27 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 
 		/* At the end of exclusive message, use label 0x07. */
 		if (!tscm->on_sysex[port]) {
-			consume = i;
-			buf[0] = (port << 4) | 0x07;
+			consume = i + 1;
+			*label = (port << 4) | 0x07;
 		/* During exclusive message, use label 0x04. */
 		} else if (consume == 3) {
-			buf[0] = (port << 4) | 0x04;
+			*label = (port << 4) | 0x04;
 		/* We need to fill whole 3 bytes. Go to next change. */
 		} else {
 			consume = 0;
 		}
 	} else {
 		/* The beginning of exclusives. */
-		if (buf[1] == 0xf0) {
+		if (msg[0] == 0xf0) {
 			/* Transfer it in next chance in another condition. */
 			tscm->on_sysex[port] = true;
 			return 0;
 		} else {
 			/* On running-status. */
-			if ((buf[1] & 0x80) != 0x80)
+			if ((msg[0] & 0x80) != 0x80)
 				status = tscm->running_status[port];
 			else
-				status = buf[1];
+				status = msg[0];
 
 			/* Calculate consume bytes. */
 			len = calculate_message_bytes(status);
@@ -109,13 +114,13 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 				return 0;
 
 			/* On running-status. */
-			if ((buf[1] & 0x80) != 0x80) {
-				buf[3] = buf[2];
-				buf[2] = buf[1];
-				buf[1] = tscm->running_status[port];
+			if ((msg[0] & 0x80) != 0x80) {
+				msg[2] = msg[1];
+				msg[1] = msg[0];
+				msg[0] = tscm->running_status[port];
 				consume--;
 			} else {
-				tscm->running_status[port] = buf[1];
+				tscm->running_status[port] = msg[0];
 			}
 
 			/* Confirm length. */
@@ -125,7 +130,7 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 				consume = len;
 		}
 
-		buf[0] = (port << 4) | (buf[1] >> 4);
+		*label = (port << 4) | (msg[0] >> 4);
 	}
 
 	return consume;
-- 
2.1.4
