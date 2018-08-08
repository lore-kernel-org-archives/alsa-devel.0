From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: opl3: Mark expected switch fall-through
Date: Wed, 8 Aug 2018 14:25:16 -0500
Message-ID: <20180808192516.GA27987@embeddedor.com>
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

Addresses-Coverity-ID: 114878 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/drivers/opl3/opl3_midi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/drivers/opl3/opl3_midi.c b/sound/drivers/opl3/opl3_midi.c
index 471916ca..a33cb74 100644
--- a/sound/drivers/opl3/opl3_midi.c
+++ b/sound/drivers/opl3/opl3_midi.c
@@ -368,6 +368,7 @@ void snd_opl3_note_on(void *p, int note, int vel, struct snd_midi_channel *chan)
 			instr_4op = 1;
 			break;
 		}
+		/* fall through */
 	default:
 		spin_unlock_irqrestore(&opl3->voice_lock, flags);
 		return;
-- 
2.7.4
