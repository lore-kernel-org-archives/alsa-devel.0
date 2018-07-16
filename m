From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v6 09/10] soundwire: intel: Add pre/post bank
	switch ops
Date: Tue, 17 Jul 2018 00:17:12 +0530
Message-ID: <20180716184713.13356-10-sanyog.r.kale@intel.com>
References: <20180716184713.13356-1-sanyog.r.kale@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id EC96026779C
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 20:47:13 +0200 (CEST)
In-Reply-To: <20180716184713.13356-1-sanyog.r.kale@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, shreyas.nc@intel.com, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

To support multi link on Intel platforms, we need to update
SDW SHIM registers.

So, add pre/post bank switch ops for the same in Intel driver.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 drivers/soundwire/intel.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 0a8990e758f9..da7f91f1a588 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -398,6 +398,69 @@ static int intel_config_stream(struct sdw_intel *sdw,
 }
 
 /*
+ * bank switch routines
+ */
+
+static int intel_pre_bank_switch(struct sdw_bus *bus)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	void __iomem *shim = sdw->res->shim;
+	int sync_reg;
+
+	/* Write to register only for multi-link */
+	if (!bus->multi_link)
+		return 0;
+
+	/* Read SYNC register */
+	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
+	sync_reg |= SDW_SHIM_SYNC_CMDSYNC << sdw->instance;
+	intel_writel(shim, SDW_SHIM_SYNC, sync_reg);
+
+	return 0;
+}
+
+static int intel_post_bank_switch(struct sdw_bus *bus)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	void __iomem *shim = sdw->res->shim;
+	int sync_reg, ret;
+
+	/* Write to register only for multi-link */
+	if (!bus->multi_link)
+		return 0;
+
+	/* Read SYNC register */
+	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
+
+	/*
+	 * post_bank_switch() ops is called from the bus in loop for
+	 * all the Masters in the steam with the expectation that
+	 * we trigger the bankswitch for the only first Master in the list
+	 * and do nothing for the other Masters
+	 *
+	 * So, set the SYNCGO bit only if CMDSYNC bit is set for any Master.
+	 */
+	if (!(sync_reg & SDW_SHIM_SYNC_CMDSYNC_MASK))
+		return 0;
+
+	/*
+	 * Set SyncGO bit to synchronously trigger a bank switch for
+	 * all the masters. A write to SYNCGO bit clears CMDSYNC bit for all
+	 * the Masters.
+	 */
+	sync_reg |= SDW_SHIM_SYNC_SYNCGO;
+
+	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
+					SDW_SHIM_SYNC_SYNCGO);
+	if (ret < 0)
+		dev_err(sdw->cdns.dev, "Post bank switch failed: %d", ret);
+
+	return ret;
+}
+
+/*
  * DAI routines
  */
 
@@ -750,6 +813,8 @@ static struct sdw_master_ops sdw_intel_ops = {
 	.xfer_msg_defer = cdns_xfer_msg_defer,
 	.reset_page_addr = cdns_reset_page_addr,
 	.set_bus_conf = cdns_bus_conf,
+	.pre_bank_switch = intel_pre_bank_switch,
+	.post_bank_switch = intel_post_bank_switch,
 };
 
 /*
-- 
2.13.0
