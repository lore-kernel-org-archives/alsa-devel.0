From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 4/8] slimbus: messaging: remove multiple calls to pm_runtime_mark_last_busy
Date: Fri, 25 May 2018 15:36:14 +0100
Message-ID: <20180525143618.820-5-srinivas.kandagatla@linaro.org>
References: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

There seems to be a multiple calls to pm_runtime_mark_last_busy(),
which looks like a typo.
Fix this by properly adding pm_runtime_put_autosuspend to put controller
in auto suspend state.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 5a2ff01b394c..1c57b631031a 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -139,7 +139,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 		 * if there was error during this transaction
 		 */
 		pm_runtime_mark_last_busy(ctrl->dev);
-		pm_runtime_mark_last_busy(ctrl->dev);
+		pm_runtime_put_autosuspend(ctrl->dev);
 	}
 	return ret;
 }
-- 
2.16.2
