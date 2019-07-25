From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 15/40] soundwire: cadence_master: handle multiple status reports per Slave
Date: Thu, 25 Jul 2019 18:40:07 -0500
Message-ID: <20190725234032.21152-16-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

When a Slave reports multiple status in the sticky bits, find the
latest configuration from the mirror of the PING frame status and
update the status directly.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 34 ++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 889fa2cd49ae..25d5c7267c15 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -643,13 +643,35 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 
 		/* first check if Slave reported multiple status */
 		if (set_status > 1) {
+			u32 val;
+
 			dev_warn_ratelimited(cdns->dev,
-					     "Slave reported multiple Status: %d\n",
-					     mask);
-			/*
-			 * TODO: we need to reread the status here by
-			 * issuing a PING cmd
-			 */
+					     "Slave %d reported multiple Status: %d\n",
+					     i, mask);
+
+			/* re-check latest status extracted from PING commands */
+			val = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
+			val >>= (i * 2);
+
+			switch (val & 0x3) {
+			case 0:
+				status[i] = SDW_SLAVE_UNATTACHED;
+				break;
+			case 1:
+				status[i] = SDW_SLAVE_ATTACHED;
+				break;
+			case 2:
+				status[i] = SDW_SLAVE_ALERT;
+				break;
+			default:
+				status[i] = SDW_SLAVE_RESERVED;
+				break;
+			}
+
+			dev_warn_ratelimited(cdns->dev,
+					     "Slave %d status updated to %d\n",
+					     i, status[i]);
+
 		}
 	}
 
-- 
2.20.1
