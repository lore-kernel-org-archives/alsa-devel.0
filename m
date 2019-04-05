From: Jan Kotas <jank@cadence.com>
Subject: [PATCH] soundwire: fix pm_runtime_get_sync return code checks
Date: Fri, 5 Apr 2019 08:26:55 +0100
Message-ID: <20190405072655.25995-1-jank@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jan Kotas <jank@cadence.com>
List-Id: alsa-devel@alsa-project.org

When PM is disabled it returns -EACCES, which is currently
threated as an error, and prevents accessing the slave's
registers.

This patch ignores the -EACCES return value from
pm_runtime_get_sync() to let the SoundWire work in systems
without runtime PM.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/soundwire/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1cbfedfc2..6567ff439 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -328,7 +328,7 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 		return ret;
 
 	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -EACCES)
 		return ret;
 
 	ret = sdw_transfer(slave->bus, &msg);
@@ -356,7 +356,7 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 		return ret;
 
 	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -EACCES)
 		return ret;
 
 	ret = sdw_transfer(slave->bus, &msg);
-- 
2.15.0
