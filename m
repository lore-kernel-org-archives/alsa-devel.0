From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/7] ALSA: firewire-tascam: drop reuse of
	incoming packet parameter for outgoing packet parameter
Date: Mon,  9 May 2016 23:15:52 +0900
Message-ID: <1462803356-6229-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1462803356-6229-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id EE8882654D4
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 16:16:01 +0200 (CEST)
In-Reply-To: <1462803356-6229-1-git-send-email-o-takashi@sakamocchi.jp>
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

In packet streaming protocol applied to TASCAM FireWire series, the value
of SYT field in CIP header is always zero, therefore it has no meaning.
There's no need to synchronize packets in both direction for the series.

In current implementation of ALSA firewire stack, driver for the series
uses incoming packet parameter for outgoing packet parameter to calculate
the number of data blocks. This can be simplified because the task of
corresponding driver is to transfer data blocks enough to sampling transfer
frequency.

This commit purges support of full duplex synchronization to prevent
over-engineering implementation.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-stream.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index 0e6dd5c6..4ad3bd7 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -381,19 +381,17 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 	if (err < 0)
 		return err;
 	if (curr_rate != rate ||
-	    amdtp_streaming_error(&tscm->tx_stream) ||
-	    amdtp_streaming_error(&tscm->rx_stream)) {
+	    amdtp_streaming_error(&tscm->rx_stream) ||
+	    amdtp_streaming_error(&tscm->tx_stream)) {
 		finish_session(tscm);
 
-		amdtp_stream_stop(&tscm->tx_stream);
 		amdtp_stream_stop(&tscm->rx_stream);
+		amdtp_stream_stop(&tscm->tx_stream);
 
 		release_resources(tscm);
 	}
 
-	if (!amdtp_stream_running(&tscm->tx_stream)) {
-		amdtp_stream_set_sync(CIP_SYNC_TO_DEVICE,
-				      &tscm->tx_stream, &tscm->rx_stream);
+	if (!amdtp_stream_running(&tscm->rx_stream)) {
 		err = keep_resources(tscm, rate);
 		if (err < 0)
 			goto error;
@@ -406,27 +404,27 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 		if (err < 0)
 			goto error;
 
-		err = amdtp_stream_start(&tscm->tx_stream,
-				tscm->tx_resources.channel,
+		err = amdtp_stream_start(&tscm->rx_stream,
+				tscm->rx_resources.channel,
 				fw_parent_device(tscm->unit)->max_speed);
 		if (err < 0)
 			goto error;
 
-		if (!amdtp_stream_wait_callback(&tscm->tx_stream,
+		if (!amdtp_stream_wait_callback(&tscm->rx_stream,
 						CALLBACK_TIMEOUT)) {
 			err = -ETIMEDOUT;
 			goto error;
 		}
 	}
 
-	if (!amdtp_stream_running(&tscm->rx_stream)) {
-		err = amdtp_stream_start(&tscm->rx_stream,
-				tscm->rx_resources.channel,
+	if (!amdtp_stream_running(&tscm->tx_stream)) {
+		err = amdtp_stream_start(&tscm->tx_stream,
+				tscm->tx_resources.channel,
 				fw_parent_device(tscm->unit)->max_speed);
 		if (err < 0)
 			goto error;
 
-		if (!amdtp_stream_wait_callback(&tscm->rx_stream,
+		if (!amdtp_stream_wait_callback(&tscm->tx_stream,
 						CALLBACK_TIMEOUT)) {
 			err = -ETIMEDOUT;
 			goto error;
@@ -435,8 +433,8 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 
 	return 0;
 error:
-	amdtp_stream_stop(&tscm->tx_stream);
 	amdtp_stream_stop(&tscm->rx_stream);
+	amdtp_stream_stop(&tscm->tx_stream);
 
 	finish_session(tscm);
 	release_resources(tscm);
-- 
2.7.4
