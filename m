From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/14] ALSA: atiixp: Move PCM suspend/resume
	code into trigger callback
Date: Tue, 15 Jan 2019 17:21:43 +0100
Message-ID: <20190115162155.6308-3-tiwai@suse.de>
References: <20190115162155.6308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 29672266ABE
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:21:56 +0100 (CET)
In-Reply-To: <20190115162155.6308-1-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

ATIIXP driver supports the full PCM resume and saves/restores the
running PCM pointer.  This used to be done in the suspend and resume
callbacks together with snd_pcm_suspend() call.  But since we moved
the snd_pcm_supsend*() call in PCM device PM ops, this should be moved
to a more appropriate place, i.e. the trigger callback.

Along with the movement of the PCM suspend/resume code, remove the
superfluous snd_pcm_suspend_all() call, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/atiixp.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 1a41f8c80243..7715d26916ac 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -733,6 +733,10 @@ static int snd_atiixp_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
+		if (dma->running && dma->suspended &&
+		    cmd == SNDRV_PCM_TRIGGER_RESUME)
+			writel(dma->saved_curptr, chip->remap_addr +
+			       dma->ops->dt_cur);
 		dma->ops->enable_transfer(chip, 1);
 		dma->running = 1;
 		dma->suspended = 0;
@@ -740,9 +744,12 @@ static int snd_atiixp_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
+		dma->suspended = cmd == SNDRV_PCM_TRIGGER_SUSPEND;
+		if (dma->running && dma->suspended)
+			dma->saved_curptr = readl(chip->remap_addr +
+						  dma->ops->dt_cur);
 		dma->ops->enable_transfer(chip, 0);
 		dma->running = 0;
-		dma->suspended = cmd == SNDRV_PCM_TRIGGER_SUSPEND;
 		break;
 	default:
 		err = -EINVAL;
@@ -1479,14 +1486,6 @@ static int snd_atiixp_suspend(struct device *dev)
 	int i;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	for (i = 0; i < NUM_ATI_PCMDEVS; i++)
-		if (chip->pcmdevs[i]) {
-			struct atiixp_dma *dma = &chip->dmas[i];
-			if (dma->substream && dma->running)
-				dma->saved_curptr = readl(chip->remap_addr +
-							  dma->ops->dt_cur);
-			snd_pcm_suspend_all(chip->pcmdevs[i]);
-		}
 	for (i = 0; i < NUM_ATI_CODECS; i++)
 		snd_ac97_suspend(chip->ac97[i]);
 	snd_atiixp_aclink_down(chip);
@@ -1514,8 +1513,6 @@ static int snd_atiixp_resume(struct device *dev)
 				dma->substream->ops->prepare(dma->substream);
 				writel((u32)dma->desc_buf.addr | ATI_REG_LINKPTR_EN,
 				       chip->remap_addr + dma->ops->llp_offset);
-				writel(dma->saved_curptr, chip->remap_addr +
-				       dma->ops->dt_cur);
 			}
 		}
 
-- 
2.20.1
