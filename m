From: srinivas.kandagatla@linaro.org
Subject: [PATCH v7 09/13] slimbus: core: add common defines
	required for controllers
Date: Wed, 15 Nov 2017 14:10:39 +0000
Message-ID: <20171115141043.29202-10-srinivas.kandagatla@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
 [209.85.128.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 5613B2675D4
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 15:13:40 +0100 (CET)
Received: by mail-wr0-f194.google.com with SMTP id 15so20558574wrb.5
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 06:13:40 -0800 (PST)
In-Reply-To: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, andreas.noever@gmail.com, arnd@arndb.de, vinod.koul@intel.com, bp@suse.de, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, treding@nvidia.com, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds some common constant defines which are required
for qcom slim controller driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/slimbus.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 4fe1892cbd4f..e1fc6d23f374 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -18,9 +18,37 @@
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
 
 /* Information Element management messages */
 #define SLIM_MSG_MC_REQUEST_INFORMATION          0x20
@@ -116,6 +144,10 @@ struct slim_msg_txn {
 #define DEFINE_SLIM_BCAST_TXN(name, mc, rl, la, msg) \
 	struct slim_msg_txn name = { rl, 0, mc, SLIM_MSG_DEST_BROADCAST, 0,\
 					0, la, msg, }
+
+#define DEFINE_SLIM_EDEST_TXN(name, mc, rl, la, msg) \
+	struct slim_msg_txn name = { rl, 0, mc, SLIM_MSG_DEST_ENUMADDR, 0,\
+					0, la, msg, }
 /**
  * enum slim_clk_state: Slimbus controller's clock state used internally for
  *	maintaining current clock state.
-- 
2.15.0
