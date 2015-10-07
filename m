From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] ALSA: firewire-lib: add throttle for MIDI
	data rate
Date: Wed,  7 Oct 2015 09:19:38 +0900
Message-ID: <1444177179-8082-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1444177179-8082-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 1096A2658CB
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 02:19:44 +0200 (CEST)
In-Reply-To: <1444177179-8082-1-git-send-email-o-takashi@sakamocchi.jp>
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

Typically, the target devices have internal buffer to adjust output of
received MIDI messages for MIDI serial bus, while the capacity of the
buffer is limited. IEEE 1394 transactions can transfer more MIDI messages
than MIDI serial bus can. This can cause buffer over flow in device side.

This commit adds throttle to limit MIDI data rate by counting intervals
by jiffies between two MIDI messages. Usual MIDI messages consists of two
or three bytes. This requires 1.302 to 1.953 mili-seconds interval between
these messages. This commit uses kernel monotonic time service to calculate
the time of next transaction.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.c | 19 ++++++++++++++++++-
 sound/firewire/lib.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index 3e9afd7..fd620e8 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -76,6 +76,9 @@ static void async_midi_port_callback(struct fw_card *card, int rcode,
 
 	if (rcode == RCODE_COMPLETE && substream != NULL)
 		snd_rawmidi_transmit_ack(substream, port->consume_bytes);
+	else if (!rcode_is_permanent_error(rcode))
+		/* To start next transaction immediately for recovery. */
+		port->next_ktime = ktime_set(0, 0);
 
 	port->idling = true;
 
@@ -99,6 +102,12 @@ static void midi_port_work(struct work_struct *work)
 	if (substream == NULL || snd_rawmidi_transmit_empty(substream))
 		return;
 
+	/* Do it in next chance. */
+	if (ktime_after(port->next_ktime, ktime_get())) {
+		schedule_work(&port->work);
+		return;
+	}
+
 	/*
 	 * Fill the buffer. The callee must use snd_rawmidi_transmit_peek().
 	 * Later, snd_rawmidi_transmit_ack() is called.
@@ -107,8 +116,10 @@ static void midi_port_work(struct work_struct *work)
 	port->consume_bytes = port->fill(substream, port->buf);
 	if (port->consume_bytes <= 0) {
 		/* Do it in next chance, immediately. */
-		if (port->consume_bytes == 0)
+		if (port->consume_bytes == 0) {
+			port->next_ktime = ktime_set(0, 0);
 			schedule_work(&port->work);
+		}
 		return;
 	}
 
@@ -118,6 +129,10 @@ static void midi_port_work(struct work_struct *work)
 	else
 		type = TCODE_WRITE_BLOCK_REQUEST;
 
+	/* Set interval to next transaction. */
+	port->next_ktime = ktime_add_ns(ktime_get(),
+				port->consume_bytes * 8 * NSEC_PER_SEC / 31250);
+
 	/* Start this transaction. */
 	port->idling = false;
 
@@ -162,6 +177,8 @@ int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
 	port->addr = addr;
 	port->fill = fill;
 	port->idling = true;
+	port->next_ktime = ktime_set(0, 0);
+	port->error = false;
 
 	INIT_WORK(&port->work, midi_port_work);
 
diff --git a/sound/firewire/lib.h b/sound/firewire/lib.h
index 0af06f4..59e0865 100644
--- a/sound/firewire/lib.h
+++ b/sound/firewire/lib.h
@@ -31,6 +31,7 @@ struct snd_fw_async_midi_port {
 	struct fw_device *parent;
 	struct work_struct work;
 	bool idling;
+	ktime_t next_ktime;
 
 	u64 addr;
 	struct fw_transaction transaction;
-- 
2.1.4
