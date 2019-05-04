From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 3/7] ABI: testing: Add description of soundwire master sysfs files
Date: Fri,  3 May 2019 20:00:26 -0500
Message-ID: <20190504010030.29233-4-pierre-louis.bossart@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

The description is directly derived from the MIPI DisCo specification.

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../ABI/testing/sysfs-bus-soundwire-master    | 21 +++++++++++++++++++
 drivers/soundwire/sysfs.c                     |  1 +
 2 files changed, 22 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-soundwire-master

diff --git a/Documentation/ABI/testing/sysfs-bus-soundwire-master b/Documentation/ABI/testing/sysfs-bus-soundwire-master
new file mode 100644
index 000000000000..69cadf31049d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-soundwire-master
@@ -0,0 +1,21 @@
+What:		/sys/bus/soundwire/devices/sdw-master-N/revision
+		/sys/bus/soundwire/devices/sdw-master-N/clk_stop_modes
+		/sys/bus/soundwire/devices/sdw-master-N/clk_freq
+		/sys/bus/soundwire/devices/sdw-master-N/clk_gears
+		/sys/bus/soundwire/devices/sdw-master-N/default_col
+		/sys/bus/soundwire/devices/sdw-master-N/default_frame_rate
+		/sys/bus/soundwire/devices/sdw-master-N/default_row
+		/sys/bus/soundwire/devices/sdw-master-N/dynamic_shape
+		/sys/bus/soundwire/devices/sdw-master-N/err_threshold
+		/sys/bus/soundwire/devices/sdw-master-N/max_clk_freq
+
+Date:		May 2019
+
+Contact:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+
+Description:	SoundWire Master-N DisCo properties.
+		These properties are defined by MIPI DisCo Specification
+		for SoundWire. They define various properties of the Master
+		and are used by the bus to configure the Master. clk_stop_modes
+		is a bitmask for simplifications and combines the
+		clock-stop-mode0 and clock-stop-mode1 properties.
diff --git a/drivers/soundwire/sysfs.c b/drivers/soundwire/sysfs.c
index 734e2c8bc5cd..c2e5b7ad42fb 100644
--- a/drivers/soundwire/sysfs.c
+++ b/drivers/soundwire/sysfs.c
@@ -31,6 +31,7 @@ struct sdw_master_sysfs {
  *      |---- clk_gears
  *      |---- default_row
  *      |---- default_col
+ *      |---- default_frame_shape
  *      |---- dynamic_shape
  *      |---- err_threshold
  */
-- 
2.17.1
