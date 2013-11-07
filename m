From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH v2][RESEND] ASoC: generic-dmaengine-pcm: Use
	SNDRV_DMA_TYPE_DEV_IRAM as default
Date: Thu, 7 Nov 2013 14:45:16 +0800
Message-ID: <1383806716-23469-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 by alsa0.perex.cz (Postfix) with ESMTP id DE98D2650C2
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 07:45:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lars@metafoo.de, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When allocating memory space for DMA buffer, use on-chip internal SRAM
as default choice to save power. Since the core would allocate memory
from traditional external memory if iram allocation failed, we don't
need to worry about any side effect.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---

 * ! This patch should be applied to a branch containing the patch -- ALSA:
 *   Add SoC on-chip internal ram support for DMA buffer allocation.

Changelog
v1->v2:
 * Use iram memory space as default

 sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index e29ec3c..e5b61e3 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -163,7 +163,7 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		}
 
 		ret = snd_pcm_lib_preallocate_pages(substream,
-				SNDRV_DMA_TYPE_DEV,
+				SNDRV_DMA_TYPE_DEV_IRAM,
 				dmaengine_dma_dev(pcm, substream),
 				config->prealloc_buffer_size,
 				config->pcm_hardware->buffer_bytes_max);
-- 
1.8.4
