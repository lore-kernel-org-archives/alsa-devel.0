From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/10] [media] saa7134: Fix unlocked
	snd_pcm_stop() call
Date: Mon, 15 Jul 2013 15:06:21 +0200
Message-ID: <1373893582-17116-10-git-send-email-tiwai@suse.de>
References: <1373893582-17116-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A70926158D
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 15:06:04 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DE3E6A52D9
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
 drivers/media/pci/saa7134/saa7134-alsa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c b/drivers/media/pci/saa7134/saa7134-alsa.c
index 10460fd..dbcdfbf 100644
--- a/drivers/media/pci/saa7134/saa7134-alsa.c
+++ b/drivers/media/pci/saa7134/saa7134-alsa.c
@@ -172,7 +172,9 @@ static void saa7134_irq_alsa_done(struct saa7134_dev *dev,
 		dprintk("irq: overrun [full=%d/%d] - Blocks in %d\n",dev->dmasound.read_count,
 			dev->dmasound.bufsize, dev->dmasound.blocks);
 		spin_unlock(&dev->slock);
+		snd_pcm_stream_lock(dev->dmasound.substream);
 		snd_pcm_stop(dev->dmasound.substream,SNDRV_PCM_STATE_XRUN);
+		snd_pcm_stream_unlock(dev->dmasound.substream);
 		return;
 	}
 
-- 
1.8.3.1
