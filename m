From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] ALSA: wavefront: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 08:35:09 -0700
Message-ID: <20171024153509.GA112907@beast>
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
 include/sound/snd_wavefront.h        |  1 +
 sound/isa/wavefront/wavefront_midi.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/sound/snd_wavefront.h b/include/sound/snd_wavefront.h
index cd0bab1ef6f1..fcd770fdcda5 100644
--- a/include/sound/snd_wavefront.h
+++ b/include/sound/snd_wavefront.h
@@ -28,6 +28,7 @@ struct _snd_wavefront_midi {
 	struct snd_rawmidi_substream	 *substream_output[2];
 	struct snd_rawmidi_substream	 *substream_input[2];
 	struct timer_list	 timer;
+	snd_wavefront_card_t	 *timer_card;
         spinlock_t               open;
         spinlock_t               virtual;     /* protects isvirtual */
 };
diff --git a/sound/isa/wavefront/wavefront_midi.c b/sound/isa/wavefront/wavefront_midi.c
index 2aa05f3aaa38..556b14738970 100644
--- a/sound/isa/wavefront/wavefront_midi.c
+++ b/sound/isa/wavefront/wavefront_midi.c
@@ -349,10 +349,10 @@ static void snd_wavefront_midi_input_trigger(struct snd_rawmidi_substream *subst
 	spin_unlock_irqrestore (&midi->virtual, flags);
 }
 
-static void snd_wavefront_midi_output_timer(unsigned long data)
+static void snd_wavefront_midi_output_timer(struct timer_list *t)
 {
-	snd_wavefront_card_t *card = (snd_wavefront_card_t *)data;
-	snd_wavefront_midi_t *midi = &card->wavefront.midi;
+	snd_wavefront_midi_t *midi = from_timer(midi, t, timer);
+	snd_wavefront_card_t *card = midi->timer_card;
 	unsigned long flags;
 	
 	spin_lock_irqsave (&midi->virtual, flags);
@@ -383,9 +383,9 @@ static void snd_wavefront_midi_output_trigger(struct snd_rawmidi_substream *subs
 	if (up) {
 		if ((midi->mode[mpu] & MPU401_MODE_OUTPUT_TRIGGER) == 0) {
 			if (!midi->istimer) {
-				setup_timer(&midi->timer,
+				timer_setup(&midi->timer,
 					    snd_wavefront_midi_output_timer,
-					    (unsigned long) substream->rmidi->card->private_data);
+					    0);
 				mod_timer(&midi->timer, 1 + jiffies);
 			}
 			midi->istimer++;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
