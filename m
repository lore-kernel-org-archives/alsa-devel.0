From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 06/37] ALSA: firewire-lib: add throttle
	for MIDI data rate
Date: Sat, 11 Jul 2015 23:12:17 +0900
Message-ID: <1436623968-10780-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 4632A260564
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:04 +0200 (CEST)
In-Reply-To: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Typically, the target devices has internal buffer to adjust output of
received MIDI messages for MIDI serial bus. The capacity of the buffer
is limited, while IEEE 1394 transactions can transfer more MIDI messages
than MIDI serial bus can. For this reason, the MIDI transmission rate
should be constrained.

This commit adds throttle to limit MIDI data rate as 31,250 bits per
seconds. The data rate is enough slower than jiffies granuarity, thus
this commit utilize jiffies count to calculate data rate.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.c | 16 +++++++++++++++-
 sound/firewire/lib.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index e309b9b..f9c1873 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -76,6 +76,9 @@ static void async_midi_port_callback(struct fw_card *card, int rcode,
 
 	if (rcode == RCODE_COMPLETE && substream != NULL)
 		snd_rawmidi_transmit_ack(substream, port->consume_bytes);
+	else if (!rcode_is_permanent_error(rcode))
+		/* To start next transaction immediately for recovery. */
+		port->next_tick = 0;
 
 	port->idling = true;
 
@@ -99,6 +102,10 @@ static void midi_port_tasklet(unsigned long data)
 	if (substream == NULL || snd_rawmidi_transmit_empty(substream))
 		return;
 
+	/* Do it in next chance. */
+	if (time_is_after_jiffies(port->next_tick))
+		tasklet_schedule(&port->tasklet);
+
 	/*
 	 * Fill the buffer. The callee must use snd_rawmidi_transmit_peek().
 	 * Later, snd_rawmidi_transmit_ack() may be called.
@@ -107,8 +114,10 @@ static void midi_port_tasklet(unsigned long data)
 	port->consume_bytes = port->packetize(substream, port->buf);
 	if (port->consume_bytes <= 0) {
 		/* Do it in next chance, immediately. */
-		if (port->consume_bytes == 0)
+		if (port->consume_bytes == 0) {
+			port->next_tick = 0;
 			tasklet_schedule(&port->tasklet);
+		}
 		return;
 	}
 
@@ -118,6 +127,10 @@ static void midi_port_tasklet(unsigned long data)
 	else
 		type = TCODE_WRITE_BLOCK_REQUEST;
 
+	/* Set interval to next transaction. */
+	port->next_tick =
+		jiffies_64 + msecs_to_jiffies(port->consume_bytes * 8 / 31250);
+
 	/* Start this transaction. */
 	port->idling = false;
 	generation = port->parent->generation;
@@ -153,6 +166,7 @@ int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
 	port->addr = addr;
 	port->packetize = packetize;
 	port->idling = true;
+	port->next_tick = 0;
 
 	tasklet_init(&port->tasklet, midi_port_tasklet, (unsigned long)port);
 
diff --git a/sound/firewire/lib.h b/sound/firewire/lib.h
index 9d76f5c..e4b00e2 100644
--- a/sound/firewire/lib.h
+++ b/sound/firewire/lib.h
@@ -26,6 +26,7 @@ struct snd_fw_async_midi_port {
 	struct fw_device *parent;
 	struct tasklet_struct tasklet;
 	bool idling;
+	unsigned long next_tick;
 
 	__u64 addr;
 	struct fw_transaction transaction;
-- 
2.1.4
