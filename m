From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/15] ALSA: fireface: minor code refactoring
	to finish streaming session
Date: Sun,  2 Jun 2019 16:12:58 +0900
Message-ID: <20190602071259.21622-15-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28D47F8974F
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:27 +0200 (CEST)
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
 sound/firewire/fireface/ff-stream.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
index 4f40dfb11979..884705ecf940 100644
--- a/sound/firewire/fireface/ff-stream.c
+++ b/sound/firewire/fireface/ff-stream.c
@@ -33,6 +33,9 @@ int snd_ff_stream_get_multiplier_mode(enum cip_sfc sfc,
 
 static inline void finish_session(struct snd_ff *ff)
 {
+	amdtp_stream_stop(&ff->tx_stream);
+	amdtp_stream_stop(&ff->rx_stream);
+
 	ff->spec->protocol->finish_session(ff);
 	ff->spec->protocol->switch_fetching_mode(ff, false);
 }
@@ -112,9 +115,6 @@ int snd_ff_stream_reserve_duplex(struct snd_ff *ff, unsigned int rate)
 		enum snd_ff_stream_mode mode;
 		int i;
 
-		amdtp_stream_stop(&ff->tx_stream);
-		amdtp_stream_stop(&ff->rx_stream);
-
 		finish_session(ff);
 
 		fw_iso_resources_free(&ff->tx_resources);
@@ -165,12 +165,8 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 		return 0;
 
 	if (amdtp_streaming_error(&ff->tx_stream) ||
-	    amdtp_streaming_error(&ff->rx_stream)) {
-		amdtp_stream_stop(&ff->tx_stream);
-		amdtp_stream_stop(&ff->rx_stream);
-
+	    amdtp_streaming_error(&ff->rx_stream))
 		finish_session(ff);
-	}
 
 	/*
 	 * Regardless of current source of clock signal, drivers transfer some
@@ -214,9 +210,6 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 
 	return 0;
 error:
-	amdtp_stream_stop(&ff->tx_stream);
-	amdtp_stream_stop(&ff->rx_stream);
-
 	finish_session(ff);
 
 	return err;
@@ -224,12 +217,8 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 
 void snd_ff_stream_stop_duplex(struct snd_ff *ff)
 {
-	if (ff->substreams_counter > 0)
-		return;
-
-	amdtp_stream_stop(&ff->tx_stream);
-	amdtp_stream_stop(&ff->rx_stream);
-	finish_session(ff);
+	if (ff->substreams_counter == 0)
+		finish_session(ff);
 }
 
 void snd_ff_stream_update_duplex(struct snd_ff *ff)
-- 
2.20.1
