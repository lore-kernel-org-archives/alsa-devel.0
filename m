From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 11/22] soundwire: mipi_disco: fix boolean comparisons
Date: Wed,  1 May 2019 10:57:34 -0500
Message-ID: <20190501155745.21806-12-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

No need for explicit test against true

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 95efa82dc73b..2bf4046e68b6 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -49,11 +49,11 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 	}
 
 	if (fwnode_property_read_bool(link,
-			"mipi-sdw-clock-stop-mode0-supported") == true)
+				      "mipi-sdw-clock-stop-mode0-supported"))
 		prop->clk_stop_mode = SDW_CLK_STOP_MODE0;
 
 	if (fwnode_property_read_bool(link,
-			"mipi-sdw-clock-stop-mode1-supported") == true)
+				      "mipi-sdw-clock-stop-mode1-supported"))
 		prop->clk_stop_mode |= SDW_CLK_STOP_MODE1;
 
 	fwnode_property_read_u32(link,
-- 
2.17.1
