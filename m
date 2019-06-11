From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/12] ALSA: firewire-digi00x: code refactoring
	to finish streaming session
Date: Tue, 11 Jun 2019 22:21:08 +0900
Message-ID: <20190611132118.8378-3-o-takashi@sakamocchi.jp>
References: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52E7FF8970F
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 15:21:27 +0200 (CEST)
In-Reply-To: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
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
of isochronous resources in pcm.hw_params/hw_free callbacks.

The operation to finish packet streaming corresponds to stopping
isochronous contexts. This commit applies code refactoring to
move codes to stop into a helper function to finish the session.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-stream.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 455c43e81850..90e31b63ac2f 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -125,8 +125,12 @@ int snd_dg00x_stream_get_external_rate(struct snd_dg00x *dg00x,
 
 static void finish_session(struct snd_dg00x *dg00x)
 {
-	__be32 data = cpu_to_be32(0x00000003);
+	__be32 data;
+
+	amdtp_stream_stop(&dg00x->tx_stream);
+	amdtp_stream_stop(&dg00x->rx_stream);
 
+	data = cpu_to_be32(0x00000003);
 	snd_fw_transaction(dg00x->unit, TCODE_WRITE_QUADLET_REQUEST,
 			   DG00X_ADDR_BASE + DG00X_OFFSET_STREAMING_SET,
 			   &data, sizeof(data), 0);
@@ -136,6 +140,10 @@ static void finish_session(struct snd_dg00x *dg00x)
 	snd_fw_transaction(dg00x->unit, TCODE_WRITE_QUADLET_REQUEST,
 			   DG00X_ADDR_BASE + DG00X_OFFSET_ISOC_CHANNELS,
 			   &data, sizeof(data), 0);
+
+	// Just after finishing the session, the device may lost transmitting
+	// functionality for a short time.
+	msleep(50);
 }
 
 static int begin_session(struct snd_dg00x *dg00x)
@@ -289,8 +297,6 @@ int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x, unsigned int rate)
 	    amdtp_streaming_error(&dg00x->rx_stream)) {
 		finish_session(dg00x);
 
-		amdtp_stream_stop(&dg00x->tx_stream);
-		amdtp_stream_stop(&dg00x->rx_stream);
 		release_resources(dg00x);
 	}
 
@@ -346,8 +352,6 @@ int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x, unsigned int rate)
 error:
 	finish_session(dg00x);
 
-	amdtp_stream_stop(&dg00x->tx_stream);
-	amdtp_stream_stop(&dg00x->rx_stream);
 	release_resources(dg00x);
 
 	return err;
@@ -358,16 +362,8 @@ void snd_dg00x_stream_stop_duplex(struct snd_dg00x *dg00x)
 	if (dg00x->substreams_counter > 0)
 		return;
 
-	amdtp_stream_stop(&dg00x->tx_stream);
-	amdtp_stream_stop(&dg00x->rx_stream);
 	finish_session(dg00x);
 	release_resources(dg00x);
-
-	/*
-	 * Just after finishing the session, the device may lost transmitting
-	 * functionality for a short time.
-	 */
-	msleep(50);
 }
 
 void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x)
-- 
2.20.1
