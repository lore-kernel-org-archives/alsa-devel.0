From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 18/40] soundwire: bus: split handling of Device0 events
Date: Thu, 25 Jul 2019 18:40:10 -0500
Message-ID: <20190725234032.21152-19-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Assigning a device number to a Slave will result in additional events
when it reports its status in a PING frame. There is no point in
dealing with all the other devices in a loop, this can be done when a
non-device0 event happens.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 0a45dc5713df..bca378806d00 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -985,6 +985,11 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		ret = sdw_program_device_num(bus);
 		if (ret)
 			dev_err(bus->dev, "Slave attach failed: %d\n", ret);
+		/*
+		 * programming a device number will have side effects,
+		 * so we deal with other devices at a later time
+		 */
+		return ret;
 	}
 
 	/* Continue to check other slave statuses */
-- 
2.20.1
