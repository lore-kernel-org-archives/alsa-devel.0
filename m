From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/20] ASoC: dwc: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:11 +0100
Message-ID: <20190205194221.25924-11-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 709B0267914
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 20:42:28 +0100 (CET)
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
 sound/soc/dwc/dwc-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/dwc/dwc-pcm.c b/sound/soc/dwc/dwc-pcm.c
index 2cc9632024fc..a9ae91c4597f 100644
--- a/sound/soc/dwc/dwc-pcm.c
+++ b/sound/soc/dwc/dwc-pcm.c
@@ -249,9 +249,10 @@ static int dw_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	size_t size = dw_pcm_hardware.buffer_bytes_max;
 
-	return snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
+	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
 			SNDRV_DMA_TYPE_CONTINUOUS,
 			snd_dma_continuous_data(GFP_KERNEL), size, size);
+	return 0;
 }
 
 static void dw_pcm_free(struct snd_pcm *pcm)
-- 
2.16.4
