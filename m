From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 09/22] soundwire: bus_type: fix alignment issues
Date: Wed,  1 May 2019 10:57:32 -0500
Message-ID: <20190501155745.21806-10-pierre-louis.bossart@linux.intel.com>
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
 drivers/soundwire/bus_type.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 283b2832728e..2655602f0cfb 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -107,7 +107,7 @@ static int sdw_drv_probe(struct device *dev)
 		slave->prop.clk_stop_timeout = 300;
 
 	slave->bus->clk_stop_timeout = max_t(u32, slave->bus->clk_stop_timeout,
-					slave->prop.clk_stop_timeout);
+					     slave->prop.clk_stop_timeout);
 
 	return 0;
 }
@@ -148,7 +148,7 @@ int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
 
 	if (!drv->probe) {
 		pr_err("driver %s didn't provide SDW probe routine\n",
-							drv->name);
+		       drv->name);
 		return -EINVAL;
 	}
 
-- 
2.17.1
