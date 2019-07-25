From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 11/40] soundwire: cadence_master: simplify bus clash interrupt clear
Date: Thu, 25 Jul 2019 18:40:03 -0500
Message-ID: <20190725234032.21152-12-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

The bus clash interrupts are generated when the status is one, and
also cleared by writing a one. It's overkill/useless to use an OR when
the bit is already set.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index e85e49340986..bdc3ed844829 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -692,7 +692,6 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 	if (int_status & CDNS_MCP_INT_CTRL_CLASH) {
 		/* Slave is driving bit slot during control word */
 		dev_err_ratelimited(cdns->dev, "Bus clash for control word\n");
-		int_status |= CDNS_MCP_INT_CTRL_CLASH;
 	}
 
 	if (int_status & CDNS_MCP_INT_DATA_CLASH) {
@@ -701,7 +700,6 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 		 * ownership of data bits or Slave gone bonkers
 		 */
 		dev_err_ratelimited(cdns->dev, "Bus clash for data word\n");
-		int_status |= CDNS_MCP_INT_DATA_CLASH;
 	}
 
 	if (int_status & CDNS_MCP_INT_SLAVE_MASK) {
-- 
2.20.1
