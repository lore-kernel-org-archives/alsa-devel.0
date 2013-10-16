From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH v2 2/2] ASoC: generic-dmaengine-pcm: Use
	on-chip internal memory for DMA buffer
Date: Wed, 16 Oct 2013 17:34:46 +0800
Message-ID: <dc332f7b7c05ae41f4b5e5cfabe074d10dfb1047.1381915852.git.b42378@freescale.com>
References: <61709896cb0bac221df2a7717b157d5b884dfd78.1381915852.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id F422C2650C0
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 11:35:04 +0200 (CEST)
In-Reply-To: <61709896cb0bac221df2a7717b157d5b884dfd78.1381915852.git.b42378@freescale.com>
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

When allocating memory space for DMA buffer, use on-chip internal memory
as default to save power.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
Changelog
v1->v2:
 * Use iram memory space as default

---
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
