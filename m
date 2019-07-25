From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 12/40] soundwire: cadence_master: revisit interrupt settings
Date: Thu, 25 Jul 2019 18:40:04 -0500
Message-ID: <20190725234032.21152-13-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <yung-chuan.liao@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Adding missing interrupt masks (parity, etc) and missing checks.
Clarify which masks are for which usage.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index bdc3ed844829..0f3b9c160b01 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -76,9 +76,12 @@
 #define CDNS_MCP_INT_DPINT			BIT(11)
 #define CDNS_MCP_INT_CTRL_CLASH			BIT(10)
 #define CDNS_MCP_INT_DATA_CLASH			BIT(9)
+#define CDNS_MCP_INT_PARITY			BIT(8)
 #define CDNS_MCP_INT_CMD_ERR			BIT(7)
+#define CDNS_MCP_INT_RX_NE			BIT(3)
 #define CDNS_MCP_INT_RX_WL			BIT(2)
 #define CDNS_MCP_INT_TXE			BIT(1)
+#define CDNS_MCP_INT_TXF			BIT(0)
 
 #define CDNS_MCP_INTSET				0x4C
 
@@ -689,6 +692,11 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 		}
 	}
 
+	if (int_status & CDNS_MCP_INT_PARITY) {
+		/* Parity error detected by Master */
+		dev_err_ratelimited(cdns->dev, "Parity error\n");
+	}
+
 	if (int_status & CDNS_MCP_INT_CTRL_CLASH) {
 		/* Slave is driving bit slot during control word */
 		dev_err_ratelimited(cdns->dev, "Bus clash for control word\n");
@@ -761,10 +769,21 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
 		    CDNS_MCP_SLAVE_INTMASK1_MASK);
 
+	/* enable detection of slave state changes */
 	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
-		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH |
-		CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
-		CDNS_MCP_INT_RX_WL | CDNS_MCP_INT_IRQ | CDNS_MCP_INT_DPINT;
+		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
+
+	/* enable detection of bus issues */
+	mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
+		CDNS_MCP_INT_PARITY;
+
+	/* no detection of port interrupts for now */
+
+	/* enable detection of RX fifo level */
+	mask |= CDNS_MCP_INT_RX_WL;
+
+	/* now enable all of the above */
+	mask |= CDNS_MCP_INT_IRQ;
 
 	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
 
-- 
2.20.1
