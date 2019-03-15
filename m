From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] slimbus: fix a NULL pointer dereference in of_qcom_slim_ngd_register
Date: Fri, 15 Mar 2019 01:20:48 -0500
Message-ID: <20190315062048.16642-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In case platform_device_alloc fails, the fix returns an error
code to avoid the NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 71f094c9ec68..f3585777324c 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1342,6 +1342,10 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			return -ENOMEM;
 
 		ngd->pdev = platform_device_alloc(QCOM_SLIM_NGD_DRV_NAME, id);
+		if (!ngd->pdev) {
+			kfree(ngd);
+			return -ENOMEM;
+		}
 		ngd->id = id;
 		ngd->pdev->dev.parent = parent;
 		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
-- 
2.17.1
