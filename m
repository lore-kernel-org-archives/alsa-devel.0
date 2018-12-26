From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] slimbus: add a check for the status of platform_driver_register
Date: Tue, 25 Dec 2018 19:16:33 -0600
Message-ID: <20181226011633.70420-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

platform_driver_register() may fail. The fix checks its status and
issues an error message if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 1382a8df6c75..5b923c8dedb2 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1443,7 +1443,9 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	init_completion(&ctrl->reconf);
 	init_completion(&ctrl->qmi.qmi_comp);
 
-	platform_driver_register(&qcom_slim_ngd_driver);
+	ret = platform_driver_register(&qcom_slim_ngd_driver);
+	if (ret)
+		dev_err(&pdev->dev, "registering driver failed\n");
 	return of_qcom_slim_ngd_register(dev, ctrl);
 }
 
-- 
2.17.2 (Apple Git-113)
