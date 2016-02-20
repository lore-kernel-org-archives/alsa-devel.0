From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: bebob: give up updating streams at
	bus reset handler
Date: Sat, 20 Feb 2016 16:18:59 +0900
Message-ID: <1455952739-17044-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1455952739-17044-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C7C0F26145A
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

DM1000/DM1100/DM1500 chipsets transfer packets with discontinue value in
'dbc' field of CIP header. For ALSA bebob driver, this makes its bus-reset
handler meaningless, because the discontinuity is detected quite earlier
than executing the handler.

This commit gives up updating streams at the bus reset handler.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c        | 20 ++++++++++++++++----
 sound/firewire/bebob/bebob.h        |  1 -
 sound/firewire/bebob/bebob_stream.c | 15 ---------------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 671179e..3e4e075 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -300,6 +300,22 @@ error:
 	return err;
 }
 
+/*
+ * This driver doesn't update streams in bus reset handler.
+ *
+ * DM1000/ DM1100/DM1500 chipsets with BeBoB firmware transfer packets with
+ * discontinued counter at bus reset. This discontinuity is immediately
+ * detected in packet streaming layer, then it sets XRUN to PCM substream.
+ *
+ * ALSA PCM applications can know the XRUN by getting -EPIPE from PCM operation.
+ * Then, they can recover the PCM substream by executing ioctl(2) with
+ * SNDRV_PCM_IOCTL_PREPARE. 'struct snd_pcm_ops.prepare' is called and drivers
+ * restart packet streaming.
+ *
+ * The above processing may be executed before this bus-reset handler is
+ * executed. When this handler updates streams with current isochronous
+ * channels, the streams already have the current ones.
+ */
 static void
 bebob_update(struct fw_unit *unit)
 {
@@ -310,10 +326,6 @@ bebob_update(struct fw_unit *unit)
 
 	fcp_bus_reset(bebob->unit);
 
-	mutex_lock(&bebob->mutex);
-	snd_bebob_stream_update_duplex(bebob);
-	mutex_unlock(&bebob->mutex);
-
 	if (bebob->deferred_registration) {
 		if (snd_card_register(bebob->card) < 0) {
 			snd_bebob_stream_destroy_duplex(bebob);
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 4fe58e4..b50bb33d 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -217,7 +217,6 @@ int snd_bebob_stream_discover(struct snd_bebob *bebob);
 int snd_bebob_stream_init_duplex(struct snd_bebob *bebob);
 int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate);
 void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob);
-void snd_bebob_stream_update_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob);
 
 void snd_bebob_stream_lock_changed(struct snd_bebob *bebob);
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 8c68745..77cbb02 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -746,21 +746,6 @@ void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)
 	}
 }
 
-void snd_bebob_stream_update_duplex(struct snd_bebob *bebob)
-{
-	if ((cmp_connection_update(&bebob->in_conn) < 0) ||
-	    (cmp_connection_update(&bebob->out_conn) < 0)) {
-		amdtp_stream_pcm_abort(&bebob->rx_stream);
-		amdtp_stream_pcm_abort(&bebob->tx_stream);
-		amdtp_stream_stop(&bebob->rx_stream);
-		amdtp_stream_stop(&bebob->tx_stream);
-		break_both_connections(bebob);
-	} else {
-		amdtp_stream_update(&bebob->rx_stream);
-		amdtp_stream_update(&bebob->tx_stream);
-	}
-}
-
 /*
  * This function should be called before starting streams or after stopping
  * streams.
-- 
2.5.0
