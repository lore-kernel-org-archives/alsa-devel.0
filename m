From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 5/8] slimbus: messaging: remove multiple
	calls to pm_runtime_mark_last_busy
Date: Thu, 17 May 2018 09:58:47 +0100
Message-ID: <20180517085850.14276-6-srinivas.kandagatla@linaro.org>
References: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id B46B4267365
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 11:01:01 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id x9-v6so1950758wrl.13
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 02:01:01 -0700 (PDT)
In-Reply-To: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org
Cc: alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
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
