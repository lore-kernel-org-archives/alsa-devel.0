From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/15] ALSA: firewire-tascam: minor code
	refactoring to finish streaming session
Date: Sun,  2 Jun 2019 16:12:50 +0900
Message-ID: <20190602071259.21622-7-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F403AF896FE
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:14 +0200 (CEST)
In-Reply-To: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The operation to finish packet streaming corresponds to stopping
isochronous contexts.

This commit applies code refactoring to move codes to stop into
a helper function to finish the session.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-stream.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index be9dcc808188..f572dfc15114 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -181,6 +181,9 @@ static void finish_session(struct snd_tscm *tscm)
 {
 	__be32 reg;
 
+	amdtp_stream_stop(&tscm->rx_stream);
+	amdtp_stream_stop(&tscm->tx_stream);
+
 	reg = 0;
 	snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
 			   TSCM_ADDR_BASE + TSCM_OFFSET_START_STREAMING,
@@ -354,9 +357,6 @@ int snd_tscm_stream_reserve_duplex(struct snd_tscm *tscm, unsigned int rate)
 		return err;
 
 	if (tscm->substreams_counter == 0 || rate != curr_rate) {
-		amdtp_stream_stop(&tscm->rx_stream);
-		amdtp_stream_stop(&tscm->tx_stream);
-
 		finish_session(tscm);
 
 		fw_iso_resources_free(&tscm->tx_resources);
@@ -397,12 +397,8 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 		return 0;
 
 	if (amdtp_streaming_error(&tscm->rx_stream) ||
-	    amdtp_streaming_error(&tscm->tx_stream)) {
-		amdtp_stream_stop(&tscm->rx_stream);
-		amdtp_stream_stop(&tscm->tx_stream);
-
+	    amdtp_streaming_error(&tscm->tx_stream))
 		finish_session(tscm);
-	}
 
 	if (generation != fw_parent_device(tscm->unit)->card->generation) {
 		err = fw_iso_resources_update(&tscm->tx_resources);
@@ -452,9 +448,6 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 
 	return 0;
 error:
-	amdtp_stream_stop(&tscm->rx_stream);
-	amdtp_stream_stop(&tscm->tx_stream);
-
 	finish_session(tscm);
 
 	return err;
@@ -462,12 +455,8 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 
 void snd_tscm_stream_stop_duplex(struct snd_tscm *tscm)
 {
-	if (tscm->substreams_counter == 0) {
-		amdtp_stream_stop(&tscm->tx_stream);
-		amdtp_stream_stop(&tscm->rx_stream);
-
+	if (tscm->substreams_counter == 0)
 		finish_session(tscm);
-	}
 }
 
 void snd_tscm_stream_lock_changed(struct snd_tscm *tscm)
-- 
2.20.1
