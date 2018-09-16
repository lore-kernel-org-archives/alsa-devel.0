From: srinivas.kandagatla@linaro.org
Subject: [PATCH 6/7] slimbus: ngd: return proper error code instead of zero
Date: Sun, 16 Sep 2018 16:45:45 -0700
Message-ID: <20180916234546.29661-7-srinivas.kandagatla@linaro.org>
References: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

It looks like there is a typo in probe return. Fix it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 0241373..f48a06e 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1396,7 +1396,7 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	if (ctrl->mwq)
 		destroy_workqueue(ctrl->mwq);
 
-	return 0;
+	return ret;
 }
 
 static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
-- 
2.9.3
