From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: uniphier: fix an error code in
 uniphier_aio_comprdma_new()
Date: Wed, 14 Feb 2018 10:15:31 +0300
Message-ID: <20180214071531.GB26677@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 58C1A26778B
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 08:15:44 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The dma_mapping_error() returns true or false, but we want to return
-ENOMEM if there was an error.

Fixes: e98131222ff9 ("ASoC: uniphier: add support for UniPhier AIO compress audio")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/uniphier/aio-compress.c b/sound/soc/uniphier/aio-compress.c
index 7f7abe3ae99d..4751c8bdabec 100644
--- a/sound/soc/uniphier/aio-compress.c
+++ b/sound/soc/uniphier/aio-compress.c
@@ -54,12 +54,11 @@ static int uniphier_aio_comprdma_new(struct snd_soc_pcm_runtime *rtd)
 		dma_dir = DMA_TO_DEVICE;
 
 	sub->compr_addr = dma_map_single(dev, sub->compr_area, size, dma_dir);
-	ret = dma_mapping_error(dev, sub->compr_addr);
-	if (ret) {
+	if (dma_mapping_error(dev, sub->compr_addr)) {
 		kfree(sub->compr_area);
 		sub->compr_area = NULL;
 
-		return ret;
+		return -ENOMEM;
 	}
 
 	sub->compr_bytes = size;
