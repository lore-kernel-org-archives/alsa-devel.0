From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 06/22] soundwire: bus: remove useless parentheses
Date: Wed,  1 May 2019 10:57:29 -0500
Message-ID: <20190501155745.21806-7-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

and make the code more readable

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index efdcefc62e1a..423dc6d17999 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -415,10 +415,10 @@ static struct sdw_slave *sdw_get_slave(struct sdw_bus *bus, int i)
 static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
 {
 
-	if ((slave->id.unique_id != id.unique_id) ||
-	    (slave->id.mfg_id != id.mfg_id) ||
-	    (slave->id.part_id != id.part_id) ||
-	    (slave->id.class_id != id.class_id))
+	if (slave->id.unique_id != id.unique_id ||
+	    slave->id.mfg_id != id.mfg_id ||
+	    slave->id.part_id != id.part_id ||
+	    slave->id.class_id != id.class_id)
 		return -ENODEV;
 
 	return 0;
@@ -896,8 +896,8 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		}
 
 		/* Update the Slave driver */
-		if (slave_notify && (slave->ops) &&
-					(slave->ops->interrupt_callback)) {
+		if (slave_notify && slave->ops &&
+		    slave->ops->interrupt_callback) {
 			slave_intr.control_port = clear;
 			memcpy(slave_intr.port, &port_status,
 			       sizeof(slave_intr.port));
@@ -955,7 +955,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 static int sdw_update_slave_status(struct sdw_slave *slave,
 				   enum sdw_slave_status status)
 {
-	if ((slave->ops) && (slave->ops->update_status))
+	if (slave->ops && slave->ops->update_status)
 		return slave->ops->update_status(slave, status);
 
 	return 0;
-- 
2.17.1
