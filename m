From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 09/13] soundwire: Remove cdns_master_ops
Date: Mon, 16 Apr 2018 20:53:37 +0530
Message-ID: <1523892221-16169-10-git-send-email-vinod.koul@intel.com>
References: <1523892221-16169-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id E23B8267628
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 17:19:35 +0200 (CEST)
In-Reply-To: <1523892221-16169-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

There can be instances where drivers using Cadence IP might want
to set sdw_master_ops differently per instance of it's use, so
remove the cdns_master_ops and export the APIs.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/cadence_master.c | 17 ++++++-----------
 drivers/soundwire/cadence_master.h |  8 ++++++++
 drivers/soundwire/intel.c          | 11 +++++++++--
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 3a9b1462039b..b0c09efd8f83 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -396,7 +396,7 @@ static int cdns_prep_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int *cmd)
 	return 0;
 }
 
-static enum sdw_command_response
+enum sdw_command_response
 cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
@@ -422,8 +422,9 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
 exit:
 	return ret;
 }
+EXPORT_SYMBOL(cdns_xfer_msg);
 
-static enum sdw_command_response
+enum sdw_command_response
 cdns_xfer_msg_defer(struct sdw_bus *bus,
 		struct sdw_msg *msg, struct sdw_defer *defer)
 {
@@ -443,8 +444,9 @@ cdns_xfer_msg_defer(struct sdw_bus *bus,
 
 	return _cdns_xfer_msg(cdns, msg, cmd, 0, msg->len, true);
 }
+EXPORT_SYMBOL(cdns_xfer_msg_defer);
 
-static enum sdw_command_response
+enum sdw_command_response
 cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
@@ -456,6 +458,7 @@ cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num)
 
 	return cdns_program_scp_addr(cdns, &msg);
 }
+EXPORT_SYMBOL(cdns_reset_page_addr);
 
 /*
  * IRQ handling
@@ -727,14 +730,6 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 }
 EXPORT_SYMBOL(sdw_cdns_init);
 
-struct sdw_master_ops sdw_cdns_master_ops = {
-	.read_prop = sdw_master_read_prop,
-	.xfer_msg = cdns_xfer_msg,
-	.xfer_msg_defer = cdns_xfer_msg_defer,
-	.reset_page_addr = cdns_reset_page_addr,
-};
-EXPORT_SYMBOL(sdw_cdns_master_ops);
-
 /**
  * sdw_cdns_probe() - Cadence probe routine
  * @cdns: Cadence instance
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index beaf6c9804eb..3ec74fa5f4f9 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -44,5 +44,13 @@ irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
 int sdw_cdns_init(struct sdw_cdns *cdns);
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
 
+enum sdw_command_response
+cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg);
 
+enum sdw_command_response
+cdns_xfer_msg_defer(struct sdw_bus *bus,
+		struct sdw_msg *msg, struct sdw_defer *defer);
+
+enum sdw_command_response
+cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num);
 #endif /* __SDW_CADENCE_H */
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 86a7bd1fc912..aa0c60133de5 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -252,6 +252,13 @@ static int intel_prop_read(struct sdw_bus *bus)
 	return 0;
 }
 
+static struct sdw_master_ops sdw_intel_ops = {
+	.read_prop = sdw_master_read_prop,
+	.xfer_msg = cdns_xfer_msg,
+	.xfer_msg_defer = cdns_xfer_msg_defer,
+	.reset_page_addr = cdns_reset_page_addr,
+};
+
 /*
  * probe and init
  */
@@ -276,8 +283,8 @@ static int intel_probe(struct platform_device *pdev)
 	sdw_cdns_probe(&sdw->cdns);
 
 	/* Set property read ops */
-	sdw_cdns_master_ops.read_prop = intel_prop_read;
-	sdw->cdns.bus.ops = &sdw_cdns_master_ops;
+	sdw_intel_ops.read_prop = intel_prop_read;
+	sdw->cdns.bus.ops = &sdw_intel_ops;
 
 	platform_set_drvdata(pdev, sdw);
 
-- 
2.7.4
