From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH 2/8] ARM: davinci: use gen_pool_dma_alloc() to
	sram.c
Date: Fri, 1 Nov 2013 19:36:00 +0800
Message-ID: <9536ee2bbb1a8463ebb21068a750b61fa59900df.1383303752.git.b42378@freescale.com>
References: <cover.1383303752.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FC47265750
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 12:36:31 +0100 (CET)
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
 arch/arm/mach-davinci/sram.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
index f18928b..8540ddd 100644
--- a/arch/arm/mach-davinci/sram.c
+++ b/arch/arm/mach-davinci/sram.c
@@ -25,7 +25,6 @@ struct gen_pool *sram_get_gen_pool(void)
 
 void *sram_alloc(size_t len, dma_addr_t *dma)
 {
-	unsigned long vaddr;
 	dma_addr_t dma_base = davinci_soc_info.sram_dma;
 
 	if (dma)
@@ -33,13 +32,7 @@ void *sram_alloc(size_t len, dma_addr_t *dma)
 	if (!sram_pool || (dma && !dma_base))
 		return NULL;
 
-	vaddr = gen_pool_alloc(sram_pool, len);
-	if (!vaddr)
-		return NULL;
-
-	if (dma)
-		*dma = gen_pool_virt_to_phys(sram_pool, vaddr);
-	return (void *)vaddr;
+	return gen_pool_dma_alloc(sram_pool, len, dma);
 
 }
 EXPORT_SYMBOL(sram_alloc);
-- 
1.8.4
