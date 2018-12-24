From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] slimbus: Add a check on the return value of platform_device_add
Date: Mon, 24 Dec 2018 10:56:59 -0600
Message-ID: <20181224165659.18448-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In of_qcom_slim_ngd_register, the function platform_device_add() may fail.
The fix returns the error value upstream in case of failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 1382a8df6c75..a2dffb2b4c88 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1329,6 +1329,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 	struct qcom_slim_ngd *ngd;
 	struct device_node *node;
 	u32 id;
+	int ret;
 
 	data = of_match_node(qcom_slim_ngd_dt_match, parent->of_node)->data;
 
@@ -1348,7 +1349,10 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		ctrl->ngd = ngd;
 		platform_set_drvdata(ngd->pdev, ctrl);
 
-		platform_device_add(ngd->pdev);
+		ret = platform_device_add(ngd->pdev);
+		if (ret)
+			return ret;
+
 		ngd->base = ctrl->base + ngd->id * data->offset +
 					(ngd->id - 1) * data->size;
 		ctrl->ngd = ngd;
-- 
2.17.1
