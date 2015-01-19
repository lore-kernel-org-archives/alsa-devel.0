From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 16/18] ALSA: emux: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:29 +0100
Message-ID: <1421665891-14475-17-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 42C272606E9
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:37 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F3D34AD8D
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
 sound/synth/emux/emux.c       | 4 +---
 sound/synth/emux/emux_synth.c | 6 ++----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index f27a1c85f81b..49195325fdf6 100644
--- a/sound/synth/emux/emux.c
+++ b/sound/synth/emux/emux.c
@@ -53,9 +53,7 @@ int snd_emux_new(struct snd_emux **remu)
 	emu->max_voices = 0;
 	emu->use_time = 0;
 
-	init_timer(&emu->tlist);
-	emu->tlist.function = snd_emux_timer_callback;
-	emu->tlist.data = (unsigned long)emu;
+	setup_timer(&emu->tlist, snd_emux_timer_callback, (unsigned long)emu);
 	emu->timer_active = 0;
 
 	*remu = emu;
diff --git a/sound/synth/emux/emux_synth.c b/sound/synth/emux/emux_synth.c
index 9a38de459acb..599551b5af44 100644
--- a/sound/synth/emux/emux_synth.c
+++ b/sound/synth/emux/emux_synth.c
@@ -186,8 +186,7 @@ snd_emux_note_off(void *p, int note, int vel, struct snd_midi_channel *chan)
 				 */
 				vp->state = SNDRV_EMUX_ST_PENDING;
 				if (! emu->timer_active) {
-					emu->tlist.expires = jiffies + 1;
-					add_timer(&emu->tlist);
+					mod_timer(&emu->tlist, jiffies + 1);
 					emu->timer_active = 1;
 				}
 			} else
@@ -223,8 +222,7 @@ void snd_emux_timer_callback(unsigned long data)
 		}
 	}
 	if (do_again) {
-		emu->tlist.expires = jiffies + 1;
-		add_timer(&emu->tlist);
+		mod_timer(&emu->tlist, jiffies + 1);
 		emu->timer_active = 1;
 	} else
 		emu->timer_active = 0;
-- 
2.2.1
