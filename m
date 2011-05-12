From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-pcm: Period wakeup disabling on
	OMAP2+
Date: Thu, 12 May 2011 13:04:55 +0300
Message-ID: <1305194695-4425-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 962D110381E
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 12:05:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Allow disabling ALSA period wakeup interrupts.
This can only be done on OMAP2+ (2/3/4), since there
we can chain the DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hello,

with this patch we can dramatically decrease the number of wake ups for user
space during audio playback on OMAP2/3/4 platforms.
Currently PulseAudio is the only one supporting this mode (using timer instead
of pcm wakeup).
If for example PA is configured to use ~2sec audio buffer, we do not need to
handle the DMA interrupts - they are coming in ~10ms (McBSP2), or ~1ms
intervals.
Internally we still going to have triggers (from McBSP to the sDMA), but we are
not going to bother to let SW stack know about this.

Output from pulseaudio,
without this patch:
I: alsa-util.c: cannot disable ALSA period wakeups
I: alsa-util.c: ALSA period wakeups were not disabled

with this patch in the kernel:
I: alsa-util.c: Trying to disable ALSA period wakeups, using timers only
I: alsa-util.c: ALSA period wakeups disabled

And in fact the amount of interrupts decreased with the patch.

Peter

 sound/soc/omap/omap-pcm.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 551b7f5..3a1e395 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -37,7 +37,8 @@ static const struct snd_pcm_hardware omap_pcm_hardware = {
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_INTERLEAVED |
 				  SNDRV_PCM_INFO_PAUSE |
-				  SNDRV_PCM_INFO_RESUME,
+				  SNDRV_PCM_INFO_RESUME |
+				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
 	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
 				  SNDRV_PCM_FMTBIT_S32_LE,
 	.period_bytes_min	= 32,
@@ -195,7 +196,7 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 	if ((cpu_is_omap1510()))
 		omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ |
 			      OMAP_DMA_LAST_IRQ | OMAP_DMA_BLOCK_IRQ);
-	else
+	else if (!substream->runtime->no_period_wakeup)
 		omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ);
 
 	if (!(cpu_class_is_omap1())) {
-- 
1.7.5.rc3
