From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/19] ALSA: firewire-tascam: code refactoring
	for initialization/destruction of AMDTP stream
Date: Sun,  4 Aug 2019 15:21:27 +0900
Message-ID: <20190804062138.1217-9-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B05FFF800F3
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:21:55 +0200 (CEST)
In-Reply-To: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
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

This commit is a preparation to support AMDTP domain.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-stream.c | 71 +++++++++++++++++----------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index e852e46ebe6f..d5e77036e0ee 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -287,38 +287,60 @@ static int keep_resources(struct snd_tscm *tscm, unsigned int rate,
 				fw_parent_device(tscm->unit)->max_speed);
 }
 
-int snd_tscm_stream_init_duplex(struct snd_tscm *tscm)
+static int init_stream(struct snd_tscm *tscm, struct amdtp_stream *s)
 {
+	struct fw_iso_resources *resources;
+	enum amdtp_stream_direction dir;
 	unsigned int pcm_channels;
 	int err;
 
-	/* For out-stream. */
-	err = fw_iso_resources_init(&tscm->rx_resources, tscm->unit);
-	if (err < 0)
-		return err;
-	pcm_channels = tscm->spec->pcm_playback_analog_channels;
+	if (s == &tscm->tx_stream) {
+		resources = &tscm->tx_resources;
+		dir = AMDTP_IN_STREAM;
+		pcm_channels = tscm->spec->pcm_capture_analog_channels;
+	} else {
+		resources = &tscm->rx_resources;
+		dir = AMDTP_OUT_STREAM;
+		pcm_channels = tscm->spec->pcm_playback_analog_channels;
+	}
+
 	if (tscm->spec->has_adat)
 		pcm_channels += 8;
 	if (tscm->spec->has_spdif)
 		pcm_channels += 2;
-	err = amdtp_tscm_init(&tscm->rx_stream, tscm->unit, AMDTP_OUT_STREAM,
-			      pcm_channels);
+
+	err = fw_iso_resources_init(resources, tscm->unit);
 	if (err < 0)
 		return err;
 
-	/* For in-stream. */
-	err = fw_iso_resources_init(&tscm->tx_resources, tscm->unit);
+	err = amdtp_tscm_init(s, tscm->unit, dir, pcm_channels);
+	if (err < 0)
+		fw_iso_resources_free(resources);
+
+	return err;
+}
+
+static void destroy_stream(struct snd_tscm *tscm, struct amdtp_stream *s)
+{
+	amdtp_stream_destroy(s);
+
+	if (s == &tscm->tx_stream)
+		fw_iso_resources_destroy(&tscm->tx_resources);
+	else
+		fw_iso_resources_destroy(&tscm->rx_resources);
+}
+
+int snd_tscm_stream_init_duplex(struct snd_tscm *tscm)
+{
+	int err;
+
+	err = init_stream(tscm, &tscm->tx_stream);
 	if (err < 0)
 		return err;
-	pcm_channels = tscm->spec->pcm_capture_analog_channels;
-	if (tscm->spec->has_adat)
-		pcm_channels += 8;
-	if (tscm->spec->has_spdif)
-		pcm_channels += 2;
-	err = amdtp_tscm_init(&tscm->tx_stream, tscm->unit, AMDTP_IN_STREAM,
-			      pcm_channels);
+
+	err = init_stream(tscm, &tscm->rx_stream);
 	if (err < 0)
-		amdtp_stream_destroy(&tscm->rx_stream);
+		destroy_stream(tscm, &tscm->tx_stream);
 
 	return err;
 }
@@ -333,17 +355,12 @@ void snd_tscm_stream_update_duplex(struct snd_tscm *tscm)
 	amdtp_stream_stop(&tscm->rx_stream);
 }
 
-/*
- * This function should be called before starting streams or after stopping
- * streams.
- */
+// This function should be called before starting streams or after stopping
+// streams.
 void snd_tscm_stream_destroy_duplex(struct snd_tscm *tscm)
 {
-	amdtp_stream_destroy(&tscm->rx_stream);
-	amdtp_stream_destroy(&tscm->tx_stream);
-
-	fw_iso_resources_destroy(&tscm->rx_resources);
-	fw_iso_resources_destroy(&tscm->tx_resources);
+	destroy_stream(tscm, &tscm->rx_stream);
+	destroy_stream(tscm, &tscm->tx_stream);
 }
 
 int snd_tscm_stream_reserve_duplex(struct snd_tscm *tscm, unsigned int rate)
-- 
2.20.1
