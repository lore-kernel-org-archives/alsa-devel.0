From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 40/40] soundwire: intel: add delay on restart for enumeration
Date: Thu, 25 Jul 2019 18:40:32 -0500
Message-ID: <20190725234032.21152-41-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

We have a conceptual issue on restart: the interaction with the slaves
can start before (re) enumeration is complete. Add a delay for now but
we will need to have an async notification that all devices are back
on the bus.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 1394a2322553..e4ea430b5a8e 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1242,6 +1242,11 @@ static int intel_resume(struct device *dev)
 
 	ret = sdw_cdns_exit_reset(&sdw->cdns);
 
+	/* add delay to let Slaves re-enumerate */
+	usleep_range(20000, 30000);
+
+	dev_dbg(dev, "%s done\n", __func__);
+
 	return ret;
 }
 
-- 
2.20.1
