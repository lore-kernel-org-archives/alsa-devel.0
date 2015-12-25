From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] ALSA: dice: ensure to release sound
	devices after sound card registration fails
Date: Fri, 25 Dec 2015 10:13:13 +0900
Message-ID: <1451005995-12098-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1451005995-12098-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B6442666F5
 for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2015 02:13:20 +0100 (CET)
In-Reply-To: <1451005995-12098-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

When work of sound card registration fails, bus reset on IEEE 1394
can schedule the work again. In this case, currently instances of PCM and
RawMIDI devices are not released, but allocated and errors occurs.

This commit solves this issue. The allocated data is kept and released
at any failures in the work.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-midi.c |  2 ++
 sound/firewire/dice/dice-pcm.c  |  2 ++
 sound/firewire/dice/dice.c      | 21 ++++++++++++++++-----
 sound/firewire/dice/dice.h      |  2 ++
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/dice/dice-midi.c b/sound/firewire/dice/dice-midi.c
index 151b09f..908b43f 100644
--- a/sound/firewire/dice/dice-midi.c
+++ b/sound/firewire/dice/dice-midi.c
@@ -153,5 +153,7 @@ int snd_dice_create_midi(struct snd_dice *dice)
 	if ((midi_out_ports > 0) && (midi_in_ports > 0))
 		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
 
+	dice->rmidi_dev = rmidi;
+
 	return 0;
 }
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 9b34319..6246ce3 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -426,5 +426,7 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 	if (playback > 0)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &playback_ops);
 
+	dice->pcm_dev = pcm;
+
 	return 0;
 }
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 64ea843..725bb7c 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -202,27 +202,30 @@ static void do_registration(struct work_struct *work)
 	if (dice->card->shutdown || dice->registered)
 		return;
 
+	dice->pcm_dev = NULL;
+	dice->rmidi_dev = NULL;
+
 	err = snd_dice_transaction_init(dice);
 	if (err < 0)
-		goto end;
+		goto error;
 
 	err = dice_read_params(dice);
 	if (err < 0)
-		goto end;
+		goto error;
 
 	dice_card_strings(dice);
 
 	err = snd_dice_create_pcm(dice);
 	if (err < 0)
-		goto end;
+		goto error;
 
 	err = snd_dice_create_midi(dice);
 	if (err < 0)
-		goto end;
+		goto error;
 
 	err = snd_card_register(dice->card);
 	if (err < 0)
-		goto end;
+		goto error;
 
 	dice->registered = true;
 
@@ -234,6 +237,14 @@ static void do_registration(struct work_struct *work)
 	 * card is released as the same way that usual sound cards are going to
 	 * be released.
 	 */
+error:
+	snd_dice_transaction_destroy(dice);
+
+	if (dice->pcm_dev)
+		snd_device_free(dice->card, dice->pcm_dev);
+
+	if (dice->rmidi_dev)
+		snd_device_free(dice->card, dice->rmidi_dev);
 }
 
 static u64 calc_delay(struct snd_dice *dice)
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 3d5ebeb..d632ac1 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -47,6 +47,8 @@ struct snd_dice {
 
 	bool registered;
 	struct delayed_work dwork;
+	struct snd_pcm *pcm_dev;
+	struct snd_rawmidi *rmidi_dev;
 
 	/* Offsets for sub-addresses */
 	unsigned int global_offset;
-- 
2.5.0
