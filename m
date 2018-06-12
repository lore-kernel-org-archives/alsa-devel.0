From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v2 6/6] soundwire: intel: Add pre/post bank
	switch ops
Date: Tue, 12 Jun 2018 16:23:44 +0530
Message-ID: <1528800824-696-7-git-send-email-shreyas.nc@intel.com>
References: <1528800824-696-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EA412676AD
 for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2018 12:55:38 +0200 (CEST)
In-Reply-To: <1528800824-696-1-git-send-email-shreyas.nc@intel.com>
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
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, Shreyas NC <shreyas.nc@intel.com>, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

To support multi link on Intel platforms, we need to update
SDW SHIM registers.

So, add pre/post bank switch ops for the same in Intel driver.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 drivers/soundwire/intel.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 0a8990e..524110f 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -398,6 +398,58 @@ static int intel_config_stream(struct sdw_intel *sdw,
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
+	/* Check CMDSYNC bit set for any Master */
+	if (!(sync_reg & SDW_SHIM_SYNC_CMDSYNC_MASK))
+		return 0;
+
+	/* Set SyncGO bit */
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
 
@@ -750,6 +802,8 @@ static struct sdw_master_ops sdw_intel_ops = {
 	.xfer_msg_defer = cdns_xfer_msg_defer,
 	.reset_page_addr = cdns_reset_page_addr,
 	.set_bus_conf = cdns_bus_conf,
+	.pre_bank_switch = intel_pre_bank_switch,
+	.post_bank_switch = intel_post_bank_switch,
 };
 
 /*
-- 
2.7.4
