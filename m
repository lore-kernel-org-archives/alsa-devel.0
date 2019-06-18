From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/8] ALSA: firewire-digi00x: unify stop and
	release method for duplex streams
Date: Tue, 18 Jun 2019 22:26:18 +0900
Message-ID: <20190618132622.32659-5-o-takashi@sakamocchi.jp>
References: <20190618132622.32659-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12F6CF80CC4
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 15:26:35 +0200 (CEST)
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
 sound/firewire/digi00x/digi00x-midi.c   |  1 -
 sound/firewire/digi00x/digi00x-pcm.c    |  1 -
 sound/firewire/digi00x/digi00x-stream.c | 14 +++++---------
 sound/firewire/digi00x/digi00x.h        |  1 -
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
index cca888cce0d3..ca06ad318ed6 100644
--- a/sound/firewire/digi00x/digi00x-midi.c
+++ b/sound/firewire/digi00x/digi00x-midi.c
@@ -37,7 +37,6 @@ static int midi_close(struct snd_rawmidi_substream *substream)
 	mutex_lock(&dg00x->mutex);
 	--dg00x->substreams_counter;
 	snd_dg00x_stream_stop_duplex(dg00x);
-	snd_dg00x_stream_release_duplex(dg00x);
 	mutex_unlock(&dg00x->mutex);
 
 	snd_dg00x_stream_lock_release(dg00x);
diff --git a/sound/firewire/digi00x/digi00x-pcm.c b/sound/firewire/digi00x/digi00x-pcm.c
index 9ed2ebdcf23a..c38fbd6ded9f 100644
--- a/sound/firewire/digi00x/digi00x-pcm.c
+++ b/sound/firewire/digi00x/digi00x-pcm.c
@@ -189,7 +189,6 @@ static int pcm_hw_free(struct snd_pcm_substream *substream)
 		--dg00x->substreams_counter;
 
 	snd_dg00x_stream_stop_duplex(dg00x);
-	snd_dg00x_stream_release_duplex(dg00x);
 
 	mutex_unlock(&dg00x->mutex);
 
diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 3c5e1c5a2e11..7c8e7ad48d03 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -293,14 +293,6 @@ int snd_dg00x_stream_reserve_duplex(struct snd_dg00x *dg00x, unsigned int rate)
 	return 0;
 }
 
-void snd_dg00x_stream_release_duplex(struct snd_dg00x *dg00x)
-{
-	if (dg00x->substreams_counter == 0) {
-		fw_iso_resources_free(&dg00x->tx_resources);
-		fw_iso_resources_free(&dg00x->rx_resources);
-	}
-}
-
 int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x)
 {
 	unsigned int generation = dg00x->rx_resources.generation;
@@ -372,8 +364,12 @@ int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x)
 
 void snd_dg00x_stream_stop_duplex(struct snd_dg00x *dg00x)
 {
-	if (dg00x->substreams_counter == 0)
+	if (dg00x->substreams_counter == 0) {
 		finish_session(dg00x);
+
+		fw_iso_resources_free(&dg00x->tx_resources);
+		fw_iso_resources_free(&dg00x->rx_resources);
+	}
 }
 
 void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x)
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 3fb1c49f6f9e..2d026b5b0079 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -143,7 +143,6 @@ int snd_dg00x_stream_init_duplex(struct snd_dg00x *dg00x);
 int snd_dg00x_stream_reserve_duplex(struct snd_dg00x *dg00x, unsigned int rate);
 int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_stop_duplex(struct snd_dg00x *dg00x);
-void snd_dg00x_stream_release_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x);
 
-- 
2.20.1
