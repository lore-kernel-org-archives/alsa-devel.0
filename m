From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 16/40] soundwire: cadence_master: improve startup sequence with link hw_reset
Date: Thu, 25 Jul 2019 18:40:08 -0500
Message-ID: <20190725234032.21152-17-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Enable interrupts first, then engage hardware bus reset with maximum
duration to make sure the Slave(s) correctly detect the reset pattern
and to ensure electrical conflicts can be resolved.

Without these changes the initialization is randomly corrupted by bus
clashes, parity errors and Slave attachment does not generate any
interrupt, despite the status showing them being attached.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 35 +++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 25d5c7267c15..442f78c00f09 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -778,6 +778,31 @@ EXPORT_SYMBOL(sdw_cdns_thread);
  * init routines
  */
 
+static int do_reset(struct sdw_cdns *cdns)
+{
+	int ret;
+
+	/* program maximum length reset to be safe */
+	cdns_updatel(cdns, CDNS_MCP_CONTROL,
+		     CDNS_MCP_CONTROL_RST_DELAY,
+		     CDNS_MCP_CONTROL_RST_DELAY);
+
+	/* use hardware generated reset */
+	cdns_updatel(cdns, CDNS_MCP_CONTROL,
+		     CDNS_MCP_CONTROL_HW_RST,
+		     CDNS_MCP_CONTROL_HW_RST);
+
+	/* enable bus operations with clock and data */
+	cdns_updatel(cdns, CDNS_MCP_CONFIG,
+		     CDNS_MCP_CONFIG_OP,
+		     CDNS_MCP_CONFIG_OP_NORMAL);
+
+	/* commit changes */
+	ret = cdns_update_config(cdns);
+
+	return ret;
+}
+
 /**
  * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
  * @cdns: Cadence instance
@@ -809,7 +834,7 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 
 	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
 
-	return 0;
+	return do_reset(cdns);
 }
 EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
 
@@ -958,6 +983,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, CDNS_DEFAULT_SSP_INTERVAL);
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL1, CDNS_DEFAULT_SSP_INTERVAL);
 
+	/* flush command FIFOs */
+	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_RST,
+		     CDNS_MCP_CONTROL_CMD_RST);
+
 	/* Set cmd accept mode */
 	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_ACCEPT,
 		     CDNS_MCP_CONTROL_CMD_ACCEPT);
@@ -980,10 +1009,6 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	/* Set cmd mode for Tx and Rx cmds */
 	val &= ~CDNS_MCP_CONFIG_CMD;
 
-	/* Set operation to normal */
-	val &= ~CDNS_MCP_CONFIG_OP;
-	val |= CDNS_MCP_CONFIG_OP_NORMAL;
-
 	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
 
 	/* commit changes */
-- 
2.20.1
