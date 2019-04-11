From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 1/5] soundwire: intel: fix inversion in devm_kcalloc parameters
Date: Wed, 10 Apr 2019 22:16:57 -0500
Message-ID: <20190411031701.5926-2-pierre-louis.bossart@linux.intel.com>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

the number of elements and size are inverted, fix.

This probably only worked because the number of properties is
hard-coded to 1.

Fixes: 71bb8a1b059e ('soundwire: intel: Add Intel Master driver')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index fd8d034cfec1..8669b314c476 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -796,8 +796,8 @@ static int intel_prop_read(struct sdw_bus *bus)
 
 	/* BIOS is not giving some values correctly. So, lets override them */
 	bus->prop.num_freq = 1;
-	bus->prop.freq = devm_kcalloc(bus->dev, sizeof(*bus->prop.freq),
-					bus->prop.num_freq, GFP_KERNEL);
+	bus->prop.freq = devm_kcalloc(bus->dev, bus->prop.num_freq,
+				      sizeof(*bus->prop.freq), GFP_KERNEL);
 	if (!bus->prop.freq)
 		return -ENOMEM;
 
-- 
2.17.1
