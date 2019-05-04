From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 6/8] soundwire: remove master data port properties
Date: Fri,  3 May 2019 19:29:24 -0500
Message-ID: <20190504002926.28815-7-pierre-louis.bossart@linux.intel.com>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

The SoundWire and DisCo specifications do not define Master data ports
or related properties. Data ports are only defined for Slave devices,
so remove the unused member in properties.

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index bd05a85d345c..80584e9d5970 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -377,7 +377,6 @@ struct sdw_slave_prop {
  * @dynamic_frame: Dynamic frame supported
  * @err_threshold: Number of times that software may retry sending a single
  * command
- * @dpn_prop: Data Port N properties
  */
 struct sdw_master_prop {
 	u32 revision;
@@ -393,7 +392,6 @@ struct sdw_master_prop {
 	u32 default_col;
 	bool dynamic_frame;
 	u32 err_threshold;
-	struct sdw_dpn_prop *dpn_prop;
 };
 
 int sdw_master_read_prop(struct sdw_bus *bus);
-- 
2.17.1
