From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] ALSA: emux: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 08:34:40 -0700
Message-ID: <20171024153440.GA112878@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/synth/emux/emux.c       | 2 +-
 sound/synth/emux/emux_synth.c | 4 ++--
 sound/synth/emux/emux_voice.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index b9981e8c0027..b840ff2dcfbb 100644
--- a/sound/synth/emux/emux.c
+++ b/sound/synth/emux/emux.c
@@ -53,7 +53,7 @@ int snd_emux_new(struct snd_emux **remu)
 	emu->max_voices = 0;
 	emu->use_time = 0;
 
-	setup_timer(&emu->tlist, snd_emux_timer_callback, (unsigned long)emu);
+	timer_setup(&emu->tlist, snd_emux_timer_callback, 0);
 	emu->timer_active = 0;
 
 	*remu = emu;
diff --git a/sound/synth/emux/emux_synth.c b/sound/synth/emux/emux_synth.c
index 599551b5af44..9fa696b0dbde 100644
--- a/sound/synth/emux/emux_synth.c
+++ b/sound/synth/emux/emux_synth.c
@@ -202,9 +202,9 @@ snd_emux_note_off(void *p, int note, int vel, struct snd_midi_channel *chan)
  *
  * release the pending note-offs
  */
-void snd_emux_timer_callback(unsigned long data)
+void snd_emux_timer_callback(struct timer_list *t)
 {
-	struct snd_emux *emu = (struct snd_emux *) data;
+	struct snd_emux *emu = from_timer(emu, t, tlist);
 	struct snd_emux_voice *vp;
 	unsigned long flags;
 	int ch, do_again = 0;
diff --git a/sound/synth/emux/emux_voice.h b/sound/synth/emux/emux_voice.h
index a7073c371bcc..326fa8993d7b 100644
--- a/sound/synth/emux/emux_voice.h
+++ b/sound/synth/emux/emux_voice.h
@@ -55,7 +55,7 @@ void snd_emux_update_channel(struct snd_emux_port *port,
 			     struct snd_midi_channel *chan, int update);
 void snd_emux_update_port(struct snd_emux_port *port, int update);
 
-void snd_emux_timer_callback(unsigned long data);
+void snd_emux_timer_callback(struct timer_list *t);
 
 /* emux_effect.c */
 #ifdef SNDRV_EMUX_USE_RAW_EFFECT
-- 
2.7.4


-- 
Kees Cook
Pixel Security
