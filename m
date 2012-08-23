From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ASoC: samsung dma - prepare dma in
	start/resume trigger path
Date: Thu, 23 Aug 2012 13:51:09 -0700
Message-ID: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f201.google.com (mail-we0-f201.google.com
 [74.125.82.201])
 by alsa0.perex.cz (Postfix) with ESMTP id AC2B0265CBA
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 22:51:15 +0200 (CEST)
Received: by weyx56 with SMTP id x56so54279wey.2
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 13:51:15 -0700 (PDT)
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
Cc: kgene.kim@samsung.com, ben-linux@fluff.org, jassi.brar@samsung.com, padma.v@samsung.com, broonie@opensource.wolfsonmicro.com, alim.akhtar@samsung.com, olofj@chromium.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

On suspend all dma transactions are terminated (by the stop/suspend
trigger calling ops->stop), they need to be set up again during resume.
Move the prepare op to the start/resume/unpause trigger path so that dma
and audio will restart on resume/unpause.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/soc/samsung/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index f3ebc38..5772762 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -250,6 +250,7 @@ static int dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		dma_prepare(substream);
 		prtd->state |= ST_RUNNING;
 		prtd->params->ops->trigger(prtd->params->ch);
 		break;
@@ -352,7 +353,6 @@ static struct snd_pcm_ops dma_ops = {
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= dma_hw_params,
 	.hw_free	= dma_hw_free,
-	.prepare	= dma_prepare,
 	.trigger	= dma_trigger,
 	.pointer	= dma_pointer,
 	.mmap		= dma_mmap,
-- 
1.7.7.3
