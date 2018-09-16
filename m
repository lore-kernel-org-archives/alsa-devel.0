From: srinivas.kandagatla@linaro.org
Subject: [PATCH 5/7] silmbus: ngd: register controller after power up.
Date: Sun, 16 Sep 2018 16:45:44 -0700
Message-ID: <20180916234546.29661-6-srinivas.kandagatla@linaro.org>
References: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Register slimbus controller only after finishing powerup sequnce so that we
do not endup in situation where core starts sending transactions before
the controller is ready.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index b9f2e3f..0241373 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1238,8 +1238,17 @@ static int qcom_slim_ngd_enable(struct qcom_slim_ngd_ctrl *ctrl, bool enable)
 			pm_runtime_resume(ctrl->dev);
 		pm_runtime_mark_last_busy(ctrl->dev);
 		pm_runtime_put(ctrl->dev);
+
+		ret = slim_register_controller(&ctrl->ctrl);
+		if (ret) {
+			dev_err(ctrl->dev, "error adding slim controller\n");
+			return ret;
+		}
+
+		dev_info(ctrl->dev, "SLIM controller Registered\n");
 	} else {
 		qcom_slim_qmi_exit(ctrl);
+		slim_unregister_controller(&ctrl->ctrl);
 	}
 
 	return 0;
@@ -1361,11 +1370,6 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	int ret;
 
 	ctrl->ctrl.dev = dev;
-	ret = slim_register_controller(&ctrl->ctrl);
-	if (ret) {
-		dev_err(dev, "error adding slim controller\n");
-		return ret;
-	}
 
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, QCOM_SLIM_NGD_AUTOSUSPEND);
@@ -1375,7 +1379,7 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
-		goto err;
+		return ret;
 	}
 
 	INIT_WORK(&ctrl->m_work, qcom_slim_ngd_master_worker);
@@ -1387,8 +1391,6 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-err:
-	slim_unregister_controller(&ctrl->ctrl);
 wq_err:
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
 	if (ctrl->mwq)
@@ -1460,7 +1462,7 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-	slim_unregister_controller(&ctrl->ctrl);
+	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
 	if (ctrl->mwq)
-- 
2.9.3
