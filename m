From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 04/17] soundwire: bus: improve dynamic debug comments for enumeration
Date: Mon,  5 Aug 2019 19:55:09 -0500
Message-ID: <20190806005522.22642-5-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org, Slawomir <slawomir.blauciak@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

update comments to provide better understanding of enumeration flows.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 89d5f1537d9b..40f7d0dc59a6 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -476,7 +476,8 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 
 	ret = sdw_write(slave, SDW_SCP_DEVNUMBER, dev_num);
 	if (ret < 0) {
-		dev_err(&slave->dev, "Program device_num failed: %d\n", ret);
+		dev_err(&slave->dev, "Program device_num %d failed: %d\n",
+			dev_num, ret);
 		return ret;
 	}
 
@@ -533,6 +534,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 	do {
 		ret = sdw_transfer(bus, &msg);
 		if (ret == -ENODATA) { /* end of device id reads */
+			dev_dbg(bus->dev, "No more devices to enumerate\n");
 			ret = 0;
 			break;
 		}
@@ -975,6 +977,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 	int i, ret = 0;
 
 	if (status[0] == SDW_SLAVE_ATTACHED) {
+		dev_dbg(bus->dev, "Slave attached, programming device number\n");
 		ret = sdw_program_device_num(bus);
 		if (ret)
 			dev_err(bus->dev, "Slave attach failed: %d\n", ret);
-- 
2.20.1
