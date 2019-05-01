From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 13/22] soundwire: slave: fix alignment issues
Date: Wed,  1 May 2019 10:57:36 -0500
Message-ID: <20190501155745.21806-14-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Use Linux style

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/slave.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index ac103bd0c176..f39a5815e25d 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -14,7 +14,7 @@ static void sdw_slave_release(struct device *dev)
 }
 
 static int sdw_slave_add(struct sdw_bus *bus,
-		struct sdw_slave_id *id, struct fwnode_handle *fwnode)
+			 struct sdw_slave_id *id, struct fwnode_handle *fwnode)
 {
 	struct sdw_slave *slave;
 	int ret;
@@ -30,8 +30,8 @@ static int sdw_slave_add(struct sdw_bus *bus,
 
 	/* name shall be sdw:link:mfg:part:class:unique */
 	dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
-			bus->link_id, id->mfg_id, id->part_id,
-			id->class_id, id->unique_id);
+		     bus->link_id, id->mfg_id, id->part_id,
+		     id->class_id, id->unique_id);
 
 	slave->dev.release = sdw_slave_release;
 	slave->dev.bus = &sdw_bus_type;
@@ -84,11 +84,11 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
 		acpi_status status;
 
 		status = acpi_evaluate_integer(adev->handle,
-					METHOD_NAME__ADR, NULL, &addr);
+					       METHOD_NAME__ADR, NULL, &addr);
 
 		if (ACPI_FAILURE(status)) {
 			dev_err(bus->dev, "_ADR resolution failed: %x\n",
-							status);
+				status);
 			return status;
 		}
 
-- 
2.17.1
