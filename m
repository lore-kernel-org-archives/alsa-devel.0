From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/8] soundwire: mipi_disco: expose sdw_slave_read_dpn as symbol
Date: Fri,  3 May 2019 19:29:21 -0500
Message-ID: <20190504002926.28815-4-pierre-louis.bossart@linux.intel.com>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

sdw_slave_read_dpn was so far a static function, which prevented
codec drivers from using it. Expose as non-static function and add symbol

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 7 ++++---
 include/linux/soundwire/sdw.h  | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 6df68584c963..4995554bd6b6 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -161,9 +161,9 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
 	return 0;
 }
 
-static int sdw_slave_read_dpn(struct sdw_slave *slave,
-			      struct sdw_dpn_prop *dpn, int count, int ports,
-			      char *type)
+int sdw_slave_read_dpn(struct sdw_slave *slave,
+		       struct sdw_dpn_prop *dpn, int count, int ports,
+		       char *type)
 {
 	struct fwnode_handle *node;
 	u32 bit, i = 0;
@@ -283,6 +283,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 
 	return 0;
 }
+EXPORT_SYMBOL(sdw_slave_read_dpn);
 
 /**
  * sdw_slave_read_prop() - Read Slave properties
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 35662d9c2c62..04a45225e248 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -345,6 +345,9 @@ struct sdw_master_prop {
 
 int sdw_master_read_prop(struct sdw_bus *bus);
 int sdw_slave_read_prop(struct sdw_slave *slave);
+int sdw_slave_read_dpn(struct sdw_slave *slave,
+		       struct sdw_dpn_prop *dpn, int count, int ports,
+		       char *type);
 
 /*
  * SDW Slave Structures and APIs
-- 
2.17.1
