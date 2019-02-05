From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/20] ASoC: meson: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:14 +0100
Message-ID: <20190205194221.25924-14-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 59D0D26789B
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 20:42:29 +0100 (CET)
In-Reply-To: <20190205194221.25924-1-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

snd_pcm_lib_preallocate_pages() and co always succeed, so the error
check is simply redundant.  Drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/meson/axg-fifo.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 0e4f65e654c4..75e5e480fda2 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -267,9 +267,10 @@ int axg_fifo_pcm_new(struct snd_soc_pcm_runtime *rtd, unsigned int type)
 	struct snd_card *card = rtd->card->snd_card;
 	size_t size = axg_fifo_hw.buffer_bytes_max;
 
-	return snd_pcm_lib_preallocate_pages(rtd->pcm->streams[type].substream,
-					     SNDRV_DMA_TYPE_DEV, card->dev,
-					     size, size);
+	snd_pcm_lib_preallocate_pages(rtd->pcm->streams[type].substream,
+				      SNDRV_DMA_TYPE_DEV, card->dev,
+				      size, size);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(axg_fifo_pcm_new);
 
-- 
2.16.4
