From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 4/8] ALSA: firewire-tascam: use the same
	address for asynchronous transaction for MIDI message
Date: Fri, 14 Apr 2017 16:46:28 +0900
Message-ID: <20170414074632.13453-5-o-takashi@sakamocchi.jp>
References: <20170414074632.13453-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 37C31267168
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 09:46:36 +0200 (CEST)
In-Reply-To: <20170414074632.13453-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, dev@andree.sk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Units on TASCAM FireWire series receive MIDI messages by asynchronous
transactions on IEEE 1394 bus. Although the transaction is sent to a
certain register, current ALSA driver for this series has a redundant design.

This commit use the same address for the transaction.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 9 ++++-----
 sound/firewire/tascam/tascam.h             | 3 +--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 2f5e20c..4e362b83 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -230,20 +230,20 @@ static void midi_port_work(struct work_struct *work)
 	fw_send_request(port->parent->card, &port->transaction,
 			TCODE_WRITE_QUADLET_REQUEST,
 			port->parent->node_id, generation,
-			port->parent->max_speed, port->addr,
+			port->parent->max_speed,
+			TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_RX_QUAD,
 			port->buf, 4, async_midi_port_callback,
 			port);
 }
 
 int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
-		struct fw_unit *unit, u64 addr)
+		struct fw_unit *unit)
 {
 	port->buf = kzalloc(4, GFP_KERNEL);
 	if (port->buf == NULL)
 		return -ENOMEM;
 
 	port->parent = fw_parent_device(unit);
-	port->addr = addr;
 	port->idling = true;
 	port->next_ktime = 0;
 	port->error = false;
@@ -336,8 +336,7 @@ int snd_tscm_transaction_register(struct snd_tscm *tscm)
 
 	for (i = 0; i < TSCM_MIDI_OUT_PORT_MAX; i++) {
 		err = snd_fw_async_midi_port_init(
-				&tscm->out_ports[i], tscm->unit,
-				TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_RX_QUAD);
+				&tscm->out_ports[i], tscm->unit);
 		if (err < 0)
 			goto error;
 	}
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index c89d7af..de0aefe 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -52,7 +52,6 @@ struct snd_fw_async_midi_port {
 	ktime_t next_ktime;
 	bool error;
 
-	u64 addr;
 	struct fw_transaction transaction;
 
 	u8 *buf;
@@ -148,7 +147,7 @@ int snd_tscm_stream_lock_try(struct snd_tscm *tscm);
 void snd_tscm_stream_lock_release(struct snd_tscm *tscm);
 
 int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
-		struct fw_unit *unit, u64 addr);
+		struct fw_unit *unit);
 void snd_fw_async_midi_port_destroy(struct snd_fw_async_midi_port *port);
 
 static inline void
-- 
2.9.3
