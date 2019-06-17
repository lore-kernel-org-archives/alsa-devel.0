From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/10] ALSA: firewire-motu: rename helper
	functions to begin/finish streaming session
Date: Mon, 17 Jun 2019 17:15:05 +0900
Message-ID: <20190617081510.11025-6-o-takashi@sakamocchi.jp>
References: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 316D2F896F9
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 10:15:25 +0200 (CEST)
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

Like the other drivers in ALSA firewire stack, this commit renames
functions to begin/finish packet streaming.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-stream.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index a3f45f2c817c..cb01f1d784f1 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -60,7 +60,7 @@ static int keep_resources(struct snd_motu *motu, unsigned int rate,
 				fw_parent_device(motu->unit)->max_speed);
 }
 
-static int start_both_streams(struct snd_motu *motu, unsigned int rate)
+static int begin_session(struct snd_motu *motu, unsigned int rate)
 {
 	__be32 reg;
 	u32 data;
@@ -91,7 +91,7 @@ static int start_both_streams(struct snd_motu *motu, unsigned int rate)
 					  sizeof(reg));
 }
 
-static void stop_both_streams(struct snd_motu *motu)
+static void finish_session(struct snd_motu *motu)
 {
 	__be32 reg;
 	u32 data;
@@ -235,7 +235,7 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
 	    amdtp_streaming_error(&motu->tx_stream)) {
 		amdtp_stream_stop(&motu->rx_stream);
 		amdtp_stream_stop(&motu->tx_stream);
-		stop_both_streams(motu);
+		finish_session(motu);
 	}
 
 	if (!amdtp_stream_running(&motu->rx_stream)) {
@@ -250,7 +250,7 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
 		if (err < 0)
 			return err;
 
-		err = start_both_streams(motu, rate);
+		err = begin_session(motu, rate);
 		if (err < 0) {
 			dev_err(&motu->unit->device,
 				"fail to start isochronous comm: %d\n", err);
@@ -285,7 +285,7 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
 	return 0;
 
 stop_streams:
-	stop_both_streams(motu);
+	finish_session(motu);
 	return err;
 }
 
-- 
2.20.1
