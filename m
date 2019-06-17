From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/10] ALSA: firewire-motu: minor code
	refactoring to stop isochronous context
Date: Mon, 17 Jun 2019 17:15:06 +0900
Message-ID: <20190617081510.11025-7-o-takashi@sakamocchi.jp>
References: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D969FF89731
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 10:15:26 +0200 (CEST)
In-Reply-To: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
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

The helper function to stop isochronous context is superfluous. This
commit removes it with simpler codes.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-stream.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index cb01f1d784f1..4fbec35eaad5 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -142,19 +142,6 @@ static int start_isoc_ctx(struct snd_motu *motu, struct amdtp_stream *stream)
 	return 0;
 }
 
-static void stop_isoc_ctx(struct snd_motu *motu, struct amdtp_stream *stream)
-{
-	struct fw_iso_resources *resources;
-
-	if (stream == &motu->rx_stream)
-		resources = &motu->rx_resources;
-	else
-		resources = &motu->tx_resources;
-
-	amdtp_stream_stop(stream);
-	fw_iso_resources_free(resources);
-}
-
 int snd_motu_stream_cache_packet_formats(struct snd_motu *motu)
 {
 	int err;
@@ -292,11 +279,11 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
 void snd_motu_stream_stop_duplex(struct snd_motu *motu)
 {
 	if (motu->substreams_counter == 0) {
-		if (amdtp_stream_running(&motu->tx_stream))
-			stop_isoc_ctx(motu, &motu->tx_stream);
+		amdtp_stream_stop(&motu->tx_stream);
+		amdtp_stream_stop(&motu->rx_stream);
 
-		if (amdtp_stream_running(&motu->rx_stream))
-			stop_isoc_ctx(motu, &motu->rx_stream);
+		fw_iso_resources_free(&motu->tx_resources);
+		fw_iso_resources_free(&motu->rx_resources);
 	}
 }
 
-- 
2.20.1
