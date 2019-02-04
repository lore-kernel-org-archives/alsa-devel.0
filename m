From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ASoC: sh: Avoid passing NULL to memory
	allocators
Date: Mon,  4 Feb 2019 14:42:21 +0100
Message-ID: <20190204134222.9560-5-tiwai@suse.de>
References: <20190204134222.9560-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F07126751A
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 14:42:27 +0100 (CET)
In-Reply-To: <20190204134222.9560-1-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org

We should pass a proper	non-NULL device	object to memory allocators
although it was accepted in the past.  The card->dev points to the
most appropriate device object in such a case, so let's put it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/sh/siu_pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index e263757e4a69..23384c477740 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -542,7 +542,7 @@ static int siu_pcm_new(struct snd_soc_pcm_runtime *rtd)
 			return ret;
 
 		ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
-				SNDRV_DMA_TYPE_DEV, NULL,
+				SNDRV_DMA_TYPE_DEV, card->dev,
 				SIU_BUFFER_BYTES_MAX, SIU_BUFFER_BYTES_MAX);
 		if (ret < 0) {
 			dev_err(card->dev,
-- 
2.16.4
