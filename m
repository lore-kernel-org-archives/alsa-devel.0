From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: bebob: simplify bus-reset handling
Date: Sat, 20 Feb 2016 16:18:56 +0900
Message-ID: <1455952739-17044-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1455952739-17044-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C66FE2612D2
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 08:19:04 +0100 (CET)
In-Reply-To: <1455952739-17044-1-git-send-email-o-takashi@sakamocchi.jp>
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

At bus-reset, DM1000/DM1100/DM1500 chipsets transfer packets with
discontinuous value in 'dbc' field of CIP header. In this case, packet
streaming layer in firewire-lib module stops streaming and set XRUN to PCM
substream.

In ALSA, PCM applications are notified the XRUN status by the return value
of ALSA PCM interface. They can recover this state by executing
snd_pcm_prepare(), then PCM drivers' prepare handler is called, and start
new PCM substream. For ALSA BeBoB driver, the handler establishes new
connections and start new AMDTP streaming.

Unfortunately, neither the PCM applications nor the driver know the reason
of XRUN. The driver gets to know the reason when update handler is called
by IEEE 1394 bus driver. As long as I tested, the order of below events are
not fixed:
 * Detecting packet discontinuity in tasklet context of OHCI 1394 driver
 * Calling prepare handler in process context of ALSA PCM application
 * Calling update handler in kthread context of IEEE 1394 bus driver

The unpredictable order is disadvantage for the driver to be compliant to
CMP. In IEC 61883-1, new CMP establish operations should be done 1 sec
(isoc_resource_delay) after bus-reset. Within 1 sec, CMP restore
operations are allowed. For this reason, in former commit ('b6bc812327aa:
ALSA: bebob/firewire-lib: Add a quirk for discontinuity at bus reset'),
the process context is forced to wait for executing update handler. The
process context wait for bus-reset up to 1 sec. This commit solves the
issue, while causes more disadvantages. For PCM applications, calling
snd_pcm_prepare() for recovering XRUN state takes more time and the driver
got a bit complicated code, while the recovery is not always successful.

As long as I tested, DM1000/DM1100/DM1500 and BeBoB firmware can allow
drivers to establish new connections just after bus reset. Furthermore,
any FCP transactions are handled correctly. Therefore, the driver don't
need to wait for bus reset handler for starting new streaming.

This commit removes the codes to reduce maintenance cost.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c        |  7 +++----
 sound/firewire/bebob/bebob.h        |  2 --
 sound/firewire/bebob/bebob_stream.c | 32 ++------------------------------
 3 files changed, 5 insertions(+), 36 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 091290d..671179e 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -309,7 +309,10 @@ bebob_update(struct fw_unit *unit)
 		return;
 
 	fcp_bus_reset(bebob->unit);
+
+	mutex_lock(&bebob->mutex);
 	snd_bebob_stream_update_duplex(bebob);
+	mutex_unlock(&bebob->mutex);
 
 	if (bebob->deferred_registration) {
 		if (snd_card_register(bebob->card) < 0) {
@@ -327,10 +330,6 @@ static void bebob_remove(struct fw_unit *unit)
 	if (bebob == NULL)
 		return;
 
-	/* Awake bus-reset waiters. */
-	if (!completion_done(&bebob->bus_reset))
-		complete_all(&bebob->bus_reset);
-
 	/* No need to wait for releasing card object in this context. */
 	snd_card_free_when_closed(bebob->card);
 }
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 4d8fcc7..c2e885c 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -88,8 +88,6 @@ struct snd_bebob {
 	unsigned int midi_input_ports;
 	unsigned int midi_output_ports;
 
-	/* for bus reset quirk */
-	struct completion bus_reset;
 	bool connected;
 
 	struct amdtp_stream *master;
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 5022c9b..073ad6d 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -549,8 +549,7 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 		destroy_both_connections(bebob);
 		goto end;
 	}
-	/* See comments in next function */
-	init_completion(&bebob->bus_reset);
+
 	bebob->tx_stream.flags |= CIP_SKIP_INIT_DBC_CHECK;
 
 	/*
@@ -588,25 +587,8 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 	struct amdtp_stream *master, *slave;
 	enum cip_flags sync_mode;
 	unsigned int curr_rate;
-	bool updated = false;
 	int err = 0;
 
-	/*
-	 * Normal BeBoB firmware has a quirk at bus reset to transmits packets
-	 * with discontinuous value in dbc field.
-	 *
-	 * This 'struct completion' is used to call .update() at first to update
-	 * connections/streams. Next following codes handle streaming error.
-	 */
-	if (amdtp_streaming_error(&bebob->tx_stream)) {
-		if (completion_done(&bebob->bus_reset))
-			reinit_completion(&bebob->bus_reset);
-
-		updated = (wait_for_completion_interruptible_timeout(
-				&bebob->bus_reset,
-				msecs_to_jiffies(FW_ISO_RESOURCE_DELAY)) > 0);
-	}
-
 	mutex_lock(&bebob->mutex);
 
 	/* Need no substreams */
@@ -642,8 +624,7 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 		amdtp_stream_stop(master);
 	if (amdtp_streaming_error(slave))
 		amdtp_stream_stop(slave);
-	if (!updated &&
-	    !amdtp_stream_running(master) && !amdtp_stream_running(slave))
+	if (!amdtp_stream_running(master) && !amdtp_stream_running(slave))
 		break_both_connections(bebob);
 
 	/* stop streams if rate is different */
@@ -774,9 +755,6 @@ void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)
 
 void snd_bebob_stream_update_duplex(struct snd_bebob *bebob)
 {
-	/* vs. XRUN recovery due to discontinuity at bus reset */
-	mutex_lock(&bebob->mutex);
-
 	if ((cmp_connection_update(&bebob->in_conn) < 0) ||
 	    (cmp_connection_update(&bebob->out_conn) < 0)) {
 		amdtp_stream_pcm_abort(&bebob->rx_stream);
@@ -788,12 +766,6 @@ void snd_bebob_stream_update_duplex(struct snd_bebob *bebob)
 		amdtp_stream_update(&bebob->rx_stream);
 		amdtp_stream_update(&bebob->tx_stream);
 	}
-
-	/* wake up stream_start_duplex() */
-	if (!completion_done(&bebob->bus_reset))
-		complete_all(&bebob->bus_reset);
-
-	mutex_unlock(&bebob->mutex);
 }
 
 /*
-- 
2.5.0
