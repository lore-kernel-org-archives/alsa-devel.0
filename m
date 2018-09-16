From: srinivas.kandagatla@linaro.org
Subject: [PATCH 4/7] slimbus: ngd: validate logical address assigned by remote
Date: Sun, 16 Sep 2018 16:45:43 -0700
Message-ID: <20180916234546.29661-5-srinivas.kandagatla@linaro.org>
References: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Validate logical address assigned by remote, in failure cases this value
is all zeors.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 8be4d67..b9f2e3f 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1004,6 +1004,7 @@ static int qcom_slim_ngd_get_laddr(struct slim_controller *ctrl,
 				   struct slim_eaddr *ea, u8 *laddr)
 {
 	struct slim_val_inf msg =  {0};
+	u8 failed_ea[6] = {0, 0, 0, 0, 0, 0};
 	struct slim_msg_txn txn;
 	u8 wbuf[10] = {0};
 	u8 rbuf[10] = {0};
@@ -1034,6 +1035,9 @@ static int qcom_slim_ngd_get_laddr(struct slim_controller *ctrl,
 		return ret;
 	}
 
+	if (!memcmp(rbuf, failed_ea, 6))
+		return -ENXIO;
+
 	*laddr = rbuf[6];
 
 	return ret;
-- 
2.9.3
