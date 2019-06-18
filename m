From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/8] ALSA: firewire-motu: unify stop and
	release method for duplex streams
Date: Tue, 18 Jun 2019 22:26:17 +0900
Message-ID: <20190618132622.32659-4-o-takashi@sakamocchi.jp>
References: <20190618132622.32659-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 690C4F8075C
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 15:26:33 +0200 (CEST)
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
 sound/firewire/motu/motu-midi.c   |  1 -
 sound/firewire/motu/motu-pcm.c    |  1 -
 sound/firewire/motu/motu-stream.c | 14 +++++---------
 sound/firewire/motu/motu.h        |  1 -
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/motu/motu-midi.c b/sound/firewire/motu/motu-midi.c
index a463730c72bc..4520c0060b83 100644
--- a/sound/firewire/motu/motu-midi.c
+++ b/sound/firewire/motu/motu-midi.c
@@ -40,7 +40,6 @@ static int midi_close(struct snd_rawmidi_substream *substream)
 
 	--motu->substreams_counter;
 	snd_motu_stream_stop_duplex(motu);
-	snd_motu_stream_release_duplex(motu);
 
 	mutex_unlock(&motu->mutex);
 
diff --git a/sound/firewire/motu/motu-pcm.c b/sound/firewire/motu/motu-pcm.c
index b9852c911b98..60c691d18952 100644
--- a/sound/firewire/motu/motu-pcm.c
+++ b/sound/firewire/motu/motu-pcm.c
@@ -224,7 +224,6 @@ static int pcm_hw_free(struct snd_pcm_substream *substream)
 		--motu->substreams_counter;
 
 	snd_motu_stream_stop_duplex(motu);
-	snd_motu_stream_release_duplex(motu);
 
 	mutex_unlock(&motu->mutex);
 
diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index 82891583b736..8aab5db71c0f 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -200,14 +200,6 @@ int snd_motu_stream_reserve_duplex(struct snd_motu *motu, unsigned int rate)
 	return 0;
 }
 
-void snd_motu_stream_release_duplex(struct snd_motu *motu)
-{
-	if (motu->substreams_counter == 0) {
-		fw_iso_resources_free(&motu->tx_resources);
-		fw_iso_resources_free(&motu->rx_resources);
-	}
-}
-
 static int ensure_packet_formats(struct snd_motu *motu)
 {
 	__be32 reg;
@@ -301,8 +293,12 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu)
 
 void snd_motu_stream_stop_duplex(struct snd_motu *motu)
 {
-	if (motu->substreams_counter == 0)
+	if (motu->substreams_counter == 0) {
 		finish_session(motu);
+
+		fw_iso_resources_free(&motu->tx_resources);
+		fw_iso_resources_free(&motu->rx_resources);
+	}
 }
 
 static int init_stream(struct snd_motu *motu, enum amdtp_stream_direction dir)
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 32cd42873fd0..a4ac320f2c9e 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -154,7 +154,6 @@ int snd_motu_stream_init_duplex(struct snd_motu *motu);
 void snd_motu_stream_destroy_duplex(struct snd_motu *motu);
 int snd_motu_stream_cache_packet_formats(struct snd_motu *motu);
 int snd_motu_stream_reserve_duplex(struct snd_motu *motu, unsigned int rate);
-void snd_motu_stream_release_duplex(struct snd_motu *motu);
 int snd_motu_stream_start_duplex(struct snd_motu *motu);
 void snd_motu_stream_stop_duplex(struct snd_motu *motu);
 int snd_motu_stream_lock_try(struct snd_motu *motu);
-- 
2.20.1
