From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH 3/8] dma: mmp_tdma: use gen_pool_dma_alloc() to
	allocate descriptor
Date: Fri, 1 Nov 2013 19:36:01 +0800
Message-ID: <b7d5dce9fcc118a60261824196c820de6fb434a2.1383303752.git.b42378@freescale.com>
References: <cover.1383303752.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 82A232657A7
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 12:36:38 +0100 (CET)
In-Reply-To: <cover.1383303752.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: akpm@linux-foundation.org, joe@perches.com, nsekhar@ti.com, khilman@deeprootsystems.com, linux@arm.linux.org.uk, dan.j.williams@intel.com, vinod.koul@intel.com, m.chehab@samsung.com, hjk@hansjkoch.de, gregkh@linuxfoundation.org, perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, rmk+kernel@arm.linux.org.uk, eric.y.miao@gmail.com, haojian.zhuang@gmail.com
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Since gen_pool_dma_alloc() is introduced, we implement it to simplify code.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 drivers/dma/mmp_tdma.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 2b4026d..3ddacc1 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -378,12 +378,7 @@ struct mmp_tdma_desc *mmp_tdma_alloc_descriptor(struct mmp_tdma_chan *tdmac)
 	if (!gpool)
 		return NULL;
 
-	tdmac->desc_arr = (void *)gen_pool_alloc(gpool, size);
-	if (!tdmac->desc_arr)
-		return NULL;
-
-	tdmac->desc_arr_phys = gen_pool_virt_to_phys(gpool,
-			(unsigned long)tdmac->desc_arr);
+	tdmac->desc_arr = gen_pool_dma_alloc(gpool, size, &tdmac->desc_arr_phys);
 
 	return tdmac->desc_arr;
 }
-- 
1.8.4
