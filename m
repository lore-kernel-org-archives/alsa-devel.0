From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: mips: Use
	SNDRV_PCM_INFO_SYNC_APPLPTR info flag
Date: Tue,  4 Sep 2018 08:18:48 +0200
Message-ID: <20180904061851.1934-3-tiwai@suse.de>
References: <20180904061851.1934-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E4042678D9
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 08:18:56 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id EFCF6AFD8
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 06:18:55 +0000 (UTC)
In-Reply-To: <20180904061851.1934-1-tiwai@suse.de>
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

The recently introduced PCM info flag assures the call of ack ops at
each applptr change, and this is mandatory for the indirect PCM
helpers.

Also, with the proper ack callback, we need no longer prefill at
trigger start.  The relevant code can be killed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/mips/hal2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index c8904e732aaa..2bd1cb7489ff 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -500,7 +500,8 @@ static const struct snd_pcm_hardware hal2_pcm_hw = {
 	.info = (SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_INTERLEAVED |
-		 SNDRV_PCM_INFO_BLOCK_TRANSFER),
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_SYNC_APPLPTR),
 	.formats =          SNDRV_PCM_FMTBIT_S16_BE,
 	.rates =            SNDRV_PCM_RATE_8000_48000,
 	.rate_min =         8000,
@@ -577,7 +578,6 @@ static int hal2_playback_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 		hal2->dac.pcm_indirect.hw_io = hal2->dac.buffer_dma;
 		hal2->dac.pcm_indirect.hw_data = 0;
-		substream->ops->ack(substream);
 		hal2_start_dac(hal2);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
2.18.0
