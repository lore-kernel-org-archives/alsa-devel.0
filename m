From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] ALSA: use designated initializers
Date: Fri, 16 Dec 2016 16:59:44 -0800
Message-ID: <20161217005944.GA140281@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Prepare to mark sensitive kernel structures for randomization by making
sure they're using designated initializers. These were identified during
allyesconfig builds of x86, arm, and arm64, with most initializer fixes
extracted from grsecurity.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/synth/emux/emux_seq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/synth/emux/emux_seq.c b/sound/synth/emux/emux_seq.c
index a0209204ae48..55579f6b8cb2 100644
--- a/sound/synth/emux/emux_seq.c
+++ b/sound/synth/emux/emux_seq.c
@@ -33,13 +33,13 @@ static int snd_emux_unuse(void *private_data, struct snd_seq_port_subscribe *inf
  * MIDI emulation operators
  */
 static struct snd_midi_op emux_ops = {
-	snd_emux_note_on,
-	snd_emux_note_off,
-	snd_emux_key_press,
-	snd_emux_terminate_note,
-	snd_emux_control,
-	snd_emux_nrpn,
-	snd_emux_sysex,
+	.note_on = snd_emux_note_on,
+	.note_off = snd_emux_note_off,
+	.key_press = snd_emux_key_press,
+	.note_terminate = snd_emux_terminate_note,
+	.control = snd_emux_control,
+	.nrpn = snd_emux_nrpn,
+	.sysex = snd_emux_sysex,
 };
 
 
-- 
2.7.4


-- 
Kees Cook
Nexus Security
