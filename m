From: srinivas.kandagatla@linaro.org
Subject: [PATCH 6/6] slimbus: qcom: Fix return value check in qcom_slim_probe()
Date: Tue,  2 Jan 2018 17:54:24 +0000
Message-ID: <20180102175424.14391-7-srinivas.kandagatla@linaro.org>
References: <20180102175424.14391-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180102175424.14391-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sdharia@codeaurora.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 8d12baae4119..ffb46f915334 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -529,9 +529,9 @@ static int qcom_slim_probe(struct platform_device *pdev)
 
 	slim_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
 	ctrl->base = devm_ioremap_resource(ctrl->dev, slim_mem);
-	if (!ctrl->base) {
+	if (IS_ERR(ctrl->base)) {
 		dev_err(&pdev->dev, "IOremap failed\n");
-		return -ENOMEM;
+		return PTR_ERR(ctrl->base);
 	}
 
 	sctrl->set_laddr = qcom_set_laddr;
-- 
2.15.0
