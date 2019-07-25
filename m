From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 30/40] soundwire: cadence_master: add kernel parameter to override interrupt mask
Date: Thu, 25 Jul 2019 18:40:22 -0500
Message-ID: <20190725234032.21152-31-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

The code has a set of defaults which may not be relevant in all cases,
add kernel parameter as a helper - mostly for early board bring-up.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 18c6ac026e85..dede55072191 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -20,6 +20,10 @@
 #include "bus.h"
 #include "cadence_master.h"
 
+static int interrupt_mask;
+module_param_named(cnds_mcp_int_mask, interrupt_mask, int, 0444);
+MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
+
 #define CDNS_MCP_CONFIG				0x0
 
 #define CDNS_MCP_CONFIG_MCMD_RETRY		GENMASK(27, 24)
@@ -830,6 +834,9 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 	/* now enable all of the above */
 	mask |= CDNS_MCP_INT_IRQ;
 
+	if (interrupt_mask) /* parameter override */
+		mask = interrupt_mask;
+
 	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
 
 	return do_reset(cdns);
-- 
2.20.1
