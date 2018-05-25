From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 2/8] slimbus: core: add need_tid flag to slim_msg_txn
Date: Fri, 25 May 2018 15:36:12 +0100
Message-ID: <20180525143618.820-3-srinivas.kandagatla@linaro.org>
References: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add need_tid flag to txn, this flag can be set before start of transcation.
Having this flag would avoid calling slim_tid_txn() multiple times on the
same txn. Also it is handy for controller drivers too.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/slimbus.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 79f8e05d92dd..3ec5a85fba8e 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -102,6 +102,7 @@ struct slim_framer {
  * @msg: Elemental access message to be read/written
  * @comp: completion if read/write is synchronous, used internally
  *	for tid based transactions.
+ * @need_tid: flag indicating if a tid is required for this txn
  */
 struct slim_msg_txn {
 	u8			rl;
@@ -113,6 +114,7 @@ struct slim_msg_txn {
 	u8			la;
 	struct slim_val_inf	*msg;
 	struct	completion	*comp;
+	bool			need_tid;
 };
 
 /* Frequently used message transaction structures */
-- 
2.16.2
