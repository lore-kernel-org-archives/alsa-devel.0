From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ASoC: samsung dma - Don't indicate support for
	pause/resume.
Date: Thu, 30 Aug 2012 21:37:34 -0700
Message-ID: <1346387854-22222-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f201.google.com (mail-lb0-f201.google.com
 [209.85.217.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DE7D26640C
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 06:39:05 +0200 (CEST)
Received: by lboj14 with SMTP id j14so70477lbo.2
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 21:39:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: kgene.kim@samsung.com, ben-linux@fluff.org, padma.v@samsung.com, broonie@opensource.wolfsonmicro.com, clemens@ladisch.de, alim.akhtar@samsung.com, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

The pause and resume operations indicate that the stream can be
un-paused/resumed from the exact location they were paused/suspended.
This is not true for this driver, the pause and suspend triggers share
the same code path with stop, they flush all pending DMA transfers.
This drops all pending samples.  The pause_release/resume triggers are
the same as start, except that prepare won't be called beforehand,
nothing will be enqueued to the DMA engine and nothing will happen (no
audio).  Removing the pause flag will let apps know that it isn't
supported.  Removing the resume flag will cause user space to call
prepare and start instead of resume, so audio will continue playing when
the system wakes up.

Before removing the pause and resume flags, I tested this on an exynos
5250, using 'aplay -i'. Pause/un-pause leads to silence followed by a
write error.  Suspend/resume testing led to the same result.  Removing
the two flags fixes suspend/resume (since snd_pcm_prepare is called
again). And leads to a proper reporting of pause not supported.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/soc/samsung/dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index f3ebc38..56a507a 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -34,9 +34,7 @@ static const struct snd_pcm_hardware dma_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
 				    SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				    SNDRV_PCM_INFO_MMAP |
-				    SNDRV_PCM_INFO_MMAP_VALID |
-				    SNDRV_PCM_INFO_PAUSE |
-				    SNDRV_PCM_INFO_RESUME,
+				    SNDRV_PCM_INFO_MMAP_VALID,
 	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
 				    SNDRV_PCM_FMTBIT_U16_LE |
 				    SNDRV_PCM_FMTBIT_U8 |
-- 
1.7.12.146.g16d26b1
