From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/10] ASoC: atmel: Fix unlocked snd_pcm_stop()
	call
Date: Mon, 15 Jul 2013 15:06:19 +0200
Message-ID: <1373893582-17116-8-git-send-email-tiwai@suse.de>
References: <1373893582-17116-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EC3F261599
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 15:06:04 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DE37AA52D7
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 15:06:03 +0200 (CEST)
In-Reply-To: <1373893582-17116-1-git-send-email-tiwai@suse.de>
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

snd_pcm_stop() must be called in the PCM substream lock context.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/atmel/atmel-pcm-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index 1d38fd0..d128265 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -81,7 +81,9 @@ static void atmel_pcm_dma_irq(u32 ssc_sr,
 
 		/* stop RX and capture: will be enabled again at restart */
 		ssc_writex(prtd->ssc->regs, SSC_CR, prtd->mask->ssc_disable);
+		snd_pcm_stream_lock(substream);
 		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		snd_pcm_stream_unlock(substream);
 
 		/* now drain RHR and read status to remove xrun condition */
 		ssc_readx(prtd->ssc->regs, SSC_RHR);
-- 
1.8.3.1
