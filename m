From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 18/20] ASoC: xtensa: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:19 +0100
Message-ID: <20190205194221.25924-19-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 88EA2267942
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
 sound/soc/xtensa/xtfpga-i2s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/xtensa/xtfpga-i2s.c b/sound/soc/xtensa/xtfpga-i2s.c
index 503560916620..2f20a02c8d46 100644
--- a/sound/soc/xtensa/xtfpga-i2s.c
+++ b/sound/soc/xtensa/xtfpga-i2s.c
@@ -469,9 +469,9 @@ static int xtfpga_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	struct snd_card *card = rtd->card->snd_card;
 	size_t size = xtfpga_pcm_hardware.buffer_bytes_max;
 
-	return snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
-						     SNDRV_DMA_TYPE_DEV,
-						     card->dev, size, size);
+	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
+					      card->dev, size, size);
+	return 0;
 }
 
 static const struct snd_pcm_ops xtfpga_pcm_ops = {
-- 
2.16.4
