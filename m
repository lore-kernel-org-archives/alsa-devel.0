From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: sb8: remove redundant pointer runtime
Date: Mon, 16 Jul 2018 09:52:56 +0100
Message-ID: <20180716085256.15878-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DB2D26767C
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 10:52:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Pointer runtime is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'runtime' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/sb/sb8_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index d45df5c54423..80e7dcaa551f 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -381,7 +381,6 @@ static int snd_sb8_capture_trigger(struct snd_pcm_substream *substream,
 irqreturn_t snd_sb8dsp_interrupt(struct snd_sb *chip)
 {
 	struct snd_pcm_substream *substream;
-	struct snd_pcm_runtime *runtime;
 
 	snd_sb_ack_8bit(chip);
 	switch (chip->mode) {
@@ -391,7 +390,6 @@ irqreturn_t snd_sb8dsp_interrupt(struct snd_sb *chip)
 		/* fallthru */
 	case SB_MODE_PLAYBACK_8:
 		substream = chip->playback_substream;
-		runtime = substream->runtime;
 		if (chip->playback_format == SB_DSP_OUTPUT)
 		    	snd_sb8_playback_trigger(substream, SNDRV_PCM_TRIGGER_START);
 		snd_pcm_period_elapsed(substream);
@@ -402,7 +400,6 @@ irqreturn_t snd_sb8dsp_interrupt(struct snd_sb *chip)
 		/* fallthru */
 	case SB_MODE_CAPTURE_8:
 		substream = chip->capture_substream;
-		runtime = substream->runtime;
 		if (chip->capture_format == SB_DSP_INPUT)
 		    	snd_sb8_capture_trigger(substream, SNDRV_PCM_TRIGGER_START);
 		snd_pcm_period_elapsed(substream);
-- 
2.17.1
