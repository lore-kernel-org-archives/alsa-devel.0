From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/18] ALSA: sb: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:21 +0100
Message-ID: <1421665891-14475-9-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E977260648
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:36 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E0859AD7B
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:35 +0000 (UTC)
In-Reply-To: <1421665891-14475-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

No functional change, refactoring with the standard helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/sb/emu8000_pcm.c | 10 +++-------
 sound/isa/sb/sb8_midi.c    | 12 +++++-------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/sound/isa/sb/emu8000_pcm.c b/sound/isa/sb/emu8000_pcm.c
index 2f85c66f8e38..250fd0006b53 100644
--- a/sound/isa/sb/emu8000_pcm.c
+++ b/sound/isa/sb/emu8000_pcm.c
@@ -207,8 +207,7 @@ static void emu8k_pcm_timer_func(unsigned long data)
 	rec->last_ptr = ptr;
 
 	/* reprogram timer */
-	rec->timer.expires = jiffies + 1;
-	add_timer(&rec->timer);
+	mod_timer(&rec->timer, jiffies + 1);
 
 	/* update period */
 	if (rec->period_pos >= (int)rec->period_size) {
@@ -240,9 +239,7 @@ static int emu8k_pcm_open(struct snd_pcm_substream *subs)
 	runtime->private_data = rec;
 
 	spin_lock_init(&rec->timer_lock);
-	init_timer(&rec->timer);
-	rec->timer.function = emu8k_pcm_timer_func;
-	rec->timer.data = (unsigned long)rec;
+	setup_timer(&rec->timer, emu8k_pcm_timer_func, (unsigned long)rec);
 
 	runtime->hw = emu8k_pcm_hw;
 	runtime->hw.buffer_bytes_max = emu->mem_size - LOOP_BLANK_SIZE * 3;
@@ -359,8 +356,7 @@ static void start_voice(struct snd_emu8k_pcm *rec, int ch)
 	/* start timer */
 	spin_lock_irqsave(&rec->timer_lock, flags);
 	if (! rec->timer_running) {
-		rec->timer.expires = jiffies + 1;
-		add_timer(&rec->timer);
+		mod_timer(&rec->timer, jiffies + 1);
 		rec->timer_running = 1;
 	}
 	spin_unlock_irqrestore(&rec->timer_lock, flags);
diff --git a/sound/isa/sb/sb8_midi.c b/sound/isa/sb/sb8_midi.c
index ffc71f0267df..925ea45b3d97 100644
--- a/sound/isa/sb/sb8_midi.c
+++ b/sound/isa/sb/sb8_midi.c
@@ -216,8 +216,7 @@ static void snd_sb8dsp_midi_output_timer(unsigned long data)
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->open_lock, flags);
-	chip->midi_timer.expires = 1 + jiffies;
-	add_timer(&chip->midi_timer);
+	mod_timer(&chip->midi_timer, 1 + jiffies);
 	spin_unlock_irqrestore(&chip->open_lock, flags);	
 	snd_sb8dsp_midi_output_write(substream);
 }
@@ -231,11 +230,10 @@ static void snd_sb8dsp_midi_output_trigger(struct snd_rawmidi_substream *substre
 	spin_lock_irqsave(&chip->open_lock, flags);
 	if (up) {
 		if (!(chip->open & SB_OPEN_MIDI_OUTPUT_TRIGGER)) {
-			init_timer(&chip->midi_timer);
-			chip->midi_timer.function = snd_sb8dsp_midi_output_timer;
-			chip->midi_timer.data = (unsigned long) substream;
-			chip->midi_timer.expires = 1 + jiffies;
-			add_timer(&chip->midi_timer);
+			setup_timer(&chip->midi_timer,
+				    snd_sb8dsp_midi_output_timer,
+				    (unsigned long) substream);
+			mod_timer(&chip->midi_timer, 1 + jiffies);
 			chip->open |= SB_OPEN_MIDI_OUTPUT_TRIGGER;
 		}
 	} else {
-- 
2.2.1
