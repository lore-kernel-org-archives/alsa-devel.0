From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH 8/8] ASoC: pxa: use gen_pool_dma_alloc() to allocate dma buffer
Date: Fri, 1 Nov 2013 19:36:06 +0800
Message-ID: <290c4ed99f88c1d07544bf5f8f0c9a1d09395bed.1383303752.git.b42378@freescale.com>
References: <cover.1383303752.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1383303752.git.b42378@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, joe@perches.com, nsekhar@ti.com, khilman@deeprootsystems.com, linux@arm.linux.org.uk, dan.j.williams@intel.com, vinod.koul@intel.com, m.chehab@samsung.com, hjk@hansjkoch.de, gregkh@linuxfoundation.org, perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, rmk+kernel@arm.linux.org.uk, eric.y.miao@gmail.com, haojian.zhuang@gmail.com
Cc: linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, linux-media@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since gen_pool_dma_alloc() is introduced, we implement it to simplify code.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/pxa/mmp-pcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 8235e23..7929e19 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -201,10 +201,9 @@ static int mmp_pcm_preallocate_dma_buffer(struct snd_pcm_substream *substream,
 	if (!gpool)
 		return -ENOMEM;
 
-	buf->area = (unsigned char *)gen_pool_alloc(gpool, size);
+	buf->area = gen_pool_dma_alloc(gpool, size, &buf->addr);
 	if (!buf->area)
 		return -ENOMEM;
-	buf->addr = gen_pool_virt_to_phys(gpool, (unsigned long)buf->area);
 	buf->bytes = size;
 	return 0;
 }
-- 
1.8.4
