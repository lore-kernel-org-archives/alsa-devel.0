From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/15] ALSA: firewire-tascam: update
	isochronous resources when starting packet streaming after bus reset
Date: Sun,  2 Jun 2019 16:12:49 +0900
Message-ID: <20190602071259.21622-6-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C43FFF896F7
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:13 +0200 (CEST)
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

After bus reset, isochronous resource manager releases all of allocated
isochronous resources. The nodes to restart packet streaming should
request reallocation of the resources.

However, between the bus-reset and invocation of 'struct fw_driver.update'
handler, ALSA PCM application can detect this situation by XRUN because
the target device cancelled to transmit packets once bus-reset occurs.

Due to the above mechanism, ALSA firewire-tascam driver just stops
packet streaming in the update handler, thus pcm.prepare handler
should request the reallocation.

This commit requests the reallocation in pcm.prepare callback when
bus generation is changed.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-stream.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index 18d554d46be5..be9dcc808188 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -321,7 +321,7 @@ int snd_tscm_stream_init_duplex(struct snd_tscm *tscm)
 	return err;
 }
 
-/* At bus reset, streaming is stopped and some registers are clear. */
+// At bus reset, streaming is stopped and some registers are clear.
 void snd_tscm_stream_update_duplex(struct snd_tscm *tscm)
 {
 	amdtp_stream_pcm_abort(&tscm->tx_stream);
@@ -390,6 +390,7 @@ void snd_tscm_stream_release_duplex(struct snd_tscm *tscm)
 
 int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 {
+	unsigned int generation = tscm->rx_resources.generation;
 	int err;
 
 	if (tscm->substreams_counter == 0)
@@ -403,6 +404,16 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 		finish_session(tscm);
 	}
 
+	if (generation != fw_parent_device(tscm->unit)->card->generation) {
+		err = fw_iso_resources_update(&tscm->tx_resources);
+		if (err < 0)
+			goto error;
+
+		err = fw_iso_resources_update(&tscm->rx_resources);
+		if (err < 0)
+			goto error;
+	}
+
 	if (!amdtp_stream_running(&tscm->rx_stream)) {
 		err = set_stream_formats(tscm, rate);
 		if (err < 0)
-- 
2.20.1
