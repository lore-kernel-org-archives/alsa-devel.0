From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/8] ALSA: firewire-tascam: unify stop and
	release method for duplex streams
Date: Tue, 18 Jun 2019 22:26:15 +0900
Message-ID: <20190618132622.32659-2-o-takashi@sakamocchi.jp>
References: <20190618132622.32659-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E144F896DB
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 15:26:29 +0200 (CEST)
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
 sound/firewire/tascam/tascam-pcm.c    |  1 -
 sound/firewire/tascam/tascam-stream.c | 14 +++++---------
 sound/firewire/tascam/tascam.h        |  1 -
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/firewire/tascam/tascam-pcm.c b/sound/firewire/tascam/tascam-pcm.c
index 450711bef508..300683a82c68 100644
--- a/sound/firewire/tascam/tascam-pcm.c
+++ b/sound/firewire/tascam/tascam-pcm.c
@@ -118,7 +118,6 @@ static int pcm_hw_free(struct snd_pcm_substream *substream)
 		--tscm->substreams_counter;
 
 	snd_tscm_stream_stop_duplex(tscm);
-	snd_tscm_stream_release_duplex(tscm);
 
 	mutex_unlock(&tscm->mutex);
 
diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index f572dfc15114..0e515b7be276 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -380,14 +380,6 @@ int snd_tscm_stream_reserve_duplex(struct snd_tscm *tscm, unsigned int rate)
 	return 0;
 }
 
-void snd_tscm_stream_release_duplex(struct snd_tscm *tscm)
-{
-	if (tscm->substreams_counter == 0) {
-		fw_iso_resources_free(&tscm->tx_resources);
-		fw_iso_resources_free(&tscm->rx_resources);
-	}
-}
-
 int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 {
 	unsigned int generation = tscm->rx_resources.generation;
@@ -455,8 +447,12 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate)
 
 void snd_tscm_stream_stop_duplex(struct snd_tscm *tscm)
 {
-	if (tscm->substreams_counter == 0)
+	if (tscm->substreams_counter == 0) {
 		finish_session(tscm);
+
+		fw_iso_resources_free(&tscm->tx_resources);
+		fw_iso_resources_free(&tscm->rx_resources);
+	}
 }
 
 void snd_tscm_stream_lock_changed(struct snd_tscm *tscm)
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index 1cb75c374f11..4ed88cceaedb 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -148,7 +148,6 @@ int snd_tscm_stream_init_duplex(struct snd_tscm *tscm);
 void snd_tscm_stream_update_duplex(struct snd_tscm *tscm);
 void snd_tscm_stream_destroy_duplex(struct snd_tscm *tscm);
 int snd_tscm_stream_reserve_duplex(struct snd_tscm *tscm, unsigned int rate);
-void snd_tscm_stream_release_duplex(struct snd_tscm *tscm);
 int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate);
 void snd_tscm_stream_stop_duplex(struct snd_tscm *tscm);
 
-- 
2.20.1
