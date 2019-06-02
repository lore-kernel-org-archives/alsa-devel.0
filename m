From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/15] ALSA: firewire-tascam: code refactoring
	for release of isochronous resources
Date: Sun,  2 Jun 2019 16:12:47 +0900
Message-ID: <20190602071259.21622-4-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 747FFF80C06
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:10 +0200 (CEST)
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

This commit is a part of preparation to perform allocation/release
of isochronous channels in pcm.hw_params/hw_free callbacks.

This commit obsoletes a helper function to release isochronous resources
for both direction.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-stream.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index fc963469f6b0..6ad149274050 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -269,13 +269,6 @@ static int begin_session(struct snd_tscm *tscm)
 				  &reg, sizeof(reg), 0);
 }
 
-static void release_resources(struct snd_tscm *tscm)
-{
-	// Release isochronous resources.
-	fw_iso_resources_free(&tscm->tx_resources);
-	fw_iso_resources_free(&tscm->rx_resources);
-}
-
 static int keep_resources(struct snd_tscm *tscm, unsigned int rate,
 			  struct amdtp_stream *stream)
 {
@@ -374,7 +367,8 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 		amdtp_stream_stop(&tscm->rx_stream);
 		amdtp_stream_stop(&tscm->tx_stream);
 
-		release_resources(tscm);
+		fw_iso_resources_free(&tscm->tx_resources);
+		fw_iso_resources_free(&tscm->rx_resources);
 	}
 
 	if (!amdtp_stream_running(&tscm->rx_stream)) {
@@ -427,7 +421,9 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 	amdtp_stream_stop(&tscm->tx_stream);
 
 	finish_session(tscm);
-	release_resources(tscm);
+
+	fw_iso_resources_free(&tscm->tx_resources);
+	fw_iso_resources_free(&tscm->rx_resources);
 
 	return err;
 }
@@ -441,7 +437,9 @@ void snd_tscm_stream_stop_duplex(struct snd_tscm *tscm)
 	amdtp_stream_stop(&tscm->rx_stream);
 
 	finish_session(tscm);
-	release_resources(tscm);
+
+	fw_iso_resources_free(&tscm->tx_resources);
+	fw_iso_resources_free(&tscm->rx_resources);
 }
 
 void snd_tscm_stream_lock_changed(struct snd_tscm *tscm)
-- 
2.20.1
