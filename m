From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 6/8] ALSA: firewire-tascam: initialize
	parameters at open of rawmidi character devices
Date: Fri, 14 Apr 2017 16:46:30 +0900
Message-ID: <20170414074632.13453-7-o-takashi@sakamocchi.jp>
References: <20170414074632.13453-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id AE59526717D
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

In current design of ALSA driver for TASCAM FireWire series, initialization
of members in asymc midi port structure is done at device probing. Some of
the members should be initialized every time to use rawmidi devices because
they're changed in sequence of transmission for MIDI messages.

This commit adds a new function to initialize them. Invariant parameters
during object lifetime are kept as is.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-midi.c        |  2 ++
 sound/firewire/tascam/tascam-transaction.c | 16 ++++------------
 sound/firewire/tascam/tascam.h             |  3 +--
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/sound/firewire/tascam/tascam-midi.c b/sound/firewire/tascam/tascam-midi.c
index df4f95d..901df81 100644
--- a/sound/firewire/tascam/tascam-midi.c
+++ b/sound/firewire/tascam/tascam-midi.c
@@ -18,6 +18,8 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_tscm *tscm = substream->rmidi->private_data;
 
+	snd_fw_async_midi_port_init(&tscm->out_ports[substream->number]);
+
 	/* Initialize internal status. */
 	tscm->running_status[substream->number] = 0;
 	tscm->on_sysex[substream->number] = 0;
diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 248afe6..a248a4a 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -236,17 +236,10 @@ static void midi_port_work(struct work_struct *work)
 			port);
 }
 
-int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
-		struct fw_unit *unit)
+void snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port)
 {
-	port->parent = fw_parent_device(unit);
 	port->idling = true;
-	port->next_ktime = 0;
 	port->error = false;
-
-	INIT_WORK(&port->work, midi_port_work);
-
-	return 0;
 }
 
 static void handle_midi_tx(struct fw_card *card, struct fw_request *request,
@@ -324,10 +317,9 @@ int snd_tscm_transaction_register(struct snd_tscm *tscm)
 		goto error;
 
 	for (i = 0; i < TSCM_MIDI_OUT_PORT_MAX; i++) {
-		err = snd_fw_async_midi_port_init(
-				&tscm->out_ports[i], tscm->unit);
-		if (err < 0)
-			goto error;
+		tscm->out_ports[i].parent = fw_parent_device(tscm->unit);
+		tscm->out_ports[i].next_ktime = 0;
+		INIT_WORK(&tscm->out_ports[i].work, midi_port_work);
 	}
 
 	return err;
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index fdf352b..37ec201 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -146,8 +146,7 @@ void snd_tscm_stream_lock_changed(struct snd_tscm *tscm);
 int snd_tscm_stream_lock_try(struct snd_tscm *tscm);
 void snd_tscm_stream_lock_release(struct snd_tscm *tscm);
 
-int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
-		struct fw_unit *unit);
+void snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port);
 
 static inline void
 snd_fw_async_midi_port_run(struct snd_fw_async_midi_port *port,
-- 
2.9.3
