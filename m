From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] ALSA: sb: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 08:34:58 -0700
Message-ID: <20171024153458.GA112893@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/sound/sb.h         |  1 +
 sound/isa/sb/emu8000_pcm.c |  6 +++---
 sound/isa/sb/sb8_midi.c    | 12 ++++++------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/sound/sb.h b/include/sound/sb.h
index bacefaee411a..4aef395189ec 100644
--- a/include/sound/sb.h
+++ b/include/sound/sb.h
@@ -83,6 +83,7 @@ struct snd_sb {
 	unsigned int playback_format;
 	unsigned int capture_format;
 	struct timer_list midi_timer;
+	struct snd_rawmidi_substream *timer_substream;
 	unsigned int p_dma_size;
 	unsigned int p_period_size;
 	unsigned int c_dma_size;
diff --git a/sound/isa/sb/emu8000_pcm.c b/sound/isa/sb/emu8000_pcm.c
index 8f34551abd8d..bc5af71d3bdb 100644
--- a/sound/isa/sb/emu8000_pcm.c
+++ b/sound/isa/sb/emu8000_pcm.c
@@ -193,9 +193,9 @@ static inline int emu8k_get_curpos(struct snd_emu8k_pcm *rec, int ch)
  * timer interrupt handler
  * check the current position and update the period if necessary.
  */
-static void emu8k_pcm_timer_func(unsigned long data)
+static void emu8k_pcm_timer_func(struct timer_list *t)
 {
-	struct snd_emu8k_pcm *rec = (struct snd_emu8k_pcm *)data;
+	struct snd_emu8k_pcm *rec = from_timer(rec, t, timer);
 	int ptr, delta;
 
 	spin_lock(&rec->timer_lock);
@@ -241,7 +241,7 @@ static int emu8k_pcm_open(struct snd_pcm_substream *subs)
 	runtime->private_data = rec;
 
 	spin_lock_init(&rec->timer_lock);
-	setup_timer(&rec->timer, emu8k_pcm_timer_func, (unsigned long)rec);
+	timer_setup(&rec->timer, emu8k_pcm_timer_func, 0);
 
 	runtime->hw = emu8k_pcm_hw;
 	runtime->hw.buffer_bytes_max = emu->mem_size - LOOP_BLANK_SIZE * 3;
diff --git a/sound/isa/sb/sb8_midi.c b/sound/isa/sb/sb8_midi.c
index bd672abb4854..cf23dc5d0507 100644
--- a/sound/isa/sb/sb8_midi.c
+++ b/sound/isa/sb/sb8_midi.c
@@ -209,10 +209,10 @@ static void snd_sb8dsp_midi_output_write(struct snd_rawmidi_substream *substream
 	}
 }
 
-static void snd_sb8dsp_midi_output_timer(unsigned long data)
+static void snd_sb8dsp_midi_output_timer(struct timer_list *t)
 {
-	struct snd_rawmidi_substream *substream = (struct snd_rawmidi_substream *) data;
-	struct snd_sb * chip = substream->rmidi->private_data;
+	struct snd_sb *chip = from_timer(chip, t, midi_timer);
+	struct snd_rawmidi_substream *substream = chip->timer_substream;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->open_lock, flags);
@@ -230,9 +230,9 @@ static void snd_sb8dsp_midi_output_trigger(struct snd_rawmidi_substream *substre
 	spin_lock_irqsave(&chip->open_lock, flags);
 	if (up) {
 		if (!(chip->open & SB_OPEN_MIDI_OUTPUT_TRIGGER)) {
-			setup_timer(&chip->midi_timer,
-				    snd_sb8dsp_midi_output_timer,
-				    (unsigned long) substream);
+			chip->timer_substream = substream;
+			timer_setup(&chip->midi_timer,
+				    snd_sb8dsp_midi_output_timer, 0);
 			mod_timer(&chip->midi_timer, 1 + jiffies);
 			chip->open |= SB_OPEN_MIDI_OUTPUT_TRIGGER;
 		}
-- 
2.7.4


-- 
Kees Cook
Pixel Security
