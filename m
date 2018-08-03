From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: seq: Mark expected switch fall-through
Date: Fri, 3 Aug 2018 15:52:33 -0500
Message-ID: <20180803205233.GA21910@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I replaced the code comment with
a proper "fall through" annotation, which is what GCC is expecting
to find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/core/seq/seq_midi_emul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_midi_emul.c b/sound/core/seq/seq_midi_emul.c
index f9f2133..c1975dd 100644
--- a/sound/core/seq/seq_midi_emul.c
+++ b/sound/core/seq/seq_midi_emul.c
@@ -318,7 +318,7 @@ do_control(struct snd_midi_op *ops, void *drv, struct snd_midi_channel_set *chse
 		break;
 	case MIDI_CTL_MSB_DATA_ENTRY:
 		chan->control[MIDI_CTL_LSB_DATA_ENTRY] = 0;
-		/* go through here */
+		/* fall through */
 	case MIDI_CTL_LSB_DATA_ENTRY:
 		if (chan->param_type == SNDRV_MIDI_PARAM_TYPE_REGISTERED)
 			rpn(ops, drv, chan, chset);
-- 
2.7.4
