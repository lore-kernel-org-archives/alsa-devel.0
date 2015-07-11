From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 07/37] ALSA: firewire-lib: avoid endless
	loop to transfer MIDI messages at fatal error
Date: Sat, 11 Jul 2015 23:12:18 +0900
Message-ID: <1436623968-10780-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 6962E26057A
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

When asynchronous transactions finish in error state and retries,
tasklet scheduling and tasklet running also continues.

This commit cancels transferring MIDI messages wnen transactions encounter
fatal error, by setting error state.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.c | 11 +++++++++--
 sound/firewire/lib.h |  8 ++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index f9c1873..b568059c 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -79,6 +79,9 @@ static void async_midi_port_callback(struct fw_card *card, int rcode,
 	else if (!rcode_is_permanent_error(rcode))
 		/* To start next transaction immediately for recovery. */
 		port->next_tick = 0;
+	else
+		/* Don't continue processing. */
+		port->error = true;
 
 	port->idling = true;
 
@@ -94,8 +97,8 @@ static void midi_port_tasklet(unsigned long data)
 	int generation;
 	int type;
 
-	/* Under transacting. */
-	if (!port->idling)
+	/* Under transacting or error state. */
+	if (!port->idling || port->error)
 		return;
 
 	/* Nothing to do. */
@@ -117,6 +120,9 @@ static void midi_port_tasklet(unsigned long data)
 		if (port->consume_bytes == 0) {
 			port->next_tick = 0;
 			tasklet_schedule(&port->tasklet);
+		} else {
+			/* Fatal error. */
+			port->error = true;
 		}
 		return;
 	}
@@ -167,6 +173,7 @@ int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
 	port->packetize = packetize;
 	port->idling = true;
 	port->next_tick = 0;
+	port->error = false;
 
 	tasklet_init(&port->tasklet, midi_port_tasklet, (unsigned long)port);
 
diff --git a/sound/firewire/lib.h b/sound/firewire/lib.h
index e4b00e2..c9ea52b 100644
--- a/sound/firewire/lib.h
+++ b/sound/firewire/lib.h
@@ -27,6 +27,7 @@ struct snd_fw_async_midi_port {
 	struct tasklet_struct tasklet;
 	bool idling;
 	unsigned long next_tick;
+	bool error;
 
 	__u64 addr;
 	struct fw_transaction transaction;
@@ -54,8 +55,10 @@ static inline void
 snd_fw_async_midi_port_run(struct snd_fw_async_midi_port *port,
 			   struct snd_rawmidi_substream *substream)
 {
-	port->substream = substream;
-	tasklet_schedule(&port->tasklet);
+	if (port->error) {
+		port->substream = substream;
+		tasklet_schedule(&port->tasklet);
+	}
 }
 
 /**
@@ -66,6 +69,7 @@ static inline void
 snd_fw_async_midi_port_finish(struct snd_fw_async_midi_port *port)
 {
 	port->substream = NULL;
+	port->error = false;
 }
 
 #endif
-- 
2.1.4
