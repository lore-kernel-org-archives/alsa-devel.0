From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/15] ALSA: firewire-tascam: code refactoring
	for reservation of isochronous resources
Date: Sun,  2 Jun 2019 16:12:46 +0900
Message-ID: <20190602071259.21622-3-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EFE5F896EF
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:08 +0200 (CEST)
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

This commit applies minor code refactoring for a helper function to
allocate isochronous resources.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-stream.c | 38 +++++++++++----------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index 7cddd9ece4ee..fc963469f6b0 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -276,34 +276,24 @@ static void release_resources(struct snd_tscm *tscm)
 	fw_iso_resources_free(&tscm->rx_resources);
 }
 
-static int keep_resources(struct snd_tscm *tscm, unsigned int rate)
+static int keep_resources(struct snd_tscm *tscm, unsigned int rate,
+			  struct amdtp_stream *stream)
 {
+	struct fw_iso_resources *resources;
 	int err;
 
-	/* Keep resources for in-stream. */
-	err = amdtp_tscm_set_parameters(&tscm->tx_stream, rate);
-	if (err < 0)
-		return err;
-	err = fw_iso_resources_allocate(&tscm->tx_resources,
-			amdtp_stream_get_max_payload(&tscm->tx_stream),
-			fw_parent_device(tscm->unit)->max_speed);
-	if (err < 0)
-		goto error;
+	if (stream == &tscm->tx_stream)
+		resources = &tscm->tx_resources;
+	else
+		resources = &tscm->rx_resources;
 
-	/* Keep resources for out-stream. */
-	err = amdtp_tscm_set_parameters(&tscm->rx_stream, rate);
-	if (err < 0)
-		return err;
-	err = fw_iso_resources_allocate(&tscm->rx_resources,
-			amdtp_stream_get_max_payload(&tscm->rx_stream),
-			fw_parent_device(tscm->unit)->max_speed);
+	err = amdtp_tscm_set_parameters(stream, rate);
 	if (err < 0)
 		return err;
 
-	return 0;
-error:
-	release_resources(tscm);
-	return err;
+	return fw_iso_resources_allocate(resources,
+				amdtp_stream_get_max_payload(stream),
+				fw_parent_device(tscm->unit)->max_speed);
 }
 
 int snd_tscm_stream_init_duplex(struct snd_tscm *tscm)
@@ -388,7 +378,11 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 	}
 
 	if (!amdtp_stream_running(&tscm->rx_stream)) {
-		err = keep_resources(tscm, rate);
+		err = keep_resources(tscm, rate, &tscm->tx_stream);
+		if (err < 0)
+			goto error;
+
+		err = keep_resources(tscm, rate, &tscm->rx_stream);
 		if (err < 0)
 			goto error;
 
-- 
2.20.1
