From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: emu10k1: Mark expected switch fall-throughs
Date: Sat, 4 Aug 2018 15:12:09 -0500
Message-ID: <20180804201209.GA26701@embeddedor.com>
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
 sound/pci/emu10k1/emupcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 26f6eda..9f2b609 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -778,7 +778,7 @@ static int snd_emu10k1_playback_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_START:
 		snd_emu10k1_playback_invalidate_cache(emu, 1, epcm->extra);	/* do we need this? */
 		snd_emu10k1_playback_invalidate_cache(emu, 0, epcm->voices[0]);
-		/* follow thru */
+		/* fall through */
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		if (cmd == SNDRV_PCM_TRIGGER_PAUSE_RELEASE)
@@ -928,7 +928,7 @@ static int snd_emu10k1_efx_playback_trigger(struct snd_pcm_substream *substream,
 		}
 		snd_emu10k1_playback_invalidate_cache(emu, 1, epcm->extra);
 
-		/* follow thru */
+		/* fall through */
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		snd_emu10k1_playback_prepare_voice(emu, epcm->extra, 1, 1, NULL);
-- 
2.7.4
