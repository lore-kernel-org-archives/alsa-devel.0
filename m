From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 08/40] soundwire: intel: remove BIOS work-arounds
Date: Thu, 25 Jul 2019 18:40:00 -0500
Message-ID: <20190725234032.21152-9-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

the values passed by all existing BIOS are fine, let's use them as is.
The existing code must have been needed only on early prototypes.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 51990b192dc0..c718c9c67a37 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -922,17 +922,6 @@ static int intel_prop_read(struct sdw_bus *bus)
 	/* Initialize with default handler to read all DisCo properties */
 	sdw_master_read_prop(bus);
 
-	/* BIOS is not giving some values correctly. So, lets override them */
-	bus->prop.num_clk_freq = 1;
-	bus->prop.clk_freq = devm_kcalloc(bus->dev, bus->prop.num_clk_freq,
-					  sizeof(*bus->prop.clk_freq),
-					  GFP_KERNEL);
-	if (!bus->prop.clk_freq)
-		return -ENOMEM;
-
-	bus->prop.clk_freq[0] = bus->prop.max_clk_freq;
-	bus->prop.err_threshold = 5;
-
 	return 0;
 }
 
-- 
2.20.1
