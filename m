From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/6] soundwire: cadence_master: make clock stop exit configurable on init
Date: Tue, 13 Aug 2019 16:32:25 -0500
Message-ID: <20190813213227.5163-6-pierre-louis.bossart@linux.intel.com>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

The use of clock stop is not a requirement, the IP can e.g. be
completely power gated and not detect any wakes while in s2idle/deep
sleep.

For now clock-stop is not supported anyways so the control parameter
is always false. This will be revisited when we add clock stop.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 15 ++++++++-------
 drivers/soundwire/cadence_master.h |  2 +-
 drivers/soundwire/intel.c          |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index fdf9eec7cde1..17ac2ecd8d5c 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1000,7 +1000,7 @@ static u32 cdns_set_initial_frame_shape(int n_rows, int n_cols)
  * sdw_cdns_init() - Cadence initialization
  * @cdns: Cadence instance
  */
-int sdw_cdns_init(struct sdw_cdns *cdns)
+int sdw_cdns_init(struct sdw_cdns *cdns, bool clock_stop_exit)
 {
 	struct sdw_bus *bus = &cdns->bus;
 	struct sdw_master_prop *prop = &bus->prop;
@@ -1008,12 +1008,13 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	int divider;
 	int ret;
 
-	/* Exit clock stop */
-	ret = cdns_clear_bit(cdns, CDNS_MCP_CONTROL,
-			     CDNS_MCP_CONTROL_CLK_STOP_CLR);
-	if (ret < 0) {
-		dev_err(cdns->dev, "Couldn't exit from clock stop\n");
-		return ret;
+	if (clock_stop_exit) {
+		ret = cdns_clear_bit(cdns, CDNS_MCP_CONTROL,
+				     CDNS_MCP_CONTROL_CLK_STOP_CLR);
+		if (ret < 0) {
+			dev_err(cdns->dev, "Couldn't exit from clock stop\n");
+			return ret;
+		}
 	}
 
 	/* Set clock divider */
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 302351808098..9d7a48ac6fc4 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -158,7 +158,7 @@ extern struct sdw_master_ops sdw_cdns_master_ops;
 irqreturn_t sdw_cdns_irq(int irq, void *dev_id);
 irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
 
-int sdw_cdns_init(struct sdw_cdns *cdns);
+int sdw_cdns_init(struct sdw_cdns *cdns, bool clock_stop_exit);
 int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 		      struct sdw_cdns_stream_config config);
 int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 42bdc870c3ee..fd2d0a9ccb00 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1052,7 +1052,7 @@ static int intel_init(struct sdw_intel *sdw)
 	intel_link_power_up(sdw);
 	intel_shim_init(sdw);
 
-	return sdw_cdns_init(&sdw->cdns);
+	return sdw_cdns_init(&sdw->cdns, false);
 }
 
 /*
-- 
2.20.1
