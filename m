From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: fsl: use correct format string for
	dma_addr_t
Date: Tue, 08 Dec 2015 16:35:51 +0100
Message-ID: <1625124.fpu6AsNAkc@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A646260431
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 16:35:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

We get a warning for the imx-pcm-fiq driver when CONFIG_LPAE
is enabled on ARM, because dma_addr_t is 64-bit then:

sound/soc/fsl/imx-pcm-fiq.c: In function 'snd_imx_pcm_mmap':
sound/soc/fsl/imx-pcm-fiq.c:223:107: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]

This changes the printk to use the correct format string for
printing a dma_addr_t.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/fsl/imx-pcm-fiq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 7abf6a079574..49d7513f429e 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -220,9 +220,9 @@ static int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 	ret = dma_mmap_writecombine(substream->pcm->card->dev, vma,
 		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
 
-	pr_debug("%s: ret: %d %p 0x%08x 0x%08x\n", __func__, ret,
+	pr_debug("%s: ret: %d %p %pad 0x%08x\n", __func__, ret,
 			runtime->dma_area,
-			runtime->dma_addr,
+			&runtime->dma_addr,
 			runtime->dma_bytes);
 	return ret;
 }
-- 
2.1.0.rc2
