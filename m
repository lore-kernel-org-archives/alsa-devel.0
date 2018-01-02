From: srinivas.kandagatla@linaro.org
Subject: [PATCH 3/6] slimbus: make functions slim_ack_txn and
	slim_alloc_txbuf static
Date: Tue,  2 Jan 2018 17:54:21 +0000
Message-ID: <20180102175424.14391-4-srinivas.kandagatla@linaro.org>
References: <20180102175424.14391-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1446526718D
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 18:56:36 +0100 (CET)
Received: by mail-wm0-f65.google.com with SMTP id f140so62051943wmd.2
 for <alsa-devel@alsa-project.org>; Tue, 02 Jan 2018 09:56:36 -0800 (PST)
In-Reply-To: <20180102175424.14391-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Colin Ian King <colin.king@canonical.com>, sdharia@codeaurora.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The functions slim_ack_txn and slim_alloc_txbuf are local to the
source and do not need to be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'slim_ack_txn' was not declared. Should it be static?
symbol 'slim_alloc_txbuf' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 2d67419a3c37..8d12baae4119 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -146,7 +146,7 @@ static void *slim_alloc_rxbuf(struct qcom_slim_ctrl *ctrl)
 	return ctrl->rx.base + (idx * ctrl->rx.sl_sz);
 }
 
-void slim_ack_txn(struct qcom_slim_ctrl *ctrl, int err)
+static void slim_ack_txn(struct qcom_slim_ctrl *ctrl, int err)
 {
 	struct completion *comp;
 	unsigned long flags;
@@ -299,8 +299,9 @@ static int qcom_clk_pause_wakeup(struct slim_controller *sctrl)
 	return 0;
 }
 
-void *slim_alloc_txbuf(struct qcom_slim_ctrl *ctrl, struct slim_msg_txn *txn,
-		       struct completion *done)
+static void *slim_alloc_txbuf(struct qcom_slim_ctrl *ctrl,
+			      struct slim_msg_txn *txn,
+			      struct completion *done)
 {
 	unsigned long flags;
 	int idx;
-- 
2.15.0
