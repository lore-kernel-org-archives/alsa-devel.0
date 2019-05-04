From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/8] soundwire: mipi_disco: expose sdw_slave_read_dp0 as symbol
Date: Fri,  3 May 2019 19:29:22 -0500
Message-ID: <20190504002926.28815-5-pierre-louis.bossart@linux.intel.com>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

sdw_slave_read_dp0 was so far a static function, which prevented codec
drivers from using it. Expose as non-static function and add symbol

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 7 ++++---
 include/linux/soundwire/sdw.h  | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 4995554bd6b6..f6b1be920a19 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -121,9 +121,9 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 }
 EXPORT_SYMBOL(sdw_master_read_prop);
 
-static int sdw_slave_read_dp0(struct sdw_slave *slave,
-			      struct fwnode_handle *port,
-			      struct sdw_dp0_prop *dp0)
+int sdw_slave_read_dp0(struct sdw_slave *slave,
+		       struct fwnode_handle *port,
+		       struct sdw_dp0_prop *dp0)
 {
 	int nval;
 
@@ -160,6 +160,7 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
 
 	return 0;
 }
+EXPORT_SYMBOL(sdw_slave_read_dp0);
 
 int sdw_slave_read_dpn(struct sdw_slave *slave,
 		       struct sdw_dpn_prop *dpn, int count, int ports,
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 04a45225e248..594c17ed8593 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -348,6 +348,9 @@ int sdw_slave_read_prop(struct sdw_slave *slave);
 int sdw_slave_read_dpn(struct sdw_slave *slave,
 		       struct sdw_dpn_prop *dpn, int count, int ports,
 		       char *type);
+int sdw_slave_read_dp0(struct sdw_slave *slave,
+		       struct fwnode_handle *port,
+		       struct sdw_dp0_prop *dp0);
 
 /*
  * SDW Slave Structures and APIs
-- 
2.17.1
