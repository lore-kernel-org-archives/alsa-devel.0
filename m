From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH 4/8] [media] coda: use gen_pool_dma_alloc() to allocate iram buffer
Date: Fri, 1 Nov 2013 19:36:02 +0800
Message-ID: <a4cb5380b1eeb1c634cedfe05d2a7dee950742a4.1383303752.git.b42378@freescale.com>
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
 drivers/media/platform/coda.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/coda.c b/drivers/media/platform/coda.c
index ed4998c..bd72fb9 100644
--- a/drivers/media/platform/coda.c
+++ b/drivers/media/platform/coda.c
@@ -3298,13 +3298,12 @@ static int coda_probe(struct platform_device *pdev)
 		dev->iram_size = CODA7_IRAM_SIZE;
 		break;
 	}
-	dev->iram_vaddr = gen_pool_alloc(dev->iram_pool, dev->iram_size);
+	dev->iram_vaddr = (unsigned long)gen_pool_dma_alloc(dev->iram_pool,
+			dev->iram_size, (dma_addr_t *)&dev->iram_paddr);
 	if (!dev->iram_vaddr) {
 		dev_err(&pdev->dev, "unable to alloc iram\n");
 		return -ENOMEM;
 	}
-	dev->iram_paddr = gen_pool_virt_to_phys(dev->iram_pool,
-						dev->iram_vaddr);
 
 	platform_set_drvdata(pdev, dev);
 
-- 
1.8.4
