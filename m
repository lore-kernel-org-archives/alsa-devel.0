From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] slimbus: qcom-ctrl: use normal allocation
Date: Tue,  2 Jan 2018 11:48:54 +0100
Message-ID: <20180102104909.1369737-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A3F82668F0
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 11:49:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, Sagar Dharia <sdharia@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The previous patch addressed a warning but not the cause:

drivers/slimbus/qcom-ctrl.c: In function 'qcom_slim_probe':
drivers/slimbus/qcom-ctrl.c:584:9: error: passing argument 3 of 'dmam_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]

There are two things wrong here:

- The naming is very confusing, we now have a member named 'phys'
  that doesn't refer to a phys_addr_t but a dma_addr_t. If we needed
  a dma address, it should be named 'dma' to avoid confusion, and
  to make it less likely that someone passes it into a function that
  expects a physical address.

- The dma address is not used at all at this point. It may have been
  designed to support DMA in the future, but today it doesn't, so
  the only effect right now is to make transfers artificially slower
  by using uncached memory instead of cached memory for a temporary
  buffer.

This removes the unused structure member and instead changes the code
to call devm_kcalloc(), which matches the usage of the 'base' pointer
as an array of temporary buffers.

Fixes: db809859c8ce ("slimbus: qcom: fix incompatible pointer warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/slimbus/qcom-ctrl.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index f51de1277912..fb1a5e0eb8dd 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -13,7 +13,6 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include "slimbus.h"
 
@@ -93,7 +92,6 @@
 
 struct slim_ctrl_buf {
 	void		*base;
-	dma_addr_t	phy;
 	spinlock_t	lock;
 	int		head;
 	int		tail;
@@ -579,17 +577,15 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_rclk_enable_failed;
 
-	ctrl->tx.base = dmam_alloc_coherent(&pdev->dev,
-					   (ctrl->tx.sl_sz * ctrl->tx.n),
-					   &ctrl->tx.phy, GFP_KERNEL);
+	ctrl->tx.base = devm_kcalloc(&pdev->dev, ctrl->tx.n, ctrl->tx.sl_sz,
+				     GFP_KERNEL);
 	if (!ctrl->tx.base) {
 		ret = -ENOMEM;
 		goto err;
 	}
 
-	ctrl->rx.base = dmam_alloc_coherent(&pdev->dev,
-					   (ctrl->rx.sl_sz * ctrl->rx.n),
-					   &ctrl->rx.phy, GFP_KERNEL);
+	ctrl->rx.base = devm_kcalloc(&pdev->dev,ctrl->rx.n, ctrl->rx.sl_sz,
+				     GFP_KERNEL);
 	if (!ctrl->rx.base) {
 		ret = -ENOMEM;
 		goto err;
-- 
2.9.0
