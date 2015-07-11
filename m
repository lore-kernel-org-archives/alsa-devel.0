From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 04/37] ALSA: firewire-lib: serialize
	request transaction and response transaction
Date: Sat, 11 Jul 2015 23:12:15 +0900
Message-ID: <1436623968-10780-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 80689260545
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:02 +0200 (CEST)
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

The helper functions for asynchronous MIDI port use 'tasklet' to run IEEE
1394 asynchronous transactions, while running transactions need to wait
for response. In this reason, one transaction should be transferred at
one tasklet scheduling, because tasklet runs one kernel thread available
for the other tasks

For these reasons, this commit serialize request/response transactions,
by adding one boolean member.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.c | 8 ++++++++
 sound/firewire/lib.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index f5b5526..a66e011 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -76,6 +76,8 @@ static void async_midi_port_callback(struct fw_card *card, int rcode,
 
 	if (rcode == RCODE_COMPLETE && substream != NULL)
 		snd_rawmidi_transmit_ack(substream, port->consume_bytes);
+
+	port->idling = true;
 }
 
 static void midi_port_tasklet(unsigned long data)
@@ -86,6 +88,10 @@ static void midi_port_tasklet(unsigned long data)
 	int generation;
 	int type;
 
+	/* Under transacting. */
+	if (!port->idling)
+		return;
+
 	/* Nothing to do. */
 	if (substream == NULL || snd_rawmidi_transmit_empty(substream))
 		return;
@@ -110,6 +116,7 @@ static void midi_port_tasklet(unsigned long data)
 		type = TCODE_WRITE_BLOCK_REQUEST;
 
 	/* Start this transaction. */
+	port->idling = false;
 	generation = port->parent->generation;
 	smp_rmb(); /* node_id vs. generation */
 	fw_send_request(port->parent->card, &port->transaction, type,
@@ -142,6 +149,7 @@ int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
 	port->parent = fw_parent_device(unit);
 	port->addr = addr;
 	port->packetize = packetize;
+	port->idling = true;
 
 	tasklet_init(&port->tasklet, midi_port_tasklet, (unsigned long)port);
 
diff --git a/sound/firewire/lib.h b/sound/firewire/lib.h
index c662bf9..9d76f5c 100644
--- a/sound/firewire/lib.h
+++ b/sound/firewire/lib.h
@@ -25,6 +25,7 @@ static inline bool rcode_is_permanent_error(int rcode)
 struct snd_fw_async_midi_port {
 	struct fw_device *parent;
 	struct tasklet_struct tasklet;
+	bool idling;
 
 	__u64 addr;
 	struct fw_transaction transaction;
-- 
2.1.4
