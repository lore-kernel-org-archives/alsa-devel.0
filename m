From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 17/40] soundwire: bus: use runtime_pm_get_sync/pm when enabled
Date: Thu, 25 Jul 2019 18:40:09 -0500
Message-ID: <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Not all platforms support runtime_pm for now, let's use runtime_pm
only when enabled.

Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 5ad4109dc72f..0a45dc5713df 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -332,12 +332,16 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
-		return ret;
+	if (pm_runtime_enabled(slave->bus->dev)) {
+		ret = pm_runtime_get_sync(slave->bus->dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = sdw_transfer(slave->bus, &msg);
-	pm_runtime_put(slave->bus->dev);
+
+	if (pm_runtime_enabled(slave->bus->dev))
+		pm_runtime_put(slave->bus->dev);
 
 	return ret;
 }
@@ -359,13 +363,16 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 			   slave->dev_num, SDW_MSG_FLAG_WRITE, val);
 	if (ret < 0)
 		return ret;
-
-	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
-		return ret;
+	if (pm_runtime_enabled(slave->bus->dev)) {
+		ret = pm_runtime_get_sync(slave->bus->dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = sdw_transfer(slave->bus, &msg);
-	pm_runtime_put(slave->bus->dev);
+
+	if (pm_runtime_enabled(slave->bus->dev))
+		pm_runtime_put(slave->bus->dev);
 
 	return ret;
 }
-- 
2.20.1
