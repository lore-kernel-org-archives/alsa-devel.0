From: Ding Xiang <dingxiang@cmss.chinamobile.com>
Subject: [PATCH] slimbus: remove redundant dev_err message
Date: Tue, 18 Jun 2019 17:56:29 +0800
Message-ID: <1560851789-12228-1-git-send-email-dingxiang@cmss.chinamobile.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/slimbus/qcom-ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index ad3e2e23..a444badd 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -528,10 +528,8 @@ static int qcom_slim_probe(struct platform_device *pdev)
 
 	slim_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
 	ctrl->base = devm_ioremap_resource(ctrl->dev, slim_mem);
-	if (IS_ERR(ctrl->base)) {
-		dev_err(&pdev->dev, "IOremap failed\n");
+	if (IS_ERR(ctrl->base))
 		return PTR_ERR(ctrl->base);
-	}
 
 	sctrl->set_laddr = qcom_set_laddr;
 	sctrl->xfer_msg = qcom_xfer_msg;
-- 
1.9.1
