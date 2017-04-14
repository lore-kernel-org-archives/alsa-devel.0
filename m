From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 2/8] ALSA: firewire-tascam: remove callback
	function from async midi port
Date: Fri, 14 Apr 2017 16:46:26 +0900
Message-ID: <20170414074632.13453-3-o-takashi@sakamocchi.jp>
References: <20170414074632.13453-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 38E7A267169
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

As a result of localization of async midi port, ALSA driver for TASCAM
FireWire series can call helper function directly instead of callback
registration.

This commit removes the redundant design.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 8 +++-----
 sound/firewire/tascam/tascam.h             | 9 +--------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 8ba006e..dcbc003 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -197,7 +197,7 @@ static void midi_port_work(struct work_struct *work)
 	 * Later, snd_rawmidi_transmit_ack() is called.
 	 */
 	memset(port->buf, 0, port->len);
-	port->consume_bytes = port->fill(substream, port->buf);
+	port->consume_bytes = fill_message(substream, port->buf);
 	if (port->consume_bytes <= 0) {
 		/* Do it in next chance, immediately. */
 		if (port->consume_bytes == 0) {
@@ -242,8 +242,7 @@ static void midi_port_work(struct work_struct *work)
 }
 
 int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
-		struct fw_unit *unit, u64 addr, unsigned int len,
-		snd_fw_async_midi_port_fill fill)
+		struct fw_unit *unit, u64 addr, unsigned int len)
 {
 	port->len = DIV_ROUND_UP(len, 4) * 4;
 	port->buf = kzalloc(port->len, GFP_KERNEL);
@@ -252,7 +251,6 @@ int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
 
 	port->parent = fw_parent_device(unit);
 	port->addr = addr;
-	port->fill = fill;
 	port->idling = true;
 	port->next_ktime = 0;
 	port->error = false;
@@ -347,7 +345,7 @@ int snd_tscm_transaction_register(struct snd_tscm *tscm)
 		err = snd_fw_async_midi_port_init(
 				&tscm->out_ports[i], tscm->unit,
 				TSCM_ADDR_BASE + TSCM_OFFSET_MIDI_RX_QUAD,
-				4, fill_message);
+				4);
 		if (err < 0)
 			goto error;
 	}
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index de76313..116a200 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -45,11 +45,6 @@ struct snd_tscm_spec {
 #define TSCM_MIDI_IN_PORT_MAX	4
 #define TSCM_MIDI_OUT_PORT_MAX	4
 
-struct snd_fw_async_midi_port;
-typedef int (*snd_fw_async_midi_port_fill)(
-				struct snd_rawmidi_substream *substream,
-				u8 *buf);
-
 struct snd_fw_async_midi_port {
 	struct fw_device *parent;
 	struct work_struct work;
@@ -64,7 +59,6 @@ struct snd_fw_async_midi_port {
 	unsigned int len;
 
 	struct snd_rawmidi_substream *substream;
-	snd_fw_async_midi_port_fill fill;
 	int consume_bytes;
 };
 
@@ -155,8 +149,7 @@ int snd_tscm_stream_lock_try(struct snd_tscm *tscm);
 void snd_tscm_stream_lock_release(struct snd_tscm *tscm);
 
 int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
-		struct fw_unit *unit, u64 addr, unsigned int len,
-		snd_fw_async_midi_port_fill fill);
+		struct fw_unit *unit, u64 addr, unsigned int len);
 void snd_fw_async_midi_port_destroy(struct snd_fw_async_midi_port *port);
 
 static inline void
-- 
2.9.3
