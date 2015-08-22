From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/25] ALSA: firewire-lib: add a restriction
	for a transaction at once
Date: Sat, 22 Aug 2015 18:19:20 +0900
Message-ID: <1440235181-18181-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1440235181-18181-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 71360260578
 for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2015 11:19:46 +0200 (CEST)
In-Reply-To: <1440235181-18181-1-git-send-email-o-takashi@sakamocchi.jp>
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

Currently, when waiting for a response, callers can start another
transaction by scheduling another tasklet. This is not good for error
processing.

This commit serialize request/response transactions, by adding one
boolean member to represent idling state.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.c | 9 +++++++++
 sound/firewire/lib.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index 1ec4f52..9da8894 100644
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
@@ -110,6 +116,8 @@ static void midi_port_tasklet(unsigned long data)
 		type = TCODE_WRITE_BLOCK_REQUEST;
 
 	/* Start this transaction. */
+	port->idling = false;
+
 	/*
 	 * In Linux FireWire core, when generation is updated with memory
 	 * barrier, node id has already been updated. In this module, After
@@ -151,6 +159,7 @@ int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
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
