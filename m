From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 5/8] ALSA: firewire-tascam: use fixed-length
	array for message cache to async midi port
Date: Fri, 14 Apr 2017 16:46:29 +0900
Message-ID: <20170414074632.13453-6-o-takashi@sakamocchi.jp>
References: <20170414074632.13453-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id ADE0026717C
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 09:46:39 +0200 (CEST)
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

ALSA driver for TASCAM FireWire series internally allocates 4 byte buffer
for asynchronous transaction to transfer MIDI messages. However, the buffer
can be allocated with memory object of parent structure.

This commit adds 4 byte array as a member of the structure and obsoletes
the redundant allocation. This is deallocated with memory object of parent
structure.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 15 ---------------
 sound/firewire/tascam/tascam.h             |  4 ++--
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 4e362b83..248afe6 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -239,10 +239,6 @@ static void midi_port_work(struct work_struct *work)
 int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
 		struct fw_unit *unit)
 {
-	port->buf = kzalloc(4, GFP_KERNEL);
-	if (port->buf == NULL)
-		return -ENOMEM;
-
 	port->parent = fw_parent_device(unit);
 	port->idling = true;
 	port->next_ktime = 0;
@@ -253,13 +249,6 @@ int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
 	return 0;
 }
 
-void snd_fw_async_midi_port_destroy(struct snd_fw_async_midi_port *port)
-{
-	snd_fw_async_midi_port_finish(port);
-	cancel_work_sync(&port->work);
-	kfree(port->buf);
-}
-
 static void handle_midi_tx(struct fw_card *card, struct fw_request *request,
 			   int tcode, int destination, int source,
 			   int generation, unsigned long long offset,
@@ -389,7 +378,6 @@ int snd_tscm_transaction_reregister(struct snd_tscm *tscm)
 void snd_tscm_transaction_unregister(struct snd_tscm *tscm)
 {
 	__be32 reg;
-	unsigned int i;
 
 	if (tscm->async_handler.callback_data == NULL)
 		return;
@@ -416,7 +404,4 @@ void snd_tscm_transaction_unregister(struct snd_tscm *tscm)
 
 	fw_core_remove_address_handler(&tscm->async_handler);
 	tscm->async_handler.callback_data = NULL;
-
-	for (i = 0; i < TSCM_MIDI_OUT_PORT_MAX; i++)
-		snd_fw_async_midi_port_destroy(&tscm->out_ports[i]);
 }
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index de0aefe..fdf352b 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -54,7 +54,7 @@ struct snd_fw_async_midi_port {
 
 	struct fw_transaction transaction;
 
-	u8 *buf;
+	u8 buf[4];
 
 	struct snd_rawmidi_substream *substream;
 	int consume_bytes;
@@ -148,7 +148,6 @@ void snd_tscm_stream_lock_release(struct snd_tscm *tscm);
 
 int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
 		struct fw_unit *unit);
-void snd_fw_async_midi_port_destroy(struct snd_fw_async_midi_port *port);
 
 static inline void
 snd_fw_async_midi_port_run(struct snd_fw_async_midi_port *port,
@@ -164,6 +163,7 @@ static inline void
 snd_fw_async_midi_port_finish(struct snd_fw_async_midi_port *port)
 {
 	port->substream = NULL;
+	cancel_work_sync(&port->work);
 	port->error = false;
 }
 
-- 
2.9.3
