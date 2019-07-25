From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 09/40] soundwire: cadence_master: fix usage of CONFIG_UPDATE
Date: Thu, 25 Jul 2019 18:40:01 -0500
Message-ID: <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Per the hardware documentation, all changes to MCP_CONFIG,
MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL need to be validated with a
self-clearing write to MCP_CONFIG_UPDATE.

For some reason, the existing code only does this write to
CONFIG_UPDATE when enabling interrupts. Add a helper and do the update
when the CONFIG is changed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 9f611a1fff0a..eb46cf651d62 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -224,6 +224,22 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
 	return -EAGAIN;
 }
 
+/*
+ * all changes to the MCP_CONFIG, MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL
+ * need to be confirmed with a write to MCP_CONFIG_UPDATE
+ */
+static int cdns_update_config(struct sdw_cdns *cdns)
+{
+	int ret;
+
+	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
+			     CDNS_MCP_CONFIG_UPDATE_BIT);
+	if (ret < 0)
+		dev_err(cdns->dev, "Config update timedout\n");
+
+	return ret;
+}
+
 /*
  * debugfs
  */
@@ -758,15 +774,9 @@ static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
  */
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 {
-	int ret;
-
 	_cdns_enable_interrupt(cdns);
-	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
-			     CDNS_MCP_CONFIG_UPDATE_BIT);
-	if (ret < 0)
-		dev_err(cdns->dev, "Config update timedout\n");
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
 
@@ -943,7 +953,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 
 	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
 
-	return 0;
+	/* commit changes */
+	ret = cdns_update_config(cdns);
+
+	return ret;
 }
 EXPORT_SYMBOL(sdw_cdns_init);
 
-- 
2.20.1
