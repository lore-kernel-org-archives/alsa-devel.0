From: srinivas.kandagatla@linaro.org
Subject: [PATCH] slimbus: qcom: fix incompatible pointer warning
Date: Sun, 31 Dec 2017 14:23:11 +0000
Message-ID: <20171231142311.7952-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sdharia@codeaurora.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

One of the pointer passed to dmam_alloc_coherent seems to be
phys_addr_t * instead of dma_addr_t *. This address will be
used by dma apis, so change this to proper type.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 35ad70dbfe3a..f51de1277912 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -93,7 +93,7 @@
 
 struct slim_ctrl_buf {
 	void		*base;
-	phys_addr_t	phy;
+	dma_addr_t	phy;
 	spinlock_t	lock;
 	int		head;
 	int		tail;
-- 
2.15.0
