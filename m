From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 03/17] soundwire: cadence_master: revisit interrupt settings
Date: Mon,  5 Aug 2019 19:55:08 -0500
Message-ID: <20190806005522.22642-4-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org, Slawomir <slawomir.blauciak@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <yung-chuan.liao@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Adding missing interrupt masks (parity, etc) and missing checks.
Clarify which masks are for which usage.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index a1c5f05ef27b..5d9729b4d634 100644
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
 
@@ -669,6 +672,11 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
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
@@ -736,10 +744,23 @@ static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
 		    CDNS_MCP_SLAVE_INTMASK1_MASK);
 
-	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
-		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH |
-		CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
-		CDNS_MCP_INT_RX_WL | CDNS_MCP_INT_IRQ | CDNS_MCP_INT_DPINT;
+	/* enable detection of all slave state changes */
+	mask = CDNS_MCP_INT_SLAVE_MASK;
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
+	/*
+	 * CDNS_MCP_INT_IRQ needs to be set otherwise all previous
+	 * settings are irrelevant
+	 */
+	mask |= CDNS_MCP_INT_IRQ;
 
 	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
 
-- 
2.20.1
