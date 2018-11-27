From: Colin King <colin.king@canonical.com>
Subject: [PATCH] slimbus: ngd: fix spelling mistake "exeeds" -> "exceeds"
Date: Tue, 27 Nov 2018 14:34:51 +0000
Message-ID: <20181127143451.27580-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message, fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index ccf33217236c..71f094c9ec68 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -787,7 +787,7 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
 
 	if (txn->msg->num_bytes > SLIM_MSGQ_BUF_LEN ||
 			txn->rl > SLIM_MSGQ_BUF_LEN) {
-		dev_err(ctrl->dev, "msg exeeds HW limit\n");
+		dev_err(ctrl->dev, "msg exceeds HW limit\n");
 		return -EINVAL;
 	}
 
-- 
2.19.1
