From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] slimbus: qcom: Make some local functions static
Date: Tue, 2 Jan 2018 01:46:33 +0000
Message-ID: <1514857593-84126-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Sagar Dharia <sdharia@codeaurora.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fixes the following sparse warnings:

drivers/slimbus/qcom-ctrl.c:151:6: warning:
 symbol 'slim_ack_txn' was not declared. Should it be static?
drivers/slimbus/qcom-ctrl.c:304:6: warning:
 symbol 'slim_alloc_txbuf' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/slimbus/qcom-ctrl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 35ad70d..600f62d 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -148,7 +148,7 @@ static void *slim_alloc_rxbuf(struct qcom_slim_ctrl *ctrl)
 	return ctrl->rx.base + (idx * ctrl->rx.sl_sz);
 }
 
-void slim_ack_txn(struct qcom_slim_ctrl *ctrl, int err)
+static void slim_ack_txn(struct qcom_slim_ctrl *ctrl, int err)
 {
 	struct completion *comp;
 	unsigned long flags;
@@ -301,8 +301,8 @@ static int qcom_clk_pause_wakeup(struct slim_controller *sctrl)
 	return 0;
 }
 
-void *slim_alloc_txbuf(struct qcom_slim_ctrl *ctrl, struct slim_msg_txn *txn,
-		       struct completion *done)
+static void *slim_alloc_txbuf(struct qcom_slim_ctrl *ctrl,
+			      struct slim_msg_txn *txn, struct completion *done)
 {
 	unsigned long flags;
 	int idx;
