From: srinivas.kandagatla@linaro.org
Subject: [PATCH v8 09/13] slimbus: core: add common defines required for controllers
Date: Thu, 30 Nov 2017 17:41:56 +0000
Message-ID: <20171130174200.6684-10-srinivas.kandagatla@linaro.org>
References: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds some common constant defines which are required
for qcom slim controller driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/slimbus.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index e0ae7bb1ba47..d278c951ddbf 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -18,9 +18,38 @@
 #include <linux/completion.h>
 #include <linux/slimbus.h>
 
+/* Standard values per SLIMbus spec needed by controllers and devices */
+#define SLIM_CL_PER_SUPERFRAME		6144
+#define SLIM_CL_PER_SUPERFRAME_DIV8	(SLIM_CL_PER_SUPERFRAME >> 3)
+
 /* SLIMbus message types. Related to interpretation of message code. */
 #define SLIM_MSG_MT_CORE			0x0
 
+/*
+ * SLIM Broadcast header format
+ * BYTE 0: MT[7:5] RL[4:0]
+ * BYTE 1: RSVD[7] MC[6:0]
+ * BYTE 2: RSVD[7:6] DT[5:4] PI[3:0]
+ */
+#define SLIM_MSG_MT_MASK	GENMASK(2, 0)
+#define SLIM_MSG_MT_SHIFT	5
+#define SLIM_MSG_RL_MASK	GENMASK(4, 0)
+#define SLIM_MSG_RL_SHIFT	0
+#define SLIM_MSG_MC_MASK	GENMASK(6, 0)
+#define SLIM_MSG_MC_SHIFT	0
+#define SLIM_MSG_DT_MASK	GENMASK(1, 0)
+#define SLIM_MSG_DT_SHIFT	4
+
+#define SLIM_HEADER_GET_MT(b)	((b >> SLIM_MSG_MT_SHIFT) & SLIM_MSG_MT_MASK)
+#define SLIM_HEADER_GET_RL(b)	((b >> SLIM_MSG_RL_SHIFT) & SLIM_MSG_RL_MASK)
+#define SLIM_HEADER_GET_MC(b)	((b >> SLIM_MSG_MC_SHIFT) & SLIM_MSG_MC_MASK)
+#define SLIM_HEADER_GET_DT(b)	((b >> SLIM_MSG_DT_SHIFT) & SLIM_MSG_DT_MASK)
+
+/* Device management messages used by this framework */
+#define SLIM_MSG_MC_REPORT_PRESENT               0x1
+#define SLIM_MSG_MC_ASSIGN_LOGICAL_ADDRESS       0x2
+#define SLIM_MSG_MC_REPORT_ABSENT                0xF
+
 /* Clock pause Reconfiguration messages */
 #define SLIM_MSG_MC_BEGIN_RECONFIGURATION        0x40
 #define SLIM_MSG_MC_NEXT_PAUSE_CLOCK             0x4A
@@ -101,6 +130,10 @@ struct slim_msg_txn {
 #define DEFINE_SLIM_BCAST_TXN(name, mc, rl, la, msg) \
 	struct slim_msg_txn name = { rl, 0, mc, SLIM_MSG_DEST_BROADCAST, 0,\
 					0, la, msg, }
+
+#define DEFINE_SLIM_EDEST_TXN(name, mc, rl, la, msg) \
+	struct slim_msg_txn name = { rl, 0, mc, SLIM_MSG_DEST_ENUMADDR, 0,\
+					0, la, msg, }
 /**
  * enum slim_clk_state: SLIMbus controller's clock state used internally for
  *	maintaining current clock state.
-- 
2.15.0
