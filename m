From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/8] ALSA: dice: unify stop and release method
	for duplex streams
Date: Tue, 18 Jun 2019 22:26:19 +0900
Message-ID: <20190618132622.32659-6-o-takashi@sakamocchi.jp>
References: <20190618132622.32659-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79D6CF89724
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 15:26:36 +0200 (CEST)
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
 sound/firewire/dice/dice-midi.c   | 1 -
 sound/firewire/dice/dice-pcm.c    | 1 -
 sound/firewire/dice/dice-stream.c | 8 ++------
 sound/firewire/dice/dice.h        | 1 -
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/dice/dice-midi.c b/sound/firewire/dice/dice-midi.c
index 6172dad87c4e..436f0c3c0fbb 100644
--- a/sound/firewire/dice/dice-midi.c
+++ b/sound/firewire/dice/dice-midi.c
@@ -40,7 +40,6 @@ static int midi_close(struct snd_rawmidi_substream *substream)
 
 	--dice->substreams_counter;
 	snd_dice_stream_stop_duplex(dice);
-	snd_dice_stream_release_duplex(dice);
 
 	mutex_unlock(&dice->mutex);
 
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 00b55dfc3b2c..8368073f7fa0 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -265,7 +265,6 @@ static int pcm_hw_free(struct snd_pcm_substream *substream)
 		--dice->substreams_counter;
 
 	snd_dice_stream_stop_duplex(dice);
-	snd_dice_stream_release_duplex(dice);
 
 	mutex_unlock(&dice->mutex);
 
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index e9e5c5fffb70..433714a117a0 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -336,12 +336,6 @@ int snd_dice_stream_reserve_duplex(struct snd_dice *dice, unsigned int rate)
 	return err;
 }
 
-void snd_dice_stream_release_duplex(struct snd_dice *dice)
-{
-	if (dice->substreams_counter == 0)
-		release_resources(dice);
-}
-
 static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 			 unsigned int rate, struct reg_params *params)
 {
@@ -494,6 +488,8 @@ void snd_dice_stream_stop_duplex(struct snd_dice *dice)
 	if (dice->substreams_counter == 0) {
 		if (get_register_params(dice, &tx_params, &rx_params) >= 0)
 			finish_session(dice, &tx_params, &rx_params);
+
+		release_resources(dice);
 	}
 }
 
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index f95073b85010..fd3f483283d5 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -210,7 +210,6 @@ void snd_dice_stream_stop_duplex(struct snd_dice *dice);
 int snd_dice_stream_init_duplex(struct snd_dice *dice);
 void snd_dice_stream_destroy_duplex(struct snd_dice *dice);
 int snd_dice_stream_reserve_duplex(struct snd_dice *dice, unsigned int rate);
-void snd_dice_stream_release_duplex(struct snd_dice *dice);
 void snd_dice_stream_update_duplex(struct snd_dice *dice);
 int snd_dice_stream_detect_current_formats(struct snd_dice *dice);
 
-- 
2.20.1
