From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/8] ALSA: fireface: unify stop and release
	method for duplex streams
Date: Tue, 18 Jun 2019 22:26:16 +0900
Message-ID: <20190618132622.32659-3-o-takashi@sakamocchi.jp>
References: <20190618132622.32659-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04BADF896F4
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 15:26:31 +0200 (CEST)
In-Reply-To: <20190618132622.32659-1-o-takashi@sakamocchi.jp>
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

>From callbacks for pcm and rawmidi interfaces, the functions to stop
and release duplex streams are called at the same time. This commit
merges the two functions.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-pcm.c    |  1 -
 sound/firewire/fireface/ff-stream.c | 14 +++++---------
 sound/firewire/fireface/ff.h        |  1 -
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
index 938985c2d4a8..75228e769687 100644
--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -233,7 +233,6 @@ static int pcm_hw_free(struct snd_pcm_substream *substream)
 		--ff->substreams_counter;
 
 	snd_ff_stream_stop_duplex(ff);
-	snd_ff_stream_release_duplex(ff);
 
 	mutex_unlock(&ff->mutex);
 
diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
index 884705ecf940..049920a6d43e 100644
--- a/sound/firewire/fireface/ff-stream.c
+++ b/sound/firewire/fireface/ff-stream.c
@@ -149,14 +149,6 @@ int snd_ff_stream_reserve_duplex(struct snd_ff *ff, unsigned int rate)
 	return 0;
 }
 
-void snd_ff_stream_release_duplex(struct snd_ff *ff)
-{
-	if (ff->substreams_counter == 0) {
-		fw_iso_resources_free(&ff->tx_resources);
-		fw_iso_resources_free(&ff->rx_resources);
-	}
-}
-
 int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 {
 	int err;
@@ -217,8 +209,12 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 
 void snd_ff_stream_stop_duplex(struct snd_ff *ff)
 {
-	if (ff->substreams_counter == 0)
+	if (ff->substreams_counter == 0) {
 		finish_session(ff);
+
+		fw_iso_resources_free(&ff->tx_resources);
+		fw_iso_resources_free(&ff->rx_resources);
+	}
 }
 
 void snd_ff_stream_update_duplex(struct snd_ff *ff)
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index fe5739ee1c88..9b52c368f6de 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -139,7 +139,6 @@ int snd_ff_stream_get_multiplier_mode(enum cip_sfc sfc,
 int snd_ff_stream_init_duplex(struct snd_ff *ff);
 void snd_ff_stream_destroy_duplex(struct snd_ff *ff);
 int snd_ff_stream_reserve_duplex(struct snd_ff *ff, unsigned int rate);
-void snd_ff_stream_release_duplex(struct snd_ff *ff);
 int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate);
 void snd_ff_stream_stop_duplex(struct snd_ff *ff);
 void snd_ff_stream_update_duplex(struct snd_ff *ff);
-- 
2.20.1
